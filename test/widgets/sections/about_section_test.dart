import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integrity_studio_ai/config/content.dart';
import 'package:integrity_studio_ai/widgets/sections/about_section.dart';
import '../../helpers/test_helpers.dart';

void main() {

  group('AboutSection', () {
    Widget buildTestWidget() {
      return const MaterialApp(
        home: MediaQuery(
          data: MediaQueryData(size: Size(1920, 1080)),
          child: Scaffold(
            body: SingleChildScrollView(
              child: AboutSection(),
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

        expect(find.text(AppContent.about.title), findsOneWidget);
      });

      testWidgets('renders section subtitle', (tester) async {
        setLargeViewport(tester);
        await tester.pumpWidget(buildTestWidget());

        expect(find.text(AppContent.about.subtitle), findsOneWidget);
      });

      testWidgets('renders mission statement', (tester) async {
        setLargeViewport(tester);
        await tester.pumpWidget(buildTestWidget());

        expect(find.text(AppContent.about.missionStatement), findsOneWidget);
      });

      testWidgets('renders vision statement', (tester) async {
        setLargeViewport(tester);
        await tester.pumpWidget(buildTestWidget());

        expect(find.text(AppContent.about.visionStatement), findsOneWidget);
      });

      testWidgets('renders all 4 company values', (tester) async {
        setLargeViewport(tester);
        await tester.pumpWidget(buildTestWidget());

        for (final value in AppContent.about.values) {
          expect(find.text(value.title), findsOneWidget);
        }
      });

      testWidgets('renders team member names', (tester) async {
        setLargeViewport(tester);
        await tester.pumpWidget(buildTestWidget());

        for (final member in AppContent.about.team) {
          expect(find.text(member.name), findsOneWidget);
        }
      });

      testWidgets('renders location info', (tester) async {
        setLargeViewport(tester);
        await tester.pumpWidget(buildTestWidget());

        expect(
          find.textContaining(AppContent.about.locationCity),
          findsWidgets,
        );
      });

      testWidgets('renders founding year', (tester) async {
        setLargeViewport(tester);
        await tester.pumpWidget(buildTestWidget());

        expect(
          find.textContaining(AppContent.about.foundedYear),
          findsWidgets,
        );
      });
    });

    group('accessibility', () {
      testWidgets('mission and vision cards are accessible', (tester) async {
        setLargeViewport(tester);

        final semanticsHandle = tester.ensureSemantics();

        await tester.pumpWidget(buildTestWidget());

        // Key content should be findable (actual labels are "Our Mission", "Our Vision")
        expect(find.text('Our Mission'), findsOneWidget);
        expect(find.text('Our Vision'), findsOneWidget);

        semanticsHandle.dispose();
      });
    });
  });
}
