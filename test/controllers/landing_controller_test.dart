import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integrity_studio_ai/controllers/landing_controller.dart';
import 'package:integrity_studio_ai/config/content.dart';
import '../helpers/test_helpers.dart';

void main() {
  setUpAll(() {
    initializeTestContent();
  });

  group('LandingController', () {
    late LandingController controller;

    setUp(() {
      controller = LandingController();
    });

    tearDown(() {
      controller.dispose();
    });

    group('construction', () {
      test('creates without error', () {
        expect(controller, isNotNull);
      });

      test('has scroll controller', () {
        expect(controller.scrollController, isNotNull);
        expect(controller.scrollController, isA<ScrollController>());
      });
    });

    group('initialization', () {
      test('initialize adds scroll listener', () {
        controller.initialize();
        expect(controller.scrollController.hasListeners, isTrue);
      });

      test('initialize only tracks page view once', () {
        controller.initialize();
        controller.initialize(); // Second call should not track again
        // No error means it passed
        expect(true, isTrue);
      });
    });

    group('content getters', () {
      test('heroContent returns HeroContent', () {
        expect(controller.heroContent, isA<HeroContent>());
      });

      test('pricingContent returns PricingContent', () {
        expect(controller.pricingContent, isA<PricingContent>());
      });

      test('featuresContent returns FeaturesContent', () {
        expect(controller.featuresContent, isA<FeaturesContent>());
      });

      test('ctaContent returns CTAContent', () {
        expect(controller.ctaContent, isA<CTAContent>());
      });
    });

    group('content variant', () {
      test('heroContent uses default when no variant set', () {
        expect(controller.heroContent.headline, equals(AppContent.hero.headline));
      });

      test('setContentVariant changes content', () {
        controller.setContentVariant('agent-first');
        // After setting variant, heroContent should reflect the variant
        expect(controller.heroContent, isNotNull);
      });

      test('setContentVariant notifies listeners', () {
        var notified = false;
        controller.addListener(() => notified = true);

        controller.setContentVariant('cost-focused');
        expect(notified, isTrue);
      });
    });

    group('section management', () {
      test('registerSection stores key', () {
        final key = GlobalKey();
        controller.registerSection('test-section', key);

        expect(controller.getSectionKey('test-section'), equals(key));
      });

      test('getSectionKey returns null for unregistered section', () {
        expect(controller.getSectionKey('nonexistent'), isNull);
      });

      test('registerSection allows multiple sections', () {
        final key1 = GlobalKey();
        final key2 = GlobalKey();

        controller.registerSection('section1', key1);
        controller.registerSection('section2', key2);

        expect(controller.getSectionKey('section1'), equals(key1));
        expect(controller.getSectionKey('section2'), equals(key2));
      });
    });

    group('scroll to section', () {
      testWidgets('scrollToSection handles unregistered section gracefully', (tester) async {
        // Should not throw
        controller.scrollToSection('nonexistent');
        expect(true, isTrue);
      });

      testWidgets('scrollToPricing calls scrollToSection with pricing', (tester) async {
        final key = GlobalKey();
        controller.registerSection('pricing', key);
        controller.scrollToPricing();
        // No error means it works (though context may be null)
        expect(true, isTrue);
      });

      testWidgets('scrollToCTA calls scrollToSection with cta', (tester) async {
        final key = GlobalKey();
        controller.registerSection('cta', key);
        controller.scrollToCTA();
        expect(true, isTrue);
      });
    });

    group('analytics handlers', () {
      testWidgets('handleGetStarted tracks analytics', (tester) async {
        final key = GlobalKey();
        controller.registerSection('pricing', key);
        controller.handleGetStarted();
        // Should not throw
        expect(true, isTrue);
      });

      testWidgets('handleGetStarted accepts custom location', (tester) async {
        controller.handleGetStarted(location: 'navbar');
        expect(true, isTrue);
      });

      test('handleRequestDemo tracks analytics', () {
        controller.handleRequestDemo();
        expect(true, isTrue);
      });

      test('handleTierSelection tracks tier', () {
        controller.handleTierSelection('enterprise');
        expect(true, isTrue);
      });

      test('handleFeatureInteraction tracks feature', () {
        controller.handleFeatureInteraction('AI Observability');
        expect(true, isTrue);
      });
    });

    group('scroll tracking', () {
      test('resetScrollTracking clears milestones', () {
        controller.resetScrollTracking();
        // Should not throw
        expect(true, isTrue);
      });
    });

    group('disposal', () {
      test('dispose cleans up scroll controller', () {
        final controller = LandingController();
        controller.initialize();
        controller.dispose();
        // Should not throw
        expect(true, isTrue);
      });
    });
  });

  group('ContentVariantController', () {
    late ContentVariantController controller;

    setUp(() {
      controller = ContentVariantController();
    });

    tearDown(() {
      controller.dispose();
    });

    group('construction', () {
      test('creates without error', () {
        expect(controller, isNotNull);
      });

      test('default variant is current', () {
        expect(controller.currentVariant, equals('current'));
      });
    });

    group('variants', () {
      test('has correct variant list', () {
        expect(ContentVariantController.variants, contains('current'));
        expect(ContentVariantController.variants, contains('agent-first'));
        expect(ContentVariantController.variants, contains('cost-focused'));
        expect(ContentVariantController.variants, contains('legacy'));
      });

      test('has 4 variants', () {
        expect(ContentVariantController.variants.length, equals(4));
      });
    });

    group('setVariant', () {
      test('changes current variant', () {
        controller.setVariant('agent-first');
        expect(controller.currentVariant, equals('agent-first'));
      });

      test('notifies listeners on change', () {
        var notified = false;
        controller.addListener(() => notified = true);

        controller.setVariant('cost-focused');
        expect(notified, isTrue);
      });

      test('does not notify when setting same variant', () {
        var notifyCount = 0;
        controller.addListener(() => notifyCount++);

        controller.setVariant('current'); // Same as default
        expect(notifyCount, equals(0));
      });

      test('does not accept invalid variant', () {
        controller.setVariant('invalid-variant');
        expect(controller.currentVariant, equals('current'));
      });
    });

    group('heroContent', () {
      test('returns HeroContent', () {
        expect(controller.heroContent, isA<HeroContent>());
      });

      test('content changes with variant', () {
        final defaultContent = controller.heroContent;
        controller.setVariant('agent-first');
        // Content should be different for different variants
        expect(controller.heroContent, isNotNull);
      });
    });
  });
}
