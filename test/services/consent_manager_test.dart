import 'package:flutter_test/flutter_test.dart';
import 'package:integrity_studio_ai/services/consent_manager.dart';
import 'package:integrity_studio_ai/models/consent_preferences.dart';
import '../helpers/test_helpers.dart';

void main() {
  setUpAll(() {
    initializeTestContent();
  });

  group('ConsentManager', () {
    group('hasConsent', () {
      test('returns true on non-web platforms', () {
        // On non-web platforms (like test runner), hasConsent returns true
        final result = ConsentManager.hasConsent();
        expect(result, isTrue);
      });
    });

    group('getStoredConsent', () {
      test('returns full consent on non-web platforms', () async {
        final consent = await ConsentManager.getStoredConsent();

        expect(consent, isNotNull);
        expect(consent!.analytics, isTrue);
        expect(consent.marketing, isTrue);
        expect(consent.essential, isTrue);
      });
    });

    group('saveConsent', () {
      test('completes without error for analytics consent', () async {
        final prefs = ConsentPreferences(
          analytics: true,
          marketing: false,
        );

        // Should not throw
        await ConsentManager.saveConsent(prefs);
        expect(true, isTrue);
      });

      test('completes without error for marketing consent', () async {
        final prefs = ConsentPreferences(
          analytics: false,
          marketing: true,
        );

        await ConsentManager.saveConsent(prefs);
        expect(true, isTrue);
      });

      test('completes without error for full consent', () async {
        final prefs = ConsentPreferences(
          analytics: true,
          marketing: true,
        );

        await ConsentManager.saveConsent(prefs);
        expect(true, isTrue);
      });

      test('completes without error for no consent', () async {
        final prefs = ConsentPreferences(
          analytics: false,
          marketing: false,
        );

        await ConsentManager.saveConsent(prefs);
        expect(true, isTrue);
      });
    });

    group('revokeConsent', () {
      test('completes without error', () async {
        await ConsentManager.revokeConsent();
        expect(true, isTrue);
      });
    });
  });

  group('ConsentPreferences', () {
    group('construction', () {
      test('creates with required values', () {
        final prefs = ConsentPreferences(
          analytics: false,
          marketing: false,
        );
        expect(prefs.essential, isTrue);
        expect(prefs.analytics, isFalse);
        expect(prefs.marketing, isFalse);
      });

      test('creates with all true values', () {
        final prefs = ConsentPreferences(
          analytics: true,
          marketing: true,
        );
        expect(prefs.essential, isTrue);
        expect(prefs.analytics, isTrue);
        expect(prefs.marketing, isTrue);
      });

      test('essential is always true', () {
        final prefs = ConsentPreferences(
          analytics: false,
          marketing: false,
        );
        expect(prefs.essential, isTrue);
      });

      test('sets timestamp to now by default', () {
        final before = DateTime.now();
        final prefs = ConsentPreferences(analytics: true, marketing: true);
        final after = DateTime.now();

        expect(prefs.timestamp.isAfter(before.subtract(const Duration(seconds: 1))), isTrue);
        expect(prefs.timestamp.isBefore(after.add(const Duration(seconds: 1))), isTrue);
      });

      test('uses provided timestamp', () {
        final timestamp = DateTime(2024, 1, 1);
        final prefs = ConsentPreferences(
          analytics: true,
          marketing: true,
          timestamp: timestamp,
        );

        expect(prefs.timestamp, equals(timestamp));
      });

      test('default consent version is 1.0', () {
        final prefs = ConsentPreferences(analytics: true, marketing: true);
        expect(prefs.consentVersion, equals('1.0'));
      });

      test('uses provided consent version', () {
        final prefs = ConsentPreferences(
          analytics: true,
          marketing: true,
          consentVersion: '2.0',
        );
        expect(prefs.consentVersion, equals('2.0'));
      });
    });

    group('factory constructors', () {
      test('acceptAll creates full consent', () {
        final prefs = ConsentPreferences.acceptAll();
        expect(prefs.essential, isTrue);
        expect(prefs.analytics, isTrue);
        expect(prefs.marketing, isTrue);
      });

      test('essentialOnly creates essential only consent', () {
        final prefs = ConsentPreferences.essentialOnly();
        expect(prefs.essential, isTrue);
        expect(prefs.analytics, isFalse);
        expect(prefs.marketing, isFalse);
      });

      test('analyticsOnly creates analytics consent', () {
        final prefs = ConsentPreferences.analyticsOnly();
        expect(prefs.essential, isTrue);
        expect(prefs.analytics, isTrue);
        expect(prefs.marketing, isFalse);
      });
    });

    group('JSON serialization', () {
      test('toJson creates correct map', () {
        final prefs = ConsentPreferences(
          analytics: true,
          marketing: false,
        );
        final json = prefs.toJson();

        expect(json['essential'], isTrue);
        expect(json['analytics'], isTrue);
        expect(json['marketing'], isFalse);
        expect(json['timestamp'], isNotNull);
        expect(json['consentVersion'], equals('1.0'));
      });

      test('fromJson creates correct object', () {
        final json = {
          'essential': true,
          'analytics': true,
          'marketing': false,
          'timestamp': '2024-01-01T00:00:00.000',
          'consentVersion': '1.0',
        };
        final prefs = ConsentPreferences.fromJson(json);

        expect(prefs.essential, isTrue);
        expect(prefs.analytics, isTrue);
        expect(prefs.marketing, isFalse);
      });

      test('fromJson handles missing analytics', () {
        final json = <String, dynamic>{
          'essential': true,
          'marketing': false,
        };
        final prefs = ConsentPreferences.fromJson(json);

        expect(prefs.analytics, isFalse);
      });

      test('fromJson handles missing marketing', () {
        final json = <String, dynamic>{
          'essential': true,
          'analytics': true,
        };
        final prefs = ConsentPreferences.fromJson(json);

        expect(prefs.marketing, isFalse);
      });

      test('fromJson handles missing consentVersion', () {
        final json = <String, dynamic>{
          'essential': true,
          'analytics': true,
          'marketing': false,
        };
        final prefs = ConsentPreferences.fromJson(json);

        expect(prefs.consentVersion, equals('1.0'));
      });
    });

    group('toString', () {
      test('returns descriptive string', () {
        final prefs = ConsentPreferences(analytics: true, marketing: false);
        final str = prefs.toString();

        expect(str, contains('ConsentPreferences'));
        expect(str, contains('analytics: true'));
        expect(str, contains('marketing: false'));
      });
    });
  });

  group('ConsentLevel', () {
    test('has three values', () {
      expect(ConsentLevel.values.length, equals(3));
    });

    test('contains essential', () {
      expect(ConsentLevel.values, contains(ConsentLevel.essential));
    });

    test('contains analytics', () {
      expect(ConsentLevel.values, contains(ConsentLevel.analytics));
    });

    test('contains all', () {
      expect(ConsentLevel.values, contains(ConsentLevel.all));
    });
  });

  group('ConsentLevelExtension', () {
    test('essential.toPreferences returns essentialOnly', () {
      final prefs = ConsentLevel.essential.toPreferences();
      expect(prefs.analytics, isFalse);
      expect(prefs.marketing, isFalse);
    });

    test('analytics.toPreferences returns analyticsOnly', () {
      final prefs = ConsentLevel.analytics.toPreferences();
      expect(prefs.analytics, isTrue);
      expect(prefs.marketing, isFalse);
    });

    test('all.toPreferences returns acceptAll', () {
      final prefs = ConsentLevel.all.toPreferences();
      expect(prefs.analytics, isTrue);
      expect(prefs.marketing, isTrue);
    });
  });
}
