# Integration Test Roadmap

## Current State

- **Unit test coverage**: 94% (615+ tests)
- **Widget test coverage**: Comprehensive
- **Integration tests**: None (`test/integration/` is empty)

Integration tests are critical for validating end-to-end user flows and catching issues that unit/widget tests miss (navigation state, service interactions, form submissions).

## Priority User Flows

### Phase 1: Critical Paths (High Priority)

#### 1. Contact Form Submission Flow
**Business Impact**: Lead generation
**Flow**:
1. Navigate to `/contact`
2. Fill form fields (name, email, company, message)
3. Submit form
4. Verify success state
5. Verify analytics tracking fired

**Test File**: `test/integration/contact_flow_test.dart`

```dart
// Pseudo-implementation
testWidgets('complete contact form submission', (tester) async {
  await tester.pumpWidget(app);
  await tester.tap(find.text('Contact'));
  await tester.pumpAndSettle();

  await tester.enterText(find.byKey(Key('name')), 'Test User');
  await tester.enterText(find.byKey(Key('email')), 'test@example.com');
  await tester.enterText(find.byKey(Key('message')), 'Hello');
  await tester.tap(find.text('Submit'));
  await tester.pumpAndSettle();

  expect(find.text('Thank you'), findsOneWidget);
});
```

#### 2. Signup Flow
**Business Impact**: Conversion funnel
**Flow**:
1. Navigate to `/pricing`
2. Select a tier
3. Click "Get Started" -> navigates to `/signup?tier=X`
4. Fill signup form
5. Submit and verify confirmation

**Test File**: `test/integration/signup_flow_test.dart`

#### 3. Cookie Consent Flow
**Business Impact**: GDPR compliance
**Flow**:
1. Load app with `showCookieBanner: true`
2. Verify banner appears
3. Click "Accept All" or "Customize"
4. Verify consent saved
5. Verify analytics enabled/disabled appropriately

**Test File**: `test/integration/consent_flow_test.dart`

### Phase 2: Navigation Flows (Medium Priority)

#### 4. Landing Page CTA Navigation
**Flow**:
1. Load landing page
2. Click "Get Started" CTA
3. Verify navigation to signup
4. Click "Learn More"
5. Verify scroll to features section

**Test File**: `test/integration/landing_navigation_test.dart`

#### 5. Documentation Navigation
**Flow**:
1. Navigate to `/docs`
2. Click through sidebar links
3. Verify each docs page loads
4. Test breadcrumb navigation
5. Test back button behavior

**Test File**: `test/integration/docs_navigation_test.dart`

#### 6. Mobile Menu Navigation
**Flow**:
1. Set viewport to mobile size
2. Tap hamburger menu
3. Verify menu opens
4. Navigate to each main section
5. Verify menu closes after selection

**Test File**: `test/integration/mobile_navigation_test.dart`

### Phase 3: Cross-Feature Flows (Lower Priority)

#### 7. Pricing to Signup Flow
**Flow**:
1. View pricing page
2. Toggle annual/monthly billing
3. Click tier CTA
4. Verify correct tier passed to signup

#### 8. Blog to Contact Flow
**Flow**:
1. View blog page
2. Click CTA in blog post
3. Verify navigation to contact with context

#### 9. Comparison Page Conversion
**Flow**:
1. Navigate to `/whylabs-alternative`
2. Scroll through comparisons
3. Click conversion CTA
4. Verify signup navigation

## Implementation Plan

### Directory Structure

```
test/
├── integration/
│   ├── helpers/
│   │   ├── integration_test_helpers.dart
│   │   └── mock_services.dart
│   ├── contact_flow_test.dart
│   ├── signup_flow_test.dart
│   ├── consent_flow_test.dart
│   ├── landing_navigation_test.dart
│   ├── docs_navigation_test.dart
│   └── mobile_navigation_test.dart
```

### Shared Test Helpers

```dart
// test/integration/helpers/integration_test_helpers.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integrity_studio_ai/main.dart';

/// Pumps the full app with optional configuration
Future<void> pumpApp(
  WidgetTester tester, {
  bool showCookieBanner = false,
  Size screenSize = const Size(1920, 1080),
}) async {
  tester.view.physicalSize = screenSize;
  tester.view.devicePixelRatio = 1.0;

  await tester.pumpWidget(
    IntegrityStudioApp(showCookieBanner: showCookieBanner),
  );
  await tester.pumpAndSettle();
}

/// Navigate to a route and wait for it to settle
Future<void> navigateTo(WidgetTester tester, String route) async {
  // Find and tap navigation element or use go_router directly
  await tester.pumpAndSettle();
}

/// Fill a form field by key
Future<void> fillField(
  WidgetTester tester,
  String key,
  String value,
) async {
  await tester.enterText(find.byKey(Key(key)), value);
  await tester.pump();
}

/// Common screen sizes for responsive testing
class ScreenSizes {
  static const mobile = Size(375, 812);
  static const tablet = Size(768, 1024);
  static const desktop = Size(1920, 1080);
}
```

### Mock Services

```dart
// test/integration/helpers/mock_services.dart

import 'package:mockito/mockito.dart';
import 'package:integrity_studio_ai/services/contact_service.dart';

class MockContactService extends Mock implements ContactService {
  bool submitCalled = false;

  @override
  Future<bool> submitContactForm({...}) async {
    submitCalled = true;
    return true;
  }
}

/// Setup service mocks for integration tests
void setupIntegrationMocks() {
  // Register mock services with GetIt or similar
}
```

## Testing Strategy

### What to Mock

| Component | Mock? | Reason |
|-----------|-------|--------|
| HTTP calls | Yes | Avoid network in tests |
| Analytics | Yes | Verify calls without sending |
| Consent storage | Yes | Isolate test state |
| Navigation | No | Test real navigation |
| Widgets | No | Test real rendering |

### What NOT to Mock

- GoRouter navigation
- Widget rendering
- Form validation
- State management
- Animations (use `pumpAndSettle`)

## Success Criteria

### Phase 1 Complete When:
- [ ] Contact form flow test passes
- [ ] Signup flow test passes
- [ ] Consent flow test passes
- [ ] Tests run in CI pipeline

### Phase 2 Complete When:
- [ ] All navigation flows tested
- [ ] Mobile responsive flows tested
- [ ] 95%+ of critical paths covered

### Phase 3 Complete When:
- [ ] Cross-feature flows tested
- [ ] Edge cases covered
- [ ] Performance benchmarks established

## Estimated Effort

| Phase | Tests | Estimated Hours |
|-------|-------|-----------------|
| Phase 1 | 3 flows | 8-12 hours |
| Phase 2 | 3 flows | 6-8 hours |
| Phase 3 | 3 flows | 4-6 hours |
| **Total** | **9 flows** | **18-26 hours** |

## Running Integration Tests

```bash
# Run all integration tests
flutter test test/integration/

# Run specific flow
flutter test test/integration/contact_flow_test.dart

# Run with coverage
flutter test test/integration/ --coverage

# Run on specific device (for web testing)
flutter drive --target=test/integration/contact_flow_test.dart
```

## CI/CD Integration

Add to GitHub Actions workflow:

```yaml
integration-tests:
  runs-on: ubuntu-latest
  steps:
    - uses: actions/checkout@v4
    - uses: subosito/flutter-action@v2
    - run: flutter pub get
    - run: flutter test test/integration/ --reporter github
```

## References

- [Flutter Integration Testing](https://docs.flutter.dev/testing/integration-tests)
- [go_router Testing](https://pub.dev/packages/go_router#testing)
- [Widget Testing Best Practices](https://docs.flutter.dev/testing/overview)
