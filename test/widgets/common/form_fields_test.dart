import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integrity_studio_ai/widgets/common/form_fields.dart';
import 'package:integrity_studio_ai/theme/colors.dart';
import '../../helpers/test_helpers.dart';

void main() {
  group('FormTextField', () {
    group('rendering', () {
      testWidgets('renders label text', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            FormTextField(
              label: 'Email Address',
              value: '',
              onChanged: (_) {},
            ),
          ),
        );

        expect(find.text('Email Address'), findsOneWidget);
      });

      testWidgets('renders required indicator when required', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            FormTextField(
              label: 'Email',
              value: '',
              required: true,
              onChanged: (_) {},
            ),
          ),
        );

        expect(find.text('Email *'), findsOneWidget);
      });

      testWidgets('does not show required indicator when not required',
          (tester) async {
        await tester.pumpWidget(
          testableWidget(
            FormTextField(
              label: 'Email',
              value: '',
              required: false,
              onChanged: (_) {},
            ),
          ),
        );

        expect(find.text('Email'), findsOneWidget);
        expect(find.text('Email *'), findsNothing);
      });

      testWidgets('renders placeholder text', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            FormTextField(
              label: 'Email',
              value: '',
              placeholder: 'you@example.com',
              onChanged: (_) {},
            ),
          ),
        );

        expect(find.text('you@example.com'), findsOneWidget);
      });

      testWidgets('renders initial value', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            FormTextField(
              label: 'Email',
              value: 'test@example.com',
              onChanged: (_) {},
            ),
          ),
        );

        expect(find.text('test@example.com'), findsOneWidget);
      });
    });

    group('input types', () {
      testWidgets('renders email field correctly', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            FormTextField(
              label: 'Email',
              value: '',
              type: FormTextFieldType.email,
              onChanged: (_) {},
            ),
          ),
        );

        expect(find.byType(TextFormField), findsOneWidget);
        expect(find.text('Email'), findsOneWidget);
      });

      testWidgets('renders phone field correctly', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            FormTextField(
              label: 'Phone',
              value: '',
              type: FormTextFieldType.phone,
              onChanged: (_) {},
            ),
          ),
        );

        expect(find.byType(TextFormField), findsOneWidget);
        expect(find.text('Phone'), findsOneWidget);
      });

      testWidgets('renders url field correctly', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            FormTextField(
              label: 'Website',
              value: '',
              type: FormTextFieldType.url,
              onChanged: (_) {},
            ),
          ),
        );

        expect(find.byType(TextFormField), findsOneWidget);
        expect(find.text('Website'), findsOneWidget);
      });

      testWidgets('renders text field correctly', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            FormTextField(
              label: 'Name',
              value: '',
              type: FormTextFieldType.text,
              onChanged: (_) {},
            ),
          ),
        );

        expect(find.byType(TextFormField), findsOneWidget);
        expect(find.text('Name'), findsOneWidget);
      });
    });

    group('error handling', () {
      testWidgets('displays error text when provided', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            FormTextField(
              label: 'Email',
              value: '',
              errorText: 'Please enter a valid email',
              onChanged: (_) {},
            ),
          ),
        );

        expect(find.text('Please enter a valid email'), findsOneWidget);
      });

      testWidgets('does not display error text when null', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            FormTextField(
              label: 'Email',
              value: '',
              errorText: null,
              onChanged: (_) {},
            ),
          ),
        );

        // Only label should exist
        expect(find.byType(Text), findsOneWidget);
      });

      testWidgets('error text has correct color', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            FormTextField(
              label: 'Email',
              value: '',
              errorText: 'Error message',
              onChanged: (_) {},
            ),
          ),
        );

        final errorText = tester.widget<Text>(find.text('Error message'));
        expect(errorText.style?.color, equals(AppColors.error));
      });
    });

    group('interaction', () {
      testWidgets('calls onChanged when text is entered', (tester) async {
        String? changedValue;

        await tester.pumpWidget(
          testableWidget(
            FormTextField(
              label: 'Name',
              value: '',
              onChanged: (value) => changedValue = value,
            ),
          ),
        );

        await tester.enterText(find.byType(TextFormField), 'John Doe');
        await tester.pump();

        expect(changedValue, equals('John Doe'));
      });

      testWidgets('disabled field does not accept input', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            FormTextField(
              label: 'Name',
              value: 'Disabled Value',
              enabled: false,
              onChanged: (_) {},
            ),
          ),
        );

        final textField = tester.widget<TextFormField>(
          find.byType(TextFormField),
        );
        expect(textField.enabled, isFalse);
      });
    });

    group('accessibility', () {
      testWidgets('has semantics for help text', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            FormTextField(
              label: 'Email',
              value: '',
              helpText: 'We will use this to contact you',
              onChanged: (_) {},
            ),
          ),
        );

        expect(find.byType(Semantics), findsWidgets);
      });

      testWidgets('error has Semantics for accessibility', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            FormTextField(
              label: 'Email',
              value: '',
              errorText: 'Invalid email',
              onChanged: (_) {},
            ),
          ),
        );

        // Verify Semantics widgets exist for accessibility
        expect(find.byType(Semantics), findsWidgets);
      });
    });
  });

  group('FormTextArea', () {
    group('rendering', () {
      testWidgets('renders label text', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            FormTextArea(
              label: 'Message',
              value: '',
              onChanged: (_) {},
            ),
          ),
        );

        expect(find.text('Message'), findsOneWidget);
      });

      testWidgets('renders required indicator when required', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            FormTextArea(
              label: 'Message',
              value: '',
              required: true,
              onChanged: (_) {},
            ),
          ),
        );

        expect(find.text('Message *'), findsOneWidget);
      });

      testWidgets('renders placeholder text', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            FormTextArea(
              label: 'Message',
              value: '',
              placeholder: 'Tell us about your needs...',
              onChanged: (_) {},
            ),
          ),
        );

        expect(find.text('Tell us about your needs...'), findsOneWidget);
      });

      testWidgets('renders with specified number of rows', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            FormTextArea(
              label: 'Message',
              value: '',
              rows: 8,
              onChanged: (_) {},
            ),
          ),
        );

        // Verify TextFormField is rendered
        expect(find.byType(TextFormField), findsOneWidget);
        expect(find.text('Message'), findsOneWidget);
      });
    });

    group('character limits', () {
      testWidgets('renders with max length configured', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            FormTextArea(
              label: 'Message',
              value: '',
              maxLength: 500,
              onChanged: (_) {},
            ),
          ),
        );

        // Verify TextFormField is rendered
        expect(find.byType(TextFormField), findsOneWidget);
      });

      testWidgets('shows character count when enabled', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            FormTextArea(
              label: 'Message',
              value: 'Hello',
              maxLength: 100,
              showCharacterCount: true,
              onChanged: (_) {},
            ),
          ),
        );

        // Character count should be visible
        expect(find.textContaining('5'), findsWidgets);
      });
    });

    group('error handling', () {
      testWidgets('displays error text when provided', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            FormTextArea(
              label: 'Message',
              value: '',
              errorText: 'Message is too short',
              onChanged: (_) {},
            ),
          ),
        );

        expect(find.text('Message is too short'), findsOneWidget);
      });
    });

    group('interaction', () {
      testWidgets('calls onChanged when text is entered', (tester) async {
        String? changedValue;

        await tester.pumpWidget(
          testableWidget(
            FormTextArea(
              label: 'Message',
              value: '',
              onChanged: (value) => changedValue = value,
            ),
          ),
        );

        await tester.enterText(find.byType(TextFormField), 'Test message');
        await tester.pump();

        expect(changedValue, equals('Test message'));
      });
    });
  });

  group('FormSelect', () {
    final testItems = [
      const DropdownMenuItem(value: 'option1', child: Text('Option 1')),
      const DropdownMenuItem(value: 'option2', child: Text('Option 2')),
      const DropdownMenuItem(value: 'option3', child: Text('Option 3')),
    ];

    group('rendering', () {
      testWidgets('renders label text', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            FormSelect<String>(
              label: 'Category',
              value: null,
              items: testItems,
              onChanged: (_) {},
            ),
          ),
        );

        expect(find.text('Category'), findsOneWidget);
      });

      testWidgets('renders required indicator when required', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            FormSelect<String>(
              label: 'Category',
              value: null,
              items: testItems,
              required: true,
              onChanged: (_) {},
            ),
          ),
        );

        expect(find.text('Category *'), findsOneWidget);
      });

      testWidgets('renders placeholder when no value selected',
          (tester) async {
        await tester.pumpWidget(
          testableWidget(
            FormSelect<String>(
              label: 'Category',
              value: null,
              items: testItems,
              placeholder: 'Select a category',
              onChanged: (_) {},
            ),
          ),
        );

        expect(find.text('Select a category'), findsOneWidget);
      });

      testWidgets('renders selected value', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            FormSelect<String>(
              label: 'Category',
              value: 'option1',
              items: testItems,
              onChanged: (_) {},
            ),
          ),
        );

        expect(find.text('Option 1'), findsOneWidget);
      });
    });

    group('error handling', () {
      testWidgets('displays error text when provided', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            FormSelect<String>(
              label: 'Category',
              value: null,
              items: testItems,
              errorText: 'Please select a category',
              onChanged: (_) {},
            ),
          ),
        );

        expect(find.text('Please select a category'), findsOneWidget);
      });
    });

    group('interaction', () {
      testWidgets('opens dropdown when tapped', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            FormSelect<String>(
              label: 'Category',
              value: null,
              items: testItems,
              onChanged: (_) {},
            ),
          ),
        );

        await tester.tap(find.byType(DropdownButtonFormField<String>));
        await tester.pumpAndSettle();

        // All options should be visible in dropdown
        expect(find.text('Option 1'), findsWidgets);
        expect(find.text('Option 2'), findsWidgets);
        expect(find.text('Option 3'), findsWidgets);
      });

      testWidgets('calls onChanged when option is selected', (tester) async {
        String? selectedValue;

        await tester.pumpWidget(
          testableWidget(
            FormSelect<String>(
              label: 'Category',
              value: null,
              items: testItems,
              onChanged: (value) => selectedValue = value,
            ),
          ),
        );

        // Open dropdown
        await tester.tap(find.byType(DropdownButtonFormField<String>));
        await tester.pumpAndSettle();

        // Select option
        await tester.tap(find.text('Option 2').last);
        await tester.pumpAndSettle();

        expect(selectedValue, equals('option2'));
      });

      testWidgets('disabled select does not open dropdown', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            FormSelect<String>(
              label: 'Category',
              value: null,
              items: testItems,
              enabled: false,
              onChanged: (_) {},
            ),
          ),
        );

        await tester.tap(find.byType(DropdownButtonFormField<String>));
        await tester.pumpAndSettle();

        // Options should not be visible (dropdown didn't open)
        expect(find.text('Option 2'), findsNothing);
      });
    });

    group('styling', () {
      testWidgets('renders dropdown with proper styling', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            FormSelect<String>(
              label: 'Category',
              value: null,
              items: testItems,
              onChanged: (_) {},
            ),
          ),
        );

        // Verify DropdownButtonFormField is rendered
        expect(find.byType(DropdownButtonFormField<String>), findsOneWidget);
      });
    });
  });
}
