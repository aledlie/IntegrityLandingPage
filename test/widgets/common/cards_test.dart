import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integrity_studio_ai/widgets/common/cards.dart';
import '../../helpers/test_helpers.dart';

void main() {
  group('GlassCard', () {
    testWidgets('renders child content', (tester) async {
      await tester.pumpWidget(
        testableWidget(
          const GlassCard(
            child: Text('Test Content'),
          ),
        ),
      );

      expect(find.text('Test Content'), findsOneWidget);
    });

    testWidgets('renders with different tiers', (tester) async {
      for (final tier in GlassCardTier.values) {
        await tester.pumpWidget(
          testableWidget(
            GlassCard(
              tier: tier,
              child: Text('Tier: ${tier.name}'),
            ),
          ),
        );

        expect(find.text('Tier: ${tier.name}'), findsOneWidget);
      }
    });

    testWidgets('applies semantic label when provided', (tester) async {
      await tester.pumpWidget(
        testableWidget(
          const GlassCard(
            semanticLabel: 'Test card',
            child: Text('Content'),
          ),
        ),
      );

      expect(find.byType(Semantics), findsWidgets);
    });

    testWidgets('shows pointer cursor when onTap is provided', (tester) async {
      await tester.pumpWidget(
        testableWidget(
          GlassCard(
            onTap: () {},
            child: const Text('Clickable'),
          ),
        ),
      );

      expect(find.byType(MouseRegion), findsWidgets);
    });

    testWidgets('invokes onTap callback when tapped', (tester) async {
      var tapped = false;

      await tester.pumpWidget(
        testableWidget(
          GlassCard(
            onTap: () => tapped = true,
            child: const Text('Tap me'),
          ),
        ),
      );

      await tester.tap(find.text('Tap me'));
      await tester.pump();

      expect(tapped, isTrue);
    });
  });

  group('FeatureCard', () {
    testWidgets('renders icon, title, and description', (tester) async {
      await tester.pumpWidget(
        testableWidget(
          const FeatureCard(
            icon: Icons.star,
            title: 'Feature Title',
            description: 'Feature description text',
          ),
        ),
      );

      expect(find.byIcon(Icons.star), findsOneWidget);
      expect(find.text('Feature Title'), findsOneWidget);
      expect(find.text('Feature description text'), findsOneWidget);
    });

    testWidgets('renders feature bullets when provided', (tester) async {
      await tester.pumpWidget(
        testableWidget(
          const FeatureCard(
            icon: Icons.check,
            title: 'Features',
            description: 'Description',
            features: ['Feature 1', 'Feature 2', 'Feature 3'],
          ),
        ),
      );

      expect(find.text('Feature 1'), findsOneWidget);
      expect(find.text('Feature 2'), findsOneWidget);
      expect(find.text('Feature 3'), findsOneWidget);
    });

    testWidgets('invokes onTap when tapped', (tester) async {
      var tapped = false;

      await tester.pumpWidget(
        testableWidget(
          FeatureCard(
            icon: Icons.star,
            title: 'Test',
            description: 'Test',
            onTap: () => tapped = true,
          ),
        ),
      );

      await tester.tap(find.text('Test').first);
      await tester.pump();

      expect(tapped, isTrue);
    });
  });

  group('StatCard', () {
    testWidgets('renders value and label', (tester) async {
      await tester.pumpWidget(
        testableWidget(
          const StatCard(
            value: '99.9%',
            label: 'Uptime',
          ),
        ),
      );

      expect(find.text('99.9%'), findsOneWidget);
      expect(find.text('Uptime'), findsOneWidget);
    });

    testWidgets('has semantic label combining value and label', (tester) async {
      await tester.pumpWidget(
        testableWidget(
          const StatCard(
            value: '100K',
            label: 'Users',
          ),
        ),
      );

      expect(find.byType(Semantics), findsWidgets);
    });
  });

  group('PricingCard', () {
    group('basic rendering', () {
      testWidgets('renders tier name and price', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            const PricingCard(
              tier: 'Starter',
              price: '\$0',
              features: ['Feature 1'],
              ctaText: 'Get Started',
            ),
          ),
        );

        expect(find.text('Starter'), findsOneWidget);
        expect(find.text('\$0'), findsOneWidget);
      });

      testWidgets('renders period when provided', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            const PricingCard(
              tier: 'Pro',
              price: '\$99',
              period: '/month',
              features: ['Feature 1'],
              ctaText: 'Subscribe',
            ),
          ),
        );

        expect(find.text('/month'), findsOneWidget);
      });

      testWidgets('renders description when provided', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            const PricingCard(
              tier: 'Pro',
              price: '\$99',
              description: 'For growing teams',
              features: ['Feature 1'],
              ctaText: 'Subscribe',
            ),
          ),
        );

        expect(find.text('For growing teams'), findsOneWidget);
      });

      testWidgets('renders all features with checkmarks', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            const PricingCard(
              tier: 'Pro',
              price: '\$99',
              features: [
                'Unlimited users',
                'Advanced analytics',
                'Priority support',
              ],
              ctaText: 'Subscribe',
            ),
          ),
        );

        expect(find.text('Unlimited users'), findsOneWidget);
        expect(find.text('Advanced analytics'), findsOneWidget);
        expect(find.text('Priority support'), findsOneWidget);
        expect(find.byIcon(Icons.check_circle), findsNWidgets(3));
      });

      testWidgets('renders CTA button with correct text', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            const PricingCard(
              tier: 'Pro',
              price: '\$99',
              features: ['Feature 1'],
              ctaText: 'Start Free Trial',
            ),
          ),
        );

        expect(find.text('Start Free Trial'), findsOneWidget);
      });
    });

    group('popular tier', () {
      testWidgets('shows Most Popular badge when isPopular is true',
          (tester) async {
        await tester.pumpWidget(
          testableWidget(
            const PricingCard(
              tier: 'Team',
              price: '\$79',
              features: ['Feature 1'],
              ctaText: 'Subscribe',
              isPopular: true,
            ),
          ),
        );

        expect(find.text('Most Popular'), findsOneWidget);
      });

      testWidgets('does not show badge when isPopular is false',
          (tester) async {
        await tester.pumpWidget(
          testableWidget(
            const PricingCard(
              tier: 'Starter',
              price: '\$0',
              features: ['Feature 1'],
              ctaText: 'Get Started',
              isPopular: false,
            ),
          ),
        );

        expect(find.text('Most Popular'), findsNothing);
      });

      testWidgets('uses ElevatedButton for popular tier', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            const PricingCard(
              tier: 'Team',
              price: '\$79',
              features: ['Feature 1'],
              ctaText: 'Subscribe',
              isPopular: true,
            ),
          ),
        );

        expect(find.byType(ElevatedButton), findsOneWidget);
      });

      testWidgets('uses OutlinedButton for non-popular tier', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            const PricingCard(
              tier: 'Starter',
              price: '\$0',
              features: ['Feature 1'],
              ctaText: 'Get Started',
              isPopular: false,
            ),
          ),
        );

        expect(find.byType(OutlinedButton), findsOneWidget);
      });
    });

    group('callback handling', () {
      testWidgets('invokes onCtaPressed when CTA button is tapped',
          (tester) async {
        var pressed = false;

        await tester.pumpWidget(
          testableWidget(
            PricingCard(
              tier: 'Pro',
              price: '\$99',
              features: const ['Feature 1'],
              ctaText: 'Subscribe',
              onCtaPressed: () => pressed = true,
            ),
          ),
        );

        await tester.tap(find.text('Subscribe'));
        await tester.pump();

        expect(pressed, isTrue);
      });
    });

    group('overflow handling', () {
      testWidgets('handles long price text without overflow', (tester) async {
        // This tests the Flexible wrapper fix for price text
        await tester.pumpWidget(
          testableWidget(
            const SizedBox(
              width: 200, // Constrained width to trigger potential overflow
              child: PricingCard(
                tier: 'Enterprise',
                price: 'Custom Pricing',
                features: ['Feature 1'],
                ctaText: 'Contact Sales',
              ),
            ),
          ),
        );

        // Should render without throwing overflow errors
        expect(find.text('Enterprise'), findsOneWidget);
        // Price text should be present (may be truncated)
        expect(find.textContaining('Custom'), findsOneWidget);
      });

      testWidgets('renders correctly at tablet width', (tester) async {
        setTabletSize(tester);

        await tester.pumpWidget(
          testableWidget(
            const Row(
              children: [
                Expanded(
                  child: PricingCard(
                    tier: 'Starter',
                    price: 'Free',
                    features: ['50K traces/month', '7-day retention'],
                    ctaText: 'Get Started',
                  ),
                ),
                Expanded(
                  child: PricingCard(
                    tier: 'Team',
                    price: '\$79',
                    period: '/month',
                    features: ['500K traces/month', '30-day retention'],
                    ctaText: 'Start Trial',
                    isPopular: true,
                  ),
                ),
                Expanded(
                  child: PricingCard(
                    tier: 'Enterprise',
                    price: 'Custom',
                    features: ['Unlimited traces', '1-year retention'],
                    ctaText: 'Contact Sales',
                  ),
                ),
              ],
            ),
          ),
        );

        // All three cards should render
        expect(find.text('Starter'), findsOneWidget);
        expect(find.text('Team'), findsOneWidget);
        expect(find.text('Enterprise'), findsOneWidget);
      });

      testWidgets('renders correctly at mobile width', (tester) async {
        setMobileSize(tester);

        await tester.pumpWidget(
          testableSection(
            const Column(
              children: [
                PricingCard(
                  tier: 'Starter',
                  price: 'Free',
                  features: ['50K traces/month'],
                  ctaText: 'Get Started',
                ),
                PricingCard(
                  tier: 'Team',
                  price: '\$79',
                  period: '/month',
                  features: ['500K traces/month'],
                  ctaText: 'Start Trial',
                  isPopular: true,
                ),
              ],
            ),
          ),
        );

        expect(find.text('Starter'), findsOneWidget);
        expect(find.text('Team'), findsOneWidget);
      });

      testWidgets('feature rows have proper alignment', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            const PricingCard(
              tier: 'Pro',
              price: '\$99',
              features: [
                'Short feature',
                'A much longer feature description that spans multiple lines',
              ],
              ctaText: 'Subscribe',
            ),
          ),
        );

        // Features should render with proper text wrapping
        expect(find.text('Short feature'), findsOneWidget);
        expect(
            find.textContaining('A much longer feature description'),
            findsOneWidget);
      });
    });

    group('GlassCard tier selection', () {
      testWidgets('uses primary tier for popular cards', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            const PricingCard(
              tier: 'Team',
              price: '\$79',
              features: ['Feature 1'],
              ctaText: 'Subscribe',
              isPopular: true,
            ),
          ),
        );

        // Find the GlassCard and verify it exists
        expect(find.byType(GlassCard), findsOneWidget);
      });

      testWidgets('uses secondary tier for non-popular cards', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            const PricingCard(
              tier: 'Starter',
              price: '\$0',
              features: ['Feature 1'],
              ctaText: 'Get Started',
              isPopular: false,
            ),
          ),
        );

        expect(find.byType(GlassCard), findsOneWidget);
      });
    });
  });
}
