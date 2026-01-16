#!/usr/bin/env python3
"""
Extract JSON-LD structured data from HTML files for validation.

Usage:
    python scripts/extract_jsonld.py                    # All pages
    python scripts/extract_jsonld.py index.html         # Single page
    python scripts/extract_jsonld.py --combined         # Single combined graph
    python scripts/extract_jsonld.py --output json      # Output as JSON file
"""

import json
import re
import sys
from pathlib import Path
from typing import Optional


def extract_jsonld_from_html(html_content: str) -> list[dict]:
    """Extract all JSON-LD blocks from HTML content."""
    pattern = r'<script type="application/ld\+json">\s*(.*?)\s*</script>'
    matches = re.findall(pattern, html_content, re.DOTALL)

    entities = []
    for match in matches:
        try:
            entity = json.loads(match)
            entities.append(entity)
        except json.JSONDecodeError as e:
            print(f"  Warning: JSON parse error: {e}", file=sys.stderr)

    return entities


def extract_from_file(file_path: Path) -> dict:
    """Extract JSON-LD from a single HTML file."""
    content = file_path.read_text()
    entities = extract_jsonld_from_html(content)
    return {
        "file": str(file_path.name),
        "path": str(file_path),
        "entities": entities,
        "count": len(entities)
    }


def extract_from_directory(web_dir: Path, file_filter: Optional[str] = None) -> list[dict]:
    """Extract JSON-LD from all HTML files in directory."""
    results = []

    for html_file in sorted(web_dir.rglob("*.html")):
        if file_filter and file_filter not in str(html_file):
            continue

        result = extract_from_file(html_file)
        if result["count"] > 0:
            results.append(result)

    return results


def create_combined_graph(results: list[dict]) -> dict:
    """Create a single @graph containing all entities."""
    all_entities = []
    for result in results:
        for entity in result["entities"]:
            # Remove _source_file if present
            entity_copy = {k: v for k, v in entity.items() if not k.startswith("_")}
            all_entities.append(entity_copy)

    return {
        "@context": "https://schema.org",
        "@graph": all_entities
    }


def print_separator():
    print("\n" + "=" * 70 + "\n")


def main():
    # Determine the web directory
    script_dir = Path(__file__).parent
    web_dir = script_dir.parent / "web"

    if not web_dir.exists():
        print(f"Error: Web directory not found: {web_dir}", file=sys.stderr)
        sys.exit(1)

    # Parse arguments
    args = sys.argv[1:]
    combined_mode = "--combined" in args
    output_json = "--output" in args and "json" in args
    file_filter = None

    for arg in args:
        if not arg.startswith("--") and arg.endswith(".html"):
            file_filter = arg

    # Extract JSON-LD
    results = extract_from_directory(web_dir, file_filter)

    if not results:
        print("No JSON-LD found in HTML files.")
        sys.exit(0)

    # Output mode
    if combined_mode:
        # Single combined @graph
        graph = create_combined_graph(results)
        output = json.dumps(graph, indent=2)

        if output_json:
            output_file = web_dir.parent / "jsonld_combined.json"
            output_file.write_text(output)
            print(f"Written to: {output_file}")
        else:
            print("# Combined JSON-LD Graph")
            print(f"# {sum(r['count'] for r in results)} entities from {len(results)} files")
            print_separator()
            print(output)

    elif output_json:
        # Output as JSON file per page
        output_dir = web_dir.parent / "jsonld_extracted"
        output_dir.mkdir(exist_ok=True)

        for result in results:
            file_name = result["file"].replace(".html", ".json")
            output_file = output_dir / file_name
            output_file.write_text(json.dumps(result["entities"], indent=2))
            print(f"Written: {output_file}")

        print(f"\nExtracted {sum(r['count'] for r in results)} entities to {output_dir}")

    else:
        # Pretty print by page
        total_entities = 0

        print("# JSON-LD Extraction Report")
        print(f"# Source: {web_dir}")

        for result in results:
            print_separator()
            print(f"## {result['file']}")
            print(f"## Path: {result['path']}")
            print(f"## Entities: {result['count']}")
            print()

            for i, entity in enumerate(result["entities"], 1):
                entity_type = entity.get("@type", "Unknown")
                entity_id = entity.get("@id", "no @id")
                print(f"### Entity {i}: {entity_type}")
                print(f"### @id: {entity_id}")
                print()
                print(json.dumps(entity, indent=2))
                print()

            total_entities += result["count"]

        print_separator()
        print(f"# TOTAL: {total_entities} entities from {len(results)} files")
        print()
        print("# Validation URLs:")
        print("# - Google: https://search.google.com/test/rich-results?url=https://integritystudio.ai")
        print("# - Schema.org: https://validator.schema.org/#url=https://integritystudio.ai")


if __name__ == "__main__":
    main()
