# Changelog

All notable changes to the IntegrityStudio.ai Flutter project.

---

## [2024-12-24] - Best LLM Monitoring Tools Guide

### New Content Published

**Best LLM Monitoring Tools (2025 Guide):**
- Comprehensive comparison of 11 LLM observability platforms
- Covers: Phoenix, Helicone, LangSmith, Langfuse, Datadog, Fiddler, Arize, OpenLLMetry
- Includes pricing, features, pros/cons for each tool
- EU AI Act compliance considerations
- Cost optimization strategies
- Written in aledlie.com informal, technically-deep style

**Files Added:**
- `web/blog/best-llm-monitoring-tools-2025.html`
- Updated `lib/config/content/resources_content.dart`

---

## [2024-12-24] - Brand Assets & Infrastructure

### Brand Assets Completed

**Logo & Branding:**
- [x] Logo (SVG, PNG) for social sharing
- [x] Favicon variants for all platforms (16x16, 32x32, 48x48, ICO)
- [x] Apple Touch Icon (180x180)
- [x] PWA Icons (192x192, 512x512)
- [x] OG Image (1200x630) for social sharing

**Legal Pages:**
- [x] Privacy Policy page (`/privacy`)
- [x] Terms of Service page (`/terms`)
- [x] Sources page with citations and methodology (`/sources`)

**Infrastructure:**
- [x] Cloudflare Pages routing configuration
- [x] Security headers (X-Frame-Options, CSP, etc.)
- [x] Route handlers for /privacy and /terms

**Bug Fixes:**
- [x] Mobile/tablet layout overflow bugs resolved
- [x] Cookie banner mobile layout fixed
- [x] Blog page mobile layout overflow fixed

**Testing:**
- [x] Comprehensive landing page tests
- [x] Sources page and footer tests
- [x] Consent and analytics service unit tests
- [x] Cookie banner widget tests

---

## [2024-12-24] - Legal Compliance & Documentation

### Legal Compliance Fixes

**SOC 2 Claim Remediation:**
- Changed "SOC 2 Type II" to "Enterprise Security" in trust indicators
- Updated comparison page to show "In progress (Q2 2025)" instead of "Certified"
- Files updated: `content.dart`, `hero_section.dart`, `social_proof_section.dart`, blog HTML

**GDPR Cookie Consent (Already Implemented):**
- Verified consent mode defaults to DENIED on app start
- GTM script only loads after explicit user consent
- Cookie banner displays if no prior consent exists
- Full granular consent options (Essential/Analytics/Marketing)

**EU AI Act Compliance Disclaimers:**
- Added `ComplianceDisclaimers` class with full legal text
- Footer now displays general platform disclaimer
- Compliance & Governance service card shows EU AI Act disclaimer
- Files: `constants.dart`, `footer_section.dart`, `services_content.dart`

**Statistics Source Citations:**
- Added `CitedStatistic` class with `value`, `label`, `source`, `sourceUrl`, `type`
- Added `AppStatistics` with all statistics and their sources
- Social proof section now shows source tooltips on hover
- Added source disclaimer at bottom of stats section
- Statistic types: `industry`, `customerData`, `platformMetric`, `slaTarget`

### Documentation Updates

**FLUTTER_ARCHITECTURE_GUIDELINES.md:**
- Added Consent Flow Architecture diagram
- Added Compliance Disclaimer Placement diagram
- Added Statistics Source Attribution diagram

### Statistics Sources Added

| Statistic | Value | Source |
|-----------|-------|--------|
| Debugging improvement | 73% | Aggregated customer data, Q4 2024 |
| Cost reduction | 30-50% | Customer-reported savings, 2024 |
| Market size | $2.9B+ | Grand View Research, 2024 |
| Market growth | 25.47% | Grand View Research, 2024 |
| Enterprise budgets | 98% | Gartner CIO Survey 2024 |
| Setup time | 5min | Median onboarding time |
| Uptime | 99.9% | SLA target |

---

## [December 2024] - Initial Implementation

### Landing Page Sections Implemented

**Core Sections:**
- Hero section with animations and responsive layout
- Features/Platform section (tabbed features)
- Navigation header (sticky, mobile menu)
- Footer section
- Pricing section with toggle
- CTA section

**Additional Sections:**
- About section - Company info display
- Services section - Service offerings
- Resources section - Blog/resources display
- Contact section - Form with validation
- Social proof section - Customer testimonials, trust badges
- Status section - Status indicators
- Tabbed features section - Feature showcase

### Pages

- Landing page (`lib/pages/landing_page.dart`) - Composes 12 sections
- Blog page (`lib/pages/blog_page.dart`) - Article display with filtering

### Content Published

**AI Observability Platform Strategy Series:**
- AI Observability Platform Strategy Overview
- Market Analysis: AI Observability Landscape
- Competitive Landscape Analysis
- Regulatory Drivers & EU AI Act Impact
- Growth Strategy & Go-to-Market
- Strategic Recommendations

**Agentic AI Content:**
- End-to-End Agentic Observability Lifecycle Guide

### Technical Implementation

**Architecture:**
- Content externalization in `config/content.dart`
- Theme system (colors, typography, spacing)
- Reusable widget library (buttons, cards, containers)
- Analytics service with GDPR compliance
- Sentry error tracking integration

**Testing:**
- Comprehensive widget tests for all sections
- Unit tests for content models
- Integration tests for landing page
- Function-level coverage reporting in CI/CD

**CI/CD:**
- GitHub Actions workflow
- Cloudflare Pages deployment
- Coverage reports deployed to GitHub Pages
- Function coverage script (`scripts/add_function_coverage.dart`)

### Design System

- Color palette (blue/indigo/purple theme)
- Typography scale with Inter font
- Spacing system (4px grid)
- Glass morphism cards
- Gradient buttons
- Animated orbs

---

## Version History

| Date | Version | Changes |
|------|---------|---------|
| 2024-12-24 | 1.3 | Brand assets (logo, favicon, og-image), legal pages, infrastructure |
| 2024-12-24 | 1.2 | Legal compliance fixes (SOC 2, EU AI Act disclaimers, statistics citations) |
| 2024-12-24 | 1.1 | Documentation updates, changelog consolidation |
| 2024-12-16 | 1.0 | Initial implementation complete |

---

*For detailed implementation plans, see:*
- `FLUTTER_LANDING_PAGE_PLAN.md` - Original implementation plan
- `FLUTTER_ARCHITECTURE_GUIDELINES.md` - Architecture patterns
- `CONTENT_STRATEGY.md` - Marketing and content strategy
