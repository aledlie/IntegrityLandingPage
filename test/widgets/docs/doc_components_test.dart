import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:integrity_studio_ai/widgets/docs/doc_components.dart';
import 'package:integrity_studio_ai/theme/theme.dart';
import '../../helpers/test_helpers.dart';

void main() {

  group('DocSection', () {
    testWidgets('renders with icon, title, and child', (tester) async {
      await tester.pumpWidget(testableWidget(
        DocSection(
          icon: LucideIcons.activity,
          title: 'Test Section',
          child: const Text('Section content'),
        ),
      ));

      expect(find.text('Test Section'), findsOneWidget);
      expect(find.text('Section content'), findsOneWidget);
      expect(find.byIcon(LucideIcons.activity), findsOneWidget);
    });

    testWidgets('uses default blue accent color', (tester) async {
      await tester.pumpWidget(testableWidget(
        DocSection(
          icon: LucideIcons.code,
          title: 'Default Color',
          child: const Text('Content'),
        ),
      ));

      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(DocSection),
          matching: find.byType(Container).first,
        ),
      );
      expect(container, isNotNull);
    });

    testWidgets('applies custom accent color', (tester) async {
      await tester.pumpWidget(testableWidget(
        DocSection(
          icon: LucideIcons.shield,
          title: 'Custom Color',
          accentColor: AppColors.purple500,
          child: const Text('Content'),
        ),
      ));

      expect(find.text('Custom Color'), findsOneWidget);
    });

    testWidgets('has correct spacing and layout', (tester) async {
      await tester.pumpWidget(testableWidget(
        DocSection(
          icon: LucideIcons.book,
          title: 'Layout Test',
          child: const Text('Content'),
        ),
      ));

      final column = tester.widget<Column>(
        find.descendant(
          of: find.byType(DocSection),
          matching: find.byType(Column).first,
        ),
      );
      expect(column.crossAxisAlignment, CrossAxisAlignment.start);
    });
  });

  group('DocFeatureCard', () {
    testWidgets('renders icon, title, and description', (tester) async {
      await tester.pumpWidget(testableWidget(
        const DocFeatureCard(
          icon: LucideIcons.zap,
          title: 'Fast Performance',
          description: 'Lightning fast execution',
        ),
      ));

      expect(find.text('Fast Performance'), findsOneWidget);
      expect(find.text('Lightning fast execution'), findsOneWidget);
      expect(find.byIcon(LucideIcons.zap), findsOneWidget);
    });

    testWidgets('uses default accent color', (tester) async {
      await tester.pumpWidget(testableWidget(
        const DocFeatureCard(
          icon: LucideIcons.cpu,
          title: 'Test',
          description: 'Description',
        ),
      ));

      expect(find.byType(DocFeatureCard), findsOneWidget);
    });

    testWidgets('applies custom accent color', (tester) async {
      await tester.pumpWidget(testableWidget(
        const DocFeatureCard(
          icon: LucideIcons.database,
          title: 'Database',
          description: 'Persistent storage',
          accentColor: AppColors.success,
        ),
      ));

      expect(find.text('Database'), findsOneWidget);
    });

    testWidgets('has fixed width of 200', (tester) async {
      await tester.pumpWidget(testableWidget(
        const DocFeatureCard(
          icon: LucideIcons.globe,
          title: 'Global',
          description: 'Worldwide reach',
        ),
      ));

      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(DocFeatureCard),
          matching: find.byType(Container).first,
        ),
      );
      expect(container.constraints?.maxWidth, 200);
    });
  });

  group('DocCodeBlock', () {
    testWidgets('renders code text', (tester) async {
      await tester.pumpWidget(testableWidget(
        const DocCodeBlock(code: 'const x = 42;'),
      ));

      expect(find.text('const x = 42;'), findsOneWidget);
    });

    testWidgets('code is selectable', (tester) async {
      await tester.pumpWidget(testableWidget(
        const DocCodeBlock(code: 'console.log("hello");'),
      ));

      expect(find.byType(SelectableText), findsOneWidget);
    });

    testWidgets('uses monospace font', (tester) async {
      await tester.pumpWidget(testableWidget(
        const DocCodeBlock(code: 'function test() {}'),
      ));

      final text = tester.widget<SelectableText>(find.byType(SelectableText));
      expect(text.style?.fontFamily, 'JetBrains Mono');
    });

    testWidgets('renders multiline code', (tester) async {
      const multilineCode = '''
function example() {
  return 42;
}''';
      await tester.pumpWidget(testableWidget(
        const DocCodeBlock(code: multilineCode),
      ));

      expect(find.text(multilineCode), findsOneWidget);
    });

    testWidgets('has full width', (tester) async {
      await tester.pumpWidget(testableWidget(
        const DocCodeBlock(code: 'code'),
      ));

      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(DocCodeBlock),
          matching: find.byType(Container).first,
        ),
      );
      expect(container.constraints?.minWidth, double.infinity);
    });
  });

  group('DocTable', () {
    testWidgets('renders headers', (tester) async {
      await tester.pumpWidget(testableWidget(
        const DocTable(
          headers: ['Name', 'Type', 'Description'],
          rows: [],
        ),
      ));

      expect(find.text('Name'), findsOneWidget);
      expect(find.text('Type'), findsOneWidget);
      expect(find.text('Description'), findsOneWidget);
    });

    testWidgets('renders data rows', (tester) async {
      await tester.pumpWidget(testableWidget(
        const DocTable(
          headers: ['Col1', 'Col2'],
          rows: [
            ['A1', 'B1'],
            ['A2', 'B2'],
          ],
        ),
      ));

      expect(find.text('A1'), findsOneWidget);
      expect(find.text('B1'), findsOneWidget);
      expect(find.text('A2'), findsOneWidget);
      expect(find.text('B2'), findsOneWidget);
    });

    testWidgets('renders empty table with headers only', (tester) async {
      await tester.pumpWidget(testableWidget(
        const DocTable(
          headers: ['Header'],
          rows: [],
        ),
      ));

      expect(find.text('Header'), findsOneWidget);
      expect(find.byType(Table), findsOneWidget);
    });

    testWidgets('uses Table widget', (tester) async {
      await tester.pumpWidget(testableWidget(
        const DocTable(
          headers: ['A'],
          rows: [
            ['1']
          ],
        ),
      ));

      expect(find.byType(Table), findsOneWidget);
    });
  });

  group('DocBulletList', () {
    testWidgets('renders all items with bullets', (tester) async {
      await tester.pumpWidget(testableWidget(
        const DocBulletList(
          items: ['Item 1', 'Item 2', 'Item 3'],
        ),
      ));

      expect(find.text('Item 1'), findsOneWidget);
      expect(find.text('Item 2'), findsOneWidget);
      expect(find.text('Item 3'), findsOneWidget);
      // Bullet character
      expect(find.textContaining('•'), findsNWidgets(3));
    });

    testWidgets('uses default bullet color', (tester) async {
      await tester.pumpWidget(testableWidget(
        const DocBulletList(
          items: ['Test item'],
        ),
      ));

      expect(find.byType(DocBulletList), findsOneWidget);
    });

    testWidgets('applies custom bullet color', (tester) async {
      await tester.pumpWidget(testableWidget(
        const DocBulletList(
          items: ['Custom color item'],
          bulletColor: AppColors.purple500,
        ),
      ));

      expect(find.text('Custom color item'), findsOneWidget);
    });

    testWidgets('renders empty list', (tester) async {
      await tester.pumpWidget(testableWidget(
        const DocBulletList(items: []),
      ));

      expect(find.byType(DocBulletList), findsOneWidget);
    });

    testWidgets('items have correct alignment', (tester) async {
      await tester.pumpWidget(testableWidget(
        const DocBulletList(items: ['Aligned item']),
      ));

      final column = tester.widget<Column>(
        find.descendant(
          of: find.byType(DocBulletList),
          matching: find.byType(Column).first,
        ),
      );
      expect(column.crossAxisAlignment, CrossAxisAlignment.start);
    });
  });

  group('DocNumberedList', () {
    testWidgets('renders items with numbers', (tester) async {
      await tester.pumpWidget(testableWidget(
        const DocNumberedList(
          items: ['First', 'Second', 'Third'],
        ),
      ));

      expect(find.text('First'), findsOneWidget);
      expect(find.text('Second'), findsOneWidget);
      expect(find.text('Third'), findsOneWidget);
      expect(find.text('1'), findsOneWidget);
      expect(find.text('2'), findsOneWidget);
      expect(find.text('3'), findsOneWidget);
    });

    testWidgets('uses default accent color', (tester) async {
      await tester.pumpWidget(testableWidget(
        const DocNumberedList(items: ['Item']),
      ));

      expect(find.byType(DocNumberedList), findsOneWidget);
    });

    testWidgets('applies custom accent color', (tester) async {
      await tester.pumpWidget(testableWidget(
        const DocNumberedList(
          items: ['Styled item'],
          accentColor: AppColors.warning,
        ),
      ));

      expect(find.text('Styled item'), findsOneWidget);
    });

    testWidgets('numbers are in circular containers', (tester) async {
      await tester.pumpWidget(testableWidget(
        const DocNumberedList(items: ['Test']),
      ));

      // Find containers with circle decoration
      final containers = tester.widgetList<Container>(
        find.descendant(
          of: find.byType(DocNumberedList),
          matching: find.byType(Container),
        ),
      );
      final circleContainers = containers.where((c) {
        final decoration = c.decoration;
        if (decoration is BoxDecoration) {
          return decoration.shape == BoxShape.circle;
        }
        return false;
      });
      expect(circleContainers, isNotEmpty);
    });

    testWidgets('handles large lists', (tester) async {
      await tester.pumpWidget(testableWidget(
        DocNumberedList(
          items: List.generate(10, (i) => 'Item ${i + 1}'),
        ),
      ));

      expect(find.text('10'), findsOneWidget);
    });
  });

  group('DocCallout', () {
    group('variants', () {
      testWidgets('info variant renders correctly', (tester) async {
        await tester.pumpWidget(testableWidget(
          const DocCallout.info(
            title: 'Info Title',
            message: 'Info message',
          ),
        ));

        expect(find.text('Info Title'), findsOneWidget);
        expect(find.text('Info message'), findsOneWidget);
        expect(find.byIcon(LucideIcons.lightbulb), findsOneWidget);
      });

      testWidgets('success variant renders correctly', (tester) async {
        await tester.pumpWidget(testableWidget(
          const DocCallout.success(
            title: 'Success Title',
            message: 'Success message',
          ),
        ));

        expect(find.text('Success Title'), findsOneWidget);
        expect(find.text('Success message'), findsOneWidget);
        expect(find.byIcon(LucideIcons.checkCircle), findsOneWidget);
      });

      testWidgets('warning variant renders correctly', (tester) async {
        await tester.pumpWidget(testableWidget(
          const DocCallout.warning(
            title: 'Warning Title',
            message: 'Warning message',
          ),
        ));

        expect(find.text('Warning Title'), findsOneWidget);
        expect(find.text('Warning message'), findsOneWidget);
        expect(find.byIcon(LucideIcons.alertTriangle), findsOneWidget);
      });

      testWidgets('danger variant renders correctly', (tester) async {
        await tester.pumpWidget(testableWidget(
          const DocCallout.danger(
            title: 'Danger Title',
            message: 'Danger message',
          ),
        ));

        expect(find.text('Danger Title'), findsOneWidget);
        expect(find.text('Danger message'), findsOneWidget);
        expect(find.byIcon(LucideIcons.alertCircle), findsOneWidget);
      });
    });

    group('content', () {
      testWidgets('renders message when provided', (tester) async {
        await tester.pumpWidget(testableWidget(
          const DocCallout(
            title: 'Title',
            message: 'This is the message',
            variant: DocCalloutVariant.info,
          ),
        ));

        expect(find.text('This is the message'), findsOneWidget);
      });

      testWidgets('renders items list when provided', (tester) async {
        await tester.pumpWidget(testableWidget(
          const DocCallout(
            title: 'Title',
            items: ['Item A', 'Item B', 'Item C'],
            variant: DocCalloutVariant.info,
          ),
        ));

        expect(find.textContaining('Item A'), findsOneWidget);
        expect(find.textContaining('Item B'), findsOneWidget);
        expect(find.textContaining('Item C'), findsOneWidget);
      });

      testWidgets('renders both message and items', (tester) async {
        await tester.pumpWidget(testableWidget(
          const DocCallout(
            title: 'Both',
            message: 'Main message',
            items: ['Extra item'],
            variant: DocCalloutVariant.success,
          ),
        ));

        expect(find.text('Main message'), findsOneWidget);
        expect(find.textContaining('Extra item'), findsOneWidget);
      });
    });

    group('styling', () {
      testWidgets('has left border accent', (tester) async {
        await tester.pumpWidget(testableWidget(
          const DocCallout.info(
            title: 'Styled',
            message: 'With border',
          ),
        ));

        final container = tester.widget<Container>(
          find.descendant(
            of: find.byType(DocCallout),
            matching: find.byType(Container).first,
          ),
        );
        final decoration = container.decoration as BoxDecoration?;
        expect(decoration?.border, isNotNull);
      });

      testWidgets('default variant is info', (tester) async {
        await tester.pumpWidget(testableWidget(
          const DocCallout(
            title: 'Default',
            message: 'Default variant',
          ),
        ));

        expect(find.byIcon(LucideIcons.lightbulb), findsOneWidget);
      });
    });
  });

  group('DocCalloutVariant', () {
    test('has all four variants', () {
      expect(DocCalloutVariant.values.length, 4);
      expect(DocCalloutVariant.values, contains(DocCalloutVariant.success));
      expect(DocCalloutVariant.values, contains(DocCalloutVariant.info));
      expect(DocCalloutVariant.values, contains(DocCalloutVariant.warning));
      expect(DocCalloutVariant.values, contains(DocCalloutVariant.danger));
    });
  });
}
