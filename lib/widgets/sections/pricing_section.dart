import 'package:flutter/material.dart';
import '../../theme/theme.dart';
import '../../services/analytics.dart';
import '../common/cards.dart';
import '../common/containers.dart';

/// Pricing section with tier comparison
///
/// LEGAL NOTE: All pricing and features should be accurate.
/// Update this section when pricing changes.
///
/// Usage:
/// ```dart
/// PricingSection(
///   onSelectTier: (tier) => navigateToSignup(tier),
/// )
/// ```
class PricingSection extends StatefulWidget {
  final void Function(String tier)? onSelectTier;

  const PricingSection({
    super.key,
    this.onSelectTier,
  });

  @override
  State<PricingSection> createState() => _PricingSectionState();
}

class _PricingSectionState extends State<PricingSection> {
  bool _isAnnual = true;

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);

    return SectionContainer(
      id: 'pricing',
      child: Column(
        children: [
          // Section header
          const SectionTitle(
            title: 'Simple, Transparent Pricing',
            subtitle: 'Start free, scale as you grow',
          ),

          const SizedBox(height: AppSpacing.xl),

          // Billing toggle
          _buildBillingToggle(),

          SizedBox(height: AppSpacing.sectionPadding(context) * 0.5),

          // Pricing cards
          if (isMobile)
            _buildMobilePricing()
          else
            _buildDesktopPricing(),

          const SizedBox(height: AppSpacing.xl),

          // Enterprise note
          _buildEnterpriseNote(),
        ],
      ),
    );
  }

  Widget _buildBillingToggle() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xs),
      decoration: BoxDecoration(
        color: AppColors.gray800,
        borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _BillingOption(
            label: 'Monthly',
            isSelected: !_isAnnual,
            onTap: () {
              setState(() => _isAnnual = false);
              AnalyticsService.trackPricingToggle(isAnnual: false);
            },
          ),
          _BillingOption(
            label: 'Annual',
            isSelected: _isAnnual,
            badge: 'Save 20%',
            onTap: () {
              setState(() => _isAnnual = true);
              AnalyticsService.trackPricingToggle(isAnnual: true);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopPricing() {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _pricingTiers.map((tier) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
              child: PricingCard(
                tier: tier.name,
                price: _isAnnual ? tier.annualPrice : tier.monthlyPrice,
                period: tier.period,
                description: tier.description,
                features: tier.features,
                isPopular: tier.isPopular,
                ctaText: tier.ctaText,
                onCtaPressed: () {
                  AnalyticsService.trackPricingView(tier.name);
                  widget.onSelectTier?.call(tier.name);
                },
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildMobilePricing() {
    return Column(
      children: _pricingTiers.map((tier) {
        return Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.lg),
          child: SizedBox(
            height: 520,
            child: PricingCard(
              tier: tier.name,
              price: _isAnnual ? tier.annualPrice : tier.monthlyPrice,
              period: tier.period,
              description: tier.description,
              features: tier.features,
              isPopular: tier.isPopular,
              ctaText: tier.ctaText,
              onCtaPressed: () {
                AnalyticsService.trackPricingView(tier.name);
                widget.onSelectTier?.call(tier.name);
              },
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildEnterpriseNote() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.gray800.withOpacity(0.5),
        borderRadius: BorderRadius.circular(AppSpacing.radiusLG),
        border: Border.all(color: AppColors.gray700),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Text(
              'Need custom solutions? ',
              style: AppTypography.bodyMD,
            ),
          ),
          TextButton(
            onPressed: () {
              AnalyticsService.trackCTAClick(
                buttonName: 'Contact Sales',
                location: 'pricing',
                ctaType: 'text',
              );
            },
            child: Text(
              'Contact our sales team',
              style: AppTypography.bodyMD.copyWith(
                color: AppColors.textLink,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BillingOption extends StatelessWidget {
  final String label;
  final bool isSelected;
  final String? badge;
  final VoidCallback onTap;

  const _BillingOption({
    required this.label,
    required this.isSelected,
    this.badge,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.gray700 : Colors.transparent,
          borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: AppTypography.buttonText.copyWith(
                color: isSelected ? AppColors.textPrimary : AppColors.gray400,
              ),
            ),
            if (badge != null) ...[
              const SizedBox(width: AppSpacing.xs),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusSM),
                ),
                child: Text(
                  badge!,
                  style: AppTypography.caption.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _PricingTier {
  final String name;
  final String monthlyPrice;
  final String annualPrice;
  final String? period;
  final String? description;
  final List<String> features;
  final bool isPopular;
  final String ctaText;

  const _PricingTier({
    required this.name,
    required this.monthlyPrice,
    required this.annualPrice,
    this.period,
    this.description,
    required this.features,
    this.isPopular = false,
    required this.ctaText,
  });
}

const List<_PricingTier> _pricingTiers = [
  _PricingTier(
    name: 'Starter',
    monthlyPrice: 'Free',
    annualPrice: 'Free',
    description: 'For individual developers',
    features: [
      '10K traces/month',
      '7-day retention',
      'Basic dashboards',
      'Email support',
      'Community access',
    ],
    ctaText: 'Get Started',
  ),
  _PricingTier(
    name: 'Team',
    monthlyPrice: '\$99',
    annualPrice: '\$79',
    period: '/month',
    description: 'For growing teams',
    features: [
      '100K traces/month',
      '30-day retention',
      'Advanced analytics',
      'Priority support',
      'Team collaboration',
      'Custom alerts',
    ],
    isPopular: true,
    ctaText: 'Start Free Trial',
  ),
  _PricingTier(
    name: 'Enterprise',
    monthlyPrice: 'Custom',
    annualPrice: 'Custom',
    description: 'For large organizations',
    features: [
      'Unlimited traces',
      '1-year retention',
      'SSO/SAML',
      'Dedicated support',
      'Custom integrations',
      'SLA guarantee',
      'On-premise option',
    ],
    ctaText: 'Contact Sales',
  ),
];
