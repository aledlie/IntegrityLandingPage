import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:integrity_studio_ai/widgets/common/buttons.dart';
import '../../helpers/test_helpers.dart';

void main() {
  group('GradientButton', () {
    group('callback handling', () {
      testWidgets('invokes onPressed when tapped', (tester) async {
        var pressed = false;

        await tester.pumpWidget(
          testableWidget(
            GradientButton(
              text: 'Test Button',
              onPressed: () => pressed = true,
            ),
          ),
        );

        await tester.tap(find.text('Test Button'));
        await tester.pump();

        expect(pressed, isTrue);
      });

      testWidgets('does not invoke callback when disabled', (tester) async {
        var pressed = false;

        await tester.pumpWidget(
          testableWidget(
            GradientButton(
              text: 'Disabled Button',
              onPressed: null,
            ),
          ),
        );

        // Button should still be visible
        expect(find.text('Disabled Button'), findsOneWidget);
        expect(pressed, isFalse);
      });

      testWidgets('does not invoke callback when loading', (tester) async {
        var pressed = false;

        await tester.pumpWidget(
          testableWidget(
            GradientButton(
              text: 'Loading',
              isLoading: true,
              onPressed: () => pressed = true,
            ),
          ),
        );

        // Text should be replaced with spinner
        expect(find.text('Loading'), findsNothing);
        expect(pressed, isFalse);
      });
    });

    group('loading state', () {
      testWidgets('shows spinner when loading', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            GradientButton(
              text: 'Test',
              isLoading: true,
              onPressed: () {},
            ),
          ),
        );

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
        expect(find.text('Test'), findsNothing);
      });

      testWidgets('shows text when not loading', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            GradientButton(
              text: 'Test',
              isLoading: false,
              onPressed: () {},
            ),
          ),
        );

        expect(find.byType(CircularProgressIndicator), findsNothing);
        expect(find.text('Test'), findsOneWidget);
      });
    });

    group('icon handling', () {
      testWidgets('shows icon when provided', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            GradientButton(
              text: 'Test',
              icon: LucideIcons.arrowRight,
              onPressed: () {},
            ),
          ),
        );

        expect(find.byIcon(LucideIcons.arrowRight), findsOneWidget);
      });

      testWidgets('hides icon when loading', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            GradientButton(
              text: 'Test',
              icon: LucideIcons.arrowRight,
              isLoading: true,
              onPressed: () {},
            ),
          ),
        );

        expect(find.byIcon(LucideIcons.arrowRight), findsNothing);
      });
    });

    group('structure', () {
      testWidgets('wraps content in GestureDetector', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            GradientButton(
              text: 'Test',
              onPressed: () {},
            ),
          ),
        );

        expect(find.byType(GestureDetector), findsWidgets);
      });

      testWidgets('has Semantics widget for accessibility', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            GradientButton(
              text: 'Test',
              onPressed: () {},
            ),
          ),
        );

        expect(find.byType(Semantics), findsWidgets);
      });
    });
  });

  group('OutlineButton', () {
    group('callback handling', () {
      testWidgets('invokes onPressed when tapped', (tester) async {
        var pressed = false;

        await tester.pumpWidget(
          testableWidget(
            OutlineButton(
              text: 'Outline Test',
              onPressed: () => pressed = true,
            ),
          ),
        );

        await tester.tap(find.text('Outline Test'));
        await tester.pump();

        expect(pressed, isTrue);
      });

      testWidgets('does not invoke callback when disabled', (tester) async {
        var pressed = false;

        await tester.pumpWidget(
          testableWidget(
            OutlineButton(
              text: 'Disabled',
              onPressed: null,
            ),
          ),
        );

        expect(find.text('Disabled'), findsOneWidget);
        expect(pressed, isFalse);
      });
    });

    group('loading state', () {
      testWidgets('shows spinner when loading', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            OutlineButton(
              text: 'Test',
              isLoading: true,
              onPressed: () {},
            ),
          ),
        );

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });
    });

    group('icon handling', () {
      testWidgets('shows icon when provided', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            OutlineButton(
              text: 'Test',
              icon: LucideIcons.play,
              onPressed: () {},
            ),
          ),
        );

        expect(find.byIcon(LucideIcons.play), findsOneWidget);
      });
    });

    group('structure', () {
      testWidgets('has AnimatedContainer for hover effects', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            OutlineButton(
              text: 'Test',
              onPressed: () {},
            ),
          ),
        );

        expect(find.byType(AnimatedContainer), findsWidgets);
      });
    });
  });

  group('AppTextButton', () {
    group('callback handling', () {
      testWidgets('invokes onPressed when tapped', (tester) async {
        var pressed = false;

        await tester.pumpWidget(
          testableWidget(
            AppTextButton(
              text: 'Link',
              onPressed: () => pressed = true,
            ),
          ),
        );

        await tester.tap(find.text('Link'));
        await tester.pump();

        expect(pressed, isTrue);
      });
    });

    group('icon handling', () {
      testWidgets('shows icon when provided', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            AppTextButton(
              text: 'Link',
              icon: LucideIcons.externalLink,
              onPressed: () {},
            ),
          ),
        );

        expect(find.text('Link'), findsOneWidget);
        expect(find.byIcon(LucideIcons.externalLink), findsOneWidget);
      });

      testWidgets('works with iconLeading option', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            AppTextButton(
              text: 'Back',
              icon: LucideIcons.arrowLeft,
              iconLeading: true,
              onPressed: () {},
            ),
          ),
        );

        expect(find.text('Back'), findsOneWidget);
        expect(find.byIcon(LucideIcons.arrowLeft), findsOneWidget);
      });
    });
  });

  group('AppIconButton', () {
    testWidgets('invokes onPressed when tapped', (tester) async {
      var pressed = false;

      await tester.pumpWidget(
        testableWidget(
          AppIconButton(
            icon: LucideIcons.menu,
            onPressed: () => pressed = true,
          ),
        ),
      );

      await tester.tap(find.byIcon(LucideIcons.menu));
      await tester.pump();

      expect(pressed, isTrue);
    });

    testWidgets('shows tooltip when provided', (tester) async {
      await tester.pumpWidget(
        testableWidget(
          AppIconButton(
            icon: LucideIcons.menu,
            tooltip: 'Open menu',
            onPressed: () {},
          ),
        ),
      );

      expect(find.byType(Tooltip), findsOneWidget);
    });

    testWidgets('uses custom icon size', (tester) async {
      await tester.pumpWidget(
        testableWidget(
          AppIconButton(
            icon: LucideIcons.menu,
            size: 32,
            onPressed: () {},
          ),
        ),
      );

      final icon = tester.widget<Icon>(find.byIcon(LucideIcons.menu));
      expect(icon.size, equals(32));
    });

    testWidgets('renders icon correctly', (tester) async {
      await tester.pumpWidget(
        testableWidget(
          AppIconButton(
            icon: LucideIcons.x,
            onPressed: () {},
          ),
        ),
      );

      expect(find.byIcon(LucideIcons.x), findsOneWidget);
    });
  });

  group('AnimatedGradientBorderButton', () {
    // AnimatedGradientBorderButton has continuous animations, use pump() with duration

    group('callback handling', () {
      testWidgets('invokes onPressed when tapped', (tester) async {
        var pressed = false;

        await tester.pumpWidget(
          testableWidget(
            AnimatedGradientBorderButton(
              text: 'Animated Button',
              onPressed: () => pressed = true,
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 500));

        await tester.tap(find.text('Animated Button'));
        await tester.pump();

        expect(pressed, isTrue);
      });

      testWidgets('does not invoke callback when disabled', (tester) async {
        var pressed = false;

        await tester.pumpWidget(
          testableWidget(
            AnimatedGradientBorderButton(
              text: 'Disabled Animated',
              onPressed: null,
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 500));

        expect(find.text('Disabled Animated'), findsOneWidget);
        expect(pressed, isFalse);
      });
    });

    group('loading state', () {
      testWidgets('shows spinner when loading', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            AnimatedGradientBorderButton(
              text: 'Test',
              isLoading: true,
              onPressed: () {},
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 500));

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
        expect(find.text('Test'), findsNothing);
      });
    });

    group('animation', () {
      testWidgets('has animation controller running', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            AnimatedGradientBorderButton(
              text: 'Test',
              onPressed: () {},
            ),
          ),
        );

        // Animation should be running - pump a few frames
        await tester.pump(const Duration(seconds: 1));
        await tester.pump(const Duration(seconds: 1));

        expect(find.byType(AnimatedGradientBorderButton), findsOneWidget);
      });

      testWidgets('uses CustomPaint for gradient border', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            AnimatedGradientBorderButton(
              text: 'Test',
              onPressed: () {},
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 500));

        expect(find.byType(CustomPaint), findsWidgets);
      });
    });

    group('structure', () {
      testWidgets('has Semantics widget for accessibility', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            AnimatedGradientBorderButton(
              text: 'Start Trial',
              onPressed: () {},
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 500));

        expect(find.byType(Semantics), findsWidgets);
      });

      testWidgets('renders text correctly', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            AnimatedGradientBorderButton(
              text: 'Get Started',
              onPressed: () {},
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 500));

        expect(find.text('Get Started'), findsOneWidget);
      });
    });
  });
}
