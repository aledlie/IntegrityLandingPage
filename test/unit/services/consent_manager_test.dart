import 'package:flutter_test/flutter_test.dart';
import 'package:integrity_studio_ai/services/consent_manager.dart';

void main() {
  group('ConsentManager', () {
    group('hasConsent', () {
      test('returns true on non-web platforms', () {
        // In test environment (non-web), hasConsent should return true
        // because consent banner is not needed on non-web platforms
        final hasConsent = ConsentManager.hasConsent();

        expect(hasConsent, isTrue);
      });
    });

    group('getStoredConsent', () {
      test('returns full consent preferences on non-web platforms', () async {
        final prefs = await ConsentManager.getStoredConsent();

        expect(prefs, isNotNull);
        expect(prefs!.essential, isTrue);
        expect(prefs.analytics, isTrue);
        expect(prefs.marketing, isTrue);
      });

      test('returns non-null result on non-web platforms', () async {
        final prefs = await ConsentManager.getStoredConsent();

        expect(prefs, isNotNull);
      });
    });

    group('saveConsent', () {
      test('completes without error on non-web platforms', () async {
        final prefs = ConsentPreferences.acceptAll();

        // Should complete without throwing
        await expectLater(
          ConsentManager.saveConsent(prefs),
          completes,
        );
      });

      test('accepts acceptAll preferences', () async {
        final prefs = ConsentPreferences.acceptAll();

        await ConsentManager.saveConsent(prefs);

        // Verify no exception was thrown
        expect(true, isTrue);
      });

      test('accepts essentialOnly preferences', () async {
        final prefs = ConsentPreferences.essentialOnly();

        await ConsentManager.saveConsent(prefs);

        expect(true, isTrue);
      });

      test('accepts analyticsOnly preferences', () async {
        final prefs = ConsentPreferences.analyticsOnly();

        await ConsentManager.saveConsent(prefs);

        expect(true, isTrue);
      });

      test('accepts custom preferences', () async {
        final prefs = ConsentPreferences(
          analytics: true,
          marketing: false,
        );

        await ConsentManager.saveConsent(prefs);

        expect(true, isTrue);
      });
    });

    group('revokeConsent', () {
      test('completes without error on non-web platforms', () async {
        await expectLater(
          ConsentManager.revokeConsent(),
          completes,
        );
      });

      test('can be called multiple times', () async {
        await ConsentManager.revokeConsent();
        await ConsentManager.revokeConsent();

        expect(true, isTrue);
      });
    });

    group('consent flow', () {
      test('save then get returns correct consent on non-web', () async {
        // On non-web platforms, getStoredConsent always returns full consent
        // This is by design as consent banner is not needed
        await ConsentManager.saveConsent(ConsentPreferences.essentialOnly());

        final stored = await ConsentManager.getStoredConsent();

        // Non-web always returns full consent
        expect(stored, isNotNull);
        expect(stored!.analytics, isTrue);
        expect(stored.marketing, isTrue);
      });

      test('save, revoke, get flow works without error', () async {
        await ConsentManager.saveConsent(ConsentPreferences.acceptAll());
        await ConsentManager.revokeConsent();
        final stored = await ConsentManager.getStoredConsent();

        // Non-web always returns preferences
        expect(stored, isNotNull);
      });
    });

    group('re-export verification', () {
      test('ConsentPreferences is accessible from consent_manager import', () {
        // Verify the re-export works
        final prefs = ConsentPreferences.acceptAll();

        expect(prefs.essential, isTrue);
        expect(prefs.analytics, isTrue);
        expect(prefs.marketing, isTrue);
      });

      test('ConsentLevel is accessible from consent_manager import', () {
        const essential = ConsentLevel.essential;
        const analytics = ConsentLevel.analytics;
        const all = ConsentLevel.all;

        expect(essential.toPreferences().analytics, isFalse);
        expect(analytics.toPreferences().analytics, isTrue);
        expect(all.toPreferences().marketing, isTrue);
      });
    });
  });
}
