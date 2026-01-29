# Technical Debt

## RenderFlex Overflow Errors at Narrow Viewports

### Status: Partially Resolved

### Impact: 8 integration tests failing (down from 19)

### Description

Several responsive layouts cause `RenderFlex overflowed` errors when rendered at narrow viewport widths (mobile/tablet).

### Resolved Issues

**App bar title overflow** - Fixed by wrapping Text widgets with `Flexible` and adding `overflow: TextOverflow.ellipsis`:
- `lib/pages/contact_page.dart`
- `lib/pages/pricing_page.dart`
- `lib/pages/careers_page.dart`
- `lib/pages/landing_page.dart`

### Remaining Issues

- **Section layouts** - Various sections still overflow at narrow widths
- **Navbar Row** - Header Row overflows when viewport < 571px on some pages

### Affected Tests

| Test File | Failing Tests |
|-----------|---------------|
| `mobile_navigation_test.dart` | 5 tests |
| `consent_flow_test.dart` | 2 tests |
| `landing_navigation_test.dart` | 1 test |

### Current Workaround

Tests use overflow error suppression:

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

### Remaining Fix Tasks

1. **Section layout audit**
   - Review remaining sections' min-width constraints
   - Add responsive wrappers or scrollable containers
   - Test at all breakpoints: mobile (375px), tablet (768px), desktop (1920px)

2. **Navbar responsive fix** (if applicable)
   - Add `Flexible` or `Expanded` wrappers to nav items
   - Use `Wrap` or overflow menu for narrow widths

### Estimated Remaining Effort

| Task | Hours |
|------|-------|
| Section layout audit | 3-4 |
| Navbar responsive fix | 1-2 |
| **Total** | **4-6** |

### Related

- Integration tests: `test/integration/`
- Archived roadmap: `docs/archive/integration-test-roadmap.md`
