import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../theme/theme.dart';
import '../../services/analytics.dart';
import '../common/buttons.dart';
import '../common/containers.dart';
import '../decorative/animated_orb.dart';

/// Hero section with gradient background and decorative orbs
///
/// Features:
/// - Animated gradient orbs (respects reduced motion)
/// - Responsive typography
/// - CTA buttons with analytics tracking
/// - Semantic structure with h1 heading
///
/// Usage:
/// ```dart
/// HeroSection(
///   onGetStarted: () => scrollTo('pricing'),
///   onWatchDemo: () => openDemo(),
/// )
/// ```
class HeroSection extends StatelessWidget {
  final VoidCallback? onGetStarted;
  final VoidCallback? onWatchDemo;

  const HeroSection({
    super.key,
    this.onGetStarted,
    this.onWatchDemo,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    final isTablet = ResponsiveUtils.isTablet(context);

    return Container(
      decoration: const BoxDecoration(
        gradient: AppColors.backgroundGradient,
      ),
      child: Stack(
        children: [
          // Decorative orbs
          const DecorativeOrbs(),

          // Content
          SectionContainer(
            id: 'hero',
            padding: EdgeInsets.symmetric(
              vertical: isMobile ? 80 : 120,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Badge
                _buildBadge(),

                SizedBox(height: isMobile ? AppSpacing.lg : AppSpacing.xl),

                // Headline
                _buildHeadline(context, isMobile),

                SizedBox(height: isMobile ? AppSpacing.md : AppSpacing.lg),

                // Subheadline
                _buildSubheadline(context, isMobile, isTablet),

                SizedBox(height: isMobile ? AppSpacing.xl : AppSpacing.xxl),

                // CTAs
                _buildCTAs(context, isMobile),

                SizedBox(height: isMobile ? AppSpacing.xl : AppSpacing.xxl),

                // Trust indicators
                _buildTrustIndicators(context, isMobile),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.blue500.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
        border: Border.all(
          color: AppColors.blue500.withOpacity(0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: AppColors.success,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(
            'AI Observability Platform',
            style: AppTypography.caption.copyWith(
              color: AppColors.blue400,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeadline(BuildContext context, bool isMobile) {
    return Semantics(
      header: true,
      child: Text(
        'Understand Your\nAI in Production',
        style: isMobile
            ? AppTypography.headingXL.copyWith(fontSize: 36)
            : AppTypography.headingXL,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildSubheadline(BuildContext context, bool isMobile, bool isTablet) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: isMobile ? double.infinity : (isTablet ? 500 : 600),
      ),
      child: Text(
        'Enterprise-grade observability for LLM applications. '
        'Monitor performance, track costs, and debug issues '
        'with comprehensive tracing and analytics.',
        style: AppTypography.bodyLG,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildCTAs(BuildContext context, bool isMobile) {
    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GradientButton(
            text: 'Start Free Trial',
            icon: LucideIcons.arrowRight,
            onPressed: () {
              AnalyticsService.trackCTAClick(
                buttonName: 'Start Free Trial',
                location: 'hero',
                ctaType: 'primary',
              );
              onGetStarted?.call();
            },
            fullWidth: true,
          ),
          const SizedBox(height: AppSpacing.md),
          OutlineButton(
            text: 'Watch Demo',
            icon: LucideIcons.play,
            onPressed: () {
              AnalyticsService.trackCTAClick(
                buttonName: 'Watch Demo',
                location: 'hero',
                ctaType: 'secondary',
              );
              onWatchDemo?.call();
            },
            fullWidth: true,
          ),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GradientButton(
          text: 'Start Free Trial',
          icon: LucideIcons.arrowRight,
          onPressed: () {
            AnalyticsService.trackCTAClick(
              buttonName: 'Start Free Trial',
              location: 'hero',
              ctaType: 'primary',
            );
            onGetStarted?.call();
          },
        ),
        const SizedBox(width: AppSpacing.md),
        OutlineButton(
          text: 'Watch Demo',
          icon: LucideIcons.play,
          onPressed: () {
            AnalyticsService.trackCTAClick(
              buttonName: 'Watch Demo',
              location: 'hero',
              ctaType: 'secondary',
            );
            onWatchDemo?.call();
          },
        ),
      ],
    );
  }

  Widget _buildTrustIndicators(BuildContext context, bool isMobile) {
    final indicators = [
      'No credit card required',
      '14-day free trial',
      'Cancel anytime',
    ];

    if (isMobile) {
      return Column(
        children: indicators
            .map((text) => Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                  child: _TrustIndicator(text: text),
                ))
            .toList(),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: indicators.asMap().entries.map((entry) {
        final isLast = entry.key == indicators.length - 1;
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _TrustIndicator(text: entry.value),
            if (!isLast) ...[
              const SizedBox(width: AppSpacing.md),
              Container(
                width: 4,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.gray600,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
            ],
          ],
        );
      }).toList(),
    );
  }
}

class _TrustIndicator extends StatelessWidget {
  final String text;

  const _TrustIndicator({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          LucideIcons.check,
          size: 16,
          color: AppColors.success,
        ),
        const SizedBox(width: AppSpacing.xs),
        Text(
          text,
          style: AppTypography.bodySM.copyWith(
            color: AppColors.gray400,
          ),
        ),
      ],
    );
  }
}
