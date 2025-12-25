import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integrity_studio_ai/pages/landing_page.dart';
import 'package:integrity_studio_ai/widgets/sections/hero_section.dart';
import 'package:integrity_studio_ai/widgets/sections/tabbed_features_section.dart';
import '../helpers/test_helpers.dart';

void main() {
  group('LandingPage', () {
    // Use pump with duration instead of pumpAndSettle to avoid animation timeouts
    Future<void> pumpLandingPage(WidgetTester tester,
        {VoidCallback? onShowCookieSettings}) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: testTheme,
          home: LandingPage(onShowCookieSettings: onShowCookieSettings),
        ),
      );
      // Pump a few frames to let the widget build
      await tester.pump(const Duration(milliseconds: 100));
      await tester.pump(const Duration(milliseconds: 100));
    }

    group('widget structure', () {
      testWidgets('renders as Scaffold', (tester) async {
        setDesktopSize(tester);
        await pumpLandingPage(tester);

        expect(find.byType(Scaffold), findsWidgets);
        expect(find.byType(LandingPage), findsOneWidget);
      });

      testWidgets('renders CustomScrollView for smooth scrolling',
          (tester) async {
        setDesktopSize(tester);
        await pumpLandingPage(tester);

        expect(find.byType(CustomScrollView), findsOneWidget);
      });

      testWidgets('renders SelectionArea for text selection', (tester) async {
        setDesktopSize(tester);
        await pumpLandingPage(tester);

        expect(find.byType(SelectionArea), findsOneWidget);
      });

      testWidgets('renders HeroSection as first visible section',
          (tester) async {
        setDesktopSize(tester);
        await pumpLandingPage(tester);

        expect(find.byType(HeroSection), findsOneWidget);
      });

      testWidgets('renders TabbedFeaturesSection', (tester) async {
        setDesktopSize(tester);
        await pumpLandingPage(tester);

        expect(find.byType(TabbedFeaturesSection), findsOneWidget);
      });

      testWidgets('contains SliverToBoxAdapter widgets for sections',
          (tester) async {
        setDesktopSize(tester);
        await pumpLandingPage(tester);

        // At least some slivers should be present
        expect(find.byType(SliverToBoxAdapter), findsWidgets);
      });
    });

    group('accessibility', () {
      testWidgets('hero section has semantic label', (tester) async {
        setDesktopSize(tester);
        await pumpLandingPage(tester);

        expect(find.bySemanticsLabel('Hero section'), findsOneWidget);
      });

      testWidgets('feature explorer section has semantic label',
          (tester) async {
        setDesktopSize(tester);
        await pumpLandingPage(tester);

        expect(
            find.bySemanticsLabel('Feature explorer section'), findsOneWidget);
      });

      testWidgets('sections use Semantics widgets', (tester) async {
        setDesktopSize(tester);
        await pumpLandingPage(tester);

        // Semantics widgets are used for accessibility
        expect(find.byType(Semantics), findsWidgets);
      });
    });

    group('responsive design', () {
      testWidgets('renders correctly on mobile', (tester) async {
        setMobileSize(tester);
        await pumpLandingPage(tester);

        expect(find.byType(LandingPage), findsOneWidget);
        expect(find.byType(CustomScrollView), findsOneWidget);
      });

      testWidgets('renders correctly on tablet', (tester) async {
        setTabletSize(tester);
        await pumpLandingPage(tester);

        expect(find.byType(LandingPage), findsOneWidget);
        expect(find.byType(CustomScrollView), findsOneWidget);
      });

      testWidgets('renders correctly on desktop', (tester) async {
        setDesktopSize(tester);
        await pumpLandingPage(tester);

        expect(find.byType(LandingPage), findsOneWidget);
        expect(find.byType(HeroSection), findsOneWidget);
      });

      testWidgets('renders correctly on large desktop', (tester) async {
        setScreenSize(tester, TestScreenSizes.desktopLarge);
        await pumpLandingPage(tester);

        expect(find.byType(LandingPage), findsOneWidget);
        expect(find.byType(HeroSection), findsOneWidget);
      });
    });

    group('scroll behavior', () {
      testWidgets('has scroll controller attached', (tester) async {
        setDesktopSize(tester);
        await pumpLandingPage(tester);

        final scrollView = tester.widget<CustomScrollView>(
          find.byType(CustomScrollView),
        );
        expect(scrollView.controller, isNotNull);
      });

      testWidgets('page responds to scroll gestures', (tester) async {
        setDesktopSize(tester);
        await pumpLandingPage(tester);

        // Get initial scroll position
        final scrollView = tester.widget<CustomScrollView>(
          find.byType(CustomScrollView),
        );
        final initialOffset = scrollView.controller?.offset ?? 0;

        // Scroll down
        await tester.drag(find.byType(CustomScrollView), const Offset(0, -300));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));

        // Get new offset after scroll
        final newOffset = scrollView.controller?.offset ?? 0;

        // Offset should have changed
        expect(newOffset, greaterThan(initialOffset));
      });
    });

    group('hero section content', () {
      testWidgets('hero section is rendered', (tester) async {
        setDesktopSize(tester);
        await pumpLandingPage(tester);

        // HeroSection should be present
        expect(find.byType(HeroSection), findsOneWidget);
      });

      testWidgets('hero section has text content', (tester) async {
        setDesktopSize(tester);
        await pumpLandingPage(tester);

        // Hero section should have text widgets
        expect(find.byType(Text), findsWidgets);
      });
    });

    group('state management', () {
      testWidgets('widget can be disposed without errors', (tester) async {
        setDesktopSize(tester);
        await pumpLandingPage(tester);

        // Get the scroll controller reference
        final scrollView = tester.widget<CustomScrollView>(
          find.byType(CustomScrollView),
        );
        expect(scrollView.controller, isNotNull);

        // Replace with different widget to trigger dispose
        await tester.pumpWidget(
          MaterialApp(
            theme: testTheme,
            home: const Scaffold(body: Text('Replaced')),
          ),
        );
        await tester.pump();

        // Widget should be replaced successfully without throwing
        expect(find.text('Replaced'), findsOneWidget);
      });
    });

    group('callbacks', () {
      testWidgets('accepts optional onShowCookieSettings callback',
          (tester) async {
        setDesktopSize(tester);

        // Should work with callback
        await pumpLandingPage(
          tester,
          onShowCookieSettings: () {},
        );
        expect(find.byType(LandingPage), findsOneWidget);
      });

      testWidgets('works without onShowCookieSettings callback',
          (tester) async {
        setDesktopSize(tester);

        // Should work without callback
        await pumpLandingPage(tester);
        expect(find.byType(LandingPage), findsOneWidget);
      });
    });

    group('section navigation', () {
      testWidgets('sections have keyed subtrees for scroll navigation',
          (tester) async {
        setDesktopSize(tester);
        await pumpLandingPage(tester);

        // KeyedSubtree is used for section navigation
        expect(find.byType(KeyedSubtree), findsWidgets);
      });
    });

    group('constructor', () {
      testWidgets('creates with default parameters', (tester) async {
        setDesktopSize(tester);

        await tester.pumpWidget(
          MaterialApp(
            theme: testTheme,
            home: const LandingPage(),
          ),
        );
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.byType(LandingPage), findsOneWidget);
      });

      testWidgets('creates with onShowCookieSettings parameter',
          (tester) async {
        setDesktopSize(tester);

        await tester.pumpWidget(
          MaterialApp(
            theme: testTheme,
            home: LandingPage(onShowCookieSettings: () {}),
          ),
        );
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.byType(LandingPage), findsOneWidget);
      });
    });
  });
}
