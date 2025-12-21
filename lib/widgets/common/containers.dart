import 'package:flutter/material.dart';
import '../../theme/theme.dart';

/// Responsive container with max-width and horizontal padding
///
/// Automatically adjusts padding based on screen size:
/// - Mobile: 16px
/// - Tablet: 24px
/// - Desktop: 32px
///
/// Usage:
/// ```dart
/// ResponsiveContainer(
///   child: Column(children: [...]),
/// )
/// ```
class ResponsiveContainer extends StatelessWidget {
  final Widget child;
  final double? maxWidth;
  final bool useSafeArea;
  final EdgeInsets? additionalPadding;

  const ResponsiveContainer({
    super.key,
    required this.child,
    this.maxWidth,
    this.useSafeArea = false,
    this.additionalPadding,
  });

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxWidth ?? AppSpacing.containerMaxWidth,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.containerPadding(context),
          ).add(additionalPadding ?? EdgeInsets.zero),
          child: child,
        ),
      ),
    );

    if (useSafeArea) {
      content = SafeArea(child: content);
    }

    return content;
  }
}

/// Section container with vertical padding and optional background
///
/// Usage:
/// ```dart
/// SectionContainer(
///   id: 'features',
///   backgroundColor: AppColors.gray800,
///   child: FeaturesContent(),
/// )
/// ```
class SectionContainer extends StatelessWidget {
  final String? id;
  final Widget child;
  final Color? backgroundColor;
  final Gradient? backgroundGradient;
  final EdgeInsets? padding;
  final bool useResponsiveContainer;

  const SectionContainer({
    super.key,
    this.id,
    required this.child,
    this.backgroundColor,
    this.backgroundGradient,
    this.padding,
    this.useResponsiveContainer = true,
  });

  @override
  Widget build(BuildContext context) {
    final sectionPadding = padding ??
        EdgeInsets.symmetric(
          vertical: AppSpacing.sectionPadding(context),
        );

    Widget content = Padding(
      padding: sectionPadding,
      child: useResponsiveContainer
          ? ResponsiveContainer(child: child)
          : child,
    );

    if (backgroundColor != null || backgroundGradient != null) {
      content = Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          gradient: backgroundGradient,
        ),
        child: content,
      );
    }

    if (id != null) {
      return Semantics(
        container: true,
        label: '$id section',
        child: content,
      );
    }

    return content;
  }
}

/// Section title with optional subtitle
///
/// Usage:
/// ```dart
/// SectionTitle(
///   title: 'Platform Features',
///   subtitle: 'Everything you need for AI observability',
///   alignment: CrossAxisAlignment.center,
/// )
/// ```
class SectionTitle extends StatelessWidget {
  final String title;
  final String? subtitle;
  final CrossAxisAlignment alignment;
  final TextAlign? textAlign;

  const SectionTitle({
    super.key,
    required this.title,
    this.subtitle,
    this.alignment = CrossAxisAlignment.center,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveTextAlign = textAlign ??
        (alignment == CrossAxisAlignment.center
            ? TextAlign.center
            : TextAlign.left);

    return Column(
      crossAxisAlignment: alignment,
      children: [
        Semantics(
          header: true,
          child: Text(
            title,
            style: AppTypography.headingMDResponsive(context),
            textAlign: effectiveTextAlign,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: AppSpacing.md),
          Text(
            subtitle!,
            style: AppTypography.bodyLG,
            textAlign: effectiveTextAlign,
          ),
        ],
      ],
    );
  }
}

/// Responsive grid that adjusts columns based on screen size
///
/// Usage:
/// ```dart
/// ResponsiveGrid(
///   children: features.map((f) => FeatureCard(feature: f)).toList(),
/// )
/// ```
class ResponsiveGrid extends StatelessWidget {
  final List<Widget> children;
  final int? mobileColumns;
  final int? tabletColumns;
  final int? desktopColumns;
  final double spacing;
  final double runSpacing;

  const ResponsiveGrid({
    super.key,
    required this.children,
    this.mobileColumns,
    this.tabletColumns,
    this.desktopColumns,
    this.spacing = AppSpacing.lg,
    this.runSpacing = AppSpacing.lg,
  });

  @override
  Widget build(BuildContext context) {
    final columns = ResponsiveUtils.responsive(
      context,
      mobile: mobileColumns ?? 1,
      tablet: tabletColumns ?? 2,
      desktop: desktopColumns ?? 3,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth =
            (constraints.maxWidth - (spacing * (columns - 1))) / columns;

        return Wrap(
          spacing: spacing,
          runSpacing: runSpacing,
          children: children.map((child) {
            return SizedBox(
              width: itemWidth,
              child: child,
            );
          }).toList(),
        );
      },
    );
  }
}

/// Gradient background container with optional decorative orbs
///
/// Usage:
/// ```dart
/// GradientBackground(
///   showOrbs: true,
///   child: HeroContent(),
/// )
/// ```
class GradientBackground extends StatelessWidget {
  final Widget child;
  final Gradient? gradient;
  final bool showOrbs;
  final double? orbOpacity;

  const GradientBackground({
    super.key,
    required this.child,
    this.gradient,
    this.showOrbs = false,
    this.orbOpacity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradient ?? AppColors.backgroundGradient,
      ),
      child: Stack(
        children: [
          if (showOrbs) ...[
            // Top-left orb
            Positioned(
              left: -80,
              top: -80,
              child: Container(
                width: 256,
                height: 256,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.blue500.withValues(alpha: orbOpacity ?? 0.15),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            // Bottom-right orb
            Positioned(
              right: -60,
              bottom: 100,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.indigo500.withValues(alpha: orbOpacity ?? 0.15),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ],
          child,
        ],
      ),
    );
  }
}

/// Divider with optional label
///
/// Usage:
/// ```dart
/// LabeledDivider(label: 'or')
/// ```
class LabeledDivider extends StatelessWidget {
  final String? label;
  final Color? color;

  const LabeledDivider({
    super.key,
    this.label,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    if (label == null) {
      return Divider(color: color ?? AppColors.gray700);
    }

    return Row(
      children: [
        Expanded(child: Divider(color: color ?? AppColors.gray700)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Text(
            label!,
            style: AppTypography.caption,
          ),
        ),
        Expanded(child: Divider(color: color ?? AppColors.gray700)),
      ],
    );
  }
}
