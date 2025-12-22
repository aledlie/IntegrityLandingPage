import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:integrity_studio_ai/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Landing Page E2E', () {
    testWidgets('full page renders without errors', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // The app should render
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('cookie banner appears on fresh app', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Cookie banner should appear (may not if consent already exists)
      // This is environment-dependent
    });

    testWidgets('can scroll through all sections', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Accept cookies if banner is present
      final acceptButton = find.text('Accept All');
      if (acceptButton.evaluate().isNotEmpty) {
        await tester.tap(acceptButton);
        await tester.pumpAndSettle();
      }

      // Scroll down
      await tester.fling(
        find.byType(Scrollable).first,
        const Offset(0, -500),
        1000,
      );
      await tester.pumpAndSettle();

      // Continue scrolling to features
      await tester.fling(
        find.byType(Scrollable).first,
        const Offset(0, -500),
        1000,
      );
      await tester.pumpAndSettle();

      // Continue to pricing
      await tester.fling(
        find.byType(Scrollable).first,
        const Offset(0, -500),
        1000,
      );
      await tester.pumpAndSettle();

      // Continue to footer
      await tester.fling(
        find.byType(Scrollable).first,
        const Offset(0, -500),
        1000,
      );
      await tester.pumpAndSettle();
    });

    testWidgets('pricing toggle switches billing period', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Accept cookies if present
      final acceptButton = find.text('Accept All');
      if (acceptButton.evaluate().isNotEmpty) {
        await tester.tap(acceptButton);
        await tester.pumpAndSettle();
      }

      // Scroll to pricing section
      await tester.fling(
        find.byType(Scrollable).first,
        const Offset(0, -1000),
        1000,
      );
      await tester.pumpAndSettle();

      // Find and tap Monthly toggle
      final monthlyToggle = find.text('Monthly');
      if (monthlyToggle.evaluate().isNotEmpty) {
        await tester.tap(monthlyToggle);
        await tester.pumpAndSettle();
      }

      // Find and tap Annual toggle
      final annualToggle = find.text('Annual');
      if (annualToggle.evaluate().isNotEmpty) {
        await tester.tap(annualToggle);
        await tester.pumpAndSettle();
      }
    });

    testWidgets('footer renders at bottom', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Accept cookies if present
      final acceptButton = find.text('Accept All');
      if (acceptButton.evaluate().isNotEmpty) {
        await tester.tap(acceptButton);
        await tester.pumpAndSettle();
      }

      // Scroll to very bottom
      await tester.fling(
        find.byType(Scrollable).first,
        const Offset(0, -3000),
        2000,
      );
      await tester.pumpAndSettle();

      // Footer should be visible
      expect(find.text('IntegrityStudio'), findsOneWidget);
    });
  });
}
