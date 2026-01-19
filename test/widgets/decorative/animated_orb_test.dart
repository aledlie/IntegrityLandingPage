import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integrity_studio_ai/widgets/decorative/animated_orb.dart';
import 'package:integrity_studio_ai/theme/theme.dart';

void main() {
  group('AnimatedOrb', () {
    testWidgets('renders with required parameters', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AnimatedOrb(
              size: 100,
              color: Colors.blue,
            ),
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.byType(AnimatedOrb), findsOneWidget);
      expect(find.byType(RepaintBoundary), findsWidgets);
    });

    testWidgets('renders with all parameters', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AnimatedOrb(
              size: 200,
              color: Colors.purple,
              position: Alignment.topLeft,
              offset: Offset(-50, -50),
              opacity: 0.3,
              duration: Duration(seconds: 5),
            ),
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.byType(AnimatedOrb), findsOneWidget);
    });

    testWidgets('uses RepaintBoundary for performance', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AnimatedOrb(
              size: 100,
              color: Colors.blue,
            ),
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.byType(RepaintBoundary), findsWidgets);
    });

    testWidgets('creates circular Container decoration', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AnimatedOrb(
              size: 100,
              color: Colors.blue,
            ),
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.byType(Container), findsWidgets);
    });

    testWidgets('disposes animation controller properly', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AnimatedOrb(
              size: 100,
              color: Colors.blue,
            ),
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 100));

      // Replace with different widget to trigger dispose
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Text('Replaced'),
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(AnimatedOrb), findsNothing);
    });
  });

  group('StaticOrb', () {
    testWidgets('renders with required parameters', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: StaticOrb(
              size: 100,
              color: Colors.green,
            ),
          ),
        ),
      );

      expect(find.byType(StaticOrb), findsOneWidget);
      expect(find.byType(Container), findsWidgets);
    });

    testWidgets('renders with custom opacity', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: StaticOrb(
              size: 150,
              color: Colors.red,
              opacity: 0.5,
            ),
          ),
        ),
      );

      expect(find.byType(StaticOrb), findsOneWidget);
    });

    testWidgets('creates circular container', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: StaticOrb(
              size: 100,
              color: Colors.blue,
            ),
          ),
        ),
      );

      // StaticOrb should create a Container
      expect(find.byType(Container), findsWidgets);
    });
  });

  group('DecorativeOrbs', () {
    testWidgets('renders with default animation', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Stack(
              children: [
                DecorativeOrbs(),
              ],
            ),
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.byType(DecorativeOrbs), findsOneWidget);
    });

    testWidgets('renders animated orbs when animate is true', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Stack(
              children: [
                DecorativeOrbs(animate: true),
              ],
            ),
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 100));

      // Should have AnimatedOrb widgets
      expect(find.byType(AnimatedOrb), findsWidgets);
    });

    testWidgets('renders static orbs when animate is false', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Stack(
              children: [
                DecorativeOrbs(animate: false),
              ],
            ),
          ),
        ),
      );

      // Should have StaticOrb widgets instead
      expect(find.byType(StaticOrb), findsWidgets);
      expect(find.byType(AnimatedOrb), findsNothing);
    });

    testWidgets('uses Stack with Positioned widgets', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Stack(
              children: [
                DecorativeOrbs(),
              ],
            ),
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.byType(Stack), findsWidgets);
      expect(find.byType(Positioned), findsWidgets);
    });

    testWidgets('respects reduced motion preference', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(disableAnimations: true),
            child: const Scaffold(
              body: Stack(
                children: [
                  DecorativeOrbs(animate: true),
                ],
              ),
            ),
          ),
        ),
      );

      // With reduced motion, should use StaticOrb
      expect(find.byType(StaticOrb), findsWidgets);
      expect(find.byType(AnimatedOrb), findsNothing);
    });

    testWidgets('uses blue and indigo orb colors when static', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Stack(
              children: [
                DecorativeOrbs(animate: false),
              ],
            ),
          ),
        ),
      );

      // Verify orbs are present
      final staticOrbs = tester.widgetList<StaticOrb>(find.byType(StaticOrb));
      expect(staticOrbs.length, greaterThanOrEqualTo(2));

      // Check colors
      final orbColors = staticOrbs.map((orb) => orb.color).toList();
      expect(orbColors, contains(AppColors.blue500));
      expect(orbColors, contains(AppColors.indigo500));
    });
  });
}
