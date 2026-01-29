import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:integrity_studio_ai/app.dart';
import 'package:integrity_studio_ai/pages/landing_page.dart';
import 'package:integrity_studio_ai/pages/blog_page.dart';
import 'package:integrity_studio_ai/pages/comparison_page.dart';
import 'package:integrity_studio_ai/pages/sources_page.dart';
import 'package:integrity_studio_ai/pages/about_page.dart';
import 'package:integrity_studio_ai/pages/signup_page.dart';
import 'package:integrity_studio_ai/pages/legal_page.dart';
import 'package:integrity_studio_ai/pages/contact_page.dart';
import 'package:integrity_studio_ai/pages/docs_index_page.dart';
import 'package:integrity_studio_ai/pages/docs_tracing_page.dart';
import 'package:integrity_studio_ai/theme/theme.dart';
import 'helpers/test_helpers.dart';

void main() {
  setUpAll(() {
    initializeTestContent();
  });

  void setDesktopSize(WidgetTester tester) {
    tester.view.physicalSize = const Size(1920, 1080);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
  }

  /// Helper to build a test app with GoRouter at a specific location.
  Widget buildTestApp({String initialLocation = '/'}) {
    final testRouter = GoRouter(
      initialLocation: initialLocation,
      redirect: (context, state) {
        final path = state.uri.path;
        if (path == '/support') return '/contact';
        if (path == '/eu-ai-act') return '/docs';
        if (path == '/docs/compliance') return '/docs';
        if (path == '/docs/agents') return '/docs';
        if (path == '/docs/security/audit-trails') return '/docs/tracing';
        if (path.startsWith('/reports/')) return '/docs';
        return null;
      },
      routes: [
        ShellRoute(
          builder: (context, state, child) => child,
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => LandingPage(onShowCookieSettings: () {}),
            ),
            GoRoute(
              path: '/blog',
              builder: (context, state) => BlogPage(onBack: () => context.go('/')),
            ),
            GoRoute(
              path: '/whylabs-alternative',
              builder: (context, state) => ComparisonPage.whylabs(onBack: () => context.go('/')),
            ),
            GoRoute(
              path: '/compare/arize-ai-alternative',
              builder: (context, state) => ComparisonPage.arize(onBack: () => context.go('/')),
            ),
            GoRoute(
              path: '/sources',
              builder: (context, state) => SourcesPage(onBack: () => context.go('/')),
            ),
            GoRoute(
              path: '/about',
              builder: (context, state) => AboutPage(
                onBack: () => context.go('/'),
                onShowCookieSettings: () {},
              ),
            ),
            GoRoute(
              path: '/signup',
              builder: (context, state) {
                final tier = state.uri.queryParameters['tier'] ?? 'starter';
                return SignupPage(tier: tier, onBack: () => context.go('/'));
              },
            ),
            GoRoute(
              path: '/privacy',
              builder: (context, state) => LegalPage.privacy(onBack: () => context.go('/')),
            ),
            GoRoute(
              path: '/terms',
              builder: (context, state) => LegalPage.terms(onBack: () => context.go('/')),
            ),
            GoRoute(
              path: '/cookies',
              builder: (context, state) => LegalPage.cookies(onBack: () => context.go('/')),
            ),
            GoRoute(
              path: '/accessibility',
              builder: (context, state) => LegalPage.accessibility(onBack: () => context.go('/')),
            ),
            GoRoute(
              path: '/contact',
              builder: (context, state) => ContactPage(
                onBack: () => context.go('/'),
                onShowCookieSettings: () {},
              ),
            ),
            GoRoute(
              path: '/docs',
              builder: (context, state) => DocsIndexPage(onBack: () => context.go('/')),
            ),
            GoRoute(
              path: '/docs/tracing',
              builder: (context, state) => DocsTracingPage(onBack: () => context.go('/')),
            ),
          ],
        ),
      ],
      errorBuilder: (context, state) => LandingPage(onShowCookieSettings: () {}),
    );
    return MaterialApp.router(
      title: 'Integrity Studio - Enterprise AI Observability',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      routerConfig: testRouter,
    );
  }

  group('IntegrityStudioApp', () {
    group('construction', () {
      testWidgets('creates without error', (tester) async {
        setDesktopSize(tester);

        await tester.pumpWidget(const IntegrityStudioApp());
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.byType(IntegrityStudioApp), findsOneWidget);
      });

      testWidgets('shows MaterialApp', (tester) async {
        setDesktopSize(tester);

        await tester.pumpWidget(const IntegrityStudioApp());
        await tester.pump(const Duration(milliseconds: 100));

        // MaterialApp.router creates a MaterialApp internally
        expect(find.byType(MaterialApp), findsOneWidget);
      });
    });

    group('routing', () {
      testWidgets('initial route shows landing page', (tester) async {
        setDesktopSize(tester);

        await tester.pumpWidget(buildTestApp());
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.byType(LandingPage), findsOneWidget);
      });

      testWidgets('navigates to blog page', (tester) async {
        setDesktopSize(tester);

        await tester.pumpWidget(buildTestApp(initialLocation: '/blog'));
        await tester.pumpAndSettle();

        expect(find.byType(BlogPage), findsOneWidget);
      });

      testWidgets('navigates to whylabs alternative page', (tester) async {
        setDesktopSize(tester);

        await tester.pumpWidget(buildTestApp(initialLocation: '/whylabs-alternative'));
        await tester.pumpAndSettle();

        expect(find.byType(ComparisonPage), findsOneWidget);
      });

      testWidgets('navigates to arize alternative page', (tester) async {
        setDesktopSize(tester);

        await tester.pumpWidget(buildTestApp(initialLocation: '/compare/arize-ai-alternative'));
        await tester.pumpAndSettle();

        expect(find.byType(ComparisonPage), findsOneWidget);
      });

      testWidgets('navigates to sources page', (tester) async {
        setDesktopSize(tester);

        await tester.pumpWidget(buildTestApp(initialLocation: '/sources'));
        await tester.pumpAndSettle();

        expect(find.byType(SourcesPage), findsOneWidget);
      });

      testWidgets('navigates to about page', (tester) async {
        setDesktopSize(tester);

        await tester.pumpWidget(buildTestApp(initialLocation: '/about'));
        await tester.pumpAndSettle();

        expect(find.byType(AboutPage), findsOneWidget);
      });

      testWidgets('navigates to signup page', (tester) async {
        setDesktopSize(tester);

        await tester.pumpWidget(buildTestApp(initialLocation: '/signup'));
        await tester.pumpAndSettle();

        expect(find.byType(SignupPage), findsOneWidget);
      });

      testWidgets('navigates to signup page with tier parameter', (tester) async {
        setDesktopSize(tester);

        await tester.pumpWidget(buildTestApp(initialLocation: '/signup?tier=growth'));
        await tester.pumpAndSettle();

        expect(find.byType(SignupPage), findsOneWidget);
      });

      testWidgets('navigates to privacy page', (tester) async {
        setDesktopSize(tester);

        await tester.pumpWidget(buildTestApp(initialLocation: '/privacy'));
        await tester.pumpAndSettle();

        expect(find.byType(LegalPage), findsOneWidget);
      });

      testWidgets('navigates to terms page', (tester) async {
        setDesktopSize(tester);

        await tester.pumpWidget(buildTestApp(initialLocation: '/terms'));
        await tester.pumpAndSettle();

        expect(find.byType(LegalPage), findsOneWidget);
      });

      testWidgets('navigates to cookies page', (tester) async {
        setDesktopSize(tester);

        await tester.pumpWidget(buildTestApp(initialLocation: '/cookies'));
        await tester.pumpAndSettle();

        expect(find.byType(LegalPage), findsOneWidget);
      });

      testWidgets('navigates to accessibility page', (tester) async {
        setDesktopSize(tester);

        await tester.pumpWidget(buildTestApp(initialLocation: '/accessibility'));
        await tester.pumpAndSettle();

        expect(find.byType(LegalPage), findsOneWidget);
      });

      testWidgets('unknown routes show landing page', (tester) async {
        setDesktopSize(tester);

        await tester.pumpWidget(buildTestApp(initialLocation: '/nonexistent-page'));
        await tester.pumpAndSettle();

        expect(find.byType(LandingPage), findsOneWidget);
      });

      // Redirect tests
      testWidgets('redirects /support to /contact', (tester) async {
        setDesktopSize(tester);

        await tester.pumpWidget(buildTestApp(initialLocation: '/support'));
        await tester.pumpAndSettle();

        expect(find.byType(ContactPage), findsOneWidget);
      });

      testWidgets('redirects /eu-ai-act to /docs', (tester) async {
        setDesktopSize(tester);

        await tester.pumpWidget(buildTestApp(initialLocation: '/eu-ai-act'));
        await tester.pumpAndSettle();

        expect(find.byType(DocsIndexPage), findsOneWidget);
      });

      testWidgets('redirects /docs/compliance to /docs', (tester) async {
        setDesktopSize(tester);

        await tester.pumpWidget(buildTestApp(initialLocation: '/docs/compliance'));
        await tester.pumpAndSettle();

        expect(find.byType(DocsIndexPage), findsOneWidget);
      });

      testWidgets('redirects /docs/security/audit-trails to /docs/tracing', (tester) async {
        setDesktopSize(tester);

        await tester.pumpWidget(buildTestApp(initialLocation: '/docs/security/audit-trails'));
        await tester.pumpAndSettle();

        expect(find.byType(DocsTracingPage), findsOneWidget);
      });
    });

    group('theme', () {
      testWidgets('uses dark theme', (tester) async {
        setDesktopSize(tester);

        await tester.pumpWidget(const IntegrityStudioApp());
        await tester.pump(const Duration(milliseconds: 100));

        final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
        expect(materialApp.theme, isNotNull);
      });

      testWidgets('has correct title', (tester) async {
        setDesktopSize(tester);

        await tester.pumpWidget(const IntegrityStudioApp());
        await tester.pump(const Duration(milliseconds: 100));

        final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
        expect(
          materialApp.title,
          equals('Integrity Studio - Enterprise AI Observability'),
        );
      });

      testWidgets('hides debug banner', (tester) async {
        setDesktopSize(tester);

        await tester.pumpWidget(const IntegrityStudioApp());
        await tester.pump(const Duration(milliseconds: 100));

        final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
        expect(materialApp.debugShowCheckedModeBanner, isFalse);
      });
    });
  });
}
