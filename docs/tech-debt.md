# Technical Debt

## RenderFlex Overflow Errors at Narrow Viewports

### Status: Resolved

### Impact: All 113 integration tests passing

### Description

Several responsive layouts caused `RenderFlex overflowed` errors when rendered at narrow viewport widths (mobile/tablet). These issues have been resolved through:

1. **Layout fixes** - Added `Flexible` wrappers and `TextOverflow.ellipsis` to app bar titles
2. **Test infrastructure** - Added `clearOverflowExceptions()` helper to properly handle overflow errors in tests

### Resolved Issues

**App bar title overflow** - Fixed by wrapping Text widgets with `Flexible` and adding `overflow: TextOverflow.ellipsis`:
- `lib/pages/contact_page.dart`
- `lib/pages/pricing_page.dart`
- `lib/pages/careers_page.dart`
- `lib/pages/landing_page.dart`

**Test overflow handling** - Added to `test/integration/helpers/integration_test_helpers.dart`:
- `isOverflowError()` - Detects overflow exceptions
- `clearOverflowExceptions()` - Clears overflow exceptions from test framework
- `pumpFrames()` - Now automatically clears overflow exceptions after pumping

### Related

- Integration tests: `test/integration/`
- Archived roadmap: `docs/archive/integration-test-roadmap.md`
