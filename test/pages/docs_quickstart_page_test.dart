import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integrity_studio_ai/pages/docs_quickstart_page.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../helpers/test_helpers.dart';

void main() {
  // Suppress overflow errors in layout tests (visual-only, not functional)
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

  /// Helper to pump the DocsQuickstartPage widget
  Future<void> pumpDocsQuickstartPage(
    WidgetTester tester, {
    VoidCallback? onBack,
    bool mobile = false,
  }) async {
    if (mobile) {
      setMobileSize(tester);
    } else {
      setDesktopSize(tester);
    }
    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(disableAnimations: true),
        child: MaterialApp(
          theme: testTheme,
          home: DocsQuickstartPage(onBack: onBack),
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 100));
    await tester.pump(const Duration(milliseconds: 100));
  }

  group('DocsQuickstartPage', () {
    group('page structure', () {
      testWidgets('renders Scaffold with correct background', (tester) async {
        await pumpDocsQuickstartPage(tester);

        expect(find.byType(Scaffold), findsOneWidget);
      });

      testWidgets('renders CustomScrollView', (tester) async {
        await pumpDocsQuickstartPage(tester);

        expect(find.byType(CustomScrollView), findsOneWidget);
      });

      testWidgets('renders SliverAppBar', (tester) async {
        await pumpDocsQuickstartPage(tester);

        expect(find.byType(SliverAppBar), findsOneWidget);
      });

      testWidgets('renders page title in app bar', (tester) async {
        await pumpDocsQuickstartPage(tester);

        expect(find.text('Quick Start'), findsOneWidget);
      });

      testWidgets('renders back button', (tester) async {
        await pumpDocsQuickstartPage(tester);

        expect(find.byIcon(LucideIcons.arrowLeft), findsOneWidget);
      });

      testWidgets('renders Back to Home text button', (tester) async {
        await pumpDocsQuickstartPage(tester);

        expect(find.text('Back to Home'), findsOneWidget);
      });
    });

    group('navigation', () {
      testWidgets('back button triggers onBack callback', (tester) async {
        bool backCalled = false;
        await pumpDocsQuickstartPage(tester, onBack: () => backCalled = true);

        await tester.tap(find.byIcon(LucideIcons.arrowLeft));
        await tester.pump();

        expect(backCalled, isTrue);
      });

      testWidgets('Back to Home button triggers onBack callback',
          (tester) async {
        bool backCalled = false;
        await pumpDocsQuickstartPage(tester, onBack: () => backCalled = true);

        await tester.tap(find.text('Back to Home'));
        await tester.pump();

        expect(backCalled, isTrue);
      });
    });

    group('hero section', () {
      testWidgets('renders 5-Minute Setup badge', (tester) async {
        await pumpDocsQuickstartPage(tester);

        expect(find.text('5-Minute Setup'), findsOneWidget);
      });

      testWidgets('renders rocket icon in badge', (tester) async {
        await pumpDocsQuickstartPage(tester);

        expect(find.byIcon(LucideIcons.rocket), findsOneWidget);
      });

      testWidgets('renders headline', (tester) async {
        await pumpDocsQuickstartPage(tester);

        expect(find.text('Get Started with Integrity Studio'), findsOneWidget);
      });

      testWidgets('renders subheadline', (tester) async {
        await pumpDocsQuickstartPage(tester);

        expect(
          find.textContaining('Start monitoring your LLM applications'),
          findsOneWidget,
        );
      });
    });

    group('getting started steps', () {
      testWidgets('renders step 1 preview - Create Account', (tester) async {
        await pumpDocsQuickstartPage(tester);

        expect(find.text('1'), findsWidgets);
        expect(find.text('Create Account'), findsOneWidget);
      });

      testWidgets('renders step 2 preview - Install SDK', (tester) async {
        await pumpDocsQuickstartPage(tester);

        expect(find.text('2'), findsWidgets);
        expect(find.text('Install SDK'), findsOneWidget);
      });

      testWidgets('renders step 3 preview - Add Code', (tester) async {
        await pumpDocsQuickstartPage(tester);

        expect(find.text('3'), findsWidgets);
        expect(find.text('Add Code'), findsOneWidget);
      });

      testWidgets('renders step 4 preview - View Traces', (tester) async {
        await pumpDocsQuickstartPage(tester);

        expect(find.text('4'), findsWidgets);
        expect(find.text('View Traces'), findsOneWidget);
      });
    });

    group('prerequisites section', () {
      testWidgets('renders prerequisites title', (tester) async {
        await pumpDocsQuickstartPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -300));
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.text('Prerequisites'), findsOneWidget);
      });

      testWidgets('renders check circle icon for prerequisites',
          (tester) async {
        await pumpDocsQuickstartPage(tester);

        expect(find.byIcon(LucideIcons.checkCircle), findsWidgets);
      });

      testWidgets('renders prerequisite items', (tester) async {
        await pumpDocsQuickstartPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -300));
        await tester.pump(const Duration(milliseconds: 100));

        expect(
          find.textContaining('Integrity Studio account'),
          findsOneWidget,
        );
        expect(
          find.textContaining('Python 3.8+'),
          findsOneWidget,
        );
      });

      testWidgets('renders No Account Yet info callout', (tester) async {
        await pumpDocsQuickstartPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -400));
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.text('No Account Yet?'), findsOneWidget);
      });
    });

    group('installation instructions', () {
      testWidgets('renders Step 1: Get Your API Key section', (tester) async {
        await pumpDocsQuickstartPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -500));
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.text('Step 1: Get Your API Key'), findsOneWidget);
      });

      testWidgets('renders key icon for API key section', (tester) async {
        await pumpDocsQuickstartPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -500));
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.byIcon(LucideIcons.key), findsOneWidget);
      });

      testWidgets('renders Step 2: Install the SDK section', (tester) async {
        await pumpDocsQuickstartPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -900));
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.text('Step 2: Install the SDK'), findsOneWidget);
      });

      testWidgets('renders download icon for install section', (tester) async {
        await pumpDocsQuickstartPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -900));
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.byIcon(LucideIcons.download), findsOneWidget);
      });

      testWidgets('renders Step 3: Initialize the SDK section', (tester) async {
        await pumpDocsQuickstartPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -1300));
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.text('Step 3: Initialize the SDK'), findsOneWidget);
      });

      testWidgets('renders Step 4: Instrument Your Code section',
          (tester) async {
        await pumpDocsQuickstartPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -1800));
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.text('Step 4: Instrument Your Code'), findsOneWidget);
      });

      testWidgets('renders Step 5: View Your Traces section', (tester) async {
        await pumpDocsQuickstartPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -2400));
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.text('Step 5: View Your Traces'), findsOneWidget);
      });
    });

    group('code examples', () {
      testWidgets('renders language tabs for SDK installation', (tester) async {
        await pumpDocsQuickstartPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -900));
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.text('Python'), findsWidgets);
        expect(find.text('TypeScript'), findsWidgets);
        expect(find.text('Go'), findsWidgets);
      });

      testWidgets('renders environment variable code block', (tester) async {
        await pumpDocsQuickstartPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -700));
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.text('Set Environment Variable'), findsOneWidget);
      });

      testWidgets('can tap language tabs to switch code', (tester) async {
        await pumpDocsQuickstartPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -1000));
        await tester.pump(const Duration(milliseconds: 100));

        // Find and tap TypeScript tab
        final typescriptTab = find.text('TypeScript').first;
        await tester.tap(typescriptTab);
        await tester.pump(const Duration(milliseconds: 100));

        // Verify TypeScript code is visible
        expect(find.textContaining('npm install'), findsOneWidget);
      });
    });

    group('feature grid', () {
      testWidgets('renders Trace Explorer feature', (tester) async {
        await pumpDocsQuickstartPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -2600));
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.text('Trace Explorer'), findsOneWidget);
        expect(find.byIcon(LucideIcons.activity), findsOneWidget);
      });

      testWidgets('renders Cost Dashboard feature', (tester) async {
        await pumpDocsQuickstartPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -2600));
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.text('Cost Dashboard'), findsOneWidget);
        expect(find.byIcon(LucideIcons.dollarSign), findsOneWidget);
      });

      testWidgets('renders Latency Metrics feature', (tester) async {
        await pumpDocsQuickstartPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -2600));
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.text('Latency Metrics'), findsOneWidget);
        expect(find.byIcon(LucideIcons.gauge), findsOneWidget);
      });

      testWidgets('renders Alerting feature', (tester) async {
        await pumpDocsQuickstartPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -2600));
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.text('Alerting'), findsOneWidget);
        expect(find.byIcon(LucideIcons.bell), findsOneWidget);
      });
    });

    group('success callout', () {
      testWidgets('renders You\'re All Set callout', (tester) async {
        await pumpDocsQuickstartPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -2800));
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.text("You're All Set!"), findsOneWidget);
      });
    });

    group('what\'s captured section', () {
      testWidgets('renders What\'s Captured Automatically section',
          (tester) async {
        await pumpDocsQuickstartPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -3000));
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.text("What's Captured Automatically"), findsOneWidget);
      });

      testWidgets('renders database icon for captured section', (tester) async {
        await pumpDocsQuickstartPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -3000));
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.byIcon(LucideIcons.database), findsOneWidget);
      });

      testWidgets('renders attribute table headers', (tester) async {
        await pumpDocsQuickstartPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -3200));
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.text('Attribute'), findsOneWidget);
        expect(find.text('Description'), findsOneWidget);
        expect(find.text('Example'), findsOneWidget);
      });

      testWidgets('renders Cost Tracking info callout', (tester) async {
        await pumpDocsQuickstartPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -3500));
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.text('Cost Tracking'), findsOneWidget);
      });
    });

    group('OpenTelemetry configuration', () {
      testWidgets('renders OpenTelemetry Configuration section',
          (tester) async {
        await pumpDocsQuickstartPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -3800));
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.text('OpenTelemetry Configuration'), findsOneWidget);
      });

      testWidgets('renders plug icon for OpenTelemetry section',
          (tester) async {
        await pumpDocsQuickstartPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -3800));
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.byIcon(LucideIcons.plug), findsOneWidget);
      });

      testWidgets('renders Environment Variables code block title',
          (tester) async {
        await pumpDocsQuickstartPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -3900));
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.text('Environment Variables'), findsOneWidget);
      });
    });

    group('troubleshooting section', () {
      testWidgets('renders Troubleshooting section', (tester) async {
        await pumpDocsQuickstartPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -4300));
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.text('Troubleshooting'), findsOneWidget);
      });

      testWidgets('renders help circle icon for troubleshooting',
          (tester) async {
        await pumpDocsQuickstartPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -4300));
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.byIcon(LucideIcons.helpCircle), findsOneWidget);
      });

      testWidgets('renders troubleshooting problems', (tester) async {
        await pumpDocsQuickstartPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -4400));
        await tester.pump(const Duration(milliseconds: 100));

        expect(
          find.text('Traces not appearing in dashboard'),
          findsOneWidget,
        );
      });

      testWidgets('renders alert circle icons for problems', (tester) async {
        await pumpDocsQuickstartPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -4400));
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.byIcon(LucideIcons.alertCircle), findsWidgets);
      });
    });

    group('next steps section', () {
      testWidgets('renders Next Steps section', (tester) async {
        await pumpDocsQuickstartPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -5000));
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.text('Next Steps'), findsOneWidget);
      });

      testWidgets('renders arrow right icon for next steps', (tester) async {
        await pumpDocsQuickstartPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -5000));
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.byIcon(LucideIcons.arrowRight), findsOneWidget);
      });

      testWidgets('renders next steps bullet items', (tester) async {
        await pumpDocsQuickstartPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -5100));
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.textContaining('Set up alerts'), findsOneWidget);
      });
    });

    group('footer', () {
      testWidgets('renders footer with OpenTelemetry and SigNoz text',
          (tester) async {
        await pumpDocsQuickstartPage(tester);

        // Scroll to the very bottom
        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -6000));
        await tester.pump(const Duration(milliseconds: 100));
        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -1000));
        await tester.pump(const Duration(milliseconds: 100));

        expect(
          find.text('Built with OpenTelemetry and SigNoz'),
          findsOneWidget,
        );
      });

      testWidgets('renders copyright footer', (tester) async {
        await pumpDocsQuickstartPage(tester);

        // Scroll to the very bottom
        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -6000));
        await tester.pump(const Duration(milliseconds: 100));
        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -1000));
        await tester.pump(const Duration(milliseconds: 100));

        expect(
          find.textContaining('Integrity Studio LLC'),
          findsOneWidget,
        );
      });
    });

    group('responsive layout', () {
      testWidgets('renders on mobile viewport', (tester) async {
        await pumpDocsQuickstartPage(tester, mobile: true);

        expect(find.byType(DocsQuickstartPage), findsOneWidget);
        expect(find.text('Quick Start'), findsOneWidget);
      });

      testWidgets('renders on desktop viewport', (tester) async {
        await pumpDocsQuickstartPage(tester, mobile: false);

        expect(find.byType(DocsQuickstartPage), findsOneWidget);
        expect(find.text('Quick Start'), findsOneWidget);
      });

      testWidgets('renders hero section on mobile', (tester) async {
        await pumpDocsQuickstartPage(tester, mobile: true);

        expect(find.text('5-Minute Setup'), findsOneWidget);
        expect(find.text('Get Started with Integrity Studio'), findsOneWidget);
      });

      testWidgets('renders step previews on mobile', (tester) async {
        await pumpDocsQuickstartPage(tester, mobile: true);

        expect(find.text('Create Account'), findsOneWidget);
        expect(find.text('Install SDK'), findsOneWidget);
        expect(find.text('Add Code'), findsOneWidget);
        expect(find.text('View Traces'), findsOneWidget);
      });
    });

    group('section icons', () {
      testWidgets('renders correct icons for each section', (tester) async {
        await pumpDocsQuickstartPage(tester);

        // Icons visible in initial view
        expect(find.byIcon(LucideIcons.rocket), findsOneWidget);
        expect(find.byIcon(LucideIcons.checkCircle), findsWidgets);

        // Scroll to see more icons
        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -600));
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.byIcon(LucideIcons.key), findsOneWidget);
      });

      testWidgets('renders play icon for initialize section', (tester) async {
        await pumpDocsQuickstartPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -1300));
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.byIcon(LucideIcons.play), findsOneWidget);
      });

      testWidgets('renders code icon for instrument section', (tester) async {
        await pumpDocsQuickstartPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -1800));
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.byIcon(LucideIcons.code), findsOneWidget);
      });

      testWidgets('renders barChart3 icon for traces section', (tester) async {
        await pumpDocsQuickstartPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -2400));
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.byIcon(LucideIcons.barChart3), findsOneWidget);
      });
    });

    group('numbered steps content', () {
      testWidgets('renders log in step', (tester) async {
        await pumpDocsQuickstartPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -500));
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.text('Log in to your dashboard'), findsOneWidget);
      });

      testWidgets('renders API Keys step', (tester) async {
        await pumpDocsQuickstartPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -550));
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.textContaining('API Keys'), findsWidgets);
      });

      testWidgets('renders create new key step', (tester) async {
        await pumpDocsQuickstartPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -600));
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.text('Create a new key'), findsOneWidget);
      });

      testWidgets('renders copy and store step', (tester) async {
        await pumpDocsQuickstartPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -650));
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.text('Copy and store securely'), findsOneWidget);
      });
    });

    group('info callouts', () {
      testWidgets('renders lightbulb icon in info callouts', (tester) async {
        await pumpDocsQuickstartPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -400));
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.byIcon(LucideIcons.lightbulb), findsWidgets);
      });
    });

    group('table content', () {
      testWidgets('renders gen_ai.system attribute', (tester) async {
        await pumpDocsQuickstartPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -3300));
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.text('gen_ai.system'), findsOneWidget);
      });

      testWidgets('renders gen_ai.request.model attribute', (tester) async {
        await pumpDocsQuickstartPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -3300));
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.text('gen_ai.request.model'), findsOneWidget);
      });
    });
  });
}
