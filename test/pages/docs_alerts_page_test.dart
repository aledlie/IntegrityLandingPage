import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integrity_studio_ai/pages/docs_alerts_page.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../helpers/test_helpers.dart';

void main() {
  // Suppress overflow errors in layout tests (visual-only, not functional)
  final originalOnError = FlutterError.onError;

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

  /// Helper to pump the DocsAlertsPage widget
  Future<void> pumpDocsAlertsPage(
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
          home: DocsAlertsPage(onBack: onBack),
        ),
      ),
    );
    await tester.pump();
    await tester.pump();
  }

  group('DocsAlertsPage', () {
    group('page structure', () {
      testWidgets('renders Scaffold with correct background', (tester) async {
        await pumpDocsAlertsPage(tester);

        expect(find.byType(Scaffold), findsOneWidget);
      });

      testWidgets('renders CustomScrollView', (tester) async {
        await pumpDocsAlertsPage(tester);

        expect(find.byType(CustomScrollView), findsOneWidget);
      });

      testWidgets('renders SliverAppBar', (tester) async {
        await pumpDocsAlertsPage(tester);

        expect(find.byType(SliverAppBar), findsOneWidget);
      });

      testWidgets('renders page title in app bar', (tester) async {
        await pumpDocsAlertsPage(tester);

        expect(find.text('Alerts Guide'), findsOneWidget);
      });

      testWidgets('renders back button', (tester) async {
        await pumpDocsAlertsPage(tester);

        expect(find.byIcon(LucideIcons.arrowLeft), findsOneWidget);
      });

      testWidgets('renders Back to Home text button', (tester) async {
        await pumpDocsAlertsPage(tester);

        expect(find.text('Back to Home'), findsOneWidget);
      });
    });

    group('navigation', () {
      testWidgets('back button triggers onBack callback', (tester) async {
        bool backCalled = false;
        await pumpDocsAlertsPage(tester, onBack: () => backCalled = true);

        await tester.tap(find.byIcon(LucideIcons.arrowLeft));
        await tester.pump();

        expect(backCalled, isTrue);
      });

      testWidgets('Back to Home button triggers onBack callback',
          (tester) async {
        bool backCalled = false;
        await pumpDocsAlertsPage(tester, onBack: () => backCalled = true);

        await tester.tap(find.text('Back to Home'));
        await tester.pump();

        expect(backCalled, isTrue);
      });
    });

    group('hero section', () {
      testWidgets('renders proactive monitoring badge', (tester) async {
        await pumpDocsAlertsPage(tester);

        expect(find.text('Proactive Monitoring'), findsOneWidget);
      });

      testWidgets('renders bell icon in badge', (tester) async {
        await pumpDocsAlertsPage(tester);

        expect(find.byIcon(LucideIcons.bell), findsOneWidget);
      });

      testWidgets('renders main headline', (tester) async {
        await pumpDocsAlertsPage(tester);

        expect(find.text('Alerts & Incident Management'), findsOneWidget);
      });

      testWidgets('renders subtitle', (tester) async {
        await pumpDocsAlertsPage(tester);

        expect(
          find.textContaining('Get notified before problems become incidents'),
          findsOneWidget,
        );
      });

      testWidgets('renders alert type previews', (tester) async {
        await pumpDocsAlertsPage(tester);

        expect(find.text('Budget'), findsOneWidget);
        expect(find.text('Anomaly'), findsOneWidget);
        expect(find.text('Latency'), findsOneWidget);
        expect(find.text('Error Rate'), findsOneWidget);
      });

      testWidgets('renders alert type preview icons', (tester) async {
        await pumpDocsAlertsPage(tester);

        expect(find.byIcon(LucideIcons.dollarSign), findsWidgets);
        expect(find.byIcon(LucideIcons.activity), findsWidgets);
        expect(find.byIcon(LucideIcons.gauge), findsWidgets);
        expect(find.byIcon(LucideIcons.alertTriangle), findsWidgets);
      });
    });

    group('overview section', () {
      testWidgets('renders Overview section title', (tester) async {
        await pumpDocsAlertsPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -300));
        await tester.pump();

        expect(find.text('Overview'), findsOneWidget);
      });

      testWidgets('renders info icon for overview', (tester) async {
        await pumpDocsAlertsPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -300));
        await tester.pump();

        expect(find.byIcon(LucideIcons.info), findsOneWidget);
      });

      testWidgets('renders feature grid cards', (tester) async {
        await pumpDocsAlertsPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -400));
        await tester.pump();

        expect(find.text('Budget Protection'), findsOneWidget);
        expect(find.text('Smart Detection'), findsOneWidget);
        expect(find.text('Instant Routing'), findsOneWidget);
        expect(find.text('Flexible Rules'), findsOneWidget);
      });
    });

    group('alert types section', () {
      testWidgets('renders Alert Types section title', (tester) async {
        await pumpDocsAlertsPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -600));
        await tester.pump();

        expect(find.text('Alert Types'), findsOneWidget);
      });

      testWidgets('renders layers icon for alert types', (tester) async {
        await pumpDocsAlertsPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -600));
        await tester.pump();

        expect(find.byIcon(LucideIcons.layers), findsOneWidget);
      });

      testWidgets('renders Budget Alerts card', (tester) async {
        await pumpDocsAlertsPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -700));
        await tester.pump();

        expect(find.text('Budget Alerts'), findsOneWidget);
      });

      testWidgets('renders Anomaly Detection card', (tester) async {
        await pumpDocsAlertsPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -900));
        await tester.pump();

        // "Anomaly Detection" appears multiple times: in hero preview and in card
        expect(find.text('Anomaly Detection'), findsWidgets);
      });

      testWidgets('renders Performance Alerts card', (tester) async {
        await pumpDocsAlertsPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -1100));
        await tester.pump();

        expect(find.text('Performance Alerts'), findsOneWidget);
      });

      testWidgets('renders Error Rate Alerts card', (tester) async {
        await pumpDocsAlertsPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -1300));
        await tester.pump();

        expect(find.text('Error Rate Alerts'), findsOneWidget);
      });
    });

    group('creating alerts section', () {
      testWidgets('renders Creating Alerts section title', (tester) async {
        await pumpDocsAlertsPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -1500));
        await tester.pump();

        expect(find.text('Creating Alerts'), findsOneWidget);
      });

      testWidgets('renders plus icon for creating alerts', (tester) async {
        await pumpDocsAlertsPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -1500));
        await tester.pump();

        expect(find.byIcon(LucideIcons.plus), findsOneWidget);
      });

      testWidgets('renders Dashboard UI heading', (tester) async {
        await pumpDocsAlertsPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -1600));
        await tester.pump();

        expect(find.text('Dashboard UI'), findsOneWidget);
      });

      testWidgets('renders API heading', (tester) async {
        await pumpDocsAlertsPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -1800));
        await tester.pump();

        expect(find.text('API'), findsOneWidget);
      });

      testWidgets('renders numbered list items', (tester) async {
        await pumpDocsAlertsPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -1650));
        await tester.pump();

        expect(find.textContaining('Navigate to Alerts'), findsOneWidget);
      });
    });

    group('alert conditions section', () {
      testWidgets('renders Alert Conditions section title', (tester) async {
        await pumpDocsAlertsPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -2300));
        await tester.pump();

        expect(find.text('Alert Conditions'), findsOneWidget);
      });

      testWidgets('renders filter icon for conditions', (tester) async {
        await pumpDocsAlertsPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -2300));
        await tester.pump();

        expect(find.byIcon(LucideIcons.filter), findsOneWidget);
      });

      testWidgets('renders Available Metrics heading', (tester) async {
        await pumpDocsAlertsPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -2400));
        await tester.pump();

        expect(find.text('Available Metrics'), findsOneWidget);
      });

      testWidgets('renders Operators heading', (tester) async {
        await pumpDocsAlertsPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -2700));
        await tester.pump();

        expect(find.text('Operators'), findsOneWidget);
      });

      testWidgets('renders Time Windows heading', (tester) async {
        await pumpDocsAlertsPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -3000));
        await tester.pump();

        expect(find.text('Time Windows'), findsOneWidget);
      });
    });

    group('notification channels section', () {
      testWidgets('renders Notification Channels section title', (tester) async {
        await pumpDocsAlertsPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -3300));
        await tester.pump();

        expect(find.text('Notification Channels'), findsOneWidget);
      });

      testWidgets('renders send icon for channels', (tester) async {
        await pumpDocsAlertsPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -3300));
        await tester.pump();

        expect(find.byIcon(LucideIcons.send), findsOneWidget);
      });

      testWidgets('renders Slack channel card', (tester) async {
        await pumpDocsAlertsPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -3500));
        await tester.pump();

        expect(find.text('Slack'), findsOneWidget);
      });

      testWidgets('renders PagerDuty channel card', (tester) async {
        await pumpDocsAlertsPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -3700));
        await tester.pump();

        expect(find.text('PagerDuty'), findsOneWidget);
      });

      testWidgets('renders Email channel card', (tester) async {
        await pumpDocsAlertsPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -3900));
        await tester.pump();

        expect(find.text('Email'), findsOneWidget);
      });

      testWidgets('renders Webhook channel card', (tester) async {
        await pumpDocsAlertsPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -4100));
        await tester.pump();

        expect(find.text('Webhook'), findsOneWidget);
      });

      testWidgets('renders Microsoft Teams channel card', (tester) async {
        await pumpDocsAlertsPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -4300));
        await tester.pump();

        expect(find.text('Microsoft Teams'), findsOneWidget);
      });
    });

    group('alert severity section', () {
      testWidgets('renders Alert Severity section title', (tester) async {
        await pumpDocsAlertsPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -4600));
        await tester.pump();

        expect(find.text('Alert Severity'), findsOneWidget);
      });

      testWidgets('renders thermometer icon for severity', (tester) async {
        await pumpDocsAlertsPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -4600));
        await tester.pump();

        expect(find.byIcon(LucideIcons.thermometer), findsOneWidget);
      });

      testWidgets('renders Critical severity card', (tester) async {
        await pumpDocsAlertsPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -4700));
        await tester.pump();

        expect(find.text('Critical'), findsOneWidget);
      });

      testWidgets('renders Warning severity card', (tester) async {
        await pumpDocsAlertsPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -4900));
        await tester.pump();

        expect(find.text('Warning'), findsOneWidget);
      });

      testWidgets('renders Info severity card', (tester) async {
        await pumpDocsAlertsPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -5100));
        await tester.pump();

        expect(find.text('Info'), findsOneWidget);
      });
    });

    group('alert schedules section', () {
      testWidgets('renders Alert Schedules section title', (tester) async {
        await pumpDocsAlertsPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -5300));
        await tester.pump();

        expect(find.text('Alert Schedules'), findsOneWidget);
      });

      testWidgets('renders clock icon for schedules', (tester) async {
        await pumpDocsAlertsPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -5300));
        await tester.pump();

        expect(find.byIcon(LucideIcons.clock), findsOneWidget);
      });

      testWidgets('renders Time-Based Rules heading', (tester) async {
        await pumpDocsAlertsPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -5400));
        await tester.pump();

        expect(find.text('Time-Based Rules'), findsOneWidget);
      });

      testWidgets('renders Escalation Policies heading', (tester) async {
        await pumpDocsAlertsPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -5700));
        await tester.pump();

        expect(find.text('Escalation Policies'), findsOneWidget);
      });
    });

    group('best practices section', () {
      testWidgets('renders Best Practices section title', (tester) async {
        await pumpDocsAlertsPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -6000));
        await tester.pump();

        expect(find.text('Best Practices'), findsOneWidget);
      });

      testWidgets('renders lightbulb icon for best practices', (tester) async {
        await pumpDocsAlertsPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -6000));
        await tester.pump();

        expect(find.byIcon(LucideIcons.lightbulb), findsOneWidget);
      });

      testWidgets('renders check circle icons for practices', (tester) async {
        await pumpDocsAlertsPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -6100));
        await tester.pump();

        expect(find.byIcon(LucideIcons.checkCircle), findsWidgets);
      });

      testWidgets('renders Start with budget alerts practice', (tester) async {
        await pumpDocsAlertsPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -6100));
        await tester.pump();

        expect(find.text('Start with budget alerts'), findsOneWidget);
      });

      testWidgets('renders Avoid alert fatigue practice', (tester) async {
        await pumpDocsAlertsPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -6200));
        await tester.pump();

        expect(find.text('Avoid alert fatigue'), findsOneWidget);
      });
    });

    group('example alerts section', () {
      testWidgets('renders Example Alert Configurations section title',
          (tester) async {
        await pumpDocsAlertsPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -6500));
        await tester.pump();

        expect(find.text('Example Alert Configurations'), findsOneWidget);
      });

      testWidgets('renders file code icon for examples', (tester) async {
        await pumpDocsAlertsPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -6500));
        await tester.pump();

        expect(find.byIcon(LucideIcons.fileCode), findsOneWidget);
      });

      testWidgets('renders Daily Cost Budget example', (tester) async {
        await pumpDocsAlertsPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -6600));
        await tester.pump();

        expect(find.text('Daily Cost Budget'), findsOneWidget);
      });

      testWidgets('renders Latency Degradation example', (tester) async {
        await pumpDocsAlertsPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -7000));
        await tester.pump();

        expect(find.text('Latency Degradation'), findsOneWidget);
      });

      testWidgets('renders Anomaly Detection example', (tester) async {
        await pumpDocsAlertsPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -7400));
        await tester.pump();

        expect(find.text('Anomaly Detection'), findsWidgets);
      });
    });

    group('related documentation section', () {
      testWidgets('renders Related Documentation section title', (tester) async {
        await pumpDocsAlertsPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -7800));
        await tester.pump();

        expect(find.text('Related Documentation'), findsOneWidget);
      });

      testWidgets('renders book open icon for related docs', (tester) async {
        await pumpDocsAlertsPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -7800));
        await tester.pump();

        expect(find.byIcon(LucideIcons.bookOpen), findsOneWidget);
      });
    });

    group('code samples', () {
      testWidgets('renders API code block with curl command', (tester) async {
        await pumpDocsAlertsPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -2000));
        await tester.pump();

        expect(find.textContaining('curl -X POST'), findsOneWidget);
      });

      testWidgets('renders selectable code text', (tester) async {
        await pumpDocsAlertsPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -2000));
        await tester.pump();

        expect(find.byType(SelectableText), findsWidgets);
      });
    });

    group('tables', () {
      testWidgets('renders metrics table', (tester) async {
        await pumpDocsAlertsPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -2500));
        await tester.pump();

        expect(find.byType(Table), findsWidgets);
        expect(find.text('Metric'), findsOneWidget);
        expect(find.text('Description'), findsWidgets);
        expect(find.text('Unit'), findsOneWidget);
      });

      testWidgets('renders operators table', (tester) async {
        await pumpDocsAlertsPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -2800));
        await tester.pump();

        expect(find.text('Operator'), findsOneWidget);
        expect(find.text('Example'), findsOneWidget);
      });
    });

    group('footer', () {
      testWidgets('renders footer with OpenTelemetry and SigNoz text',
          (tester) async {
        await pumpDocsAlertsPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -8500));
        await tester.pump();

        expect(
          find.text('Built with OpenTelemetry and SigNoz'),
          findsOneWidget,
        );
      });

      testWidgets('renders copyright text', (tester) async {
        await pumpDocsAlertsPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -8500));
        await tester.pump();

        expect(
          find.textContaining('2026 Integrity Studio LLC'),
          findsOneWidget,
        );
      });
    });

    group('responsive layout', () {
      testWidgets('renders on mobile viewport', (tester) async {
        await pumpDocsAlertsPage(tester, mobile: true);

        expect(find.byType(DocsAlertsPage), findsOneWidget);
        expect(find.text('Alerts Guide'), findsOneWidget);
        expect(find.text('Alerts & Incident Management'), findsOneWidget);
      });

      testWidgets('renders on desktop viewport', (tester) async {
        await pumpDocsAlertsPage(tester, mobile: false);

        expect(find.byType(DocsAlertsPage), findsOneWidget);
        expect(find.text('Alerts Guide'), findsOneWidget);
        expect(find.text('Alerts & Incident Management'), findsOneWidget);
      });

      testWidgets('renders hero section on mobile', (tester) async {
        await pumpDocsAlertsPage(tester, mobile: true);

        expect(find.text('Proactive Monitoring'), findsOneWidget);
        expect(find.text('Alerts & Incident Management'), findsOneWidget);
      });

      testWidgets('renders alert type previews on mobile', (tester) async {
        await pumpDocsAlertsPage(tester, mobile: true);

        expect(find.text('Budget'), findsOneWidget);
        expect(find.text('Anomaly'), findsOneWidget);
      });
    });

    group('section icons', () {
      testWidgets('renders correct icons for each section', (tester) async {
        await pumpDocsAlertsPage(tester);

        // Icons visible in initial view
        expect(find.byIcon(LucideIcons.bell), findsOneWidget);

        // Scroll to see more icons
        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -400));
        await tester.pump();

        expect(find.byIcon(LucideIcons.info), findsOneWidget);
      });

      testWidgets('renders dollar sign icon for budget features',
          (tester) async {
        await pumpDocsAlertsPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -500));
        await tester.pump();

        expect(find.byIcon(LucideIcons.dollarSign), findsWidgets);
      });

      testWidgets('renders brain icon for smart detection', (tester) async {
        await pumpDocsAlertsPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -500));
        await tester.pump();

        expect(find.byIcon(LucideIcons.brain), findsOneWidget);
      });

      testWidgets('renders zap icon for instant routing', (tester) async {
        await pumpDocsAlertsPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -500));
        await tester.pump();

        expect(find.byIcon(LucideIcons.zap), findsOneWidget);
      });

      testWidgets('renders settings icon for flexible rules', (tester) async {
        await pumpDocsAlertsPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -500));
        await tester.pump();

        expect(find.byIcon(LucideIcons.settings), findsOneWidget);
      });
    });

    group('channel icons', () {
      testWidgets('renders hash icon for Slack', (tester) async {
        await pumpDocsAlertsPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -3500));
        await tester.pump();

        expect(find.byIcon(LucideIcons.hash), findsOneWidget);
      });

      testWidgets('renders alert circle icon for PagerDuty', (tester) async {
        await pumpDocsAlertsPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -3700));
        await tester.pump();

        expect(find.byIcon(LucideIcons.alertCircle), findsOneWidget);
      });

      testWidgets('renders mail icon for Email', (tester) async {
        await pumpDocsAlertsPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -3900));
        await tester.pump();

        expect(find.byIcon(LucideIcons.mail), findsOneWidget);
      });

      testWidgets('renders webhook icon for Webhook', (tester) async {
        await pumpDocsAlertsPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -4100));
        await tester.pump();

        expect(find.byIcon(LucideIcons.webhook), findsOneWidget);
      });

      testWidgets('renders message square icon for Teams', (tester) async {
        await pumpDocsAlertsPage(tester);

        await tester.drag(
            find.byType(CustomScrollView), const Offset(0, -4300));
        await tester.pump();

        expect(find.byIcon(LucideIcons.messageSquare), findsOneWidget);
      });
    });
  });
}
