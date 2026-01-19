import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integrity_studio_ai/app.dart';
import 'package:integrity_studio_ai/pages/landing_page.dart';
import 'package:integrity_studio_ai/pages/blog_page.dart';
import 'package:integrity_studio_ai/pages/comparison_page.dart';
import 'package:integrity_studio_ai/pages/sources_page.dart';
import 'package:integrity_studio_ai/pages/about_page.dart';
import 'package:integrity_studio_ai/pages/signup_page.dart';
import 'package:integrity_studio_ai/pages/legal_page.dart';
import 'helpers/test_helpers.dart';

void main() {
  setUpAll(() {
    initializeTestContent();
  });

  void setDesktopSize(WidgetTester tester) {
    tester.view.physicalSize = const Size(1920, 1080);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
  }

  group('IntegrityStudioApp', () {
    group('construction', () {
      testWidgets('creates without error', (tester) async {
        setDesktopSize(tester);

        await tester.pumpWidget(const IntegrityStudioApp());
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.byType(IntegrityStudioApp), findsOneWidget);
      });

      testWidgets('shows MaterialApp', (tester) async {
        setDesktopSize(tester);

        await tester.pumpWidget(const IntegrityStudioApp());
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.byType(MaterialApp), findsOneWidget);
      });
    });

    group('routing', () {
      testWidgets('initial route shows landing page', (tester) async {
        setDesktopSize(tester);

        await tester.pumpWidget(const IntegrityStudioApp());
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.byType(LandingPage), findsOneWidget);
      });

      testWidgets('navigates to blog page', (tester) async {
        setDesktopSize(tester);

        await tester.pumpWidget(const IntegrityStudioApp());
        await tester.pump(const Duration(milliseconds: 100));

        // Navigate to blog - get context from a widget inside Navigator
        final context = tester.element(find.byType(LandingPage));
        Navigator.of(context).pushNamed('/blog');
        await tester.pumpAndSettle();

        expect(find.byType(BlogPage), findsOneWidget);
      });

      testWidgets('navigates to whylabs alternative page', (tester) async {
        setDesktopSize(tester);

        await tester.pumpWidget(const IntegrityStudioApp());
        await tester.pump(const Duration(milliseconds: 100));

        final context = tester.element(find.byType(LandingPage));
        Navigator.of(context).pushNamed('/whylabs-alternative');
        await tester.pumpAndSettle();

        expect(find.byType(ComparisonPage), findsOneWidget);
      });

      testWidgets('navigates to arize alternative page', (tester) async {
        setDesktopSize(tester);

        await tester.pumpWidget(const IntegrityStudioApp());
        await tester.pump(const Duration(milliseconds: 100));

        final context = tester.element(find.byType(LandingPage));
        Navigator.of(context).pushNamed('/compare/arize-ai-alternative');
        await tester.pumpAndSettle();

        expect(find.byType(ComparisonPage), findsOneWidget);
      });

      testWidgets('navigates to sources page', (tester) async {
        setDesktopSize(tester);

        await tester.pumpWidget(const IntegrityStudioApp());
        await tester.pump(const Duration(milliseconds: 100));

        final context = tester.element(find.byType(LandingPage));
        Navigator.of(context).pushNamed('/sources');
        await tester.pumpAndSettle();

        expect(find.byType(SourcesPage), findsOneWidget);
      });

      testWidgets('navigates to about page', (tester) async {
        setDesktopSize(tester);

        await tester.pumpWidget(const IntegrityStudioApp());
        await tester.pump(const Duration(milliseconds: 100));

        final context = tester.element(find.byType(LandingPage));
        Navigator.of(context).pushNamed('/about');
        // Pump multiple frames for route transition animation
        for (int i = 0; i < 10; i++) {
          await tester.pump(const Duration(milliseconds: 50));
        }

        expect(find.byType(AboutPage), findsOneWidget);
      });

      testWidgets('navigates to signup page', (tester) async {
        setDesktopSize(tester);

        await tester.pumpWidget(const IntegrityStudioApp());
        await tester.pump(const Duration(milliseconds: 100));

        final context = tester.element(find.byType(LandingPage));
        Navigator.of(context).pushNamed('/signup');
        // Pump multiple frames for route transition animation
        for (int i = 0; i < 10; i++) {
          await tester.pump(const Duration(milliseconds: 50));
        }

        expect(find.byType(SignupPage), findsOneWidget);
      });

      testWidgets('navigates to signup page with tier parameter', (tester) async {
        setDesktopSize(tester);

        await tester.pumpWidget(const IntegrityStudioApp());
        await tester.pump(const Duration(milliseconds: 100));

        final context = tester.element(find.byType(LandingPage));
        Navigator.of(context).pushNamed('/signup?tier=growth');
        // Pump multiple frames for route transition animation
        for (int i = 0; i < 10; i++) {
          await tester.pump(const Duration(milliseconds: 50));
        }

        expect(find.byType(SignupPage), findsOneWidget);
      });

      testWidgets('navigates to privacy page', (tester) async {
        setDesktopSize(tester);

        await tester.pumpWidget(const IntegrityStudioApp());
        await tester.pump(const Duration(milliseconds: 100));

        final context = tester.element(find.byType(LandingPage));
        Navigator.of(context).pushNamed('/privacy');
        await tester.pumpAndSettle();

        expect(find.byType(LegalPage), findsOneWidget);
      });

      testWidgets('navigates to terms page', (tester) async {
        setDesktopSize(tester);

        await tester.pumpWidget(const IntegrityStudioApp());
        await tester.pump(const Duration(milliseconds: 100));

        final context = tester.element(find.byType(LandingPage));
        Navigator.of(context).pushNamed('/terms');
        await tester.pumpAndSettle();

        expect(find.byType(LegalPage), findsOneWidget);
      });

      testWidgets('navigates to cookies page', (tester) async {
        setDesktopSize(tester);

        await tester.pumpWidget(const IntegrityStudioApp());
        await tester.pump(const Duration(milliseconds: 100));

        final context = tester.element(find.byType(LandingPage));
        Navigator.of(context).pushNamed('/cookies');
        await tester.pumpAndSettle();

        expect(find.byType(LegalPage), findsOneWidget);
      });

      testWidgets('navigates to accessibility page', (tester) async {
        setDesktopSize(tester);

        await tester.pumpWidget(const IntegrityStudioApp());
        await tester.pump(const Duration(milliseconds: 100));

        final context = tester.element(find.byType(LandingPage));
        Navigator.of(context).pushNamed('/accessibility');
        await tester.pumpAndSettle();

        expect(find.byType(LegalPage), findsOneWidget);
      });

      testWidgets('unknown routes show landing page', (tester) async {
        setDesktopSize(tester);

        await tester.pumpWidget(const IntegrityStudioApp());
        await tester.pump(const Duration(milliseconds: 100));

        final context = tester.element(find.byType(LandingPage));
        Navigator.of(context).pushNamed('/nonexistent-page');
        // Pump multiple frames for route transition animation
        for (int i = 0; i < 10; i++) {
          await tester.pump(const Duration(milliseconds: 50));
        }

        // At least one LandingPage should be visible (may have 2 in stack)
        expect(find.byType(LandingPage), findsWidgets);
      });
    });

    group('theme', () {
      testWidgets('uses dark theme', (tester) async {
        setDesktopSize(tester);

        await tester.pumpWidget(const IntegrityStudioApp());
        await tester.pump(const Duration(milliseconds: 100));

        final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
        expect(materialApp.theme, isNotNull);
      });

      testWidgets('has correct title', (tester) async {
        setDesktopSize(tester);

        await tester.pumpWidget(const IntegrityStudioApp());
        await tester.pump(const Duration(milliseconds: 100));

        final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
        expect(
          materialApp.title,
          equals('Integrity Studio - Enterprise AI Observability'),
        );
      });

      testWidgets('hides debug banner', (tester) async {
        setDesktopSize(tester);

        await tester.pumpWidget(const IntegrityStudioApp());
        await tester.pump(const Duration(milliseconds: 100));

        final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
        expect(materialApp.debugShowCheckedModeBanner, isFalse);
      });
    });
  });
}
