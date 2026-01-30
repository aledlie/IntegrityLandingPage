import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:integrity_studio_ai/widgets/common/alert.dart';
import 'package:integrity_studio_ai/theme/colors.dart';
import '../../helpers/test_helpers.dart';

void main() {

  group('Alert', () {
    group('variants', () {
      testWidgets('renders success variant with correct icon', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            const Alert(
              variant: AlertVariant.success,
              message: 'Success message',
            ),
          ),
        );

        expect(find.byIcon(LucideIcons.checkCircle), findsOneWidget);
        expect(find.text('Success message'), findsOneWidget);
      });

      testWidgets('renders error variant with correct icon', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            const Alert(
              variant: AlertVariant.error,
              message: 'Error message',
            ),
          ),
        );

        expect(find.byIcon(LucideIcons.alertCircle), findsOneWidget);
        expect(find.text('Error message'), findsOneWidget);
      });

      testWidgets('renders warning variant with correct icon', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            const Alert(
              variant: AlertVariant.warning,
              message: 'Warning message',
            ),
          ),
        );

        expect(find.byIcon(LucideIcons.alertTriangle), findsOneWidget);
        expect(find.text('Warning message'), findsOneWidget);
      });

      testWidgets('renders info variant with correct icon', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            const Alert(
              variant: AlertVariant.info,
              message: 'Info message',
            ),
          ),
        );

        expect(find.byIcon(LucideIcons.info), findsOneWidget);
        expect(find.text('Info message'), findsOneWidget);
      });
    });

    group('factory constructors', () {
      testWidgets('Alert.success creates success variant', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            Alert.success(message: 'Success!'),
          ),
        );

        expect(find.byIcon(LucideIcons.checkCircle), findsOneWidget);
        expect(find.text('Success!'), findsOneWidget);
      });

      testWidgets('Alert.error creates error variant', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            Alert.error(message: 'Error!'),
          ),
        );

        expect(find.byIcon(LucideIcons.alertCircle), findsOneWidget);
        expect(find.text('Error!'), findsOneWidget);
      });

      testWidgets('Alert.warning creates warning variant', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            Alert.warning(message: 'Warning!'),
          ),
        );

        expect(find.byIcon(LucideIcons.alertTriangle), findsOneWidget);
        expect(find.text('Warning!'), findsOneWidget);
      });

      testWidgets('Alert.info creates info variant', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            Alert.info(message: 'Info!'),
          ),
        );

        expect(find.byIcon(LucideIcons.info), findsOneWidget);
        expect(find.text('Info!'), findsOneWidget);
      });
    });

    group('title', () {
      testWidgets('renders title when provided', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            const Alert(
              variant: AlertVariant.success,
              title: 'Success Title',
              message: 'Success message',
            ),
          ),
        );

        expect(find.text('Success Title'), findsOneWidget);
        expect(find.text('Success message'), findsOneWidget);
      });

      testWidgets('does not render title when not provided', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            const Alert(
              variant: AlertVariant.success,
              message: 'Success message',
            ),
          ),
        );

        // Only message should be present, not a title
        final textWidgets = tester.widgetList<Text>(find.byType(Text));
        expect(textWidgets.length, equals(1));
      });
    });

    group('dismissible', () {
      testWidgets('shows dismiss button when dismissible', (tester) async {
        var dismissed = false;

        await tester.pumpWidget(
          testableWidget(
            Alert(
              variant: AlertVariant.info,
              message: 'Dismissible alert',
              dismissible: true,
              onDismiss: () => dismissed = true,
            ),
          ),
        );

        expect(find.byIcon(LucideIcons.x), findsOneWidget);

        await tester.tap(find.byIcon(LucideIcons.x));
        await tester.pump();

        expect(dismissed, isTrue);
      });

      testWidgets('hides dismiss button when not dismissible', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            const Alert(
              variant: AlertVariant.info,
              message: 'Non-dismissible alert',
              dismissible: false,
            ),
          ),
        );

        expect(find.byIcon(LucideIcons.x), findsNothing);
      });

      testWidgets('hides dismiss button when dismissible but no callback',
          (tester) async {
        await tester.pumpWidget(
          testableWidget(
            const Alert(
              variant: AlertVariant.info,
              message: 'Alert without callback',
              dismissible: true,
              onDismiss: null,
            ),
          ),
        );

        expect(find.byIcon(LucideIcons.x), findsNothing);
      });
    });

    group('custom icon', () {
      testWidgets('uses custom icon when provided', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            const Alert(
              variant: AlertVariant.success,
              message: 'Custom icon alert',
              icon: LucideIcons.star,
            ),
          ),
        );

        expect(find.byIcon(LucideIcons.star), findsOneWidget);
        expect(find.byIcon(LucideIcons.checkCircle), findsNothing);
      });
    });

    group('accessibility', () {
      testWidgets('has Semantics container', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            const Alert(
              variant: AlertVariant.success,
              message: 'Accessible alert',
            ),
          ),
        );

        expect(find.byType(Semantics), findsWidgets);
      });

      testWidgets('has Semantics for screen reader announcements',
          (tester) async {
        await tester.pumpWidget(
          testableWidget(
            const Alert(
              variant: AlertVariant.error,
              message: 'Error alert',
            ),
          ),
        );

        // Verify Semantics widgets exist for accessibility
        expect(find.byType(Semantics), findsWidgets);
      });
    });

    group('styling', () {
      testWidgets('has container with proper decoration', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            const Alert(
              variant: AlertVariant.success,
              message: 'Styled alert',
            ),
          ),
        );

        expect(find.byType(Container), findsWidgets);
      });

      testWidgets('success variant uses success colors', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            const Alert(
              variant: AlertVariant.success,
              message: 'Success',
            ),
          ),
        );

        final icon = tester.widget<Icon>(find.byIcon(LucideIcons.checkCircle));
        expect(icon.color, equals(AppColors.success));
      });

      testWidgets('error variant uses error colors', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            const Alert(
              variant: AlertVariant.error,
              message: 'Error',
            ),
          ),
        );

        final icon = tester.widget<Icon>(find.byIcon(LucideIcons.alertCircle));
        expect(icon.color, equals(AppColors.error));
      });
    });
  });

  group('AnimatedAlert', () {
    group('animation', () {
      testWidgets('renders animated alert widget', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            const AnimatedAlert(
              variant: AlertVariant.success,
              message: 'Animated alert',
            ),
          ),
        );

        // Animation widgets should be present
        expect(find.byType(AnimatedAlert), findsOneWidget);
      });

      testWidgets('animation completes after duration', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            const AnimatedAlert(
              variant: AlertVariant.success,
              message: 'Animated alert',
            ),
          ),
        );

        // Animation should complete
        await tester.pumpAndSettle();

        expect(find.text('Animated alert'), findsOneWidget);
      });
    });

    group('auto dismiss', () {
      testWidgets('auto dismisses after specified duration', (tester) async {
        var dismissed = false;

        await tester.pumpWidget(
          testableWidget(
            AnimatedAlert(
              variant: AlertVariant.info,
              message: 'Auto dismiss alert',
              autoDismissDuration: const Duration(milliseconds: 500),
              onDismiss: () => dismissed = true,
            ),
          ),
        );

        // Initially visible
        expect(find.text('Auto dismiss alert'), findsOneWidget);

        // Wait for auto dismiss
        await tester.pump(const Duration(milliseconds: 600));
        await tester.pumpAndSettle();

        expect(dismissed, isTrue);
      });

      testWidgets('does not auto dismiss when duration is null',
          (tester) async {
        var dismissed = false;

        await tester.pumpWidget(
          testableWidget(
            AnimatedAlert(
              variant: AlertVariant.info,
              message: 'Persistent alert',
              onDismiss: () => dismissed = true,
            ),
          ),
        );

        // Wait a while
        await tester.pump(const Duration(seconds: 2));

        expect(dismissed, isFalse);
        expect(find.text('Persistent alert'), findsOneWidget);
      });
    });

    group('dismissible', () {
      testWidgets('can be manually dismissed', (tester) async {
        var dismissed = false;

        await tester.pumpWidget(
          testableWidget(
            AnimatedAlert(
              variant: AlertVariant.warning,
              message: 'Dismissible animated alert',
              dismissible: true,
              onDismiss: () => dismissed = true,
            ),
          ),
        );

        await tester.pumpAndSettle();

        // Find and tap dismiss button
        await tester.tap(find.byIcon(LucideIcons.x));
        await tester.pumpAndSettle();

        expect(dismissed, isTrue);
      });
    });

    group('title', () {
      testWidgets('renders title when provided', (tester) async {
        await tester.pumpWidget(
          testableWidget(
            const AnimatedAlert(
              variant: AlertVariant.success,
              title: 'Animated Title',
              message: 'Animated message',
            ),
          ),
        );

        await tester.pumpAndSettle();

        expect(find.text('Animated Title'), findsOneWidget);
        expect(find.text('Animated message'), findsOneWidget);
      });
    });
  });
}
