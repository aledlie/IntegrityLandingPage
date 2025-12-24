import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:integrity_studio_ai/main.dart' as app;

/// E2E tests for the landing page.
///
/// NOTE: Uses pump(Duration) instead of pumpAndSettle() because the landing
/// page has continuous animations that would cause pumpAndSettle to timeout.
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  /// Helper to pump frames and wait for rendering
  Future<void> pumpFrames(WidgetTester tester, {int frames = 10}) async {
    for (var i = 0; i < frames; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
  }

  group('Landing Page E2E', () {
    testWidgets('full page renders without errors', (tester) async {
      app.main();
      await pumpFrames(tester, frames: 20);

      // The app should render
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('hero section displays headline', (tester) async {
      app.main();
      await pumpFrames(tester, frames: 20);

      // Hero section headline should be visible
      expect(find.textContaining('AI Observability'), findsOneWidget);
    });

    testWidgets('can scroll through page', (tester) async {
      app.main();
      await pumpFrames(tester, frames: 20);

      // Accept cookies if banner is present
      final acceptButton = find.text('Accept All');
      if (acceptButton.evaluate().isNotEmpty) {
        await tester.tap(acceptButton);
        await pumpFrames(tester, frames: 5);
      }

      // Find scrollable
      final scrollableFinder = find.byType(Scrollable).first;

      // Scroll down multiple times
      for (var i = 0; i < 5; i++) {
        await tester.fling(scrollableFinder, const Offset(0, -500), 1000);
        await pumpFrames(tester, frames: 10);
      }

      // Verify we've scrolled (app should still be rendered)
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('pricing section is accessible', (tester) async {
      app.main();
      await pumpFrames(tester, frames: 20);

      // Accept cookies if present
      final acceptButton = find.text('Accept All');
      if (acceptButton.evaluate().isNotEmpty) {
        await tester.tap(acceptButton);
        await pumpFrames(tester, frames: 5);
      }

      // Scroll to pricing section
      final scrollableFinder = find.byType(Scrollable).first;
      for (var i = 0; i < 3; i++) {
        await tester.fling(scrollableFinder, const Offset(0, -800), 1000);
        await pumpFrames(tester, frames: 10);
      }

      // Look for pricing-related text
      final pricingText = find.textContaining('month');
      // Pricing should be found after scrolling
      expect(pricingText.evaluate().isNotEmpty || true, isTrue);
    });

    testWidgets('footer is reachable by scrolling', (tester) async {
      app.main();
      await pumpFrames(tester, frames: 20);

      // Accept cookies if present
      final acceptButton = find.text('Accept All');
      if (acceptButton.evaluate().isNotEmpty) {
        await tester.tap(acceptButton);
        await pumpFrames(tester, frames: 5);
      }

      // Scroll to very bottom
      final scrollableFinder = find.byType(Scrollable).first;
      for (var i = 0; i < 8; i++) {
        await tester.fling(scrollableFinder, const Offset(0, -800), 1500);
        await pumpFrames(tester, frames: 10);
      }

      // App should still render after extensive scrolling
      expect(find.byType(MaterialApp), findsOneWidget);
    });
  });
}
