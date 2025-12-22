import 'package:flutter_test/flutter_test.dart';
import 'package:integrity_studio_ai/models/consent_preferences.dart';

void main() {
  group('CookieBanner', () {
    group('ConsentPreferences integration', () {
      test('acceptAll creates full consent', () {
        final prefs = ConsentPreferences.acceptAll();

        expect(prefs.essential, isTrue);
        expect(prefs.analytics, isTrue);
        expect(prefs.marketing, isTrue);
      });

      test('essentialOnly creates minimal consent', () {
        final prefs = ConsentPreferences.essentialOnly();

        expect(prefs.essential, isTrue);
        expect(prefs.analytics, isFalse);
        expect(prefs.marketing, isFalse);
      });

      test('custom consent allows granular control', () {
        final prefs = ConsentPreferences(
          analytics: true,
          marketing: false,
        );

        expect(prefs.essential, isTrue);
        expect(prefs.analytics, isTrue);
        expect(prefs.marketing, isFalse);
      });
    });

    group('ConsentLevel', () {
      test('essential level maps correctly', () {
        final prefs = ConsentLevel.essential.toPreferences();

        expect(prefs.analytics, isFalse);
        expect(prefs.marketing, isFalse);
      });

      test('analytics level maps correctly', () {
        final prefs = ConsentLevel.analytics.toPreferences();

        expect(prefs.analytics, isTrue);
        expect(prefs.marketing, isFalse);
      });

      test('all level maps correctly', () {
        final prefs = ConsentLevel.all.toPreferences();

        expect(prefs.analytics, isTrue);
        expect(prefs.marketing, isTrue);
      });
    });

    group('consent categories', () {
      test('essential cookies are always required', () {
        final prefs = ConsentPreferences.essentialOnly();
        expect(prefs.essential, isTrue);

        final fullPrefs = ConsentPreferences.acceptAll();
        expect(fullPrefs.essential, isTrue);
      });

      test('analytics cookies are optional', () {
        final essentialOnly = ConsentPreferences.essentialOnly();
        expect(essentialOnly.analytics, isFalse);

        final withAnalytics = ConsentPreferences.analyticsOnly();
        expect(withAnalytics.analytics, isTrue);
      });

      test('marketing cookies are optional', () {
        final essentialOnly = ConsentPreferences.essentialOnly();
        expect(essentialOnly.marketing, isFalse);

        final full = ConsentPreferences.acceptAll();
        expect(full.marketing, isTrue);
      });
    });
  });
}
