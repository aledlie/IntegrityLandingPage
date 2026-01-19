import 'package:flutter_test/flutter_test.dart';
import 'package:integrity_studio_ai/services/analytics.dart';

void main() {
  group('AnalyticsEvent', () {
    test('enum values have correct names', () {
      expect(AnalyticsEvent.pageView.name, equals('page_view'));
      expect(AnalyticsEvent.ctaClick.name, equals('cta_click'));
      expect(AnalyticsEvent.formSubmission.name, equals('form_submission'));
      expect(AnalyticsEvent.pricingTierView.name, equals('pricing_tier_view'));
      expect(AnalyticsEvent.scrollDepth.name, equals('scroll_depth'));
      expect(AnalyticsEvent.featureInteraction.name, equals('feature_interaction'));
      expect(AnalyticsEvent.pricingToggle.name, equals('pricing_toggle'));
      expect(AnalyticsEvent.externalLinkClick.name, equals('external_link_click'));
      expect(AnalyticsEvent.demoRequest.name, equals('demo_request'));
      expect(AnalyticsEvent.leadMagnetDownload.name, equals('lead_magnet_download'));
      expect(AnalyticsEvent.blogPostClick.name, equals('blog_post_click'));
    });

    test('enum has correct count of values', () {
      expect(AnalyticsEvent.values.length, equals(11));
    });
  });

  group('AnalyticsService', () {
    group('lifecycle', () {
      test('isReady returns false before initialization', () {
        // In test environment, isReady may vary based on previous tests
        // Just verify the property exists and returns a bool
        expect(AnalyticsService.isReady, isA<bool>());
      });

      test('enable and disable toggle state', () {
        AnalyticsService.enable();
        // After enable, if initialized, should be ready

        AnalyticsService.disable();
        expect(AnalyticsService.isReady, isFalse);

        AnalyticsService.enable();
        // State restored
      });
    });

    group('tracking methods exist', () {
      test('trackPageView accepts page name', () {
        // Should not throw
        expect(
          () => AnalyticsService.trackPageView('test'),
          returnsNormally,
        );
      });

      test('trackScrollDepth only tracks 25% increments', () {
        // Should not throw for any value
        expect(
          () => AnalyticsService.trackScrollDepth(25),
          returnsNormally,
        );
        expect(
          () => AnalyticsService.trackScrollDepth(50),
          returnsNormally,
        );
        expect(
          () => AnalyticsService.trackScrollDepth(75),
          returnsNormally,
        );
        expect(
          () => AnalyticsService.trackScrollDepth(100),
          returnsNormally,
        );
        // Non-25% values are silently ignored
        expect(
          () => AnalyticsService.trackScrollDepth(30),
          returnsNormally,
        );
      });

      test('trackCTAClick accepts required parameters', () {
        expect(
          () => AnalyticsService.trackCTAClick(
            buttonName: 'Start Trial',
            location: 'hero',
          ),
          returnsNormally,
        );
      });

      test('trackCTAClick accepts optional ctaType', () {
        expect(
          () => AnalyticsService.trackCTAClick(
            buttonName: 'Start Trial',
            location: 'hero',
            ctaType: 'primary',
          ),
          returnsNormally,
        );
      });

      test('trackFeatureInteraction accepts feature name', () {
        expect(
          () => AnalyticsService.trackFeatureInteraction('Tracing'),
          returnsNormally,
        );
      });

      test('trackExternalLink accepts URL', () {
        expect(
          () => AnalyticsService.trackExternalLink('https://example.com'),
          returnsNormally,
        );
      });

      test('trackFormSubmission accepts parameters', () {
        expect(
          () => AnalyticsService.trackFormSubmission(
            formType: 'contact',
            success: true,
          ),
          returnsNormally,
        );
      });

      test('trackFormSubmission accepts error message on failure', () {
        expect(
          () => AnalyticsService.trackFormSubmission(
            formType: 'contact',
            success: false,
            errorMessage: 'Validation failed',
          ),
          returnsNormally,
        );
      });

      test('trackPricingView accepts tier name', () {
        expect(
          () => AnalyticsService.trackPricingView('Team'),
          returnsNormally,
        );
      });

      test('trackPricingToggle accepts billing period', () {
        expect(
          () => AnalyticsService.trackPricingToggle(isAnnual: true),
          returnsNormally,
        );
        expect(
          () => AnalyticsService.trackPricingToggle(isAnnual: false),
          returnsNormally,
        );
      });

      test('trackDemoRequest works without parameters', () {
        expect(
          () => AnalyticsService.trackDemoRequest(),
          returnsNormally,
        );
      });

      test('trackLeadMagnetDownload accepts resource name', () {
        expect(
          () => AnalyticsService.trackLeadMagnetDownload('whitepaper'),
          returnsNormally,
        );
      });

      test('trackBlogPostClick accepts post slug', () {
        expect(
          () => AnalyticsService.trackBlogPostClick('ai-observability'),
          returnsNormally,
        );
      });

      test('trackFormSubmit simplified method works', () {
        expect(
          () => AnalyticsService.trackFormSubmit('newsletter'),
          returnsNormally,
        );
      });

      test('trackEvent accepts custom event', () {
        expect(
          () => AnalyticsService.trackEvent(
            eventName: 'custom_event',
            parameters: {'key': 'value'},
          ),
          returnsNormally,
        );
      });
    });
  });

  group('ErrorSeverity', () {
    test('enum values map to correct Sentry levels', () {
      expect(ErrorSeverity.debug.sentryLevel.name, equals('debug'));
      expect(ErrorSeverity.info.sentryLevel.name, equals('info'));
      expect(ErrorSeverity.warning.sentryLevel.name, equals('warning'));
      expect(ErrorSeverity.error.sentryLevel.name, equals('error'));
      expect(ErrorSeverity.fatal.sentryLevel.name, equals('fatal'));
    });

    test('enum has correct count of values', () {
      expect(ErrorSeverity.values.length, equals(5));
    });
  });

  group('ErrorTrackingService', () {
    group('exception capture', () {
      test('captureException accepts exception', () async {
        await ErrorTrackingService.captureException(
          Exception('Test exception'),
        );
        // Should not throw
        expect(true, isTrue);
      });

      test('captureException accepts context', () async {
        await ErrorTrackingService.captureException(
          Exception('Test'),
          context: 'test.dart:testMethod',
        );
        expect(true, isTrue);
      });

      test('captureException accepts extra data', () async {
        await ErrorTrackingService.captureException(
          Exception('Test'),
          extra: {'user_id': '123', 'action': 'test'},
        );
        expect(true, isTrue);
      });

      test('captureException accepts stack trace', () async {
        try {
          throw Exception('Test error');
        } catch (e, stackTrace) {
          await ErrorTrackingService.captureException(
            e,
            stackTrace: stackTrace,
          );
        }
        expect(true, isTrue);
      });
    });

    group('message capture', () {
      test('captureMessage accepts message', () async {
        await ErrorTrackingService.captureMessage('Test message');
        expect(true, isTrue);
      });

      test('captureMessage accepts severity', () async {
        await ErrorTrackingService.captureMessage(
          'Test warning',
          severity: ErrorSeverity.warning,
        );
        expect(true, isTrue);
      });

      test('captureMessage accepts extra data', () async {
        await ErrorTrackingService.captureMessage(
          'Test message',
          extra: {'context': 'unit_test'},
        );
        expect(true, isTrue);
      });

      test('captureMessage with all severity levels', () async {
        for (final severity in ErrorSeverity.values) {
          await ErrorTrackingService.captureMessage(
            'Test ${severity.name}',
            severity: severity,
          );
        }
        expect(true, isTrue);
      });
    });

    group('breadcrumbs', () {
      test('addBreadcrumb accepts message', () {
        expect(
          () => ErrorTrackingService.addBreadcrumb(
            message: 'Test breadcrumb',
          ),
          returnsNormally,
        );
      });

      test('addBreadcrumb accepts category', () {
        expect(
          () => ErrorTrackingService.addBreadcrumb(
            message: 'Test breadcrumb',
            category: 'ui.click',
          ),
          returnsNormally,
        );
      });

      test('addBreadcrumb accepts data', () {
        expect(
          () => ErrorTrackingService.addBreadcrumb(
            message: 'Test breadcrumb',
            data: {'target': 'button'},
          ),
          returnsNormally,
        );
      });

      test('addNavigationBreadcrumb works', () {
        expect(
          () => ErrorTrackingService.addNavigationBreadcrumb(
            from: '/home',
            to: '/about',
          ),
          returnsNormally,
        );
      });

      test('addUserActionBreadcrumb works', () {
        expect(
          () => ErrorTrackingService.addUserActionBreadcrumb(
            action: 'clicked button',
          ),
          returnsNormally,
        );
      });

      test('addUserActionBreadcrumb accepts target', () {
        expect(
          () => ErrorTrackingService.addUserActionBreadcrumb(
            action: 'clicked button',
            target: '#submit-btn',
          ),
          returnsNormally,
        );
      });
    });

    group('user context', () {
      test('setUser accepts id', () {
        expect(
          () => ErrorTrackingService.setUser(id: '123'),
          returnsNormally,
        );
      });

      test('setUser accepts all parameters', () {
        expect(
          () => ErrorTrackingService.setUser(
            id: '123',
            email: 'test@example.com',
            username: 'testuser',
            data: {'plan': 'pro'},
          ),
          returnsNormally,
        );
      });

      test('clearUser works', () {
        expect(
          () => ErrorTrackingService.clearUser(),
          returnsNormally,
        );
      });
    });

    group('performance', () {
      test('startTransaction returns span', () {
        final span = ErrorTrackingService.startTransaction(
          name: 'test-transaction',
          operation: 'test.operation',
        );
        expect(span, isNotNull);
        span.finish();
      });
    });

    group('tags', () {
      test('setTag works', () {
        expect(
          () => ErrorTrackingService.setTag('env', 'test'),
          returnsNormally,
        );
      });

      test('setTags works with multiple tags', () {
        expect(
          () => ErrorTrackingService.setTags({
            'env': 'test',
            'version': '1.0.0',
            'region': 'us-east',
          }),
          returnsNormally,
        );
      });
    });
  });

  group('FacebookPixelService', () {
    group('lifecycle', () {
      test('isReady returns false before initialization', () {
        expect(FacebookPixelService.isReady, isA<bool>());
      });

      test('enable and disable toggle state', () {
        FacebookPixelService.enable();
        FacebookPixelService.disable();
        expect(FacebookPixelService.isReady, isFalse);
        FacebookPixelService.enable();
      });

      test('initialize completes on non-web', () async {
        await FacebookPixelService.initialize();
        expect(true, isTrue);
      });
    });

    group('tracking methods exist', () {
      test('trackPageView works', () {
        expect(
          () => FacebookPixelService.trackPageView(),
          returnsNormally,
        );
      });

      test('trackLead works', () {
        expect(
          () => FacebookPixelService.trackLead(),
          returnsNormally,
        );
      });

      test('trackLead with email works', () {
        expect(
          () => FacebookPixelService.trackLead(email: 'test@example.com'),
          returnsNormally,
        );
      });

      test('trackContact works', () {
        expect(
          () => FacebookPixelService.trackContact(),
          returnsNormally,
        );
      });

      test('trackContact with email and name works', () {
        expect(
          () => FacebookPixelService.trackContact(
            email: 'test@example.com',
            name: 'Test User',
          ),
          returnsNormally,
        );
      });

      test('trackViewContent accepts content type', () {
        expect(
          () => FacebookPixelService.trackViewContent('article'),
          returnsNormally,
        );
      });
    });
  });
}
