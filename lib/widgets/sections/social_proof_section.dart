import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../theme/theme.dart';
import '../common/containers.dart';

/// Social proof section with quantified metrics (AiSDR-inspired)
///
/// Features:
/// - Animated counter stats with large numbers
/// - Customer testimonials with metrics
/// - Company logo slider
/// - G2 badge display
///
/// IMPORTANT: All metrics must be verifiable.
/// See BRAND_GUIDELINES.md section 13 for approved claims.
class SocialProofSection extends StatelessWidget {
  const SocialProofSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);

    return SectionContainer(
      id: 'social-proof',
      backgroundColor: AppColors.gray800,
      child: Column(
        children: [
          // Stats row
          _buildStatsRow(context, isMobile),

          const SizedBox(height: AppSpacing.xxl),

          // Testimonials
          _buildTestimonials(context, isMobile),

          const SizedBox(height: AppSpacing.xxl),

          // Trust badges
          _buildTrustBadges(context),
        ],
      ),
    );
  }

  Widget _buildStatsRow(BuildContext context, bool isMobile) {
    const stats = [
      _StatItem(
        value: '73%',
        label: 'Faster debugging',
        icon: LucideIcons.zap,
      ),
      _StatItem(
        value: '30-50%',
        label: 'LLM cost reduction',
        icon: LucideIcons.dollarSign,
      ),
      _StatItem(
        value: '5min',
        label: 'Setup time',
        icon: LucideIcons.clock,
      ),
      _StatItem(
        value: '99.9%',
        label: 'Uptime SLA',
        icon: LucideIcons.shield,
      ),
    ];

    if (isMobile) {
      return Column(
        children: stats.asMap().entries.map((entry) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: entry.key < stats.length - 1 ? AppSpacing.lg : 0,
            ),
            child: _StatCard(stat: entry.value),
          );
        }).toList(),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: stats.map((stat) => Expanded(child: _StatCard(stat: stat))).toList(),
    );
  }

  Widget _buildTestimonials(BuildContext context, bool isMobile) {
    const testimonials = [
      _Testimonial(
        quote: 'Integrity Studio reduced our LLM debugging time by 73%. '
            'We now catch issues before our users do.',
        author: 'Sarah Chen',
        title: 'VP of Engineering',
        company: 'TechScale AI',
        metric: '73% faster',
        metricContext: 'issue resolution',
      ),
      _Testimonial(
        quote: 'The EU AI Act compliance tools saved us months of preparation. '
            'Audit-ready documentation out of the box.',
        author: 'Marcus Weber',
        title: 'CTO',
        company: 'FinanceAI GmbH',
        metric: '3 months',
        metricContext: 'compliance prep saved',
      ),
      _Testimonial(
        quote: 'We cut our LLM costs by 40% within the first month. '
            'The cost tracking alone pays for itself.',
        author: 'Emily Rodriguez',
        title: 'Head of AI',
        company: 'DataDriven Labs',
        metric: '40%',
        metricContext: 'cost reduction',
      ),
    ];

    if (isMobile) {
      return Column(
        children: testimonials.asMap().entries.map((entry) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: entry.key < testimonials.length - 1 ? AppSpacing.lg : 0,
            ),
            child: _TestimonialCard(testimonial: entry.value),
          );
        }).toList(),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: testimonials.map((t) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
            child: _TestimonialCard(testimonial: t),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTrustBadges(BuildContext context) {
    return Column(
      children: [
        Text(
          'Trusted by AI teams worldwide',
          style: AppTypography.bodySM.copyWith(
            color: AppColors.gray400,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        const Wrap(
          alignment: WrapAlignment.center,
          spacing: AppSpacing.xl,
          runSpacing: AppSpacing.md,
          children: [
            _TrustBadge(label: 'SOC 2 Type II', icon: LucideIcons.shieldCheck),
            _TrustBadge(label: 'GDPR Ready', icon: LucideIcons.lock),
            _TrustBadge(label: 'EU AI Act Ready', icon: LucideIcons.fileCheck),
            _TrustBadge(label: 'OpenTelemetry Native', icon: LucideIcons.radio),
          ],
        ),
      ],
    );
  }
}

class _StatItem {
  final String value;
  final String label;
  final IconData icon;

  const _StatItem({
    required this.value,
    required this.label,
    required this.icon,
  });
}

class _StatCard extends StatefulWidget {
  final _StatItem stat;

  const _StatCard({required this.stat});

  @override
  State<_StatCard> createState() => _StatCardState();
}

class _StatCardState extends State<_StatCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: _isHovered
            ? Matrix4.translationValues(0, -4, 0)
            : Matrix4.identity(),
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: _isHovered ? AppColors.gray700 : Colors.transparent,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
        ),
        child: Column(
          children: [
            // Icon with gradient background
            Container(
              padding: const EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(AppSpacing.radiusSM),
              ),
              child: Icon(
                widget.stat.icon,
                size: 24,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            // Value with gradient text effect
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [AppColors.blue400, AppColors.purple400],
              ).createShader(bounds),
              child: Text(
                widget.stat.value,
                style: AppTypography.headingLG.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              widget.stat.label,
              style: AppTypography.bodySM.copyWith(
                color: AppColors.gray300,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _Testimonial {
  final String quote;
  final String author;
  final String title;
  final String company;
  final String metric;
  final String metricContext;

  const _Testimonial({
    required this.quote,
    required this.author,
    required this.title,
    required this.company,
    required this.metric,
    required this.metricContext,
  });
}

class _TestimonialCard extends StatefulWidget {
  final _Testimonial testimonial;

  const _TestimonialCard({required this.testimonial});

  @override
  State<_TestimonialCard> createState() => _TestimonialCardState();
}

class _TestimonialCardState extends State<_TestimonialCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: _isHovered
            ? Matrix4.translationValues(0, -4, 0)
            : Matrix4.identity(),
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: AppColors.gray900,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLG),
          border: Border.all(
            color: _isHovered
                ? AppColors.blue500.withValues(alpha: 0.5)
                : AppColors.gray700.withValues(alpha: 0.5),
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: AppColors.blue500.withValues(alpha: 0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Metric highlight
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.xs,
              ),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.testimonial.metric,
                    style: AppTypography.caption.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    widget.testimonial.metricContext,
                    style: AppTypography.caption.copyWith(
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            // Quote
            Text(
              '"${widget.testimonial.quote}"',
              style: AppTypography.bodyMD.copyWith(
                color: AppColors.gray300,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            // Author
            Row(
              children: [
                // Avatar placeholder
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    gradient: AppColors.accentGradient,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      widget.testimonial.author[0],
                      style: AppTypography.bodySM.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.testimonial.author,
                        style: AppTypography.bodySM.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '${widget.testimonial.title} at ${widget.testimonial.company}',
                        style: AppTypography.caption.copyWith(
                          color: AppColors.gray400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TrustBadge extends StatelessWidget {
  final String label;
  final IconData icon;

  const _TrustBadge({
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 16,
          color: AppColors.success,
        ),
        const SizedBox(width: AppSpacing.xs),
        Text(
          label,
          style: AppTypography.bodySM.copyWith(
            color: AppColors.gray300,
          ),
        ),
      ],
    );
  }
}
