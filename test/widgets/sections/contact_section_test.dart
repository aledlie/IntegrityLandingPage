import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integrity_studio_ai/config/content.dart';
import 'package:integrity_studio_ai/widgets/sections/contact_section.dart';

void main() {
  group('ContactSection', () {
    Widget buildTestWidget() {
      return MaterialApp(
        home: MediaQuery(
          data: const MediaQueryData(size: Size(1920, 1080)),
          child: const Scaffold(
            body: SingleChildScrollView(
              child: ContactSection(),
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

        expect(find.text(AppContent.contact.title), findsOneWidget);
      });

      testWidgets('renders section subtitle', (tester) async {
        setLargeViewport(tester);
        await tester.pumpWidget(buildTestWidget());

        expect(find.text(AppContent.contact.subtitle), findsOneWidget);
      });

      testWidgets('renders section description', (tester) async {
        setLargeViewport(tester);
        await tester.pumpWidget(buildTestWidget());

        expect(find.text(AppContent.contact.description), findsOneWidget);
      });

      testWidgets('renders submit button', (tester) async {
        setLargeViewport(tester);
        await tester.pumpWidget(buildTestWidget());

        expect(find.text(AppContent.contact.formSubmitText), findsOneWidget);
      });

      testWidgets('renders calendly CTA', (tester) async {
        setLargeViewport(tester);
        await tester.pumpWidget(buildTestWidget());

        // Calendly CTA text may appear multiple times (contact method + button)
        expect(find.text(AppContent.contact.calendlyCtaText), findsWidgets);
      });
    });

    group('form fields', () {
      testWidgets('renders text input fields', (tester) async {
        setLargeViewport(tester);
        await tester.pumpWidget(buildTestWidget());

        // Should have TextFormField widgets for input
        expect(find.byType(TextFormField), findsWidgets);
      });

      testWidgets('form has expected number of fields', (tester) async {
        setLargeViewport(tester);
        await tester.pumpWidget(buildTestWidget());

        // Content defines 7 form fields
        expect(AppContent.contact.formFields.length, equals(7));
      });
    });

    group('contact methods', () {
      testWidgets('renders primary contact method labels', (tester) async {
        setLargeViewport(tester);
        await tester.pumpWidget(buildTestWidget());

        // Primary contact methods (Email, Schedule a Demo) show labels as text
        // Email label appears in form AND contact methods
        expect(find.text('Email'), findsWidgets);
      });

      testWidgets('content defines correct number of contact methods', (tester) async {
        // Content should have 6 contact methods
        expect(AppContent.contact.contactMethods.length, equals(6));

        // Verify labels include expected values
        final labels = AppContent.contact.contactMethods.map((m) => m.label).toList();
        expect(labels, contains('Email'));
        expect(labels, contains('LinkedIn'));
        expect(labels, contains('Twitter'));
        expect(labels, contains('GitHub'));
        expect(labels, contains('Location'));
        expect(labels, contains('Schedule a Demo'));

        // Verify primary methods exist
        final primaryMethods = AppContent.contact.contactMethods
            .where((m) => m.isPrimary)
            .toList();
        expect(primaryMethods.length, equals(2));
      });
    });

    group('form interaction', () {
      testWidgets('submit button is tappable', (tester) async {
        setLargeViewport(tester);
        await tester.pumpWidget(buildTestWidget());

        final submitButton = find.text(AppContent.contact.formSubmitText);
        expect(submitButton, findsOneWidget);

        // Tap should not throw
        await tester.tap(submitButton);
        await tester.pump();
      });

      testWidgets('can enter text in text fields', (tester) async {
        setLargeViewport(tester);
        await tester.pumpWidget(buildTestWidget());

        // Find first text field and enter text
        final textFields = find.byType(TextFormField);
        expect(textFields, findsWidgets);

        await tester.enterText(textFields.first, 'TestInput');
        await tester.pump();

        // The entered text should appear somewhere
        expect(find.text('TestInput'), findsWidgets);
      });
    });

    group('accessibility', () {
      testWidgets('contact methods are accessible', (tester) async {
        setLargeViewport(tester);

        final semanticsHandle = tester.ensureSemantics();

        await tester.pumpWidget(buildTestWidget());

        // Email label appears in form AND contact methods
        expect(find.text('Email'), findsWidgets);

        semanticsHandle.dispose();
      });

      testWidgets('has expected required fields count', (tester) async {
        // Content-level test, doesn't need widget rendering
        final requiredFields = AppContent.contact.formFields
            .where((f) => f.required)
            .toList();
        expect(requiredFields.length, greaterThanOrEqualTo(4));
      });
    });
  });
}
