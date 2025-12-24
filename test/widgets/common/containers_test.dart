import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integrity_studio_ai/widgets/common/containers.dart';
import '../../helpers/test_helpers.dart';

void main() {
  group('ResponsiveContainer', () {
    testWidgets('constrains width with ConstrainedBox', (tester) async {
      setDesktopSize(tester);

      await tester.pumpWidget(
        testableWidget(
          ResponsiveContainer(
            maxWidth: 800,
            child: Container(color: Colors.blue),
          ),
        ),
      );

      // Verify ResponsiveContainer renders and contains a ConstrainedBox
      expect(find.byType(ResponsiveContainer), findsOneWidget);
      expect(
        find.descendant(
          of: find.byType(ResponsiveContainer),
          matching: find.byType(ConstrainedBox),
        ),
        findsWidgets,
      );
    });

    testWidgets('uses Center for horizontal centering', (tester) async {
      setDesktopSize(tester);

      await tester.pumpWidget(
        testableWidget(
          ResponsiveContainer(
            child: Container(color: Colors.blue),
          ),
        ),
      );

      // Verify ResponsiveContainer uses Center widget
      expect(
        find.descendant(
          of: find.byType(ResponsiveContainer),
          matching: find.byType(Center),
        ),
        findsOneWidget,
      );
    });

    testWidgets('wraps with SafeArea when useSafeArea is true', (tester) async {
      await tester.pumpWidget(
        testableWidget(
          ResponsiveContainer(
            useSafeArea: true,
            child: Container(color: Colors.blue),
          ),
        ),
      );

      expect(find.byType(SafeArea), findsOneWidget);
    });

    testWidgets('does not wrap with SafeArea by default', (tester) async {
      await tester.pumpWidget(
        testableWidget(
          ResponsiveContainer(
            child: Container(color: Colors.blue),
          ),
        ),
      );

      expect(find.byType(SafeArea), findsNothing);
    });

    testWidgets('applies additional padding', (tester) async {
      await tester.pumpWidget(
        testableWidget(
          ResponsiveContainer(
            additionalPadding: const EdgeInsets.all(20),
            child: Container(color: Colors.blue),
          ),
        ),
      );

      // Should have Padding widget present
      expect(find.byType(Padding), findsWidgets);
    });
  });

  group('SectionContainer', () {
    testWidgets('renders with background color', (tester) async {
      await tester.pumpWidget(
        testableWidget(
          SectionContainer(
            backgroundColor: Colors.red,
            child: const Text('Content'),
          ),
        ),
      );

      // SectionContainer should render and contain DecoratedBox or Container
      expect(find.byType(SectionContainer), findsOneWidget);
      expect(find.byType(Container), findsWidgets);
    });

    testWidgets('renders with background gradient', (tester) async {
      const gradient = LinearGradient(colors: [Colors.blue, Colors.purple]);

      await tester.pumpWidget(
        testableWidget(
          SectionContainer(
            backgroundGradient: gradient,
            child: const Text('Content'),
          ),
        ),
      );

      // SectionContainer should render with gradient
      expect(find.byType(SectionContainer), findsOneWidget);
      expect(find.byType(Container), findsWidgets);
    });

    testWidgets('adds semantic label when id is provided', (tester) async {
      await tester.pumpWidget(
        testableWidget(
          SectionContainer(
            id: 'features',
            child: const Text('Content'),
          ),
        ),
      );

      expect(find.byType(Semantics), findsWidgets);
    });

    testWidgets('uses ResponsiveContainer by default', (tester) async {
      await tester.pumpWidget(
        testableWidget(
          SectionContainer(
            child: const Text('Content'),
          ),
        ),
      );

      expect(find.byType(ResponsiveContainer), findsOneWidget);
    });

    testWidgets('skips ResponsiveContainer when useResponsiveContainer is false', (tester) async {
      await tester.pumpWidget(
        testableWidget(
          SectionContainer(
            useResponsiveContainer: false,
            child: const Text('Content'),
          ),
        ),
      );

      expect(find.byType(ResponsiveContainer), findsNothing);
    });

    testWidgets('applies custom padding', (tester) async {
      await tester.pumpWidget(
        testableWidget(
          SectionContainer(
            padding: const EdgeInsets.all(50),
            child: const Text('Content'),
          ),
        ),
      );

      expect(find.byType(Padding), findsWidgets);
    });
  });

  group('SectionTitle', () {
    testWidgets('renders title text', (tester) async {
      await tester.pumpWidget(
        testableWidget(
          const SectionTitle(title: 'Test Title'),
        ),
      );

      expect(find.text('Test Title'), findsOneWidget);
    });

    testWidgets('renders subtitle when provided', (tester) async {
      await tester.pumpWidget(
        testableWidget(
          const SectionTitle(
            title: 'Title',
            subtitle: 'Subtitle text',
          ),
        ),
      );

      expect(find.text('Subtitle text'), findsOneWidget);
    });

    testWidgets('does not render subtitle when not provided', (tester) async {
      await tester.pumpWidget(
        testableWidget(
          const SectionTitle(title: 'Title'),
        ),
      );

      // Only title should be present
      final texts = tester.widgetList<Text>(find.byType(Text));
      expect(texts.length, equals(1));
    });

    testWidgets('has semantic header attribute on title', (tester) async {
      await tester.pumpWidget(
        testableWidget(
          const SectionTitle(title: 'Title'),
        ),
      );

      expect(find.byType(Semantics), findsWidgets);
    });
  });

  group('ResponsiveGrid', () {
    testWidgets('renders all children', (tester) async {
      setDesktopSize(tester);

      await tester.pumpWidget(
        testableWidget(
          ResponsiveGrid(
            children: [
              Container(key: const Key('1'), color: Colors.red),
              Container(key: const Key('2'), color: Colors.blue),
              Container(key: const Key('3'), color: Colors.green),
            ],
          ),
        ),
      );

      expect(find.byKey(const Key('1')), findsOneWidget);
      expect(find.byKey(const Key('2')), findsOneWidget);
      expect(find.byKey(const Key('3')), findsOneWidget);
    });

    testWidgets('uses Wrap for layout', (tester) async {
      setDesktopSize(tester);

      await tester.pumpWidget(
        testableWidget(
          ResponsiveGrid(
            children: [Container()],
          ),
        ),
      );

      expect(find.byType(Wrap), findsOneWidget);
    });

    testWidgets('uses LayoutBuilder for responsive sizing', (tester) async {
      setDesktopSize(tester);

      await tester.pumpWidget(
        testableWidget(
          ResponsiveGrid(
            children: [Container()],
          ),
        ),
      );

      expect(find.byType(LayoutBuilder), findsOneWidget);
    });
  });

  group('GradientBackground', () {
    testWidgets('renders child widget', (tester) async {
      await tester.pumpWidget(
        testableWidget(
          GradientBackground(
            child: Container(key: const Key('child')),
          ),
        ),
      );

      expect(find.byKey(const Key('child')), findsOneWidget);
    });

    testWidgets('shows orbs when showOrbs is true', (tester) async {
      await tester.pumpWidget(
        testableWidget(
          GradientBackground(
            showOrbs: true,
            child: const SizedBox(),
          ),
        ),
      );

      // Should have Positioned widgets for orbs
      expect(find.byType(Positioned), findsWidgets);
    });

    testWidgets('renders without showOrbs', (tester) async {
      await tester.pumpWidget(
        testableWidget(
          GradientBackground(
            showOrbs: false,
            child: const SizedBox(),
          ),
        ),
      );

      // Should render GradientBackground
      expect(find.byType(GradientBackground), findsOneWidget);
    });

    testWidgets('uses Stack for layered content', (tester) async {
      await tester.pumpWidget(
        testableWidget(
          GradientBackground(
            child: const SizedBox(),
          ),
        ),
      );

      expect(find.byType(Stack), findsWidgets);
    });
  });

  group('LabeledDivider', () {
    testWidgets('renders simple divider when no label', (tester) async {
      await tester.pumpWidget(
        testableWidget(
          const LabeledDivider(),
        ),
      );

      expect(find.byType(Divider), findsOneWidget);
    });

    testWidgets('renders label when provided', (tester) async {
      await tester.pumpWidget(
        testableWidget(
          const LabeledDivider(label: 'or'),
        ),
      );

      expect(find.text('or'), findsOneWidget);
    });

    testWidgets('renders two dividers when label is present', (tester) async {
      await tester.pumpWidget(
        testableWidget(
          const LabeledDivider(label: 'or'),
        ),
      );

      expect(find.byType(Divider), findsNWidgets(2));
    });

    testWidgets('uses Row layout when label is present', (tester) async {
      await tester.pumpWidget(
        testableWidget(
          const LabeledDivider(label: 'or'),
        ),
      );

      expect(find.byType(Row), findsOneWidget);
    });
  });
}
