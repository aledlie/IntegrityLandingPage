import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integrity_studio_ai/models/consent_preferences.dart';
import 'package:integrity_studio_ai/widgets/consent/cookie_banner.dart';
import 'package:integrity_studio_ai/widgets/common/buttons.dart';

import '../../helpers/test_helpers.dart';

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

    group('widget rendering - main view', () {
      testWidgets('renders with cookie icon', (tester) async {
        setDesktopSize(tester);

        await tester.pumpWidget(
          testableWidget(
            Stack(
              children: [
                CookieBanner(onConsentGiven: () {}),
              ],
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 350));

        expect(find.byIcon(Icons.cookie_outlined), findsOneWidget);
      });

      testWidgets('renders header text', (tester) async {
        setDesktopSize(tester);

        await tester.pumpWidget(
          testableWidget(
            Stack(
              children: [
                CookieBanner(onConsentGiven: () {}),
              ],
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 350));

        expect(find.text('Cookie Preferences'), findsOneWidget);
      });

      testWidgets('renders description text', (tester) async {
        setDesktopSize(tester);

        await tester.pumpWidget(
          testableWidget(
            Stack(
              children: [
                CookieBanner(onConsentGiven: () {}),
              ],
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 350));

        expect(
          find.textContaining('We use cookies to improve your experience'),
          findsOneWidget,
        );
      });

      testWidgets('renders privacy policy link', (tester) async {
        setDesktopSize(tester);

        await tester.pumpWidget(
          testableWidget(
            Stack(
              children: [
                CookieBanner(onConsentGiven: () {}),
              ],
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 350));

        expect(find.text('Read our Privacy Policy'), findsOneWidget);
      });

      testWidgets('has positioned at bottom of screen', (tester) async {
        setDesktopSize(tester);

        await tester.pumpWidget(
          testableWidget(
            Stack(
              children: [
                CookieBanner(onConsentGiven: () {}),
              ],
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 350));

        expect(find.byType(Positioned), findsOneWidget);
      });

      testWidgets('has slide and fade animations', (tester) async {
        setDesktopSize(tester);

        await tester.pumpWidget(
          testableWidget(
            Stack(
              children: [
                CookieBanner(onConsentGiven: () {}),
              ],
            ),
          ),
        );
        // Don't wait for animations to settle
        await tester.pump();

        // MaterialApp adds its own transitions, so use findsWidgets
        expect(find.byType(SlideTransition), findsWidgets);
        expect(find.byType(FadeTransition), findsWidgets);
      });
    });

    group('widget rendering - desktop layout', () {
      testWidgets('shows three buttons on desktop', (tester) async {
        setDesktopSize(tester);

        await tester.pumpWidget(
          testableWidget(
            Stack(
              children: [
                CookieBanner(onConsentGiven: () {}),
              ],
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 350));

        expect(find.text('Manage Preferences'), findsOneWidget);
        expect(find.text('Reject Non-Essential'), findsOneWidget);
        expect(find.text('Accept All'), findsOneWidget);
      });

      testWidgets('buttons are in a Row on desktop', (tester) async {
        setDesktopSize(tester);

        await tester.pumpWidget(
          testableWidget(
            Stack(
              children: [
                CookieBanner(onConsentGiven: () {}),
              ],
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 350));

        // Find OutlineButtons (Manage Preferences, Reject Non-Essential)
        expect(find.byType(OutlineButton), findsNWidgets(2));
        // Find GradientButton (Accept All)
        expect(find.byType(GradientButton), findsOneWidget);
      });
    });

    group('widget rendering - mobile layout', () {
      testWidgets('shows different button layout on mobile', (tester) async {
        setMobileSize(tester);

        await tester.pumpWidget(
          testableWidget(
            Stack(
              children: [
                CookieBanner(onConsentGiven: () {}),
              ],
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 350));

        expect(find.text('Accept All'), findsOneWidget);
        expect(find.text('Reject'), findsOneWidget);
        expect(find.text('Manage'), findsOneWidget);
      });
    });

    group('button interactions - main view', () {
      testWidgets('Accept All triggers onConsentGiven', (tester) async {
        setDesktopSize(tester);
        var consentGiven = false;

        await tester.pumpWidget(
          testableWidget(
            Stack(
              children: [
                CookieBanner(onConsentGiven: () => consentGiven = true),
              ],
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 350));

        await tester.tap(find.text('Accept All'));
        await tester.pumpAndSettle();

        expect(consentGiven, isTrue);
      });

      testWidgets('Reject Non-Essential triggers onConsentGiven', (tester) async {
        setDesktopSize(tester);
        var consentGiven = false;

        await tester.pumpWidget(
          testableWidget(
            Stack(
              children: [
                CookieBanner(onConsentGiven: () => consentGiven = true),
              ],
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 350));

        await tester.tap(find.text('Reject Non-Essential'));
        await tester.pumpAndSettle();

        expect(consentGiven, isTrue);
      });

      testWidgets('Manage Preferences shows preferences view', (tester) async {
        setDesktopSize(tester);

        await tester.pumpWidget(
          testableWidget(
            Stack(
              children: [
                CookieBanner(onConsentGiven: () {}),
              ],
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 350));

        await tester.tap(find.text('Manage Preferences'));
        await tester.pump();

        // Should now see preferences view with cookie categories
        expect(find.text('Essential Cookies'), findsOneWidget);
        expect(find.text('Analytics Cookies'), findsOneWidget);
        expect(find.text('Marketing Cookies'), findsOneWidget);
      });
    });

    group('button interactions - mobile', () {
      testWidgets('Accept All triggers onConsentGiven on mobile', (tester) async {
        setMobileSize(tester);
        var consentGiven = false;

        await tester.pumpWidget(
          testableWidget(
            Stack(
              children: [
                CookieBanner(onConsentGiven: () => consentGiven = true),
              ],
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 350));

        await tester.tap(find.text('Accept All'));
        await tester.pumpAndSettle();

        expect(consentGiven, isTrue);
      });

      testWidgets('Reject triggers onConsentGiven on mobile', (tester) async {
        setMobileSize(tester);
        var consentGiven = false;

        await tester.pumpWidget(
          testableWidget(
            Stack(
              children: [
                CookieBanner(onConsentGiven: () => consentGiven = true),
              ],
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 350));

        await tester.tap(find.text('Reject'));
        await tester.pumpAndSettle();

        expect(consentGiven, isTrue);
      });

      testWidgets('Manage shows preferences view on mobile', (tester) async {
        setMobileSize(tester);

        await tester.pumpWidget(
          testableWidget(
            Stack(
              children: [
                CookieBanner(onConsentGiven: () {}),
              ],
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 350));

        await tester.tap(find.text('Manage'));
        await tester.pump();

        expect(find.text('Essential Cookies'), findsOneWidget);
      });
    });

    group('preferences view', () {
      testWidgets('shows back button', (tester) async {
        setDesktopSize(tester);

        await tester.pumpWidget(
          testableWidget(
            Stack(
              children: [
                CookieBanner(onConsentGiven: () {}),
              ],
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 350));

        await tester.tap(find.text('Manage Preferences'));
        await tester.pump();

        expect(find.byIcon(Icons.arrow_back), findsOneWidget);
      });

      testWidgets('back button returns to main view', (tester) async {
        setDesktopSize(tester);

        await tester.pumpWidget(
          testableWidget(
            Stack(
              children: [
                CookieBanner(onConsentGiven: () {}),
              ],
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 350));

        // Go to preferences
        await tester.tap(find.text('Manage Preferences'));
        await tester.pump();

        expect(find.text('Essential Cookies'), findsOneWidget);

        // Go back
        await tester.tap(find.byIcon(Icons.arrow_back));
        await tester.pump();

        // Should be back to main view
        expect(find.text('Essential Cookies'), findsNothing);
        expect(find.text('Manage Preferences'), findsOneWidget);
      });

      testWidgets('shows all three cookie categories', (tester) async {
        setDesktopSize(tester);

        await tester.pumpWidget(
          testableWidget(
            Stack(
              children: [
                CookieBanner(onConsentGiven: () {}),
              ],
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 350));

        await tester.tap(find.text('Manage Preferences'));
        await tester.pump();

        expect(find.text('Essential Cookies'), findsOneWidget);
        expect(find.text('Analytics Cookies'), findsOneWidget);
        expect(find.text('Marketing Cookies'), findsOneWidget);
      });

      testWidgets('shows Required badge for essential cookies', (tester) async {
        setDesktopSize(tester);

        await tester.pumpWidget(
          testableWidget(
            Stack(
              children: [
                CookieBanner(onConsentGiven: () {}),
              ],
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 350));

        await tester.tap(find.text('Manage Preferences'));
        await tester.pump();

        expect(find.text('Required'), findsOneWidget);
      });

      testWidgets('shows category descriptions', (tester) async {
        setDesktopSize(tester);

        await tester.pumpWidget(
          testableWidget(
            Stack(
              children: [
                CookieBanner(onConsentGiven: () {}),
              ],
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 350));

        await tester.tap(find.text('Manage Preferences'));
        await tester.pump();

        expect(
          find.textContaining('Required for the website to function'),
          findsOneWidget,
        );
        expect(
          find.textContaining('Google Analytics'),
          findsOneWidget,
        );
        expect(
          find.textContaining('Facebook Pixel'),
          findsOneWidget,
        );
      });

      testWidgets('has three Switch widgets', (tester) async {
        setDesktopSize(tester);

        await tester.pumpWidget(
          testableWidget(
            Stack(
              children: [
                CookieBanner(onConsentGiven: () {}),
              ],
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 350));

        await tester.tap(find.text('Manage Preferences'));
        await tester.pump();

        expect(find.byType(Switch), findsNWidgets(3));
      });

      testWidgets('shows Save Preferences button', (tester) async {
        setDesktopSize(tester);

        await tester.pumpWidget(
          testableWidget(
            Stack(
              children: [
                CookieBanner(onConsentGiven: () {}),
              ],
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 350));

        await tester.tap(find.text('Manage Preferences'));
        await tester.pump();

        expect(find.text('Save Preferences'), findsOneWidget);
      });

      testWidgets('Save Preferences triggers onConsentGiven', (tester) async {
        setDesktopSize(tester);
        var consentGiven = false;

        await tester.pumpWidget(
          testableWidget(
            Stack(
              children: [
                CookieBanner(onConsentGiven: () => consentGiven = true),
              ],
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 350));

        await tester.tap(find.text('Manage Preferences'));
        await tester.pump();

        await tester.tap(find.text('Save Preferences'));
        await tester.pumpAndSettle();

        expect(consentGiven, isTrue);
      });

      testWidgets('shows Reject All on desktop preferences view', (tester) async {
        setDesktopSize(tester);

        await tester.pumpWidget(
          testableWidget(
            Stack(
              children: [
                CookieBanner(onConsentGiven: () {}),
              ],
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 350));

        await tester.tap(find.text('Manage Preferences'));
        await tester.pump();

        expect(find.text('Reject All'), findsOneWidget);
      });

      testWidgets('Reject All triggers onConsentGiven', (tester) async {
        setDesktopSize(tester);
        var consentGiven = false;

        await tester.pumpWidget(
          testableWidget(
            Stack(
              children: [
                CookieBanner(onConsentGiven: () => consentGiven = true),
              ],
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 350));

        await tester.tap(find.text('Manage Preferences'));
        await tester.pump();

        await tester.tap(find.text('Reject All'));
        await tester.pumpAndSettle();

        expect(consentGiven, isTrue);
      });
    });

    group('preferences view - mobile', () {
      testWidgets('shows Save Preferences button on mobile', (tester) async {
        setMobileSize(tester);

        await tester.pumpWidget(
          testableWidget(
            Stack(
              children: [
                CookieBanner(onConsentGiven: () {}),
              ],
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 350));

        await tester.tap(find.text('Manage'));
        await tester.pump();

        expect(find.text('Save Preferences'), findsOneWidget);
        expect(find.text('Accept All'), findsOneWidget);
      });

      testWidgets('Save Preferences triggers onConsentGiven on mobile', (tester) async {
        setMobileSize(tester);
        var consentGiven = false;

        await tester.pumpWidget(
          testableWidget(
            Stack(
              children: [
                CookieBanner(onConsentGiven: () => consentGiven = true),
              ],
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 350));

        await tester.tap(find.text('Manage'));
        await tester.pump();

        await tester.tap(find.text('Save Preferences'));
        await tester.pumpAndSettle();

        expect(consentGiven, isTrue);
      });
    });

    group('toggle interactions', () {
      testWidgets('analytics toggle can be turned off', (tester) async {
        setDesktopSize(tester);

        await tester.pumpWidget(
          testableWidget(
            Stack(
              children: [
                CookieBanner(onConsentGiven: () {}),
              ],
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 350));

        await tester.tap(find.text('Manage Preferences'));
        await tester.pump();

        // Find all switches
        final switches = find.byType(Switch);
        expect(switches, findsNWidgets(3));

        // The analytics switch is the second one (index 1)
        // Essential is 0, Analytics is 1, Marketing is 2
        final analyticsSwitch = tester.widgetList<Switch>(switches).elementAt(1);

        // Initially analytics is true
        expect(analyticsSwitch.value, isTrue);

        // Tap to toggle
        await tester.tap(switches.at(1));
        await tester.pump();

        // Get updated switch
        final updatedSwitch = tester.widgetList<Switch>(switches).elementAt(1);
        expect(updatedSwitch.value, isFalse);
      });

      testWidgets('marketing toggle can be turned on', (tester) async {
        setDesktopSize(tester);

        await tester.pumpWidget(
          testableWidget(
            Stack(
              children: [
                CookieBanner(onConsentGiven: () {}),
              ],
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 350));

        await tester.tap(find.text('Manage Preferences'));
        await tester.pump();

        final switches = find.byType(Switch);

        // Marketing switch is third (index 2), initially false
        final marketingSwitch = tester.widgetList<Switch>(switches).elementAt(2);
        expect(marketingSwitch.value, isFalse);

        // Tap to toggle on
        await tester.tap(switches.at(2));
        await tester.pump();

        final updatedSwitch = tester.widgetList<Switch>(switches).elementAt(2);
        expect(updatedSwitch.value, isTrue);
      });

      testWidgets('essential toggle cannot be changed', (tester) async {
        setDesktopSize(tester);

        await tester.pumpWidget(
          testableWidget(
            Stack(
              children: [
                CookieBanner(onConsentGiven: () {}),
              ],
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 350));

        await tester.tap(find.text('Manage Preferences'));
        await tester.pump();

        final switches = find.byType(Switch);

        // Essential switch (index 0) should have onChanged = null
        final essentialSwitch = tester.widgetList<Switch>(switches).elementAt(0);
        expect(essentialSwitch.value, isTrue);
        expect(essentialSwitch.onChanged, isNull);
      });
    });

    group('animation behavior', () {
      testWidgets('animates in on mount', (tester) async {
        setDesktopSize(tester);

        await tester.pumpWidget(
          testableWidget(
            Stack(
              children: [
                CookieBanner(onConsentGiven: () {}),
              ],
            ),
          ),
        );

        // At start, should be invisible (animation at 0)
        await tester.pump();

        // After animation completes, should be visible
        await tester.pump(const Duration(milliseconds: 350));

        expect(find.text('Cookie Preferences'), findsOneWidget);
      });

      testWidgets('animates out when consent given', (tester) async {
        setDesktopSize(tester);
        var consentGiven = false;

        await tester.pumpWidget(
          testableWidget(
            Stack(
              children: [
                CookieBanner(onConsentGiven: () => consentGiven = true),
              ],
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 350));

        await tester.tap(find.text('Accept All'));

        // Animation should start
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 150));

        // Animation should complete
        await tester.pumpAndSettle();

        expect(consentGiven, isTrue);
      });
    });

    group('accessibility', () {
      testWidgets('has Material widget for elevation', (tester) async {
        setDesktopSize(tester);

        await tester.pumpWidget(
          testableWidget(
            Stack(
              children: [
                CookieBanner(onConsentGiven: () {}),
              ],
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 350));

        expect(find.byType(Material), findsWidgets);
      });

      testWidgets('has SafeArea for notch devices', (tester) async {
        setMobileSize(tester);

        await tester.pumpWidget(
          testableWidget(
            Stack(
              children: [
                CookieBanner(onConsentGiven: () {}),
              ],
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 350));

        expect(find.byType(SafeArea), findsOneWidget);
      });

      testWidgets('has TextButton for privacy policy link', (tester) async {
        setDesktopSize(tester);

        await tester.pumpWidget(
          testableWidget(
            Stack(
              children: [
                CookieBanner(onConsentGiven: () {}),
              ],
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 350));

        expect(find.byType(TextButton), findsOneWidget);
      });
    });
  });
}
