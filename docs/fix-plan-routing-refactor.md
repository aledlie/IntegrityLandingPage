# Fix Plan: Routing Boilerplate Refactor

## Issue Summary

**File**: `lib/app.dart`
**Lines**: 86-508 (~420 lines)
**Problem**: Massive routing boilerplate with repetitive if-statements

## Current State

The `onGenerateRoute` handler contains 25+ nearly identical route handlers, each following this pattern:

```dart
if (settings.name == '/some-route') {
  return MaterialPageRoute(
    builder: (context) => Stack(
      children: [
        SomePage(
          onBack: () => Navigator.of(context).pushReplacementNamed('/'),
          onShowCookieSettings: _showCookieSettings,  // optional
        ),
        if (_showCookieBanner)
          CookieBanner(onConsentGiven: _handleConsentGiven),
      ],
    ),
  );
}
```

### Problems

1. **Duplication**: Same Stack + CookieBanner pattern repeated 25+ times
2. **Maintenance burden**: Adding a new route requires ~15 lines of boilerplate
3. **Error-prone**: Easy to forget cookie banner or onBack callback
4. **Hard to read**: 420 lines obscures the actual route structure

## Proposed Solution

### Option A: Route Table with Builder (Recommended)

Create a declarative route configuration:

```dart
// lib/config/routes.dart
class AppRoute {
  final String path;
  final Widget Function(VoidCallback onBack, VoidCallback? onShowCookieSettings) builder;
  final bool showCookieSettings;

  const AppRoute({
    required this.path,
    required this.builder,
    this.showCookieSettings = false,
  });
}

final List<AppRoute> appRoutes = [
  AppRoute(
    path: '/blog',
    builder: (onBack, _) => BlogPage(onBack: onBack),
  ),
  AppRoute(
    path: '/about',
    showCookieSettings: true,
    builder: (onBack, onSettings) => AboutPage(
      onBack: onBack,
      onShowCookieSettings: onSettings,
    ),
  ),
  // ... more routes
];
```

Then in `app.dart`:

```dart
Route<dynamic>? _generateRoute(RouteSettings settings) {
  // Find matching route
  final route = appRoutes.firstWhereOrNull(
    (r) => settings.name == r.path || settings.name?.startsWith('${r.path}?') == true,
  );

  if (route != null) {
    return MaterialPageRoute(
      builder: (context) => _wrapWithBanner(
        route.builder(
          () => Navigator.of(context).pushReplacementNamed('/'),
          route.showCookieSettings ? _showCookieSettings : null,
        ),
      ),
    );
  }

  // Default to landing page
  return MaterialPageRoute(
    builder: (context) => _wrapWithBanner(
      LandingPage(onShowCookieSettings: _showCookieSettings),
    ),
  );
}

Widget _wrapWithBanner(Widget page) {
  return Stack(
    children: [
      page,
      if (_showCookieBanner)
        CookieBanner(onConsentGiven: _handleConsentGiven),
    ],
  );
}
```

### Option B: GoRouter Migration

Use `go_router` package for declarative routing:

```dart
final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (_, __) => LandingPage()),
    GoRoute(path: '/blog', builder: (_, __) => BlogPage()),
    GoRoute(path: '/about', builder: (_, __) => AboutPage()),
    // ...
  ],
);
```

**Pros**: Industry standard, supports deep linking, web URL handling
**Cons**: Larger migration, dependency addition

## Implementation Steps

### Phase 1: Create Route Configuration (Option A)

1. Create `lib/config/routes.dart` with route definitions
2. Create `_wrapWithBanner` helper method
3. Refactor `onGenerateRoute` to use route table
4. Run tests to verify all routes work

### Phase 2: Handle Special Cases

1. Query parameter routes (e.g., `/signup?tier=starter`)
2. Redirect routes (e.g., `/support` -> `/contact`)
3. Wildcard routes (e.g., `/reports/*`)

### Phase 3: Cleanup

1. Remove old if-statement code
2. Update any tests that depend on routing internals
3. Document route configuration

## Expected Results

| Metric | Before | After |
|--------|--------|-------|
| Lines in app.dart | ~510 | ~150 |
| Lines per new route | ~15 | ~5 |
| Route definitions | Scattered | Centralized |

## Files to Modify

- `lib/app.dart` - Refactor routing logic
- `lib/config/routes.dart` - New file for route configuration

## Testing

- All existing navigation tests should pass
- Manual verification of each route
- Deep link testing for web
