# Integrity Studio AI

[![CI](https://github.com/aledlie/IntegrityLandingPage/actions/workflows/ci.yml/badge.svg)](https://github.com/aledlie/IntegrityLandingPage/actions/workflows/ci.yml)
[![codecov](https://codecov.io/gh/aledlie/IntegrityLandingPage/branch/main/graph/badge.svg)](https://codecov.io/gh/aledlie/IntegrityLandingPage)

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

## Test Coverage

Coverage reports are generated automatically in CI and uploaded to Codecov.

To generate coverage locally:

```bash
flutter test --coverage
# Install lcov: brew install lcov (macOS) or apt-get install lcov (Linux)
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```
