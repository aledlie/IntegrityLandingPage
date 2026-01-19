import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integrity_studio_ai/theme/colors.dart';
import 'package:integrity_studio_ai/theme/decorations.dart';
import 'package:integrity_studio_ai/theme/spacing.dart';

void main() {
  group('AppDecorations', () {
    group('statusBadge', () {
      test('creates decoration with default opacity', () {
        final decoration = AppDecorations.statusBadge(AppColors.success);

        expect(decoration.borderRadius,
            equals(BorderRadius.circular(AppSpacing.radiusFull)));
        expect(decoration.border, isNotNull);
      });

      test('creates decoration with custom opacity', () {
        final decoration =
            AppDecorations.statusBadge(AppColors.success, opacity: 0.25);

        expect(decoration, isNotNull);
        expect(decoration.color, isNotNull);
      });

      test('uses radiusFull for pill shape', () {
        final decoration = AppDecorations.statusBadge(AppColors.info);

        expect(decoration.borderRadius,
            equals(BorderRadius.circular(AppSpacing.radiusFull)));
      });
    });

    group('chip', () {
      test('creates decoration with default values', () {
        final decoration = AppDecorations.chip();

        expect(decoration.color, equals(AppColors.gray800));
        expect(decoration.borderRadius,
            equals(BorderRadius.circular(AppSpacing.radiusSM)));
      });

      test('accepts custom background color', () {
        final decoration =
            AppDecorations.chip(backgroundColor: AppColors.blue500);

        expect(decoration.color, equals(AppColors.blue500));
      });

      test('accepts custom radius', () {
        final decoration = AppDecorations.chip(radius: 20.0);

        expect(decoration.borderRadius, equals(BorderRadius.circular(20.0)));
      });

      test('accepts both custom color and radius', () {
        final decoration = AppDecorations.chip(
          backgroundColor: AppColors.purple500,
          radius: 16.0,
        );

        expect(decoration.color, equals(AppColors.purple500));
        expect(decoration.borderRadius, equals(BorderRadius.circular(16.0)));
      });
    });

    group('gradientPill', () {
      test('creates decoration with default gradient', () {
        final decoration = AppDecorations.gradientPill();

        expect(decoration.gradient, equals(AppColors.primaryGradient));
        expect(decoration.borderRadius,
            equals(BorderRadius.circular(AppSpacing.radiusSM)));
      });

      test('accepts custom gradient', () {
        final decoration =
            AppDecorations.gradientPill(gradient: AppColors.accentGradient);

        expect(decoration.gradient, equals(AppColors.accentGradient));
      });

      test('accepts custom radius', () {
        final decoration = AppDecorations.gradientPill(radius: 24.0);

        expect(decoration.borderRadius, equals(BorderRadius.circular(24.0)));
      });
    });

    group('dot', () {
      test('creates circular decoration without glow', () {
        final decoration = AppDecorations.dot(AppColors.success);

        expect(decoration.color, equals(AppColors.success));
        expect(decoration.shape, equals(BoxShape.circle));
        expect(decoration.boxShadow, isNull);
      });

      test('creates circular decoration with glow', () {
        final decoration =
            AppDecorations.dot(AppColors.success, showGlow: true);

        expect(decoration.color, equals(AppColors.success));
        expect(decoration.shape, equals(BoxShape.circle));
        expect(decoration.boxShadow, isNotNull);
        expect(decoration.boxShadow!.length, equals(1));
      });

      test('glow shadow has correct blur and spread', () {
        final decoration = AppDecorations.dot(AppColors.info, showGlow: true);

        final shadow = decoration.boxShadow!.first;
        expect(shadow.blurRadius, equals(8));
        expect(shadow.spreadRadius, equals(2));
      });
    });

    group('static dot decorations', () {
      test('bulletDot has blue color and circle shape', () {
        expect(AppDecorations.bulletDot.color, equals(AppColors.blue500));
        expect(AppDecorations.bulletDot.shape, equals(BoxShape.circle));
      });

      test('separatorDot has gray color and circle shape', () {
        expect(AppDecorations.separatorDot.color, equals(AppColors.gray600));
        expect(AppDecorations.separatorDot.shape, equals(BoxShape.circle));
      });

      test('successDot has success color and circle shape', () {
        expect(AppDecorations.successDot.color, equals(AppColors.success));
        expect(AppDecorations.successDot.shape, equals(BoxShape.circle));
      });
    });

    group('card', () {
      test('creates decoration with default values', () {
        final decoration = AppDecorations.card();

        expect(decoration.color, equals(AppColors.gray800));
        expect(decoration.borderRadius,
            equals(BorderRadius.circular(AppSpacing.radiusMD)));
        expect(decoration.border, isNotNull);
      });

      test('accepts custom background color', () {
        final decoration =
            AppDecorations.card(backgroundColor: AppColors.gray700);

        expect(decoration.color, equals(AppColors.gray700));
      });

      test('accepts custom border color', () {
        final decoration =
            AppDecorations.card(borderColor: AppColors.blue500);

        expect(decoration.border, isNotNull);
      });

      test('accepts custom radius', () {
        final decoration = AppDecorations.card(radius: 16.0);

        expect(decoration.borderRadius, equals(BorderRadius.circular(16.0)));
      });
    });

    group('elevatedCard', () {
      test('creates decoration with shadow', () {
        final decoration = AppDecorations.elevatedCard();

        expect(decoration.color, equals(AppColors.gray800));
        expect(decoration.borderRadius,
            equals(BorderRadius.circular(AppSpacing.radiusLG)));
        expect(decoration.boxShadow, isNotNull);
        expect(decoration.boxShadow!.length, equals(1));
      });

      test('shadow has correct offset', () {
        final decoration = AppDecorations.elevatedCard();

        final shadow = decoration.boxShadow!.first;
        expect(shadow.offset, equals(const Offset(0, 4)));
        expect(shadow.blurRadius, equals(16));
      });

      test('accepts custom background color', () {
        final decoration =
            AppDecorations.elevatedCard(backgroundColor: AppColors.gray900);

        expect(decoration.color, equals(AppColors.gray900));
      });

      test('accepts custom radius', () {
        final decoration = AppDecorations.elevatedCard(radius: 24.0);

        expect(decoration.borderRadius, equals(BorderRadius.circular(24.0)));
      });
    });

    group('gradientBorderCard', () {
      test('creates decoration with default gradient', () {
        final decoration = AppDecorations.gradientBorderCard();

        expect(decoration.gradient, equals(AppColors.primaryGradient));
        expect(decoration.borderRadius,
            equals(BorderRadius.circular(AppSpacing.radiusXL)));
      });

      test('accepts custom gradient', () {
        final decoration = AppDecorations.gradientBorderCard(
            gradient: AppColors.accentGradient);

        expect(decoration.gradient, equals(AppColors.accentGradient));
      });

      test('accepts custom radius', () {
        final decoration = AppDecorations.gradientBorderCard(radius: 32.0);

        expect(decoration.borderRadius, equals(BorderRadius.circular(32.0)));
      });
    });

    group('static background decorations', () {
      test('gradientBackground uses backgroundGradient', () {
        expect(AppDecorations.gradientBackground.gradient,
            equals(AppColors.backgroundGradient));
      });

      test('primaryGradientBackground uses primaryGradient', () {
        expect(AppDecorations.primaryGradientBackground.gradient,
            equals(AppColors.primaryGradient));
      });
    });

    group('gradientIconBox', () {
      test('creates decoration with default values', () {
        final decoration = AppDecorations.gradientIconBox();

        expect(decoration.gradient, equals(AppColors.primaryGradient));
        expect(decoration.borderRadius,
            equals(BorderRadius.circular(AppSpacing.radiusLG)));
      });

      test('accepts custom gradient', () {
        final decoration =
            AppDecorations.gradientIconBox(gradient: AppColors.accentGradient);

        expect(decoration.gradient, equals(AppColors.accentGradient));
      });

      test('accepts custom radius', () {
        final decoration = AppDecorations.gradientIconBox(radius: 8.0);

        expect(decoration.borderRadius, equals(BorderRadius.circular(8.0)));
      });
    });

    group('iconBox', () {
      test('creates decoration with default values', () {
        final decoration = AppDecorations.iconBox();

        expect(decoration.color, equals(AppColors.gray700));
        expect(decoration.borderRadius,
            equals(BorderRadius.circular(AppSpacing.radiusMD)));
      });

      test('accepts custom background color', () {
        final decoration =
            AppDecorations.iconBox(backgroundColor: AppColors.blue500);

        expect(decoration.color, equals(AppColors.blue500));
      });

      test('accepts custom radius', () {
        final decoration = AppDecorations.iconBox(radius: 12.0);

        expect(decoration.borderRadius, equals(BorderRadius.circular(12.0)));
      });
    });

    group('translucentIconBox', () {
      test('creates decoration with default opacity', () {
        final decoration =
            AppDecorations.translucentIconBox(AppColors.blue500);

        expect(decoration.borderRadius,
            equals(BorderRadius.circular(AppSpacing.radiusMD)));
      });

      test('accepts custom opacity', () {
        final decoration =
            AppDecorations.translucentIconBox(AppColors.blue500, opacity: 0.3);

        expect(decoration.color, isNotNull);
      });

      test('accepts custom radius', () {
        final decoration =
            AppDecorations.translucentIconBox(AppColors.purple500, radius: 16.0);

        expect(decoration.borderRadius, equals(BorderRadius.circular(16.0)));
      });

      test('accepts all custom parameters', () {
        final decoration = AppDecorations.translucentIconBox(
          AppColors.success,
          opacity: 0.25,
          radius: 20.0,
        );

        expect(decoration.borderRadius, equals(BorderRadius.circular(20.0)));
        expect(decoration.color, isNotNull);
      });
    });
  });
}
