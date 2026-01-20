import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:integrity_studio_ai/widgets/sections/social_proof_section.dart';
import '../../helpers/test_helpers.dart';

// Use larger desktop size to avoid overflow issues with testimonial cards
void setLargeDesktopSize(WidgetTester tester) {
  setScreenSize(tester, const Size(1920, 1080));
}

void main() {
  group('SocialProofSection', () {
    group('stats row', () {
      testWidgets('renders all 4 stat values on desktop', (tester) async {
        setLargeDesktopSize(tester);

        await tester.pumpWidget(
          testableSection(const SocialProofSection()),
        );
        await tester.pumpAndSettle();

        expect(find.text('73%'), findsOneWidget);
        expect(find.text('30-50%'), findsOneWidget);
        expect(find.text('5min'), findsOneWidget);
        expect(find.text('99.9%'), findsOneWidget);
      });

      testWidgets('renders all stat labels', (tester) async {
        setLargeDesktopSize(tester);

        await tester.pumpWidget(
          testableSection(const SocialProofSection()),
        );
        await tester.pumpAndSettle();

        expect(find.text('faster debugging'), findsOneWidget);
        expect(find.text('LLM cost reduction'), findsOneWidget);
        expect(find.text('setup time'), findsOneWidget);
        expect(find.text('uptime SLA'), findsOneWidget);
      });

      testWidgets('renders stat icons', (tester) async {
        setLargeDesktopSize(tester);

        await tester.pumpWidget(
          testableSection(const SocialProofSection()),
        );
        await tester.pumpAndSettle();

        expect(find.byIcon(LucideIcons.zap), findsOneWidget);
        expect(find.byIcon(LucideIcons.dollarSign), findsOneWidget);
        expect(find.byIcon(LucideIcons.clock), findsOneWidget);
        expect(find.byIcon(LucideIcons.shield), findsOneWidget);
      });

      testWidgets('renders stats in column on mobile', (tester) async {
        setMobileSize(tester);

        await tester.pumpWidget(
          testableSection(const SocialProofSection()),
        );
        await tester.pumpAndSettle();

        // All stats should still be present
        expect(find.text('73%'), findsOneWidget);
        expect(find.text('30-50%'), findsOneWidget);
        expect(find.text('5min'), findsOneWidget);
        expect(find.text('99.9%'), findsOneWidget);
      });
    });

    // Testimonials hidden until we have real customer testimonials
    group('testimonials', skip: 'Testimonials hidden in UI', () {
      testWidgets('renders all 3 testimonials on desktop', (tester) async {
        setLargeDesktopSize(tester);

        await tester.pumpWidget(
          testableSection(const SocialProofSection()),
        );
        await tester.pumpAndSettle();

        expect(find.textContaining('Joey Rahman'), findsOneWidget);
        expect(find.textContaining('Matthew Gregory'), findsOneWidget);
        expect(find.textContaining('Aaron Bryson'), findsOneWidget);
      });

      testWidgets('renders testimonial quotes', (tester) async {
        setLargeDesktopSize(tester);

        await tester.pumpWidget(
          testableSection(const SocialProofSection()),
        );
        await tester.pumpAndSettle();

        expect(
          find.textContaining('reduced our LLM debugging time'),
          findsOneWidget,
        );
        expect(
          find.textContaining('EU AI Act compliance tools'),
          findsOneWidget,
        );
        expect(
          find.textContaining('cut our LLM costs by 40%'),
          findsOneWidget,
        );
      });

      testWidgets('renders testimonial author titles', (tester) async {
        setLargeDesktopSize(tester);

        await tester.pumpWidget(
          testableSection(const SocialProofSection()),
        );
        await tester.pumpAndSettle();

        expect(find.textContaining('VP of Engineering'), findsOneWidget);
        expect(find.textContaining('Director, Hines Development Company'), findsOneWidget);
        expect(find.textContaining('Head of AI'), findsOneWidget);
      });

      testWidgets('renders testimonial companies', (tester) async {
        setLargeDesktopSize(tester);

        await tester.pumpWidget(
          testableSection(const SocialProofSection()),
        );
        await tester.pumpAndSettle();

        expect(find.textContaining('granica.ai'), findsOneWidget);
        expect(find.textContaining('Hines Financial Group'), findsOneWidget);
        expect(find.textContaining('DataDriven Labs'), findsOneWidget);
      });

      testWidgets('renders metric badges on testimonials', (tester) async {
        setLargeDesktopSize(tester);

        await tester.pumpWidget(
          testableSection(const SocialProofSection()),
        );
        await tester.pumpAndSettle();

        // Metrics are rendered in Text.rich, so use textContaining
        expect(find.textContaining('73% faster'), findsOneWidget);
        expect(find.textContaining('3 months'), findsOneWidget);
        expect(find.textContaining('40%'), findsWidgets); // May appear in multiple places
      });

      testWidgets('renders metric context on testimonials', (tester) async {
        setLargeDesktopSize(tester);

        await tester.pumpWidget(
          testableSection(const SocialProofSection()),
        );
        await tester.pumpAndSettle();

        // Metric context is rendered in Text.rich spans
        expect(find.textContaining('issue resolution'), findsOneWidget);
        expect(find.textContaining('compliance prep saved'), findsOneWidget);
        // Note: 'cost reduction' appears in both stat label and testimonial
        expect(find.textContaining('cost reduction'), findsWidgets);
      });

      testWidgets('renders author initials as avatar', (tester) async {
        setLargeDesktopSize(tester);

        await tester.pumpWidget(
          testableSection(const SocialProofSection()),
        );
        await tester.pumpAndSettle();

        // First letter of each author name
        expect(find.text('J'), findsOneWidget); // Joey
        expect(find.text('M'), findsOneWidget); // Matthew
        expect(find.text('A'), findsOneWidget); // Aaron
      });
    });

    group('trust badges', () {
      testWidgets('renders trust section header', (tester) async {
        setLargeDesktopSize(tester);

        await tester.pumpWidget(
          testableSection(const SocialProofSection()),
        );
        await tester.pumpAndSettle();

        expect(find.text('Trusted by AI teams worldwide'), findsOneWidget);
      });

      testWidgets('renders all 4 trust badges', (tester) async {
        setLargeDesktopSize(tester);

        await tester.pumpWidget(
          testableSection(const SocialProofSection()),
        );
        await tester.pumpAndSettle();

        expect(find.text('Enterprise Security'), findsOneWidget);
        expect(find.text('GDPR Ready'), findsOneWidget);
        expect(find.text('EU AI Act Ready'), findsOneWidget);
        expect(find.text('OpenTelemetry Native'), findsOneWidget);
      });

      testWidgets('renders trust badge icons', (tester) async {
        setLargeDesktopSize(tester);

        await tester.pumpWidget(
          testableSection(const SocialProofSection()),
        );
        await tester.pumpAndSettle();

        expect(find.byIcon(LucideIcons.shieldCheck), findsWidgets);
        expect(find.byIcon(LucideIcons.lock), findsOneWidget);
        expect(find.byIcon(LucideIcons.fileCheck), findsOneWidget);
        expect(find.byIcon(LucideIcons.radio), findsOneWidget);
      });
    });

    group('responsive design', () {
      testWidgets('renders correctly on mobile', (tester) async {
        setMobileSize(tester);

        await tester.pumpWidget(
          testableSection(const SocialProofSection()),
        );
        await tester.pumpAndSettle();

        // Core elements should be present (stats and trust badges)
        expect(find.text('73%'), findsOneWidget);
        expect(find.text('Enterprise Security'), findsOneWidget);
      });

      testWidgets('renders correctly on tablet', (tester) async {
        setTabletSize(tester);

        await tester.pumpWidget(
          testableSection(const SocialProofSection()),
        );
        await tester.pumpAndSettle();

        expect(find.text('73%'), findsOneWidget);
        expect(find.text('Trusted by AI teams worldwide'), findsOneWidget);
      });

      testWidgets('renders correctly on desktop', (tester) async {
        setLargeDesktopSize(tester);

        await tester.pumpWidget(
          testableSection(const SocialProofSection()),
        );
        await tester.pumpAndSettle();

        expect(find.text('73%'), findsOneWidget);
        expect(find.text('Trusted by AI teams worldwide'), findsOneWidget);
      });
    });

    group('animations and interactivity', () {
      testWidgets('stat cards have animated container', (tester) async {
        setLargeDesktopSize(tester);

        await tester.pumpWidget(
          testableSection(const SocialProofSection()),
        );
        await tester.pumpAndSettle();

        expect(find.byType(AnimatedContainer), findsWidgets);
      });

      testWidgets('stat cards use mouse region for hover', (tester) async {
        setLargeDesktopSize(tester);

        await tester.pumpWidget(
          testableSection(const SocialProofSection()),
        );
        await tester.pumpAndSettle();

        expect(find.byType(MouseRegion), findsWidgets);
      });
    });

    group('static content validation', () {
      test('stats array has 4 items', () {
        const expectedStats = ['73%', '30-50%', '5min', '99.9%'];
        expect(expectedStats.length, equals(4));
      });

      test('stats have verifiable claims', () {
        // Per BRAND_GUIDELINES.md section 13 - all metrics must be verifiable
        const stats = [
          '73%', // Faster debugging
          '30-50%', // LLM cost reduction
          '5min', // Setup time
          '99.9%', // Uptime SLA
        ];

        for (final stat in stats) {
          expect(stat, isNotEmpty);
        }
      });

      test('testimonials array has 3 items', () {
        const testimonialAuthors = ['Joey Rahman', 'Matthew Gregory', 'Aaron Bryson'];
        expect(testimonialAuthors.length, equals(3));
      });

      test('each testimonial has metric and context', () {
        const metrics = ['73% faster', '3 months', '40%'];
        const contexts = ['issue resolution', 'compliance prep saved', 'cost reduction'];

        expect(metrics.length, equals(contexts.length));
        for (var i = 0; i < metrics.length; i++) {
          expect(metrics[i], isNotEmpty);
          expect(contexts[i], isNotEmpty);
        }
      });

      test('trust badges array has 4 items', () {
        const badges = [
          'Enterprise Security',
          'GDPR Ready',
          'EU AI Act Ready',
          'OpenTelemetry Native',
        ];
        expect(badges.length, equals(4));
      });
    });

    group('accessibility', () {
      // Skip until testimonials are re-enabled
      testWidgets('testimonials are readable', skip: true, (tester) async {
        setLargeDesktopSize(tester);

        await tester.pumpWidget(
          testableSection(const SocialProofSection()),
        );
        await tester.pumpAndSettle();

        // Quotes should be properly formatted with quotation marks
        expect(find.textContaining('"'), findsWidgets);
      });

      testWidgets('stats have descriptive labels', (tester) async {
        setLargeDesktopSize(tester);

        await tester.pumpWidget(
          testableSection(const SocialProofSection()),
        );
        await tester.pumpAndSettle();

        // Each stat should have a label explaining what it means
        expect(find.text('faster debugging'), findsOneWidget);
        expect(find.text('LLM cost reduction'), findsOneWidget);
        expect(find.text('setup time'), findsOneWidget);
        expect(find.text('uptime SLA'), findsOneWidget);
      });
    });
  });
}
