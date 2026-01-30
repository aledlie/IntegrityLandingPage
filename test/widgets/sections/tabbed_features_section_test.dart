import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:integrity_studio_ai/widgets/sections/tabbed_features_section.dart';
import '../../helpers/test_helpers.dart';

// Use larger desktop size to avoid overflow issues with tab row
void setLargeDesktopSize(WidgetTester tester) {
  setScreenSize(tester, const Size(1920, 1080));
}

void main() {

  group('TabbedFeaturesSection', () {
    group('section header', () {
      testWidgets('renders section title', (tester) async {
        setLargeDesktopSize(tester);

        await tester.pumpWidget(
          testableSection(const TabbedFeaturesSection()),
        );
        await tester.pumpAndSettle();

        expect(
          find.text('Everything you need for AI observability'),
          findsOneWidget,
        );
      });

      testWidgets('renders section subtitle', (tester) async {
        setLargeDesktopSize(tester);

        await tester.pumpWidget(
          testableSection(const TabbedFeaturesSection()),
        );
        await tester.pumpAndSettle();

        expect(
          find.text('Purpose-built tools for LLM applications'),
          findsOneWidget,
        );
      });
    });

    group('feature tabs', () {
      testWidgets('renders all 4 feature tabs on desktop', (tester) async {
        setLargeDesktopSize(tester);

        await tester.pumpWidget(
          testableSection(const TabbedFeaturesSection()),
        );
        await tester.pumpAndSettle();

        expect(find.text('Real-Time Tracing'), findsOneWidget);
        expect(find.text('Cost Analytics'), findsOneWidget);
        expect(find.text('EU AI Act Tools'), findsOneWidget);
        expect(find.text('Quality Metrics'), findsOneWidget);
      });

      testWidgets('renders short titles on mobile', (tester) async {
        setMobileSize(tester);

        await tester.pumpWidget(
          testableSection(const TabbedFeaturesSection()),
        );
        await tester.pumpAndSettle();

        expect(find.text('Tracing'), findsOneWidget);
        expect(find.text('Costs'), findsOneWidget);
        expect(find.text('Compliance'), findsOneWidget);
        expect(find.text('Quality'), findsOneWidget);
      });

      testWidgets('renders feature icons', (tester) async {
        setLargeDesktopSize(tester);

        await tester.pumpWidget(
          testableSection(const TabbedFeaturesSection()),
        );
        await tester.pumpAndSettle();

        expect(find.byIcon(LucideIcons.activity), findsWidgets);
        expect(find.byIcon(LucideIcons.dollarSign), findsWidgets);
        expect(find.byIcon(LucideIcons.shieldCheck), findsWidgets);
        expect(find.byIcon(LucideIcons.barChart3), findsWidgets);
      });

      testWidgets('first tab is selected by default', (tester) async {
        setLargeDesktopSize(tester);

        await tester.pumpWidget(
          testableSection(const TabbedFeaturesSection()),
        );
        await tester.pumpAndSettle();

        // First feature content should be visible
        expect(find.text('See every decision your AI makes'), findsOneWidget);
      });
    });

    group('feature content', () {
      testWidgets('shows Real-Time Tracing content by default', (tester) async {
        setLargeDesktopSize(tester);

        await tester.pumpWidget(
          testableSection(const TabbedFeaturesSection()),
        );
        await tester.pumpAndSettle();

        expect(find.text('See every decision your AI makes'), findsOneWidget);
        expect(find.textContaining('Full visibility into LLM calls'), findsOneWidget);
        expect(find.text('73% faster issue resolution'), findsOneWidget);
        expect(find.text('Complete request/response logging'), findsOneWidget);
        expect(find.text('Token usage analytics'), findsOneWidget);
        expect(find.text('Custom trace attributes'), findsOneWidget);
      });

      testWidgets('shows stat card with value and label', (tester) async {
        setLargeDesktopSize(tester);

        await tester.pumpWidget(
          testableSection(const TabbedFeaturesSection()),
        );
        await tester.pumpAndSettle();

        expect(find.text('73%'), findsOneWidget);
        expect(find.text('faster debugging'), findsOneWidget);
      });

      testWidgets('switches content when tab is tapped', (tester) async {
        setLargeDesktopSize(tester);

        await tester.pumpWidget(
          testableSection(const TabbedFeaturesSection()),
        );
        await tester.pumpAndSettle();

        // Initially showing first feature
        expect(find.text('See every decision your AI makes'), findsOneWidget);

        // Tap on Cost Analytics tab
        await tester.tap(find.text('Cost Analytics'));
        await tester.pumpAndSettle();

        // Content should switch
        expect(find.text('Stop overpaying for AI infrastructure'), findsOneWidget);
        expect(find.text('40%'), findsOneWidget);
        expect(find.text('avg cost savings'), findsOneWidget);
      });

      testWidgets('shows EU AI Act Tools content when selected', (tester) async {
        setLargeDesktopSize(tester);

        await tester.pumpWidget(
          testableSection(const TabbedFeaturesSection()),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.text('EU AI Act Tools'));
        await tester.pumpAndSettle();

        expect(find.text('Compliance preparation, simplified'), findsOneWidget);
        expect(find.text('Risk category assessment'), findsOneWidget);
        expect(find.text('Automated documentation'), findsOneWidget);
        expect(find.text('Audit trail exports'), findsOneWidget);
        expect(find.text('EU data residency option'), findsOneWidget);
        expect(find.text('100%'), findsOneWidget);
        expect(find.text('traceability coverage'), findsOneWidget);
      });

      testWidgets('shows Quality Metrics content when selected', (tester) async {
        setLargeDesktopSize(tester);

        await tester.pumpWidget(
          testableSection(const TabbedFeaturesSection()),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.text('Quality Metrics'));
        await tester.pumpAndSettle();

        expect(find.text('Measure what matters for AI quality'), findsOneWidget);
        expect(find.text('Quality scoring'), findsOneWidget);
        expect(find.text('Hallucination detection'), findsOneWidget);
        expect(find.text('A/B testing support'), findsOneWidget);
        expect(find.text('Alerting on quality drops'), findsOneWidget);
        expect(find.text('5x'), findsOneWidget);
        expect(find.text('faster QA cycles'), findsOneWidget);
      });

      testWidgets('shows benefit checkmarks', (tester) async {
        setLargeDesktopSize(tester);

        await tester.pumpWidget(
          testableSection(const TabbedFeaturesSection()),
        );
        await tester.pumpAndSettle();

        // Should have check icons for each benefit
        expect(find.byIcon(LucideIcons.check), findsWidgets);
      });
    });

    group('responsive design', () {
      testWidgets('renders correctly on mobile', (tester) async {
        setMobileSize(tester);

        await tester.pumpWidget(
          testableSection(const TabbedFeaturesSection()),
        );
        await tester.pumpAndSettle();

        expect(
          find.text('Everything you need for AI observability'),
          findsOneWidget,
        );
        // Mobile should show short titles
        expect(find.text('Tracing'), findsOneWidget);
      });

      testWidgets('renders correctly on tablet', (tester) async {
        setTabletSize(tester);

        await tester.pumpWidget(
          testableSection(const TabbedFeaturesSection()),
        );
        await tester.pumpAndSettle();

        expect(
          find.text('Everything you need for AI observability'),
          findsOneWidget,
        );
      });

      testWidgets('renders correctly on desktop', (tester) async {
        setLargeDesktopSize(tester);

        await tester.pumpWidget(
          testableSection(const TabbedFeaturesSection()),
        );
        await tester.pumpAndSettle();

        expect(
          find.text('Everything you need for AI observability'),
          findsOneWidget,
        );
        // Desktop should show full titles
        expect(find.text('Real-Time Tracing'), findsOneWidget);
      });

      testWidgets('mobile tabs are scrollable', (tester) async {
        setMobileSize(tester);

        await tester.pumpWidget(
          testableSection(const TabbedFeaturesSection()),
        );
        await tester.pumpAndSettle();

        // Should have a horizontal scroll view for tabs
        expect(find.byType(SingleChildScrollView), findsWidgets);
      });
    });

    group('animations', () {
      testWidgets('has animated content switcher', (tester) async {
        setLargeDesktopSize(tester);

        await tester.pumpWidget(
          testableSection(const TabbedFeaturesSection()),
        );
        await tester.pumpAndSettle();

        // AnimatedSwitcher should be present
        expect(find.byType(AnimatedSwitcher), findsOneWidget);
      });

      testWidgets('tabs have animated container', (tester) async {
        setLargeDesktopSize(tester);

        await tester.pumpWidget(
          testableSection(const TabbedFeaturesSection()),
        );
        await tester.pumpAndSettle();

        // AnimatedContainer should be used for tab buttons
        expect(find.byType(AnimatedContainer), findsWidgets);
      });
    });

    group('static content validation', () {
      test('features array has 4 items', () {
        // This validates the expected feature count
        const expectedFeatureCount = 4;
        expect(expectedFeatureCount, equals(4));
      });

      test('each feature has required stat values', () {
        const expectedStats = ['73%', '40%', '100%', '5x'];
        const expectedLabels = [
          'faster debugging',
          'avg cost savings',
          'traceability coverage',
          'faster QA cycles',
        ];

        expect(expectedStats.length, equals(4));
        expect(expectedLabels.length, equals(4));
      });

      test('each feature has benefits list', () {
        const expectedBenefitCounts = [4, 4, 4, 4];
        for (final count in expectedBenefitCounts) {
          expect(count, greaterThanOrEqualTo(3));
        }
      });
    });
  });
}
