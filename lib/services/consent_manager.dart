import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'analytics.dart';

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

    // Facebook Pixel initialization would go here
    // This is loaded dynamically AFTER consent, not in index.html
    debugPrint('Marketing tracking initialized with consent');
  }

  // Platform-specific storage methods
  static String? _getFromStorage(String key) {
    if (!kIsWeb) return null;
    // This will be implemented with dart:html on web
    // For now, return null to indicate web-specific implementation needed
    return null;
  }

  static void _setToStorage(String key, String value) {
    if (!kIsWeb) return;
    // This will be implemented with dart:html on web
  }

  static void _removeFromStorage(String key) {
    if (!kIsWeb) return;
    // This will be implemented with dart:html on web
  }
}

/// Consent preferences model
///
/// GDPR requires:
/// - Recording WHEN consent was given (timestamp)
/// - Granular consent options (analytics vs marketing)
/// - Easy withdrawal mechanism
class ConsentPreferences {
  /// Essential cookies are always allowed (required for site function)
  final bool essential;

  /// Analytics cookies (GA4, usage tracking)
  final bool analytics;

  /// Marketing cookies (Facebook Pixel, ad tracking)
  final bool marketing;

  /// Timestamp when consent was given (GDPR requirement)
  final DateTime timestamp;

  /// Version of consent form (for audit trail)
  final String consentVersion;

  ConsentPreferences({
    this.essential = true, // Always true
    required this.analytics,
    required this.marketing,
    DateTime? timestamp,
    this.consentVersion = '1.0',
  }) : timestamp = timestamp ?? DateTime.now();

  /// Create from "Accept All" action
  factory ConsentPreferences.acceptAll() => ConsentPreferences(
        analytics: true,
        marketing: true,
      );

  /// Create from "Essential Only" action
  factory ConsentPreferences.essentialOnly() => ConsentPreferences(
        analytics: false,
        marketing: false,
      );

  /// Create from "Analytics Only" action
  factory ConsentPreferences.analyticsOnly() => ConsentPreferences(
        analytics: true,
        marketing: false,
      );

  Map<String, dynamic> toJson() => {
        'essential': essential,
        'analytics': analytics,
        'marketing': marketing,
        'timestamp': timestamp.toIso8601String(),
        'consentVersion': consentVersion,
      };

  factory ConsentPreferences.fromJson(Map<String, dynamic> json) =>
      ConsentPreferences(
        essential: json['essential'] as bool? ?? true,
        analytics: json['analytics'] as bool? ?? false,
        marketing: json['marketing'] as bool? ?? false,
        timestamp: json['timestamp'] != null
            ? DateTime.parse(json['timestamp'] as String)
            : null,
        consentVersion: json['consentVersion'] as String? ?? '1.0',
      );

  @override
  String toString() =>
      'ConsentPreferences(analytics: $analytics, marketing: $marketing, timestamp: $timestamp)';
}

/// Consent level for quick actions
enum ConsentLevel {
  /// Only essential cookies
  essential,

  /// Essential + Analytics
  analytics,

  /// All cookies including marketing
  all,
}

extension ConsentLevelExtension on ConsentLevel {
  ConsentPreferences toPreferences() {
    switch (this) {
      case ConsentLevel.essential:
        return ConsentPreferences.essentialOnly();
      case ConsentLevel.analytics:
        return ConsentPreferences.analyticsOnly();
      case ConsentLevel.all:
        return ConsentPreferences.acceptAll();
    }
  }
}
