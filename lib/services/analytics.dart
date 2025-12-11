import 'package:flutter/foundation.dart';

/// Analytics service using JavaScript interop for GA4
///
/// IMPORTANT: This service ONLY initializes after user consent.
/// Analytics scripts are loaded dynamically, NOT in index.html.
///
/// This approach:
/// - Reduces bundle size (no Firebase SDK)
/// - Ensures GDPR compliance (no tracking before consent)
/// - Provides same functionality via gtag.js
class AnalyticsService {
  AnalyticsService._();

  static bool _initialized = false;
  static bool _enabled = true;

  /// Initialize GA4 analytics
  /// Called ONLY after user consent is given
  static Future<void> initialize() async {
    if (_initialized || !kIsWeb) return;

    try {
      // On web, this would inject the GA4 script dynamically
      // Using dart:js interop
      //
      // final script = html.ScriptElement()
      //   ..async = true
      //   ..src = 'https://www.googletagmanager.com/gtag/js?id=$measurementId';
      // html.document.head!.append(script);
      //
      // await script.onLoad.first;
      //
      // js.context.callMethod('eval', ['''
      //   window.dataLayer = window.dataLayer || [];
      //   function gtag(){dataLayer.push(arguments);}
      //   gtag('js', new Date());
      //   gtag('config', '$measurementId', {
      //     'anonymize_ip': true,
      //     'cookie_flags': 'SameSite=None;Secure'
      //   });
      // ''']);

      _initialized = true;
      debugPrint('Analytics initialized');
    } catch (e) {
      debugPrint('Failed to initialize analytics: $e');
    }
  }

  /// Disable analytics (for consent revocation)
  static void disable() {
    _enabled = false;
    debugPrint('Analytics disabled');
  }

  /// Enable analytics (after re-consent)
  static void enable() {
    _enabled = true;
    debugPrint('Analytics enabled');
  }

  /// Track page view
  static void trackPageView(String pageName) {
    if (!_initialized || !_enabled) return;

    _sendEvent('page_view', {
      'page_title': pageName,
      'page_location': pageName,
    });

    debugPrint('Analytics: Page view - $pageName');
  }

  /// Track CTA button click
  static void trackCTAClick({
    required String buttonName,
    required String location,
    String? ctaType,
  }) {
    if (!_initialized || !_enabled) return;

    _sendEvent('cta_click', {
      'button_name': buttonName,
      'location': location,
      if (ctaType != null) 'cta_type': ctaType,
    });

    debugPrint('Analytics: CTA click - $buttonName at $location');
  }

  /// Track form submission
  static void trackFormSubmission({
    required String formType,
    required bool success,
    String? errorMessage,
  }) {
    if (!_initialized || !_enabled) return;

    _sendEvent('form_submission', {
      'form_type': formType,
      'success': success,
      if (errorMessage != null) 'error_message': errorMessage,
    });

    debugPrint('Analytics: Form submission - $formType (success: $success)');
  }

  /// Track pricing tier view
  static void trackPricingView(String tier) {
    if (!_initialized || !_enabled) return;

    _sendEvent('pricing_tier_view', {
      'tier': tier,
    });

    debugPrint('Analytics: Pricing view - $tier');
  }

  /// Track scroll depth
  static void trackScrollDepth(int percentage) {
    if (!_initialized || !_enabled) return;

    // Only track at 25%, 50%, 75%, 100%
    if (percentage % 25 != 0) return;

    _sendEvent('scroll_depth', {
      'percentage': percentage,
    });

    debugPrint('Analytics: Scroll depth - $percentage%');
  }

  /// Track feature card interaction
  static void trackFeatureInteraction(String featureName) {
    if (!_initialized || !_enabled) return;

    _sendEvent('feature_interaction', {
      'feature_name': featureName,
    });

    debugPrint('Analytics: Feature interaction - $featureName');
  }

  /// Track pricing toggle (annual/monthly)
  static void trackPricingToggle({
    required bool isAnnual,
  }) {
    if (!_initialized || !_enabled) return;

    _sendEvent('pricing_toggle', {
      'billing_period': isAnnual ? 'annual' : 'monthly',
    });

    debugPrint('Analytics: Pricing toggle - ${isAnnual ? 'annual' : 'monthly'}');
  }

  /// Track external link click
  static void trackExternalLink(String url) {
    if (!_initialized || !_enabled) return;

    _sendEvent('external_link_click', {
      'url': url,
    });

    debugPrint('Analytics: External link - $url');
  }

  /// Track demo request
  static void trackDemoRequest() {
    if (!_initialized || !_enabled) return;

    _sendEvent('demo_request', {});

    debugPrint('Analytics: Demo request');
  }

  /// Internal method to send events
  static void _sendEvent(String eventName, Map<String, dynamic> parameters) {
    if (!kIsWeb) return;

    // On web, this would call gtag via JS interop:
    // js.context.callMethod('gtag', ['event', eventName, js.JsObject.jsify(parameters)]);

    // For now, just log the event
    debugPrint('Would send event: $eventName with params: $parameters');
  }
}

/// Facebook Pixel service (similar pattern)
class FacebookPixelService {
  FacebookPixelService._();

  static bool _initialized = false;
  static bool _enabled = true;

  /// Initialize Facebook Pixel
  /// Called ONLY after marketing consent is given
  static Future<void> initialize(String pixelId) async {
    if (_initialized || !kIsWeb) return;

    try {
      // On web, inject FB Pixel script dynamically
      _initialized = true;
      debugPrint('Facebook Pixel initialized');
    } catch (e) {
      debugPrint('Failed to initialize Facebook Pixel: $e');
    }
  }

  /// Disable tracking
  static void disable() {
    _enabled = false;
  }

  /// Track page view
  static void trackPageView() {
    if (!_initialized || !_enabled) return;
    // fbq('track', 'PageView');
  }

  /// Track lead (form submission)
  static void trackLead() {
    if (!_initialized || !_enabled) return;
    // fbq('track', 'Lead');
  }

  /// Track view content
  static void trackViewContent(String contentType) {
    if (!_initialized || !_enabled) return;
    // fbq('track', 'ViewContent', {content_type: contentType});
  }
}
