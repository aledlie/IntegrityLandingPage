import 'package:flutter/material.dart';
import 'colors.dart';
import 'spacing.dart';

/// Reusable BoxDecoration patterns for Integrity Studio
///
/// Consolidates common decoration patterns to reduce code duplication
/// and ensure consistent styling across the app.
///
/// Usage:
/// ```dart
/// Container(
///   decoration: AppDecorations.statusBadge(AppColors.success),
///   child: Text('Operational'),
/// )
/// ```
class AppDecorations {
  AppDecorations._();

  // ===========================================================================
  // Status/Badge Decorations
  // ===========================================================================

  /// Status badge with translucent background and matching border.
  ///
  /// Used for: operational status badges, category tags, feature badges.
  /// Typically paired with `radiusFull` for pill shape.
  static BoxDecoration statusBadge(Color color, {double opacity = 0.15}) {
    return BoxDecoration(
      color: color.withValues(alpha: opacity),
      borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    );
  }

  /// Simple chip/tag with solid background.
  ///
  /// Used for: category chips, filter tags, small labels.
  static BoxDecoration chip({
    Color? backgroundColor,
    double radius = AppSpacing.radiusSM,
  }) {
    return BoxDecoration(
      color: backgroundColor ?? AppColors.gray800,
      borderRadius: BorderRadius.circular(radius),
    );
  }

  /// Gradient pill badge.
  ///
  /// Used for: "Most Popular" tags, highlighted badges.
  static BoxDecoration gradientPill({
    Gradient? gradient,
    double radius = AppSpacing.radiusSM,
  }) {
    return BoxDecoration(
      gradient: gradient ?? AppColors.primaryGradient,
      borderRadius: BorderRadius.circular(radius),
    );
  }

  // ===========================================================================
  // Dot/Indicator Decorations
  // ===========================================================================

  /// Circular dot indicator.
  ///
  /// Used for: status dots, bullet points, separators.
  static BoxDecoration dot(Color color, {bool showGlow = false}) {
    return BoxDecoration(
      color: color,
      shape: BoxShape.circle,
      boxShadow: showGlow
          ? [
              BoxShadow(
                color: color.withValues(alpha: 0.4),
                blurRadius: 8,
                spreadRadius: 2,
              ),
            ]
          : null,
    );
  }

  /// Blue bullet point dot (for feature lists).
  static const BoxDecoration bulletDot = BoxDecoration(
    color: AppColors.blue500,
    shape: BoxShape.circle,
  );

  /// Gray separator dot.
  static const BoxDecoration separatorDot = BoxDecoration(
    color: AppColors.gray600,
    shape: BoxShape.circle,
  );

  /// Success (green) status dot.
  static const BoxDecoration successDot = BoxDecoration(
    color: AppColors.success,
    shape: BoxShape.circle,
  );

  // ===========================================================================
  // Card/Container Decorations
  // ===========================================================================

  /// Standard card with border.
  ///
  /// Used for: content cards, info boxes, form containers.
  static BoxDecoration card({
    Color? backgroundColor,
    Color? borderColor,
    double radius = AppSpacing.radiusMD,
  }) {
    return BoxDecoration(
      color: backgroundColor ?? AppColors.gray800,
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: borderColor ?? AppColors.borderDefault),
    );
  }

  /// Elevated card with shadow.
  ///
  /// Used for: prominent cards, modals, dropdowns.
  static BoxDecoration elevatedCard({
    Color? backgroundColor,
    double radius = AppSpacing.radiusLG,
  }) {
    return BoxDecoration(
      color: backgroundColor ?? AppColors.gray800,
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: AppColors.borderDefault),
      boxShadow: [
        BoxShadow(
          color: AppColors.shadowDefault,
          blurRadius: 16,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }

  /// Gradient bordered container.
  ///
  /// Used for: CTA sections, highlighted containers.
  static BoxDecoration gradientBorderCard({
    Gradient? gradient,
    double radius = AppSpacing.radiusXL,
  }) {
    return BoxDecoration(
      gradient: gradient ?? AppColors.primaryGradient,
      borderRadius: BorderRadius.circular(radius),
    );
  }

  // ===========================================================================
  // Background Decorations
  // ===========================================================================

  /// Standard gradient background.
  static const BoxDecoration gradientBackground = BoxDecoration(
    gradient: AppColors.backgroundGradient,
  );

  /// Primary gradient background.
  static const BoxDecoration primaryGradientBackground = BoxDecoration(
    gradient: AppColors.primaryGradient,
  );

  // ===========================================================================
  // Icon Container Decorations
  // ===========================================================================

  /// Gradient icon container (48x48 default).
  ///
  /// Used for: feature icons, service icons.
  static BoxDecoration gradientIconBox({
    Gradient? gradient,
    double radius = AppSpacing.radiusLG,
  }) {
    return BoxDecoration(
      gradient: gradient ?? AppColors.primaryGradient,
      borderRadius: BorderRadius.circular(radius),
    );
  }

  /// Subtle icon container with border.
  ///
  /// Used for: secondary icons, form field icons.
  static BoxDecoration iconBox({
    Color? backgroundColor,
    double radius = AppSpacing.radiusMD,
  }) {
    return BoxDecoration(
      color: backgroundColor ?? AppColors.gray700,
      borderRadius: BorderRadius.circular(radius),
    );
  }

  /// Translucent colored icon container.
  ///
  /// Used for: mission/vision icons, colored accent containers.
  static BoxDecoration translucentIconBox(
    Color color, {
    double opacity = 0.15,
    double radius = AppSpacing.radiusMD,
  }) {
    return BoxDecoration(
      color: color.withValues(alpha: opacity),
      borderRadius: BorderRadius.circular(radius),
    );
  }
}
