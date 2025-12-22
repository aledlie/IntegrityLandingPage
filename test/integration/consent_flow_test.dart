import 'package:flutter_test/flutter_test.dart';
import 'package:integrity_studio_ai/models/consent_preferences.dart';

import '../helpers/mocks.dart';

void main() {
  group('Consent Flow Integration', () {
    late MockConsentManager mockConsentManager;
    late MockAnalyticsTracker mockAnalytics;

    setUp(() {
      mockConsentManager = MockConsentManager();
      mockAnalytics = MockAnalyticsTracker();
    });

    group('consent manager', () {
      test('initially has no consent', () {
        expect(mockConsentManager.hasConsent, isFalse);
        expect(mockConsentManager.preferences, isNull);
      });

      test('setConsent updates state', () {
        final prefs = ConsentPreferences.acceptAll();
        mockConsentManager.setConsent(prefs);

        expect(mockConsentManager.hasConsent, isTrue);
        expect(mockConsentManager.preferences, equals(prefs));
      });

      test('clearConsent removes consent', () {
        mockConsentManager.setConsent(ConsentPreferences.acceptAll());
        mockConsentManager.clearConsent();

        expect(mockConsentManager.hasConsent, isFalse);
        expect(mockConsentManager.preferences, isNull);
      });

      test('saveConsent stores preferences', () async {
        final prefs = ConsentPreferences(
          analytics: true,
          marketing: false,
        );

        await mockConsentManager.saveConsent(prefs);

        expect(mockConsentManager.hasConsent, isTrue);
        expect(mockConsentManager.preferences?.analytics, isTrue);
        expect(mockConsentManager.preferences?.marketing, isFalse);
      });

      test('getStoredConsent returns saved preferences', () async {
        final prefs = ConsentPreferences.acceptAll();
        await mockConsentManager.saveConsent(prefs);

        final stored = await mockConsentManager.getStoredConsent();

        expect(stored, equals(prefs));
      });

      test('notifies listeners on consent change', () {
        bool notified = false;
        mockConsentManager.addListener(() => notified = true);

        mockConsentManager.setConsent(ConsentPreferences.acceptAll());

        expect(notified, isTrue);
      });
    });

    group('analytics integration', () {
      test('analytics disabled by default', () {
        expect(mockAnalytics.initialized, isFalse);
      });

      test('analytics can be initialized', () {
        mockAnalytics.initialize();

        expect(mockAnalytics.initialized, isTrue);
      });

      test('analytics can be disabled after initialization', () {
        mockAnalytics.initialize();
        mockAnalytics.disable();

        expect(mockAnalytics.enabled, isFalse);
      });

      test('analytics can be re-enabled', () {
        mockAnalytics.initialize();
        mockAnalytics.disable();
        mockAnalytics.enable();

        expect(mockAnalytics.enabled, isTrue);
      });

      test('events not tracked when disabled', () {
        mockAnalytics.initialize();
        mockAnalytics.disable();
        mockAnalytics.trackEvent('test_event', {});

        expect(mockAnalytics.calls, isEmpty);
      });

      test('events tracked when enabled', () {
        mockAnalytics.initialize();
        mockAnalytics.trackEvent('test_event', {'key': 'value'});

        expect(mockAnalytics.hasEvent('test_event'), isTrue);
      });

      test('events not tracked before initialization', () {
        mockAnalytics.trackEvent('test_event', {});

        expect(mockAnalytics.calls, isEmpty);
      });
    });

    group('consent to analytics flow', () {
      test('accepting all consent should enable analytics', () {
        // Simulate consent flow
        final prefs = ConsentPreferences.acceptAll();
        mockConsentManager.setConsent(prefs);

        // If analytics consent given, initialize analytics
        if (mockConsentManager.preferences?.analytics == true) {
          mockAnalytics.initialize();
        }

        expect(mockAnalytics.initialized, isTrue);
      });

      test('rejecting consent should not enable analytics', () {
        // Simulate reject flow
        final prefs = ConsentPreferences.essentialOnly();
        mockConsentManager.setConsent(prefs);

        // Only initialize if analytics consent given
        if (mockConsentManager.preferences?.analytics == true) {
          mockAnalytics.initialize();
        }

        expect(mockAnalytics.initialized, isFalse);
      });

      test('revoking consent should disable analytics', () {
        // Accept first
        mockConsentManager.setConsent(ConsentPreferences.acceptAll());
        mockAnalytics.initialize();

        // Then revoke
        mockConsentManager.clearConsent();
        mockAnalytics.disable();

        expect(mockAnalytics.enabled, isFalse);
      });
    });
  });
}
