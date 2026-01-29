import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integrity_studio_ai/routing/cookie_shell.dart';
import 'package:integrity_studio_ai/widgets/consent/cookie_banner.dart';
import '../helpers/test_helpers.dart';

void main() {
  // Suppress overflow errors in layout tests
  final originalOnError = FlutterError.onError;

  setUpAll(() {
    initializeTestContent();
  });

  setUp(() {
    FlutterError.onError = (FlutterErrorDetails details) {
      final isOverflowError =
          details.exception.toString().contains('overflowed');
      if (!isOverflowError) {
        originalOnError?.call(details);
      }
    };
  });

  tearDown(() {
    FlutterError.onError = originalOnError;
  });

  // Helper to check if an error is an overflow error
  bool isOverflowError(dynamic exception) {
    if (exception == null) return false;
    final message = exception.toString();
    return message.contains('overflowed') ||
        message.contains('RenderFlex') ||
        message.contains('A RenderFlex');
  }

  // Helper to clear overflow exceptions after operations
  void clearOverflowExceptions(WidgetTester tester) {
    dynamic exception = tester.takeException();
    while (exception != null) {
      if (!isOverflowError(exception)) {
        throw exception;
      }
      exception = tester.takeException();
    }
  }

  group('CookieBannerShell', () {
    group('constructor', () {
      test('creates with required parameters', () {
        const shell = CookieBannerShell(
          child: Text('Content'),
          showBanner: false,
          onConsentGiven: _noopCallback,
        );

        expect(shell.showBanner, isFalse);
        expect(shell.child, isA<Text>());
        expect(shell.onConsentGiven, isNotNull);
      });

      test('showBanner can be true', () {
        const shell = CookieBannerShell(
          child: Text('Content'),
          showBanner: true,
          onConsentGiven: _noopCallback,
        );

        expect(shell.showBanner, isTrue);
      });
    });

    group('rendering', () {
      testWidgets('renders child content', (tester) async {
        await tester.pumpWidget(testableWidget(
          const CookieBannerShell(
            child: Text('Page Content'),
            showBanner: false,
            onConsentGiven: _noopCallback,
          ),
        ));

        expect(find.text('Page Content'), findsOneWidget);
      });

      testWidgets('does not show banner when showBanner is false',
          (tester) async {
        await tester.pumpWidget(testableWidget(
          const CookieBannerShell(
            child: Text('Content'),
            showBanner: false,
            onConsentGiven: _noopCallback,
          ),
        ));

        expect(find.byType(CookieBanner), findsNothing);
      });

      testWidgets('shows banner when showBanner is true', (tester) async {
        await tester.pumpWidget(testableWidget(
          CookieBannerShell(
            child: const Text('Content'),
            showBanner: true,
            onConsentGiven: () {},
          ),
        ));

        expect(find.byType(CookieBanner), findsOneWidget);
      });

      testWidgets('uses Stack layout', (tester) async {
        await tester.pumpWidget(testableWidget(
          const CookieBannerShell(
            child: Text('Content'),
            showBanner: false,
            onConsentGiven: _noopCallback,
          ),
        ));

        // CookieBannerShell uses Stack to overlay banner on content
        expect(find.byType(Stack), findsWidgets);
        expect(
          find.descendant(
            of: find.byType(CookieBannerShell),
            matching: find.byType(Stack),
          ),
          findsOneWidget,
        );
      });

      testWidgets('child is in Stack with banner overlay', (tester) async {
        await tester.pumpWidget(testableWidget(
          CookieBannerShell(
            child: const Text('Main Content'),
            showBanner: true,
            onConsentGiven: () {},
          ),
        ));

        // Both child and banner should be in the Stack
        expect(find.text('Main Content'), findsOneWidget);
        expect(find.byType(CookieBanner), findsOneWidget);

        // The shell uses Stack to overlay banner on content
        expect(find.byType(Stack), findsWidgets);
      });
    });

    group('banner visibility toggle', () {
      testWidgets('banner visibility changes with showBanner prop',
          (tester) async {
        var showBanner = false;

        await tester.pumpWidget(
          StatefulBuilder(
            builder: (context, setState) {
              return testableWidget(
                CookieBannerShell(
                  child: ElevatedButton(
                    onPressed: () => setState(() => showBanner = !showBanner),
                    child: const Text('Toggle'),
                  ),
                  showBanner: showBanner,
                  onConsentGiven: () {},
                ),
              );
            },
          ),
        );

        expect(find.byType(CookieBanner), findsNothing);

        // Toggle banner
        await tester.tap(find.text('Toggle'));
        await tester.pump();
        clearOverflowExceptions(tester);
        await tester.pump();
        clearOverflowExceptions(tester);

        expect(find.byType(CookieBanner), findsOneWidget);
      });
    });

    group('callback handling', () {
      testWidgets('passes onConsentGiven to CookieBanner', (tester) async {
        var consentGiven = false;

        await tester.pumpWidget(testableWidget(
          CookieBannerShell(
            child: const Text('Content'),
            showBanner: true,
            onConsentGiven: () {
              consentGiven = true;
            },
          ),
        ));

        expect(find.byType(CookieBanner), findsOneWidget);

        // The CookieBanner should receive the callback
        final banner = tester.widget<CookieBanner>(find.byType(CookieBanner));
        expect(banner.onConsentGiven, isNotNull);

        // Calling the callback should set our flag
        banner.onConsentGiven();
        expect(consentGiven, isTrue);
      });
    });

    group('child widget types', () {
      testWidgets('works with complex child widgets', (tester) async {
        await tester.pumpWidget(testableWidget(
          CookieBannerShell(
            child: Column(
              children: const [
                Text('Header'),
                Text('Body'),
                Text('Footer'),
              ],
            ),
            showBanner: false,
            onConsentGiven: () {},
          ),
        ));

        expect(find.text('Header'), findsOneWidget);
        expect(find.text('Body'), findsOneWidget);
        expect(find.text('Footer'), findsOneWidget);
      });

      testWidgets('works with scrollable child', (tester) async {
        await tester.pumpWidget(testableWidget(
          CookieBannerShell(
            child: ListView(
              children: List.generate(
                10,
                (i) => ListTile(title: Text('Item $i')),
              ),
            ),
            showBanner: false,
            onConsentGiven: () {},
          ),
        ));

        expect(find.byType(ListView), findsOneWidget);
        expect(find.text('Item 0'), findsOneWidget);
      });
    });

    group('widget properties', () {
      testWidgets('is a StatelessWidget', (tester) async {
        await tester.pumpWidget(testableWidget(
          const CookieBannerShell(
            child: Text('Content'),
            showBanner: false,
            onConsentGiven: _noopCallback,
          ),
        ));

        expect(find.byType(CookieBannerShell), findsOneWidget);
        final shell = tester.widget(find.byType(CookieBannerShell));
        expect(shell, isA<StatelessWidget>());
      });

      test('child property is accessible', () {
        const child = Text('Test');
        const shell = CookieBannerShell(
          child: child,
          showBanner: false,
          onConsentGiven: _noopCallback,
        );

        expect(shell.child, equals(child));
      });
    });
  });
}

void _noopCallback() {}
