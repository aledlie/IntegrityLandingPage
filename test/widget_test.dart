/// Widget tests for Integrity Studio AI landing page.
///
/// These tests verify the app loads correctly and basic UI elements render.
/// Sentry is not initialized during tests (no DSN configured).
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:integrity_studio_ai/app.dart';

void main() {
  group('IntegrityStudioApp', () {
    testWidgets('renders without errors', (tester) async {
      await tester.pumpWidget(const IntegrityStudioApp());
      await tester.pumpAndSettle();

      expect(find.byType(IntegrityStudioApp), findsOneWidget);
    });

    testWidgets('contains MaterialApp', (tester) async {
      await tester.pumpWidget(const IntegrityStudioApp());

      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('uses dark theme background', (tester) async {
      await tester.pumpWidget(const IntegrityStudioApp());
      await tester.pumpAndSettle();

      final scaffold = tester.widget<Scaffold>(find.byType(Scaffold).first);
      expect(scaffold.backgroundColor, isNotNull);
    });
  });
}
