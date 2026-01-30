import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integrity_studio_ai/widgets/common/containers.dart';
import '../../helpers/test_helpers.dart';

void main() {
  // =======================================================================
  // ResponsiveContainer Tests
  // =======================================================================

  group('ResponsiveContainer', () {
    testWidgets('renders with all configurations', (tester) async {
      setDesktopSize(tester);

      // Test with maxWidth, Center, and ConstrainedBox
      await tester.pumpWidget(
        testableWidget(
          ResponsiveContainer(
            maxWidth: 800,
            child: Container(color: Colors.blue),
          ),
        ),
      );

      expect(find.byType(ResponsiveContainer), findsOneWidget);
      expect(
        find.descendant(
          of: find.byType(ResponsiveContainer),
          matching: find.byType(ConstrainedBox),
        ),
        findsWidgets,
      );
      expect(
        find.descendant(
          of: find.byType(ResponsiveContainer),
          matching: find.byType(Center),
        ),
        findsOneWidget,
      );

      // Test SafeArea configurations
      for (final useSafeArea in [true, false]) {
        await tester.pumpWidget(
          testableWidget(
            ResponsiveContainer(
              useSafeArea: useSafeArea,
              child: Container(color: Colors.blue),
            ),
          ),
        );

        if (useSafeArea) {
          expect(find.byType(SafeArea), findsOneWidget);
        } else {
          expect(find.byType(SafeArea), findsNothing);
        }
      }

      // Test additional padding
      await tester.pumpWidget(
        testableWidget(
          ResponsiveContainer(
            additionalPadding: const EdgeInsets.all(20),
            child: Container(color: Colors.blue),
          ),
        ),
      );

      expect(find.byType(Padding), findsWidgets);
    });
  });

  // =======================================================================
  // SectionContainer Tests
  // =======================================================================

  group('SectionContainer', () {
    testWidgets('renders with all configurations', (tester) async {
      // Test background color
      await tester.pumpWidget(
        testableWidget(
          const SectionContainer(
            backgroundColor: Colors.red,
            child: Text('Content'),
          ),
        ),
      );

      expect(find.byType(SectionContainer), findsOneWidget);
      expect(find.byType(Container), findsWidgets);

      // Test background gradient
      const gradient = LinearGradient(colors: [Colors.blue, Colors.purple]);
      await tester.pumpWidget(
        testableWidget(
          const SectionContainer(
            backgroundGradient: gradient,
            child: Text('Content'),
          ),
        ),
      );

      expect(find.byType(SectionContainer), findsOneWidget);
      expect(find.byType(Container), findsWidgets);

      // Test semantic label with id
      await tester.pumpWidget(
        testableWidget(
          const SectionContainer(
            id: 'features',
            child: Text('Content'),
          ),
        ),
      );

      expect(find.byType(Semantics), findsWidgets);

      // Test ResponsiveContainer configurations
      for (final useResponsive in [true, false]) {
        await tester.pumpWidget(
          testableWidget(
            SectionContainer(
              useResponsiveContainer: useResponsive,
              child: const Text('Content'),
            ),
          ),
        );

        if (useResponsive) {
          expect(find.byType(ResponsiveContainer), findsOneWidget);
        } else {
          expect(find.byType(ResponsiveContainer), findsNothing);
        }
      }

      // Test custom padding
      await tester.pumpWidget(
        testableWidget(
          const SectionContainer(
            padding: EdgeInsets.all(50),
            child: Text('Content'),
          ),
        ),
      );

      expect(find.byType(Padding), findsWidgets);
    });
  });

  // =======================================================================
  // SectionTitle Tests
  // =======================================================================

  group('SectionTitle', () {
    testWidgets('renders title with optional subtitle and semantics', (tester) async {
      // Test title only
      await tester.pumpWidget(
        testableWidget(
          const SectionTitle(title: 'Test Title'),
        ),
      );

      expect(find.text('Test Title'), findsOneWidget);
      var texts = tester.widgetList<Text>(find.byType(Text));
      expect(texts.length, equals(1));
      expect(find.byType(Semantics), findsWidgets);

      // Test with subtitle
      await tester.pumpWidget(
        testableWidget(
          const SectionTitle(
            title: 'Title',
            subtitle: 'Subtitle text',
          ),
        ),
      );

      expect(find.text('Title'), findsOneWidget);
      expect(find.text('Subtitle text'), findsOneWidget);
      texts = tester.widgetList<Text>(find.byType(Text));
      expect(texts.length, equals(2));
    });
  });

  // =======================================================================
  // ResponsiveGrid Tests
  // =======================================================================

  group('ResponsiveGrid', () {
    testWidgets('renders children with Wrap and LayoutBuilder', (tester) async {
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

      // Verify all children render
      expect(find.byKey(const Key('1')), findsOneWidget);
      expect(find.byKey(const Key('2')), findsOneWidget);
      expect(find.byKey(const Key('3')), findsOneWidget);

      // Verify layout widgets
      expect(find.byType(Wrap), findsOneWidget);
      expect(find.byType(LayoutBuilder), findsOneWidget);
    });
  });

  // =======================================================================
  // GradientBackground Tests
  // =======================================================================

  group('GradientBackground', () {
    testWidgets('renders child with orbs and Stack layout', (tester) async {
      // Test basic rendering with child
      await tester.pumpWidget(
        testableWidget(
          GradientBackground(
            child: Container(key: const Key('child')),
          ),
        ),
      );

      expect(find.byKey(const Key('child')), findsOneWidget);
      expect(find.byType(Stack), findsWidgets);

      // Test orbs configurations
      for (final showOrbs in [true, false]) {
        await tester.pumpWidget(
          testableWidget(
            GradientBackground(
              showOrbs: showOrbs,
              child: const SizedBox(),
            ),
          ),
        );

        expect(find.byType(GradientBackground), findsOneWidget);
        if (showOrbs) {
          expect(find.byType(Positioned), findsWidgets);
        }
      }
    });
  });

  // =======================================================================
  // LabeledDivider Tests
  // =======================================================================

  group('LabeledDivider', () {
    testWidgets('renders divider with and without label', (tester) async {
      // Test without label - single divider
      await tester.pumpWidget(
        testableWidget(
          const LabeledDivider(),
        ),
      );

      expect(find.byType(Divider), findsOneWidget);

      // Test with label - two dividers with Row layout
      await tester.pumpWidget(
        testableWidget(
          const LabeledDivider(label: 'or'),
        ),
      );

      expect(find.text('or'), findsOneWidget);
      expect(find.byType(Divider), findsNWidgets(2));
      expect(find.byType(Row), findsOneWidget);
    });
  });
}
