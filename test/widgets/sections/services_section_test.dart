import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integrity_studio_ai/config/content.dart';
import 'package:integrity_studio_ai/widgets/sections/services_section.dart';

void main() {
  group('ServicesSection', () {
    // Set up a large viewport to avoid overflow issues in tests
    setUp(() {
      TestWidgetsFlutterBinding.ensureInitialized();
    });

    Widget buildTestWidget() {
      return MaterialApp(
        home: MediaQuery(
          data: const MediaQueryData(size: Size(1920, 1080)),
          child: const Scaffold(
            body: SingleChildScrollView(
              child: ServicesSection(),
            ),
          ),
        ),
      );
    }

    group('widget structure', () {
      testWidgets('renders section title', (tester) async {
        tester.view.physicalSize = const Size(1920, 1080);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        await tester.pumpWidget(buildTestWidget());

        expect(find.text(AppContent.services.title), findsOneWidget);
      });

      testWidgets('renders section subtitle', (tester) async {
        tester.view.physicalSize = const Size(1920, 1080);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        await tester.pumpWidget(buildTestWidget());

        expect(find.text(AppContent.services.subtitle), findsOneWidget);
      });

      testWidgets('renders all 6 service titles', (tester) async {
        tester.view.physicalSize = const Size(1920, 1080);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        await tester.pumpWidget(buildTestWidget());

        for (final service in AppContent.services.services) {
          expect(find.text(service.title), findsOneWidget);
        }
      });

      testWidgets('renders service descriptions', (tester) async {
        tester.view.physicalSize = const Size(1920, 1080);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        await tester.pumpWidget(buildTestWidget());

        for (final service in AppContent.services.services) {
          expect(find.text(service.description), findsOneWidget);
        }
      });

      testWidgets('renders section CTA button', (tester) async {
        tester.view.physicalSize = const Size(1920, 1080);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        await tester.pumpWidget(buildTestWidget());

        expect(find.text(AppContent.services.ctaText), findsOneWidget);
      });
    });

    group('accessibility', () {
      testWidgets('service cards are accessible', (tester) async {
        tester.view.physicalSize = const Size(1920, 1080);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        final semanticsHandle = tester.ensureSemantics();

        await tester.pumpWidget(buildTestWidget());

        // Services content should be findable
        expect(find.text('LLM Monitoring & Tracing'), findsOneWidget);

        semanticsHandle.dispose();
      });
    });
  });
}
