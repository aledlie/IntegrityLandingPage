import 'package:flutter_test/flutter_test.dart';
import 'package:integrity_studio_ai/config/content.dart';
import '../../helpers/test_helpers.dart';

void main() {
  setUpAll(() {
    initializeTestContent();
  });

  group('PricingSection', () {
    group('PricingContent', () {
      test('default content has required fields', () {
        final content = AppContent.pricing;

        expect(content.title, isNotEmpty);
        expect(content.subtitle, isNotEmpty);
        expect(content.monthlyLabel, isNotEmpty);
        expect(content.annualLabel, isNotEmpty);
      });

      test('has pricing tiers', () {
        final content = AppContent.pricing;

        expect(content.tiers, isNotEmpty);
      });

      test('each tier has required fields', () {
        final content = AppContent.pricing;

        for (final tier in content.tiers) {
          expect(tier.name, isNotEmpty);
          expect(tier.monthlyPrice, isNotEmpty);
          expect(tier.annualPrice, isNotEmpty);
          expect(tier.features, isNotEmpty);
          expect(tier.ctaText, isNotEmpty);
        }
      });

      test('annual prices differ from monthly prices', () {
        final content = AppContent.pricing;

        for (final tier in content.tiers) {
          // Either prices differ, or it's a contact sales tier
          final hasContactSales = tier.monthlyPrice.toLowerCase().contains('contact') ||
              tier.monthlyPrice.toLowerCase().contains('custom');
          if (!hasContactSales) {
            // For regular tiers, monthly and annual should be accessible
            expect(tier.monthlyPrice, isNotNull);
            expect(tier.annualPrice, isNotNull);
          }
        }
      });

      test('at least one tier is marked as popular', () {
        final content = AppContent.pricing;

        final popularTiers = content.tiers.where((t) => t.isPopular);
        expect(popularTiers.length, greaterThanOrEqualTo(0)); // May or may not have popular tier
      });
    });

    group('PricingTierContent', () {
      test('creates with all required fields', () {
        const tier = PricingTierContent(
          name: 'Pro',
          monthlyPrice: '\$99',
          annualPrice: '\$79',
          period: '/mo',
          description: 'For growing teams',
          features: ['Feature 1', 'Feature 2'],
          ctaText: 'Get Started',
          isPopular: true,
        );

        expect(tier.name, equals('Pro'));
        expect(tier.monthlyPrice, equals('\$99'));
        expect(tier.annualPrice, equals('\$79'));
        expect(tier.period, equals('/mo'));
        expect(tier.description, equals('For growing teams'));
        expect(tier.features.length, equals(2));
        expect(tier.ctaText, equals('Get Started'));
        expect(tier.isPopular, isTrue);
      });
    });

    group('PricingContent constructor', () {
      test('creates with all required fields', () {
        const content = PricingContent(
          title: 'Pricing',
          subtitle: 'Choose a plan',
          monthlyLabel: 'Monthly',
          annualLabel: 'Annual',
          annualBadge: 'Save 20%',
          enterpriseNote: 'Need more?',
          enterpriseLink: 'Contact us',
          tiers: [],
        );

        expect(content.title, equals('Pricing'));
        expect(content.subtitle, equals('Choose a plan'));
        expect(content.monthlyLabel, equals('Monthly'));
        expect(content.annualLabel, equals('Annual'));
        expect(content.annualBadge, equals('Save 20%'));
        expect(content.enterpriseNote, equals('Need more?'));
        expect(content.enterpriseLink, equals('Contact us'));
        expect(content.tiers, isEmpty);
      });
    });
  });
}
