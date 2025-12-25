#!/bin/bash
#
# Cloudflare DNS TTL Management Script
#
# Usage:
#   ./scripts/cloudflare-dns-ttl.sh [command] [options]
#
# Commands:
#   list              List all DNS records with current TTL
#   set-ttl <seconds> Set TTL for all records (e.g., 300 for 5 min)
#   restore           Restore TTL to 3600 (1 hour) for all records
#
# Requirements:
#   - Doppler CLI configured with CLOUDFLARE_DNS_TOKEN
#   - jq installed
#   - curl installed
#
# The token needs Zone:DNS:Edit permissions for the target zone.
#

set -e

# Configuration
DOMAIN="${CLOUDFLARE_DOMAIN:-integritystudio.ai}"
DOPPLER_PROJECT="${DOPPLER_PROJECT:-analyticsbot}"
DOPPLER_CONFIG="${DOPPLER_CONFIG:-dev}"
TOKEN_NAME="${CLOUDFLARE_TOKEN_NAME:-CLOUDFLARE_DNS_TOKEN}"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Print colored output
info() { echo -e "${BLUE}ℹ${NC} $1"; }
success() { echo -e "${GREEN}✓${NC} $1"; }
warn() { echo -e "${YELLOW}⚠${NC} $1"; }
error() { echo -e "${RED}✗${NC} $1"; exit 1; }

# Check dependencies
check_deps() {
    command -v curl >/dev/null 2>&1 || error "curl is required but not installed"
    command -v jq >/dev/null 2>&1 || error "jq is required but not installed"
    command -v doppler >/dev/null 2>&1 || error "doppler CLI is required but not installed"
}

# Get Cloudflare API token from Doppler
get_token() {
    info "Fetching Cloudflare token from Doppler..."
    CF_TOKEN=$(doppler secrets get "$TOKEN_NAME" --project "$DOPPLER_PROJECT" --config "$DOPPLER_CONFIG" --plain 2>/dev/null) || {
        error "Failed to get $TOKEN_NAME from Doppler. Make sure it exists in project '$DOPPLER_PROJECT' config '$DOPPLER_CONFIG'"
    }

    if [[ -z "$CF_TOKEN" ]]; then
        error "Token is empty. Please set $TOKEN_NAME in Doppler."
    fi

    success "Token retrieved successfully"
}

# Make Cloudflare API request
cf_api() {
    local method="$1"
    local endpoint="$2"
    local data="$3"

    local args=(-s -X "$method")
    args+=(-H "Authorization: Bearer $CF_TOKEN")
    args+=(-H "Content-Type: application/json")

    if [[ -n "$data" ]]; then
        args+=(-d "$data")
    fi

    curl "${args[@]}" "https://api.cloudflare.com/client/v4$endpoint"
}

# Get zone ID for domain
get_zone_id() {
    info "Looking up zone ID for $DOMAIN..."

    local response
    response=$(cf_api GET "/zones?name=$DOMAIN")

    # Check for errors
    local success
    success=$(echo "$response" | jq -r '.success')

    if [[ "$success" != "true" ]]; then
        local error_msg
        error_msg=$(echo "$response" | jq -r '.errors[0].message // "Unknown error"')
        error "API error: $error_msg"
    fi

    ZONE_ID=$(echo "$response" | jq -r '.result[0].id // empty')

    if [[ -z "$ZONE_ID" ]]; then
        error "Zone not found for domain: $DOMAIN"
    fi

    success "Zone ID: $ZONE_ID"
}

# List all DNS records
list_records() {
    info "Fetching DNS records..."

    local response
    response=$(cf_api GET "/zones/$ZONE_ID/dns_records?per_page=100")

    local success
    success=$(echo "$response" | jq -r '.success')

    if [[ "$success" != "true" ]]; then
        local error_msg
        error_msg=$(echo "$response" | jq -r '.errors[0].message // "Unknown error"')
        error "API error: $error_msg"
    fi

    echo ""
    echo -e "${BLUE}DNS Records for $DOMAIN:${NC}"
    echo "────────────────────────────────────────────────────────────────"
    printf "%-8s %-30s %-10s %s\n" "TYPE" "NAME" "TTL" "CONTENT"
    echo "────────────────────────────────────────────────────────────────"

    echo "$response" | jq -r '.result[] | "\(.type)\t\(.name)\t\(.ttl)\t\(.content)"' | while IFS=$'\t' read -r type name ttl content; do
        # Truncate long content
        if [[ ${#content} -gt 40 ]]; then
            content="${content:0:37}..."
        fi
        # Format TTL
        if [[ "$ttl" == "1" ]]; then
            ttl="Auto"
        elif [[ "$ttl" -ge 3600 ]]; then
            ttl="${ttl}s ($(( ttl / 3600 ))h)"
        else
            ttl="${ttl}s"
        fi
        printf "%-8s %-30s %-10s %s\n" "$type" "$name" "$ttl" "$content"
    done

    echo "────────────────────────────────────────────────────────────────"
    echo ""
}

# Update TTL for all records
set_ttl() {
    local new_ttl="$1"

    if [[ -z "$new_ttl" ]] || ! [[ "$new_ttl" =~ ^[0-9]+$ ]]; then
        error "Invalid TTL value. Must be a number (in seconds)."
    fi

    if [[ "$new_ttl" -lt 60 && "$new_ttl" -ne 1 ]]; then
        error "TTL must be at least 60 seconds (or 1 for Auto)"
    fi

    info "Fetching current DNS records..."

    local response
    response=$(cf_api GET "/zones/$ZONE_ID/dns_records?per_page=100")

    local records
    records=$(echo "$response" | jq -r '.result[] | @base64')

    local count=0
    local updated=0
    local skipped=0

    echo ""
    info "Updating TTL to ${new_ttl}s for all records..."
    echo ""

    for record in $records; do
        local record_json
        record_json=$(echo "$record" | base64 --decode)

        local id type name current_ttl proxied
        id=$(echo "$record_json" | jq -r '.id')
        type=$(echo "$record_json" | jq -r '.type')
        name=$(echo "$record_json" | jq -r '.name')
        current_ttl=$(echo "$record_json" | jq -r '.ttl')
        proxied=$(echo "$record_json" | jq -r '.proxied')

        count=$((count + 1))

        # Skip if already at target TTL
        if [[ "$current_ttl" == "$new_ttl" ]]; then
            echo -e "  ${YELLOW}⊘${NC} $type $name (already at ${new_ttl}s)"
            skipped=$((skipped + 1))
            continue
        fi

        # Skip proxied records (TTL is managed by Cloudflare)
        if [[ "$proxied" == "true" && "$new_ttl" != "1" ]]; then
            # Proxied records use Auto TTL, but we can still set it
            :
        fi

        # Update the record
        local update_response
        update_response=$(cf_api PATCH "/zones/$ZONE_ID/dns_records/$id" "{\"ttl\": $new_ttl}")

        local update_success
        update_success=$(echo "$update_response" | jq -r '.success')

        if [[ "$update_success" == "true" ]]; then
            echo -e "  ${GREEN}✓${NC} $type $name: ${current_ttl}s → ${new_ttl}s"
            updated=$((updated + 1))
        else
            local error_msg
            error_msg=$(echo "$update_response" | jq -r '.errors[0].message // "Unknown error"')
            echo -e "  ${RED}✗${NC} $type $name: Failed - $error_msg"
        fi
    done

    echo ""
    success "Complete: $updated updated, $skipped skipped, $count total"
    echo ""
}

# Show usage
usage() {
    cat << EOF
${BLUE}Cloudflare DNS TTL Management${NC}

Usage: $0 <command> [options]

Commands:
    list              List all DNS records with current TTL
    set-ttl <seconds> Set TTL for all records
    restore           Restore TTL to 3600 (1 hour)

Options:
    --domain <domain>   Override domain (default: $DOMAIN)
    --help              Show this help message

Examples:
    $0 list                    # List current records
    $0 set-ttl 300             # Set TTL to 5 minutes (pre-migration)
    $0 restore                 # Restore to 1 hour (post-migration)

Environment Variables:
    CLOUDFLARE_DOMAIN       Domain to manage (default: integritystudio.ai)
    DOPPLER_PROJECT         Doppler project (default: analyticsbot)
    DOPPLER_CONFIG          Doppler config (default: dev)
    CLOUDFLARE_TOKEN_NAME   Token name in Doppler (default: CLOUDFLARE_DNS_TOKEN)

Note: Requires CLOUDFLARE_DNS_TOKEN in Doppler with Zone:DNS:Edit permissions.
EOF
}

# Main
main() {
    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case "$1" in
            --domain)
                DOMAIN="$2"
                shift 2
                ;;
            --help|-h)
                usage
                exit 0
                ;;
            list)
                COMMAND="list"
                shift
                ;;
            set-ttl)
                COMMAND="set-ttl"
                TTL_VALUE="$2"
                shift 2
                ;;
            restore)
                COMMAND="restore"
                shift
                ;;
            *)
                error "Unknown argument: $1. Use --help for usage."
                ;;
        esac
    done

    if [[ -z "$COMMAND" ]]; then
        usage
        exit 1
    fi

    # Run
    check_deps
    get_token
    get_zone_id

    case "$COMMAND" in
        list)
            list_records
            ;;
        set-ttl)
            set_ttl "$TTL_VALUE"
            ;;
        restore)
            set_ttl 3600
            ;;
    esac
}

main "$@"
