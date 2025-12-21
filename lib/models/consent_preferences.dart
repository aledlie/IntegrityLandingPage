/// Consent preferences model for GDPR compliance.
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
