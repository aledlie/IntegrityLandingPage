import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integrity_studio_ai/routing/cookie_shell.dart';
import 'package:integrity_studio_ai/widgets/consent/cookie_banner.dart';
import '../helpers/test_helpers.dart';

void main() {
  // Suppress overflow errors in layout tests
  final originalOnError = FlutterError.onError;

  setUp(() {
    // Reset notifier before each test
    cookieBannerNotifier.value = false;
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
    cookieBannerNotifier.value = false;
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
          onConsentGiven: _noopCallback,
          child: Text('Content'),
        );

        expect(shell.child, isA<Text>());
        expect(shell.onConsentGiven, isNotNull);
      });
    });

    group('rendering', () {
      testWidgets('renders child content', (tester) async {
        await tester.pumpWidget(testableWidget(
          const CookieBannerShell(
            onConsentGiven: _noopCallback,
            child: Text('Page Content'),
          ),
        ));

        expect(find.text('Page Content'), findsOneWidget);
      });

      testWidgets('does not show banner when notifier is false',
          (tester) async {
        cookieBannerNotifier.value = false;

        await tester.pumpWidget(testableWidget(
          const CookieBannerShell(
            onConsentGiven: _noopCallback,
            child: Text('Content'),
          ),
        ));

        expect(find.byType(CookieBanner), findsNothing);
      });

      testWidgets('shows banner when notifier is true', (tester) async {
        cookieBannerNotifier.value = true;

        await tester.pumpWidget(testableWidget(
          CookieBannerShell(
            child: const Text('Content'),
            onConsentGiven: () {},
          ),
        ));

        expect(find.byType(CookieBanner), findsOneWidget);
      });

      testWidgets('uses Stack layout', (tester) async {
        await tester.pumpWidget(testableWidget(
          const CookieBannerShell(
            onConsentGiven: _noopCallback,
            child: Text('Content'),
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
        cookieBannerNotifier.value = true;

        await tester.pumpWidget(testableWidget(
          CookieBannerShell(
            child: const Text('Main Content'),
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
      testWidgets('banner visibility changes with notifier value',
          (tester) async {
        cookieBannerNotifier.value = false;

        await tester.pumpWidget(testableWidget(
          CookieBannerShell(
            child: ElevatedButton(
              onPressed: () =>
                  cookieBannerNotifier.value = !cookieBannerNotifier.value,
              child: const Text('Toggle'),
            ),
            onConsentGiven: () {},
          ),
        ));

        expect(find.byType(CookieBanner), findsNothing);

        // Toggle banner via notifier
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
        cookieBannerNotifier.value = true;

        await tester.pumpWidget(testableWidget(
          CookieBannerShell(
            child: const Text('Content'),
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
            onConsentGiven: _noopCallback,
            child: Text('Content'),
          ),
        ));

        expect(find.byType(CookieBannerShell), findsOneWidget);
        final shell = tester.widget(find.byType(CookieBannerShell));
        expect(shell, isA<StatelessWidget>());
      });

      test('child property is accessible', () {
        const child = Text('Test');
        const shell = CookieBannerShell(
          onConsentGiven: _noopCallback,
          child: child,
        );

        expect(shell.child, equals(child));
      });
    });

    group('cookieBannerNotifier', () {
      test('is a ValueNotifier<bool>', () {
        expect(cookieBannerNotifier, isA<ValueNotifier<bool>>());
      });

      test('can be set to true and false', () {
        cookieBannerNotifier.value = true;
        expect(cookieBannerNotifier.value, isTrue);

        cookieBannerNotifier.value = false;
        expect(cookieBannerNotifier.value, isFalse);
      });
    });
  });
}

void _noopCallback() {}
