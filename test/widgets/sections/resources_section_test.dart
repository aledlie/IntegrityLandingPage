import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integrity_studio_ai/config/content.dart';
import 'package:integrity_studio_ai/widgets/sections/resources_section.dart';

void main() {
  group('ResourcesSection', () {
    Widget buildTestWidget() {
      return const MaterialApp(
        home: MediaQuery(
          data: MediaQueryData(size: Size(1920, 1080)),
          child: Scaffold(
            body: SingleChildScrollView(
              child: ResourcesSection(),
            ),
          ),
        ),
      );
    }

    void setLargeViewport(WidgetTester tester) {
      tester.view.physicalSize = const Size(1920, 1080);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
    }

    group('widget structure', () {
      testWidgets('renders section title', (tester) async {
        setLargeViewport(tester);
        await tester.pumpWidget(buildTestWidget());

        expect(find.text(AppContent.resources.title), findsOneWidget);
      });

      testWidgets('renders section subtitle', (tester) async {
        setLargeViewport(tester);
        await tester.pumpWidget(buildTestWidget());

        expect(find.text(AppContent.resources.subtitle), findsOneWidget);
      });

      testWidgets('renders all 4 documentation category titles', (tester) async {
        setLargeViewport(tester);
        await tester.pumpWidget(buildTestWidget());

        for (final doc in AppContent.resources.documentation) {
          expect(find.text(doc.title), findsOneWidget);
        }
      });

      testWidgets('renders blog post titles', (tester) async {
        setLargeViewport(tester);
        await tester.pumpWidget(buildTestWidget());

        for (final post in AppContent.resources.featuredPosts) {
          expect(find.text(post.title), findsOneWidget);
        }
      });

      testWidgets('renders lead magnet titles', (tester) async {
        setLargeViewport(tester);
        await tester.pumpWidget(buildTestWidget());

        for (final magnet in AppContent.resources.leadMagnets) {
          expect(find.text(magnet.title), findsOneWidget);
        }
      });

      testWidgets('renders blog CTA', (tester) async {
        setLargeViewport(tester);
        await tester.pumpWidget(buildTestWidget());

        expect(find.text(AppContent.resources.blogCtaText), findsOneWidget);
      });

      testWidgets('renders docs CTA', (tester) async {
        setLargeViewport(tester);
        await tester.pumpWidget(buildTestWidget());

        expect(find.text(AppContent.resources.docsCtaText), findsOneWidget);
      });
    });

    group('blog posts', () {
      testWidgets('renders blog post categories', (tester) async {
        setLargeViewport(tester);
        await tester.pumpWidget(buildTestWidget());

        for (final post in AppContent.resources.featuredPosts) {
          expect(find.text(post.category), findsWidgets);
        }
      });

      testWidgets('renders blog post read times', (tester) async {
        setLargeViewport(tester);
        await tester.pumpWidget(buildTestWidget());

        // Multiple posts may have the same read time, so use findsWidgets
        for (final post in AppContent.resources.featuredPosts) {
          expect(find.text(post.readTime), findsWidgets);
        }
      });
    });

    group('lead magnets', () {
      testWidgets('renders lead magnet formats', (tester) async {
        setLargeViewport(tester);
        await tester.pumpWidget(buildTestWidget());

        // Check that format text appears (PDF, Interactive, etc.)
        for (final magnet in AppContent.resources.leadMagnets) {
          expect(find.text(magnet.format), findsWidgets);
        }
      });

      testWidgets('renders lead magnet CTAs', (tester) async {
        setLargeViewport(tester);
        await tester.pumpWidget(buildTestWidget());

        for (final magnet in AppContent.resources.leadMagnets) {
          expect(find.text(magnet.ctaText), findsWidgets);
        }
      });
    });

    group('accessibility', () {
      testWidgets('documentation categories are accessible', (tester) async {
        setLargeViewport(tester);

        final semanticsHandle = tester.ensureSemantics();

        await tester.pumpWidget(buildTestWidget());

        // Key documentation sections should be findable
        expect(find.text('Getting Started'), findsOneWidget);
        expect(find.text('API Reference'), findsOneWidget);

        semanticsHandle.dispose();
      });
    });
  });
}
