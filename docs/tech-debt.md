# Technical Debt

## RenderFlex Overflow Errors at Narrow Viewports

### Status: Open

### Impact: 19 integration tests failing

### Description

Several responsive layouts cause `RenderFlex overflowed` errors when rendered at narrow viewport widths (mobile/tablet). This affects:

- **Navbar Row** - Header Row overflows when viewport < 571px
- **Section layouts** - Various sections overflow at narrow widths
- **App bar title** - Title row in SliverAppBar overflows on mobile

### Affected Tests

Integration tests that fail due to this issue:

| Test File | Failing Tests |
|-----------|---------------|
| `mobile_navigation_test.dart` | 14 tests |
| `contact_flow_test.dart` | 2 tests |
| `consent_flow_test.dart` | 2 tests |
| `landing_navigation_test.dart` | 1 test |

### Root Cause

1. **Fixed-width elements in Row widgets** - Nav items and titles don't adapt to constrained widths
2. **Missing Flexible/Expanded wrappers** - Content doesn't shrink when space is limited
3. **Test viewport mismatch** - Flutter test default viewport (800x600) doesn't match production breakpoints

### Current Workaround

Tests use overflow error suppression (technical debt):

```dart
void suppressOverflowErrors() {
  FlutterError.onError = (FlutterErrorDetails details) {
    final isOverflowError =
        details.exception.toString().contains('overflowed');
    if (!isOverflowError) {
      originalOnError?.call(details);
    }
  };
}
```

This masks the errors but doesn't fix the underlying layout issues.

### Proper Fix

1. **Navbar responsive fix**
   - Add `Flexible` or `Expanded` wrappers to nav items
   - Implement proper responsive breakpoints for nav items
   - Use `Wrap` or overflow menu for narrow widths

2. **Section layout audit**
   - Review each section's min-width constraints
   - Add responsive wrappers or scrollable containers
   - Test at all breakpoints: mobile (375px), tablet (768px), desktop (1920px)

3. **App bar title fix**
   - Wrap title Row content with `Flexible`
   - Add `overflow: TextOverflow.ellipsis` to text widgets
   - Consider hiding subtitle on mobile

4. **Test approach**
   - Set proper viewport sizes before each test: `tester.view.physicalSize = Size(1920, 1080)`
   - Use `pump()` with duration instead of `pumpAndSettle()` for pages with continuous animations

### Estimated Effort

| Task | Hours |
|------|-------|
| Navbar responsive fix | 2-3 |
| Section layout audit | 4-6 |
| App bar title fix | 1-2 |
| Test refactor | 2-3 |
| **Total** | **9-14** |

### Files to Modify

- `lib/widgets/common/navbar.dart` - Navbar layout
- `lib/pages/contact_page.dart` - App bar title
- `lib/pages/pricing_page.dart` - App bar title
- `lib/pages/docs_index_page.dart` - App bar title
- `lib/widgets/sections/*.dart` - Section layouts

### Related

- Integration tests: `test/integration/`
- Archived roadmap: `docs/archive/integration-test-roadmap.md`
