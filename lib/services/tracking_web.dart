// ignore_for_file: avoid_web_libraries_in_flutter
import 'dart:js_interop';
import 'package:web/web.dart' as web;

/// GTM Container ID from Doppler (integrity-studio/prd)
/// Updated to new container (integritystudio.ai-v2) on 2025-12-28
const String gtmContainerId = 'GTM-NLLQ5ZM3';

/// GA4 Measurement ID from Doppler (integrity-studio/prd)
const String ga4MeasurementId = 'G-J7TL7PQH7S';

/// Facebook Pixel ID from Doppler (integrity-studio/prd)
const String fbPixelId = '25629020546684786';

// =============================================================================
// JS Interop Bindings
// =============================================================================

@JS('gtag')
external void _gtag(JSString command, [JSAny? arg1, JSAny? arg2]);

@JS('fbq')
external void _fbq(JSString command, [JSAny? arg1, JSAny? arg2]);

@JS('dataLayer')
external JSArray<JSAny>? get _dataLayer;

@JS('dataLayer')
external set _dataLayer(JSArray<JSAny>? value);

/// Push to dataLayer using JS interop
@JS('dataLayer.push')
external void _dataLayerPush(JSAny data);

// =============================================================================
// GTM Tracking Service
// =============================================================================

/// Web-specific GTM and Analytics implementation.
///
/// Handles:
/// - GTM script injection (after consent)
/// - Consent Mode v2 initialization
/// - gtag event sending
/// - localStorage for consent persistence
class TrackingWeb {
  TrackingWeb._();

  static bool _gtmInjected = false;
  static bool _fbPixelInjected = false;

  // ---------------------------------------------------------------------------
  // Consent Mode v2
  // ---------------------------------------------------------------------------

  /// Initialize Consent Mode with default denied state.
  /// This MUST be called before GTM loads (in index.html or early init).
  static void initializeConsentMode() {
    // Initialize dataLayer if not exists
    _dataLayer ??= <JSAny>[].toJS;

    // Set default consent state (denied until user consents)
    _gtag(
      'consent'.toJS,
      'default'.toJS,
      <String, dynamic>{
        'ad_storage': 'denied',
        'ad_user_data': 'denied',
        'ad_personalization': 'denied',
        'analytics_storage': 'denied',
        'functionality_storage': 'granted', // Essential cookies
        'personalization_storage': 'denied',
        'security_storage': 'granted', // Essential for security
        'wait_for_update': 500, // Wait 500ms for consent update
      }.jsify(),
    );
  }

  /// Update consent state after user makes a choice.
  static void updateConsent({
    required bool analytics,
    required bool marketing,
  }) {
    _gtag(
      'consent'.toJS,
      'update'.toJS,
      <String, dynamic>{
        'ad_storage': marketing ? 'granted' : 'denied',
        'ad_user_data': marketing ? 'granted' : 'denied',
        'ad_personalization': marketing ? 'granted' : 'denied',
        'analytics_storage': analytics ? 'granted' : 'denied',
        'personalization_storage': analytics ? 'granted' : 'denied',
      }.jsify(),
    );
  }

  // ---------------------------------------------------------------------------
  // GTM Injection
  // ---------------------------------------------------------------------------

  /// Inject GTM script after user consent.
  static void injectGTM() {
    if (_gtmInjected) return;

    final head = web.document.head;
    if (head == null) return;

    // Create GTM script
    final script = web.document.createElement('script') as web.HTMLScriptElement
      ..async = true
      ..src =
          'https://www.googletagmanager.com/gtm.js?id=$gtmContainerId';

    // Initialize dataLayer with GTM start event
    _dataLayer ??= <JSAny>[].toJS;
    _pushToDataLayer({
      'gtm.start': DateTime.now().millisecondsSinceEpoch,
      'event': 'gtm.js',
    });

    head.appendChild(script);
    _gtmInjected = true;
  }

  /// Push event to dataLayer.
  static void _pushToDataLayer(Map<String, dynamic> data) {
    _dataLayer ??= <JSAny>[].toJS;
    final jsData = data.jsify();
    if (jsData != null) {
      _dataLayerPush(jsData);
    }
  }

  // ---------------------------------------------------------------------------
  // GA4 Event Tracking
  // ---------------------------------------------------------------------------

  /// Send event to GA4 via gtag.
  static void sendEvent(String eventName, Map<String, dynamic> parameters) {
    if (!_gtmInjected) return;

    _gtag(
      'event'.toJS,
      eventName.toJS,
      parameters.jsify(),
    );
  }

  /// Send page view to GA4.
  static void sendPageView(String pagePath, String pageTitle) {
    sendEvent('page_view', {
      'page_path': pagePath,
      'page_title': pageTitle,
    });
  }

  // ---------------------------------------------------------------------------
  // Facebook Pixel
  // ---------------------------------------------------------------------------

  /// Inject Facebook Pixel script.
  static void injectFacebookPixel() {
    if (_fbPixelInjected) return;

    final head = web.document.head;
    if (head == null) return;

    // Facebook Pixel base code
    final script = web.document.createElement('script') as web.HTMLScriptElement
      ..text = '''
!function(f,b,e,v,n,t,s)
{if(f.fbq)return;n=f.fbq=function(){n.callMethod?
n.callMethod.apply(n,arguments):n.queue.push(arguments)};
if(!f._fbq)f._fbq=n;n.push=n;n.loaded=!0;n.version='2.0';
n.queue=[];t=b.createElement(e);t.async=!0;
t.src=v;s=b.getElementsByTagName(e)[0];
s.parentNode.insertBefore(t,s)}(window, document,'script',
'https://connect.facebook.net/en_US/fbevents.js');
fbq('init', '$fbPixelId');
''';

    head.appendChild(script);
    _fbPixelInjected = true;
  }

  /// Track Facebook Pixel event.
  static void sendFBEvent(String eventName, [Map<String, dynamic>? parameters]) {
    if (!_fbPixelInjected) return;

    if (parameters != null) {
      _fbq('track'.toJS, eventName.toJS, parameters.jsify());
    } else {
      _fbq('track'.toJS, eventName.toJS);
    }
  }

  /// Track Facebook Pixel page view.
  static void sendFBPageView() {
    sendFBEvent('PageView');
  }

  // ---------------------------------------------------------------------------
  // localStorage
  // ---------------------------------------------------------------------------

  /// Get value from localStorage.
  static String? getFromStorage(String key) {
    try {
      return web.window.localStorage.getItem(key);
    } catch (e) {
      return null;
    }
  }

  /// Set value in localStorage.
  static void setToStorage(String key, String value) {
    try {
      web.window.localStorage.setItem(key, value);
    } catch (e) {
      // Storage might be unavailable in private browsing
    }
  }

  /// Remove value from localStorage.
  static void removeFromStorage(String key) {
    try {
      web.window.localStorage.removeItem(key);
    } catch (e) {
      // Ignore errors
    }
  }

  // ---------------------------------------------------------------------------
  // Status
  // ---------------------------------------------------------------------------

  /// Check if GTM is injected.
  static bool get isGTMInjected => _gtmInjected;

  /// Check if Facebook Pixel is injected.
  static bool get isFBPixelInjected => _fbPixelInjected;
}
