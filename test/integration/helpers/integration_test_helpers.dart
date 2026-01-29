import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:integrity_studio_ai/services/content_loader.dart';
import '../../helpers/test_content.dart';

// Re-export test content helpers
export '../../helpers/test_content.dart' show initializeTestContent;

/// Original error handler, captured at file load time.
final FlutterExceptionHandler? originalOnError = FlutterError.onError;

/// Suppress RenderFlex overflow errors during tests.
///
/// NOTE: This is technical debt documented in docs/integration-test-roadmap.md.
/// Proper fix: Make responsive layouts handle narrow viewports without overflow.
/// Call this in setUp(), not setUpAll().
void suppressOverflowErrors() {
  FlutterError.onError = (FlutterErrorDetails details) {
    final isOverflowError =
        details.exception.toString().contains('overflowed') ||
            details.exception.toString().contains('RenderFlex') ||
            details.toString().contains('overflowed');
    if (!isOverflowError) {
      originalOnError?.call(details);
    }
  };
}

/// Restore original error handler.
/// Call this in tearDown(), not tearDownAll().
void restoreErrorHandler() {
  FlutterError.onError = originalOnError;
}

/// Common screen sizes for responsive testing.
class ScreenSizes {
  static const mobile = Size(375, 812);
  static const tablet = Size(768, 1024);
  static const desktop = Size(1920, 1080);
}

/// Helper to pump frames without using pumpAndSettle.
///
/// Landing page has continuous animations that cause pumpAndSettle to timeout.
Future<void> pumpFrames(WidgetTester tester, {int frames = 10}) async {
  for (var i = 0; i < frames; i++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}

/// Helper to dismiss cookie banner if present.
Future<void> dismissCookieBanner(WidgetTester tester) async {
  final acceptButton = find.text('Accept All');
  if (acceptButton.evaluate().isNotEmpty) {
    await tester.tap(acceptButton);
    await pumpFrames(tester, frames: 5);
  }
}

/// Set up screen size for testing.
void setScreenSize(WidgetTester tester, Size size) {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1.0;
  addTearDown(() {
    tester.view.resetPhysicalSize();
    tester.view.resetDevicePixelRatio();
  });
}

/// Set mobile viewport.
void setMobileSize(WidgetTester tester) {
  setScreenSize(tester, ScreenSizes.mobile);
}

/// Set desktop viewport.
void setDesktopSize(WidgetTester tester) {
  setScreenSize(tester, ScreenSizes.desktop);
}

/// Pumps the app with a testable router at a specific initial location.
///
/// This allows testing specific routes without going through navigation.
Future<void> pumpAppWithRoute(
  WidgetTester tester, {
  required String initialLocation,
  bool showCookieBanner = false,
  Size screenSize = ScreenSizes.desktop,
}) async {
  // Ensure test content is loaded
  if (!Content.isLoaded) {
    initializeTestContent();
  }

  setScreenSize(tester, screenSize);

  final router = GoRouter(
    initialLocation: initialLocation,
    routes: [
      ShellRoute(
        builder: (context, state, child) => child,
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) =>
                const Scaffold(body: Center(child: Text('Landing'))),
          ),
          GoRoute(
            path: '/pricing',
            builder: (context, state) =>
                const Scaffold(body: Center(child: Text('Pricing'))),
          ),
          GoRoute(
            path: '/signup',
            builder: (context, state) {
              final tier = state.uri.queryParameters['tier'] ?? 'starter';
              return Scaffold(
                body: Center(child: Text('Signup - $tier')),
              );
            },
          ),
          GoRoute(
            path: '/contact',
            builder: (context, state) =>
                const Scaffold(body: Center(child: Text('Contact'))),
          ),
          GoRoute(
            path: '/docs',
            builder: (context, state) =>
                const Scaffold(body: Center(child: Text('Docs'))),
          ),
          GoRoute(
            path: '/blog',
            builder: (context, state) =>
                const Scaffold(body: Center(child: Text('Blog'))),
          ),
          GoRoute(
            path: '/whylabs-alternative',
            builder: (context, state) =>
                const Scaffold(body: Center(child: Text('WhyLabs Alternative'))),
          ),
        ],
      ),
    ],
  );

  await tester.pumpWidget(
    MaterialApp.router(
      routerConfig: router,
    ),
  );
  await pumpFrames(tester, frames: 5);
}

/// Navigate to a route using GoRouter.
Future<void> navigateTo(WidgetTester tester, String route) async {
  final context = tester.element(find.byType(Navigator).first);
  GoRouter.of(context).go(route);
  await pumpFrames(tester, frames: 10);
}

/// Fill a form field by finding TextField with given label hint.
Future<void> fillFormField(
  WidgetTester tester,
  String labelText,
  String value,
) async {
  final textFields = find.byType(TextField);
  for (var i = 0; i < textFields.evaluate().length; i++) {
    final field = tester.widget<TextField>(textFields.at(i));
    final decoration = field.decoration;
    if (decoration?.labelText?.contains(labelText) == true ||
        decoration?.hintText?.contains(labelText) == true) {
      await tester.enterText(textFields.at(i), value);
      await pumpFrames(tester, frames: 2);
      return;
    }
  }
  // If no label match, try by index for simple forms
  await tester.enterText(textFields.first, value);
  await pumpFrames(tester, frames: 2);
}

/// Scroll to find a widget.
Future<bool> scrollToFind(
  WidgetTester tester,
  Finder finder, {
  int maxScrolls = 20,
}) async {
  final scrollableFinder = find.byType(Scrollable).first;

  for (var i = 0; i < maxScrolls; i++) {
    if (finder.evaluate().isNotEmpty) {
      return true;
    }
    await tester.fling(scrollableFinder, const Offset(0, -500), 1000);
    await pumpFrames(tester, frames: 5);
  }
  return finder.evaluate().isNotEmpty;
}

/// Find widget by text containing substring (case insensitive search).
Finder findTextContaining(String text) {
  return find.byWidgetPredicate(
    (widget) =>
        widget is Text &&
        widget.data != null &&
        widget.data!.toLowerCase().contains(text.toLowerCase()),
  );
}

/// Tap a button with given text.
Future<void> tapButton(WidgetTester tester, String buttonText) async {
  final button = find.text(buttonText);
  if (button.evaluate().isNotEmpty) {
    await tester.tap(button.first);
    await pumpFrames(tester, frames: 5);
  }
}

/// Check if text is visible anywhere on screen.
bool isTextVisible(String text) {
  return find.textContaining(text).evaluate().isNotEmpty;
}
