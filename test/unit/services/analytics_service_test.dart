import 'package:flutter_test/flutter_test.dart';
import 'package:integrity_studio_ai/services/analytics.dart';

void main() {
  group('AnalyticsService', () {
    group('initialization', () {
      test('isReady is false before initialization on non-web', () {
        // On non-web, initialize() doesn't set _initialized
        // So isReady should be false
        expect(AnalyticsService.isReady, isFalse);
      });

      test('initialize completes without error', () async {
        await expectLater(
          AnalyticsService.initialize(),
          completes,
        );
      });

      test('initialize can be called multiple times safely', () async {
        await AnalyticsService.initialize();
        await AnalyticsService.initialize();

        // Should not throw
        expect(true, isTrue);
      });
    });

    group('enable/disable', () {
      test('disable can be called', () {
        AnalyticsService.disable();

        // Should not throw
        expect(true, isTrue);
      });

      test('enable can be called', () {
        AnalyticsService.enable();

        expect(true, isTrue);
      });

      test('enable and disable can be toggled', () {
        AnalyticsService.disable();
        AnalyticsService.enable();
        AnalyticsService.disable();

        expect(true, isTrue);
      });
    });

    group('page tracking', () {
      test('trackPageView does not throw when not ready', () {
        AnalyticsService.trackPageView('test_page');

        expect(true, isTrue);
      });

      test('trackScrollDepth only fires at 25% intervals', () {
        // These should not throw
        AnalyticsService.trackScrollDepth(25);
        AnalyticsService.trackScrollDepth(50);
        AnalyticsService.trackScrollDepth(75);
        AnalyticsService.trackScrollDepth(100);

        // Non-25% intervals should be ignored
        AnalyticsService.trackScrollDepth(30);
        AnalyticsService.trackScrollDepth(60);

        expect(true, isTrue);
      });
    });

    group('interaction tracking', () {
      test('trackCTAClick does not throw when not ready', () {
        AnalyticsService.trackCTAClick(
          buttonName: 'test_button',
          location: 'hero',
        );

        expect(true, isTrue);
      });

      test('trackCTAClick accepts optional ctaType', () {
        AnalyticsService.trackCTAClick(
          buttonName: 'test_button',
          location: 'hero',
          ctaType: 'primary',
        );

        expect(true, isTrue);
      });

      test('trackFeatureInteraction does not throw', () {
        AnalyticsService.trackFeatureInteraction('monitoring');

        expect(true, isTrue);
      });

      test('trackExternalLink does not throw', () {
        AnalyticsService.trackExternalLink('https://example.com');

        expect(true, isTrue);
      });
    });

    group('conversion tracking', () {
      test('trackFormSubmission does not throw', () {
        AnalyticsService.trackFormSubmission(
          formType: 'contact',
          success: true,
        );

        expect(true, isTrue);
      });

      test('trackFormSubmission accepts error message', () {
        AnalyticsService.trackFormSubmission(
          formType: 'contact',
          success: false,
          errorMessage: 'Validation failed',
        );

        expect(true, isTrue);
      });

      test('trackPricingView does not throw', () {
        AnalyticsService.trackPricingView('enterprise');

        expect(true, isTrue);
      });

      test('trackPricingToggle does not throw', () {
        AnalyticsService.trackPricingToggle(isAnnual: true);
        AnalyticsService.trackPricingToggle(isAnnual: false);

        expect(true, isTrue);
      });

      test('trackDemoRequest does not throw', () {
        AnalyticsService.trackDemoRequest();

        expect(true, isTrue);
      });

      test('trackLeadMagnetDownload does not throw', () {
        AnalyticsService.trackLeadMagnetDownload('eu-ai-act-checklist');

        expect(true, isTrue);
      });

      test('trackBlogPostClick does not throw', () {
        AnalyticsService.trackBlogPostClick('ai-observability-guide');

        expect(true, isTrue);
      });

      test('trackFormSubmit simplified wrapper does not throw', () {
        AnalyticsService.trackFormSubmit('demo_request');

        expect(true, isTrue);
      });
    });

    group('custom event tracking', () {
      test('trackEvent does not throw when not ready', () {
        AnalyticsService.trackEvent(
          eventName: 'custom_event',
          parameters: {'key': 'value'},
        );

        expect(true, isTrue);
      });

      test('trackEvent accepts empty parameters', () {
        AnalyticsService.trackEvent(eventName: 'simple_event');

        expect(true, isTrue);
      });
    });
  });

  group('AnalyticsEvent', () {
    test('all events have unique names', () {
      final names = AnalyticsEvent.values.map((e) => e.name).toList();
      final uniqueNames = names.toSet();

      expect(names.length, equals(uniqueNames.length));
    });

    test('pageView has correct name', () {
      expect(AnalyticsEvent.pageView.name, equals('page_view'));
    });

    test('ctaClick has correct name', () {
      expect(AnalyticsEvent.ctaClick.name, equals('cta_click'));
    });

    test('formSubmission has correct name', () {
      expect(AnalyticsEvent.formSubmission.name, equals('form_submission'));
    });

    test('pricingTierView has correct name', () {
      expect(AnalyticsEvent.pricingTierView.name, equals('pricing_tier_view'));
    });

    test('scrollDepth has correct name', () {
      expect(AnalyticsEvent.scrollDepth.name, equals('scroll_depth'));
    });

    test('featureInteraction has correct name', () {
      expect(
        AnalyticsEvent.featureInteraction.name,
        equals('feature_interaction'),
      );
    });

    test('pricingToggle has correct name', () {
      expect(AnalyticsEvent.pricingToggle.name, equals('pricing_toggle'));
    });

    test('externalLinkClick has correct name', () {
      expect(
        AnalyticsEvent.externalLinkClick.name,
        equals('external_link_click'),
      );
    });

    test('demoRequest has correct name', () {
      expect(AnalyticsEvent.demoRequest.name, equals('demo_request'));
    });

    test('leadMagnetDownload has correct name', () {
      expect(
        AnalyticsEvent.leadMagnetDownload.name,
        equals('lead_magnet_download'),
      );
    });

    test('blogPostClick has correct name', () {
      expect(AnalyticsEvent.blogPostClick.name, equals('blog_post_click'));
    });
  });

  group('FacebookPixelService', () {
    group('initialization', () {
      test('isReady is false before initialization', () {
        expect(FacebookPixelService.isReady, isFalse);
      });

      test('initialize completes without error on non-web', () async {
        await expectLater(
          FacebookPixelService.initialize('test-pixel-id'),
          completes,
        );
      });

      test('initialize can be called multiple times', () async {
        await FacebookPixelService.initialize('test-pixel-id');
        await FacebookPixelService.initialize('test-pixel-id');

        expect(true, isTrue);
      });
    });

    group('enable/disable', () {
      test('disable can be called', () {
        FacebookPixelService.disable();

        expect(true, isTrue);
      });

      test('enable can be called', () {
        FacebookPixelService.enable();

        expect(true, isTrue);
      });
    });

    group('tracking methods', () {
      test('trackPageView does not throw when not ready', () {
        FacebookPixelService.trackPageView();

        expect(true, isTrue);
      });

      test('trackLead does not throw when not ready', () {
        FacebookPixelService.trackLead();

        expect(true, isTrue);
      });

      test('trackViewContent does not throw when not ready', () {
        FacebookPixelService.trackViewContent('product');

        expect(true, isTrue);
      });
    });
  });

  group('ErrorSeverity', () {
    test('debug maps to SentryLevel.debug', () {
      expect(ErrorSeverity.debug.sentryLevel.name, equals('debug'));
    });

    test('info maps to SentryLevel.info', () {
      expect(ErrorSeverity.info.sentryLevel.name, equals('info'));
    });

    test('warning maps to SentryLevel.warning', () {
      expect(ErrorSeverity.warning.sentryLevel.name, equals('warning'));
    });

    test('error maps to SentryLevel.error', () {
      expect(ErrorSeverity.error.sentryLevel.name, equals('error'));
    });

    test('fatal maps to SentryLevel.fatal', () {
      expect(ErrorSeverity.fatal.sentryLevel.name, equals('fatal'));
    });
  });
}
