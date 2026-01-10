import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integrity_studio_ai/controllers/landing_controller.dart';
import '../../helpers/test_helpers.dart';

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

    group('initialization', () {
      test('creates with scroll controller', () {
        expect(controller.scrollController, isNotNull);
        expect(controller.scrollController, isA<ScrollController>());
      });

      test('heroContent returns default hero content', () {
        expect(controller.heroContent, isNotNull);
        expect(controller.heroContent.headline, isNotEmpty);
      });

      test('pricingContent returns pricing content', () {
        expect(controller.pricingContent, isNotNull);
      });

      test('featuresContent returns features content', () {
        expect(controller.featuresContent, isNotNull);
      });

      test('ctaContent returns CTA content', () {
        expect(controller.ctaContent, isNotNull);
      });
    });

    group('section registration', () {
      test('registerSection stores section key', () {
        final key = GlobalKey();
        controller.registerSection('test-section', key);

        expect(controller.getSectionKey('test-section'), equals(key));
      });

      test('getSectionKey returns null for unregistered section', () {
        expect(controller.getSectionKey('nonexistent'), isNull);
      });

      test('registerSection can overwrite existing key', () {
        final key1 = GlobalKey();
        final key2 = GlobalKey();

        controller.registerSection('test-section', key1);
        controller.registerSection('test-section', key2);

        expect(controller.getSectionKey('test-section'), equals(key2));
      });
    });

    group('content variant', () {
      test('setContentVariant changes hero content', () {
        bool notified = false;
        controller.addListener(() => notified = true);

        controller.setContentVariant('agent-first');

        expect(notified, isTrue);
      });
    });

    group('scroll tracking', () {
      test('resetScrollTracking clears tracked milestones', () {
        // This tests internal state, verifying the method runs without error
        expect(() => controller.resetScrollTracking(), returnsNormally);
      });
    });

    group('CTA handlers', () {
      test('handleGetStarted calls without error', () {
        expect(() => controller.handleGetStarted(), returnsNormally);
        expect(() => controller.handleGetStarted(location: 'footer'), returnsNormally);
      });

      test('handleRequestDemo calls without error', () {
        expect(() => controller.handleRequestDemo(), returnsNormally);
      });

      test('handleTierSelection calls without error', () {
        expect(() => controller.handleTierSelection('pro'), returnsNormally);
      });

      test('handleFeatureInteraction calls without error', () {
        expect(() => controller.handleFeatureInteraction('AI Monitoring'), returnsNormally);
      });
    });

    group('disposal', () {
      test('disposes without error', () {
        // Create a new controller for this test to avoid double dispose
        final testController = LandingController();
        expect(() => testController.dispose(), returnsNormally);
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

    test('initial variant is current', () {
      expect(controller.currentVariant, equals('current'));
    });

    test('setVariant changes current variant', () {
      bool notified = false;
      controller.addListener(() => notified = true);

      controller.setVariant('agent-first');

      expect(controller.currentVariant, equals('agent-first'));
      expect(notified, isTrue);
    });

    test('setVariant ignores invalid variant', () {
      bool notified = false;
      controller.addListener(() => notified = true);

      controller.setVariant('invalid-variant');

      expect(controller.currentVariant, equals('current'));
      expect(notified, isFalse);
    });

    test('setVariant ignores same variant', () {
      controller.setVariant('agent-first');

      bool notified = false;
      controller.addListener(() => notified = true);

      controller.setVariant('agent-first');

      expect(notified, isFalse);
    });

    test('variants list contains expected values', () {
      expect(ContentVariantController.variants, contains('current'));
      expect(ContentVariantController.variants, contains('agent-first'));
      expect(ContentVariantController.variants, contains('cost-focused'));
      expect(ContentVariantController.variants, contains('legacy'));
    });

    test('heroContent returns content for current variant', () {
      controller.setVariant('agent-first');

      expect(controller.heroContent, isNotNull);
    });
  });
}
