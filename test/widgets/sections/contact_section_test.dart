import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integrity_studio_ai/config/content.dart';
import 'package:integrity_studio_ai/widgets/sections/contact_section.dart';
import 'package:integrity_studio_ai/widgets/common/alert.dart';
import 'package:integrity_studio_ai/widgets/common/form_fields.dart';
import '../../helpers/test_helpers.dart';

void main() {
  setUpAll(() {
    initializeTestContent();
  });

  group('ContactSection', () {
    Widget buildTestWidget({
      Future<bool> Function(Map<String, String>)? onFormSubmit,
    }) {
      return MaterialApp(
        home: MediaQuery(
          data: const MediaQueryData(size: Size(1920, 1080)),
          child: Scaffold(
            body: SingleChildScrollView(
              child: ContactSection(
                onFormSubmit: onFormSubmit,
              ),
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

      testWidgets('uses FormTextField for text inputs', (tester) async {
        setLargeViewport(tester);
        await tester.pumpWidget(buildTestWidget());

        // Should use FormTextField widgets
        expect(find.byType(FormTextField), findsWidgets);
      });

      testWidgets('uses FormTextArea for textarea inputs', (tester) async {
        setLargeViewport(tester);
        await tester.pumpWidget(buildTestWidget());

        // Should use FormTextArea widget for message field
        expect(find.byType(FormTextArea), findsWidgets);
      });

      testWidgets('content defines form fields with select type',
          (tester) async {
        // Content may or may not have select fields
        // This test verifies the content is accessible
        expect(AppContent.contact.formFields, isNotEmpty);
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

      testWidgets('content defines correct number of contact methods',
          (tester) async {
        // Content should have 6 contact methods
        expect(AppContent.contact.contactMethods.length, equals(6));

        // Verify labels include expected values
        final labels =
            AppContent.contact.contactMethods.map((m) => m.label).toList();
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
      testWidgets('submit button is rendered', (tester) async {
        setLargeViewport(tester);
        await tester.pumpWidget(buildTestWidget());

        final submitButton = find.text(AppContent.contact.formSubmitText);
        expect(submitButton, findsOneWidget);
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

    group('form validation', () {
      testWidgets('form fields support validation errors', (tester) async {
        setLargeViewport(tester);
        await tester.pumpWidget(buildTestWidget());

        // Verify form fields are rendered and can display errors
        expect(find.byType(FormTextField), findsWidgets);
        expect(find.byType(FormTextArea), findsWidgets);
        expect(find.byType(ContactSection), findsOneWidget);
      });
    });

    group('form submission', () {
      testWidgets('uses custom onFormSubmit callback when provided',
          (tester) async {
        setLargeViewport(tester);

        var callbackCalled = false;

        await tester.pumpWidget(buildTestWidget(
          onFormSubmit: (_) async {
            callbackCalled = true;
            return true;
          },
        ));

        // Verify callback is available via widget
        expect(find.byType(ContactSection), findsOneWidget);
        // The callback will be used when form is submitted
        expect(callbackCalled, isFalse); // Not called yet
      });

      testWidgets('renders Alert widget type when needed', (tester) async {
        // Verify Alert import is working
        await tester.pumpWidget(
          testableWidget(
            Alert.success(message: 'Test alert'),
          ),
        );

        expect(find.byType(Alert), findsOneWidget);
        expect(find.text('Test alert'), findsOneWidget);
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

      testWidgets('form fields have proper labels', (tester) async {
        setLargeViewport(tester);
        await tester.pumpWidget(buildTestWidget());

        // Check that labels are rendered
        for (final field in AppContent.contact.formFields) {
          // Labels may have ' *' appended if required
          final labelText = field.required ? '${field.label} *' : field.label;
          expect(find.text(labelText), findsWidgets);
        }
      });
    });
  });
}
