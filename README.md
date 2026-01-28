# Integrity Studio AI

[![CI](https://github.com/aledlie/IntegrityLandingPage/actions/workflows/ci.yml/badge.svg)](https://github.com/aledlie/IntegrityLandingPage/actions/workflows/ci.yml)
[![Coverage](https://img.shields.io/endpoint?url=https://aledlie.github.io/IntegrityLandingPage/badge.json)](https://aledlie.github.io/IntegrityLandingPage/)

Landing page for Integrity Studio AI - AI Observability Platform.

## Development

### Prerequisites

- Flutter 3.32.0 or later
- Dart SDK

### Setup

```bash
# Install dependencies
flutter pub get

# Run in development
flutter run -d chrome
```

### Testing

```bash
# Run all unit and widget tests
flutter test

# Run tests with coverage
flutter test --coverage

# Generate HTML coverage report
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html

# Run E2E tests in Chrome (requires chromedriver)
chromedriver --port=4444 &
flutter drive --driver=test_driver/integration_test.dart \
  --target=integration_test/e2e/landing_page_test.dart -d chrome
```

### Build

```bash
# Build web release
flutter build web --release
```

## Project Structure

```
lib/
├── config/           # Content configuration
├── pages/            # Landing page, Blog page
├── services/         # Analytics, consent management
├── theme/            # Colors, typography, spacing
└── widgets/
    ├── common/       # Reusable buttons, cards
    └── sections/     # Hero, features, pricing, etc.
```

## Route Status

### Implemented Routes

| Route | Page |
|-------|------|
| `/` | Landing page |
| `/blog` | Blog page |
| `/about` | About page |
| `/pricing` | Pricing page |
| `/contact` | Contact page |
| `/careers` | Careers page |
| `/security` | Security page |
| `/signup` | Signup page |
| `/privacy` | Privacy policy |
| `/terms` | Terms of service |
| `/cookies` | Cookies policy |
| `/accessibility` | Accessibility statement |
| `/sources` | Sources page |
| `/whylabs-alternative` | WhyLabs comparison |
| `/compare/arize-ai-alternative` | Arize comparison |

### Documentation Routes

| Route | Status |
|-------|--------|
| `/docs` | Implemented (Documentation Index) |
| `/docs/quickstart` | Implemented (Quick Start) |
| `/docs/api` | Implemented (API Reference) |
| `/docs/integrations` | Implemented (Interoperability) |
| `/docs/alerts` | Implemented (Alerts Guide) |
| `/docs/tracing` | Implemented (Tracing Guide) |
| `/docs/claude-code-observability` | Implemented (Observability Guide) |
| `/docs/compliance` | Not implemented |
| `/docs/agents` | Not implemented |

### Not Implemented (will redirect to home)

| Route | Status |
|-------|--------|
| `/api` | Not implemented |
| `/support` | Not implemented |
| `/eu-ai-act` | Not implemented |

### Footer Links Status

| Link | Target | Status |
|------|--------|--------|
| Features | `#features` | Anchor (doesn't scroll from footer) |
| API Reference | `/api` | Not implemented |
| Help Center | `/support` | Not implemented |

## Test Coverage

Coverage reports are automatically generated and deployed to GitHub Pages on every push to main. Reports include function-level coverage metrics.

**[View Coverage Report](https://aledlie.github.io/IntegrityLandingPage/)**

### Coverage in PRs

Pull requests automatically receive a coverage comment showing:
- Overall coverage percentage
- Function coverage summary
- Link to download the full HTML report
