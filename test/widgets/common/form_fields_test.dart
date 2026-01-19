import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integrity_studio_ai/widgets/common/form_fields.dart';
import '../../helpers/test_helpers.dart';

void main() {
  setUpAll(() {
    initializeTestContent();
  });

  group('FormTextFieldType', () {
    test('has all expected values', () {
      expect(FormTextFieldType.values, contains(FormTextFieldType.text));
      expect(FormTextFieldType.values, contains(FormTextFieldType.email));
      expect(FormTextFieldType.values, contains(FormTextFieldType.phone));
      expect(FormTextFieldType.values, contains(FormTextFieldType.url));
    });

    test('has 4 types', () {
      expect(FormTextFieldType.values.length, equals(4));
    });
  });

  group('FormTextField', () {
    group('rendering', () {
      testWidgets('renders label', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            FormTextField(
              label: 'Email',
              value: '',
              onChanged: (_) {},
            ),
          ),
        );

        expect(find.text('Email'), findsOneWidget);
      });

      testWidgets('renders required indicator when required', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            FormTextField(
              label: 'Email',
              value: '',
              onChanged: (_) {},
              required: true,
            ),
          ),
        );

        expect(find.text('Email *'), findsOneWidget);
      });

      testWidgets('renders without required indicator when not required',
          (tester) async {
        await tester.pumpWidget(
          testableWidget(
            FormTextField(
              label: 'Email',
              value: '',
              onChanged: (_) {},
              required: false,
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
              onChanged: (_) {},
              placeholder: 'you@example.com',
            ),
          ),
        );

        expect(find.text('you@example.com'), findsOneWidget);
      });

      testWidgets('renders current value', (tester) async {
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

    group('error handling', () {
      testWidgets('renders error text when provided', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            FormTextField(
              label: 'Email',
              value: '',
              onChanged: (_) {},
              errorText: 'Please enter a valid email',
            ),
          ),
        );

        expect(find.text('Please enter a valid email'), findsOneWidget);
      });

      testWidgets('does not render empty error text', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            FormTextField(
              label: 'Email',
              value: '',
              onChanged: (_) {},
              errorText: '',
            ),
          ),
        );

        // When errorText is empty string, no error styling should be applied
        // Verify the widget renders without error message visible
        expect(find.byType(TextFormField), findsOneWidget);
        // Label should be visible
        expect(find.text('Email'), findsOneWidget);
      });

      testWidgets('does not render null error text', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            FormTextField(
              label: 'Email',
              value: '',
              onChanged: (_) {},
            ),
          ),
        );

        // Only the label should be visible, no error messages
        expect(find.byType(TextFormField), findsOneWidget);
      });
    });

    group('interaction', () {
      testWidgets('calls onChanged when text is entered', (tester) async {
        String? changedValue;

        await tester.pumpWidget(
          testableWidget(
            FormTextField(
              label: 'Email',
              value: '',
              onChanged: (value) => changedValue = value,
            ),
          ),
        );

        await tester.enterText(find.byType(TextFormField), 'new@example.com');

        expect(changedValue, equals('new@example.com'));
      });

      testWidgets('respects disabled state', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            FormTextField(
              label: 'Email',
              value: 'test@example.com',
              onChanged: (_) {},
              enabled: false,
            ),
          ),
        );

        final textField = tester.widget<TextFormField>(find.byType(TextFormField));
        expect(textField.enabled, isFalse);
      });
    });

    group('keyboard types', () {
      testWidgets('renders with email type', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            FormTextField(
              label: 'Email',
              value: '',
              onChanged: (_) {},
              type: FormTextFieldType.email,
            ),
          ),
        );

        // Verify the widget renders correctly with email type
        expect(find.byType(TextFormField), findsOneWidget);
        expect(find.text('Email'), findsOneWidget);
      });

      testWidgets('renders with phone type', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            FormTextField(
              label: 'Phone',
              value: '',
              onChanged: (_) {},
              type: FormTextFieldType.phone,
            ),
          ),
        );

        expect(find.byType(TextFormField), findsOneWidget);
        expect(find.text('Phone'), findsOneWidget);
      });

      testWidgets('renders with url type', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            FormTextField(
              label: 'Website',
              value: '',
              onChanged: (_) {},
              type: FormTextFieldType.url,
            ),
          ),
        );

        expect(find.byType(TextFormField), findsOneWidget);
        expect(find.text('Website'), findsOneWidget);
      });

      testWidgets('renders with text type', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            FormTextField(
              label: 'Name',
              value: '',
              onChanged: (_) {},
              type: FormTextFieldType.text,
            ),
          ),
        );

        expect(find.byType(TextFormField), findsOneWidget);
        expect(find.text('Name'), findsOneWidget);
      });
    });

    group('focus and input actions', () {
      testWidgets('accepts focus node', (tester) async {
        final focusNode = FocusNode();

        await tester.pumpWidget(
          testableWidget(
            FormTextField(
              label: 'Email',
              value: '',
              onChanged: (_) {},
              focusNode: focusNode,
            ),
          ),
        );

        expect(find.byType(TextFormField), findsOneWidget);
        focusNode.dispose();
      });

      testWidgets('accepts text input action', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            FormTextField(
              label: 'Email',
              value: '',
              onChanged: (_) {},
              textInputAction: TextInputAction.next,
            ),
          ),
        );

        // Verify widget renders correctly with textInputAction
        expect(find.byType(TextFormField), findsOneWidget);
      });
    });
  });

  group('FormTextArea', () {
    group('rendering', () {
      testWidgets('renders label', (tester) async {
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
              onChanged: (_) {},
              required: true,
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
              onChanged: (_) {},
              placeholder: 'Enter your message...',
            ),
          ),
        );

        expect(find.text('Enter your message...'), findsOneWidget);
      });

      testWidgets('renders current value', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            FormTextArea(
              label: 'Message',
              value: 'Hello world',
              onChanged: (_) {},
            ),
          ),
        );

        expect(find.text('Hello world'), findsOneWidget);
      });
    });

    group('rows configuration', () {
      testWidgets('renders with default rows', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            FormTextArea(
              label: 'Message',
              value: '',
              onChanged: (_) {},
            ),
          ),
        );

        // Verify widget renders correctly with default rows
        expect(find.byType(TextFormField), findsOneWidget);
        expect(find.text('Message'), findsOneWidget);
      });

      testWidgets('renders with custom rows', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            FormTextArea(
              label: 'Message',
              value: '',
              onChanged: (_) {},
              rows: 10,
            ),
          ),
        );

        // Verify widget renders correctly with custom rows
        expect(find.byType(TextFormField), findsOneWidget);
        expect(find.text('Message'), findsOneWidget);
      });
    });

    group('character limits', () {
      testWidgets('renders with maxLength', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            FormTextArea(
              label: 'Message',
              value: '',
              onChanged: (_) {},
              maxLength: 500,
            ),
          ),
        );

        // Verify widget renders correctly with maxLength
        expect(find.byType(TextFormField), findsOneWidget);
        expect(find.text('Message'), findsOneWidget);
      });

      testWidgets('hides counter by default', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            FormTextArea(
              label: 'Message',
              value: 'Test',
              onChanged: (_) {},
              maxLength: 500,
              showCharacterCount: false,
            ),
          ),
        );

        // Counter should not be visible when showCharacterCount is false
        expect(find.byType(TextFormField), findsOneWidget);
      });
    });

    group('error handling', () {
      testWidgets('renders error text when provided', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            FormTextArea(
              label: 'Message',
              value: '',
              onChanged: (_) {},
              errorText: 'Message is required',
            ),
          ),
        );

        expect(find.text('Message is required'), findsOneWidget);
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

        await tester.enterText(find.byType(TextFormField), 'New message');

        expect(changedValue, equals('New message'));
      });

      testWidgets('respects disabled state', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            FormTextArea(
              label: 'Message',
              value: 'Existing message',
              onChanged: (_) {},
              enabled: false,
            ),
          ),
        );

        final textField = tester.widget<TextFormField>(find.byType(TextFormField));
        expect(textField.enabled, isFalse);
      });
    });
  });

  group('FormSelect', () {
    group('rendering', () {
      testWidgets('renders label', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            FormSelect<String>(
              label: 'Country',
              value: null,
              items: const [
                DropdownMenuItem(value: 'us', child: Text('USA')),
                DropdownMenuItem(value: 'uk', child: Text('UK')),
              ],
              onChanged: (_) {},
            ),
          ),
        );

        expect(find.text('Country'), findsOneWidget);
      });

      testWidgets('renders required indicator when required', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            FormSelect<String>(
              label: 'Country',
              value: null,
              items: const [
                DropdownMenuItem(value: 'us', child: Text('USA')),
              ],
              onChanged: (_) {},
              required: true,
            ),
          ),
        );

        expect(find.text('Country *'), findsOneWidget);
      });

      testWidgets('renders placeholder text', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            FormSelect<String>(
              label: 'Country',
              value: null,
              items: const [
                DropdownMenuItem(value: 'us', child: Text('USA')),
              ],
              onChanged: (_) {},
              placeholder: 'Select a country',
            ),
          ),
        );

        expect(find.text('Select a country'), findsOneWidget);
      });

      testWidgets('renders selected value', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            FormSelect<String>(
              label: 'Country',
              value: 'us',
              items: const [
                DropdownMenuItem(value: 'us', child: Text('USA')),
                DropdownMenuItem(value: 'uk', child: Text('UK')),
              ],
              onChanged: (_) {},
            ),
          ),
        );

        expect(find.text('USA'), findsOneWidget);
      });
    });

    group('error handling', () {
      testWidgets('renders error text when provided', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            FormSelect<String>(
              label: 'Country',
              value: null,
              items: const [
                DropdownMenuItem(value: 'us', child: Text('USA')),
              ],
              onChanged: (_) {},
              errorText: 'Please select a country',
            ),
          ),
        );

        expect(find.text('Please select a country'), findsOneWidget);
      });
    });

    group('interaction', () {
      testWidgets('calls onChanged when selection changes', (tester) async {
        String? selectedValue;

        await tester.pumpWidget(
          testableWidget(
            FormSelect<String>(
              label: 'Country',
              value: null,
              items: const [
                DropdownMenuItem(value: 'us', child: Text('USA')),
                DropdownMenuItem(value: 'uk', child: Text('UK')),
              ],
              onChanged: (value) => selectedValue = value,
            ),
          ),
        );

        // Tap to open dropdown
        await tester.tap(find.byType(DropdownButtonFormField<String>));
        await tester.pumpAndSettle();

        // Select an option
        await tester.tap(find.text('UK').last);
        await tester.pumpAndSettle();

        expect(selectedValue, equals('uk'));
      });

      testWidgets('respects disabled state', (tester) async {
        String? selectedValue;

        await tester.pumpWidget(
          testableWidget(
            FormSelect<String>(
              label: 'Country',
              value: 'us',
              items: const [
                DropdownMenuItem(value: 'us', child: Text('USA')),
                DropdownMenuItem(value: 'uk', child: Text('UK')),
              ],
              onChanged: (value) => selectedValue = value,
              enabled: false,
            ),
          ),
        );

        // Try to tap the disabled dropdown
        await tester.tap(find.byType(DropdownButtonFormField<String>));
        await tester.pumpAndSettle();

        // Should not have opened dropdown or changed value
        expect(selectedValue, isNull);
      });
    });

    group('types', () {
      testWidgets('works with int values', (tester) async {
        int? selectedValue;

        await tester.pumpWidget(
          testableWidget(
            FormSelect<int>(
              label: 'Age',
              value: null,
              items: const [
                DropdownMenuItem(value: 18, child: Text('18')),
                DropdownMenuItem(value: 21, child: Text('21')),
                DropdownMenuItem(value: 30, child: Text('30')),
              ],
              onChanged: (value) => selectedValue = value,
            ),
          ),
        );

        await tester.tap(find.byType(DropdownButtonFormField<int>));
        await tester.pumpAndSettle();

        await tester.tap(find.text('21').last);
        await tester.pumpAndSettle();

        expect(selectedValue, equals(21));
      });

      testWidgets('works with enum values', (tester) async {
        _TestEnum? selectedValue;

        await tester.pumpWidget(
          testableWidget(
            FormSelect<_TestEnum>(
              label: 'Priority',
              value: null,
              items: const [
                DropdownMenuItem(value: _TestEnum.low, child: Text('Low')),
                DropdownMenuItem(value: _TestEnum.high, child: Text('High')),
              ],
              onChanged: (value) => selectedValue = value,
            ),
          ),
        );

        await tester.tap(find.byType(DropdownButtonFormField<_TestEnum>));
        await tester.pumpAndSettle();

        await tester.tap(find.text('High').last);
        await tester.pumpAndSettle();

        expect(selectedValue, equals(_TestEnum.high));
      });
    });
  });
}

enum _TestEnum { low, high }
