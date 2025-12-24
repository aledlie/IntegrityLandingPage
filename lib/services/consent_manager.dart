import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../models/consent_preferences.dart';
import 'analytics.dart';
import 'tracking.dart';

// Re-export for backward compatibility
export '../models/consent_preferences.dart';

/// GDPR-compliant consent management
///
/// This service manages user consent for cookies and analytics.
/// Analytics are ONLY initialized AFTER explicit user consent.
///
/// Usage:
/// 1. Check if consent exists: ConsentManager.hasConsent()
/// 2. Show cookie banner if no consent
/// 3. Save consent: await ConsentManager.saveConsent(prefs)
/// 4. Analytics auto-initialize based on consent preferences
class ConsentManager {
  ConsentManager._();

  static const String _storageKey = 'integrity_cookie_consent';

  /// Check if user has already given consent (any level)
  static bool hasConsent() {
    if (!kIsWeb) return true; // Non-web platforms don't need consent banner

    try {
      // Access localStorage via dart:html on web
      final stored = _getFromStorage(_storageKey);
      return stored != null;
    } catch (e) {
      return false;
    }
  }

  /// Get stored consent preferences
  static Future<ConsentPreferences?> getStoredConsent() async {
    if (!kIsWeb) {
      return ConsentPreferences(
        analytics: true,
        marketing: true,
      );
    }

    try {
      final stored = _getFromStorage(_storageKey);
      if (stored == null) return null;
      return ConsentPreferences.fromJson(jsonDecode(stored));
    } catch (e) {
      return null;
    }
  }

  /// Save consent and initialize services accordingly
  static Future<void> saveConsent(ConsentPreferences prefs) async {
    if (kIsWeb) {
      try {
        _setToStorage(_storageKey, jsonEncode(prefs.toJson()));
      } catch (e) {
        // Storage might be unavailable in private browsing
        debugPrint('Failed to save consent to storage: $e');
      }

      // Update GTM Consent Mode with user's choices
      TrackingWeb.updateConsent(
        analytics: prefs.analytics,
        marketing: prefs.marketing,
      );
    }

    // Initialize analytics ONLY if consent was given
    if (prefs.analytics) {
      await AnalyticsService.initialize();
    }

    if (prefs.marketing) {
      await _initializeMarketing();
    }
  }

  /// Revoke all consent (for "Manage Preferences" -> "Reject All")
  static Future<void> revokeConsent() async {
    if (kIsWeb) {
      try {
        _removeFromStorage(_storageKey);
      } catch (e) {
        debugPrint('Failed to remove consent from storage: $e');
      }
    }

    // Note: We can't truly "uninitialize" analytics scripts that are already loaded
    // But we can stop tracking new events
    AnalyticsService.disable();
  }

  /// Initialize Facebook Pixel (only after marketing consent)
  static Future<void> _initializeMarketing() async {
    if (!kIsWeb) return;

    // Inject Facebook Pixel script
    TrackingWeb.injectFacebookPixel();
    TrackingWeb.sendFBPageView();
    debugPrint('Marketing tracking initialized with consent');
  }

  // Platform-specific storage methods using TrackingWeb
  static String? _getFromStorage(String key) {
    if (!kIsWeb) return null;
    return TrackingWeb.getFromStorage(key);
  }

  static void _setToStorage(String key, String value) {
    if (!kIsWeb) return;
    TrackingWeb.setToStorage(key, value);
  }

  static void _removeFromStorage(String key) {
    if (!kIsWeb) return;
    TrackingWeb.removeFromStorage(key);
  }
}
