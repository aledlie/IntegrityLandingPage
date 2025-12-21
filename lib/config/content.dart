import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

/// Centralized content configuration for landing page.
///
/// This file externalizes all hardcoded content from widgets,
/// enabling A/B testing, easy content updates, and localization readiness.
///
/// Based on Content Strategy Audit 2025-12-16:
/// - EU AI Act compliance positioning (white space opportunity)
/// - Updated trust indicators (credibility signals vs trial terms)
/// - Increased free tier (50K traces per recommendation)

// ============================================================================
// HERO SECTION CONTENT
// ============================================================================

/// Hero section content with A/B testing variants.
@immutable
class HeroContent {
  final String badge;
  final String headline;
  final String subheadline;
  final String primaryCTA;
  final String secondaryCTA;
  final List<String> trustIndicators;

  const HeroContent({
    required this.badge,
    required this.headline,
    required this.subheadline,
    required this.primaryCTA,
    required this.secondaryCTA,
    required this.trustIndicators,
  });

  /// Current production content (EU AI Act positioning)
  /// Rationale: White space opportunity - no competitor owns compliance messaging
  static const current = HeroContent(
    badge: 'EU AI Act Ready',
    headline: 'AI Observability That\nProves Compliance',
    subheadline:
        'Full traceability for every LLM decision. '
        'Automated risk documentation. Audit-ready from day one. '
        'Enterprise-grade monitoring with compliance built-in.',
    primaryCTA: 'Start Free Trial',
    secondaryCTA: 'Watch Demo',
    trustIndicators: [
      'EU AI Act Ready',
      'SOC 2 Type II',
      '99.9% Uptime',
      '5-min Setup',
    ],
  );

  /// Variant B: Agent-first positioning
  /// For A/B testing - targets agentic AI category
  static const variantAgentFirst = HeroContent(
    badge: 'AI Observability Platform',
    headline: 'See Every Decision\nYour AI Agents Make',
    subheadline:
        'End-to-end visibility into your AI agent workflows. '
        'Track performance, debug issues, and optimize costs '
        'with comprehensive tracing and analytics.',
    primaryCTA: 'Start Free Trial',
    secondaryCTA: 'Watch Demo',
    trustIndicators: [
      'EU AI Act Ready',
      'SOC 2 Type II',
      '99.9% Uptime',
      '5-min Setup',
    ],
  );

  /// Variant C: Cost-focused positioning
  /// For A/B testing - targets FinOps-conscious buyers
  static const variantCostFocused = HeroContent(
    badge: 'LLM Cost Intelligence',
    headline: 'Know Your AI Spend\nBefore It Surprises You',
    subheadline:
        'Real-time cost tracking for every LLM call. '
        'Set budgets, get alerts, and optimize spend '
        'with granular token-level attribution.',
    primaryCTA: 'Start Free Trial',
    secondaryCTA: 'Watch Demo',
    trustIndicators: [
      'EU AI Act Ready',
      'SOC 2 Type II',
      '99.9% Uptime',
      '5-min Setup',
    ],
  );

  /// Legacy content (pre-audit) - kept for rollback
  static const legacy = HeroContent(
    badge: 'AI Observability Platform',
    headline: 'Understand Your\nAI in Production',
    subheadline:
        'Enterprise-grade observability for LLM applications. '
        'Monitor performance, track costs, and debug issues '
        'with comprehensive tracing and analytics.',
    primaryCTA: 'Start Free Trial',
    secondaryCTA: 'Watch Demo',
    trustIndicators: [
      'No credit card required',
      '14-day free trial',
      'Cancel anytime',
    ],
  );
}

// ============================================================================
// PRICING SECTION CONTENT
// ============================================================================

/// Pricing tier data structure.
@immutable
class PricingTierContent {
  final String name;
  final String monthlyPrice;
  final String annualPrice;
  final String? period;
  final String? description;
  final List<String> features;
  final bool isPopular;
  final String ctaText;

  const PricingTierContent({
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

/// Pricing section content configuration.
@immutable
class PricingContent {
  final String title;
  final String subtitle;
  final String monthlyLabel;
  final String annualLabel;
  final String annualBadge;
  final String enterpriseNote;
  final String enterpriseLink;
  final List<PricingTierContent> tiers;

  const PricingContent({
    required this.title,
    required this.subtitle,
    required this.monthlyLabel,
    required this.annualLabel,
    required this.annualBadge,
    required this.enterpriseNote,
    required this.enterpriseLink,
    required this.tiers,
  });

  /// Current production content
  /// Updated per audit: 50K traces free tier (vs 10K)
  static const current = PricingContent(
    title: 'Simple, Transparent Pricing',
    subtitle: 'Start free, scale as you grow',
    monthlyLabel: 'Monthly',
    annualLabel: 'Annual',
    annualBadge: 'Save 20%',
    enterpriseNote: 'Need custom solutions? ',
    enterpriseLink: 'Contact our sales team',
    tiers: [
      PricingTierContent(
        name: 'Starter',
        monthlyPrice: 'Free',
        annualPrice: 'Free',
        description: 'For individual developers',
        features: [
          '50K traces/month', // Increased from 10K per audit
          '7-day retention',
          'Basic dashboards',
          'Email support',
          'Community access',
        ],
        ctaText: 'Get Started',
      ),
      PricingTierContent(
        name: 'Team',
        monthlyPrice: '\$99',
        annualPrice: '\$79',
        period: '/month',
        description: 'For growing teams',
        features: [
          '500K traces/month', // Scaled up proportionally
          '30-day retention',
          'Advanced analytics',
          'Priority support',
          'Team collaboration',
          'Custom alerts',
          'EU AI Act reports',
        ],
        isPopular: true,
        ctaText: 'Start Free Trial',
      ),
      PricingTierContent(
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
          'Compliance dashboard',
        ],
        ctaText: 'Contact Sales',
      ),
    ],
  );

  /// Legacy content (pre-audit) - kept for rollback
  static const legacy = PricingContent(
    title: 'Simple, Transparent Pricing',
    subtitle: 'Start free, scale as you grow',
    monthlyLabel: 'Monthly',
    annualLabel: 'Annual',
    annualBadge: 'Save 20%',
    enterpriseNote: 'Need custom solutions? ',
    enterpriseLink: 'Contact our sales team',
    tiers: [
      PricingTierContent(
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
      PricingTierContent(
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
      PricingTierContent(
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
    ],
  );
}

// ============================================================================
// FEATURES SECTION CONTENT
// ============================================================================

/// Feature card data structure.
@immutable
class FeatureCardContent {
  final IconData icon;
  final String title;
  final String description;
  final List<String> bullets;

  const FeatureCardContent({
    required this.icon,
    required this.title,
    required this.description,
    required this.bullets,
  });
}

/// Features section content configuration.
@immutable
class FeaturesContent {
  final String title;
  final String subtitle;
  final List<FeatureCardContent> features;

  const FeaturesContent({
    required this.title,
    required this.subtitle,
    required this.features,
  });

  /// Current production content
  /// Enhanced with compliance/EU AI Act features
  static const current = FeaturesContent(
    title: 'Platform Capabilities',
    subtitle: 'Comprehensive tools for AI application observability',
    features: [
      FeatureCardContent(
        icon: LucideIcons.activity,
        title: 'LLM Monitoring',
        description:
            'Track every LLM call with detailed performance metrics and cost attribution.',
        bullets: [
          'Token usage tracking',
          'Latency monitoring',
          'Cost attribution per request',
        ],
      ),
      FeatureCardContent(
        icon: LucideIcons.gitBranch,
        title: 'Distributed Tracing',
        description:
            'End-to-end visibility across your AI application with OpenTelemetry support.',
        bullets: [
          'Request correlation',
          'Service dependency mapping',
          'Bottleneck identification',
        ],
      ),
      FeatureCardContent(
        icon: LucideIcons.clipboardCheck,
        title: 'Compliance Reporting',
        description:
            'Automated documentation for EU AI Act Article 12 requirements.',
        bullets: [
          'Audit trail generation',
          'Risk classification support',
          'Decision traceability',
        ],
      ),
      FeatureCardContent(
        icon: LucideIcons.shield,
        title: 'Security & Privacy',
        description:
            'Enterprise-grade security with PII detection and data masking.',
        bullets: [
          'Automatic PII redaction',
          'Role-based access control',
          'GDPR compliance tools',
        ],
      ),
      FeatureCardContent(
        icon: LucideIcons.barChart3,
        title: 'Analytics Dashboard',
        description:
            'Customizable dashboards with real-time metrics and historical trends.',
        bullets: [
          'Custom visualizations',
          'Export capabilities',
          'Team collaboration',
        ],
      ),
      FeatureCardContent(
        icon: LucideIcons.alertTriangle,
        title: 'Anomaly Detection',
        description:
            'Automated detection of performance regressions and unusual patterns.',
        bullets: [
          'Baseline comparison',
          'Custom alert thresholds',
          'Slack/PagerDuty integration',
        ],
      ),
    ],
  );

  /// Legacy content (pre-audit)
  static const legacy = FeaturesContent(
    title: 'Platform Capabilities',
    subtitle: 'Comprehensive tools for AI application observability',
    features: [
      FeatureCardContent(
        icon: LucideIcons.activity,
        title: 'LLM Monitoring',
        description:
            'Track every LLM call with detailed performance metrics and cost attribution.',
        bullets: [
          'Token usage tracking',
          'Latency monitoring',
          'Cost attribution per request',
        ],
      ),
      FeatureCardContent(
        icon: LucideIcons.gitBranch,
        title: 'Distributed Tracing',
        description:
            'End-to-end visibility across your AI application with OpenTelemetry support.',
        bullets: [
          'Request correlation',
          'Service dependency mapping',
          'Bottleneck identification',
        ],
      ),
      FeatureCardContent(
        icon: LucideIcons.alertTriangle,
        title: 'Anomaly Detection',
        description:
            'Automated detection of performance regressions and unusual patterns.',
        bullets: [
          'Baseline comparison',
          'Custom alert thresholds',
          'Slack/PagerDuty integration',
        ],
      ),
      FeatureCardContent(
        icon: LucideIcons.shield,
        title: 'Security & Privacy',
        description:
            'Enterprise-grade security with PII detection and data masking.',
        bullets: [
          'Automatic PII redaction',
          'Role-based access control',
          'Audit logging',
        ],
      ),
      FeatureCardContent(
        icon: LucideIcons.barChart3,
        title: 'Analytics Dashboard',
        description:
            'Customizable dashboards with real-time metrics and historical trends.',
        bullets: [
          'Custom visualizations',
          'Export capabilities',
          'Team collaboration',
        ],
      ),
      FeatureCardContent(
        icon: LucideIcons.zap,
        title: 'Performance Optimization',
        description:
            'Identify optimization opportunities with detailed performance insights.',
        bullets: [
          'Slow query detection',
          'Caching recommendations',
          'Resource utilization',
        ],
      ),
    ],
  );
}

// ============================================================================
// CTA SECTION CONTENT
// ============================================================================

/// CTA section content configuration.
@immutable
class CTAContent {
  final String headline;
  final String subheadline;
  final String primaryCTA;
  final String secondaryCTA;

  const CTAContent({
    required this.headline,
    required this.subheadline,
    required this.primaryCTA,
    required this.secondaryCTA,
  });

  /// Current production content
  static const current = CTAContent(
    headline: 'Ready to Gain Visibility Into Your AI?',
    subheadline:
        'Join teams who trust Integrity Studio for AI observability '
        'with compliance built-in.',
    primaryCTA: 'Start Free Trial',
    secondaryCTA: 'Schedule Demo',
  );

  /// Legacy content
  static const legacy = CTAContent(
    headline: 'Ready to Gain Visibility Into Your AI?',
    subheadline:
        'Join thousands of teams who trust Integrity Studio for '
        'their AI observability needs.',
    primaryCTA: 'Start Free Trial',
    secondaryCTA: 'Schedule Demo',
  );
}

// ============================================================================
// SOCIAL PROOF CONTENT (NEW - per audit recommendations)
// ============================================================================

/// Customer logo/testimonial for social proof section.
@immutable
class CustomerLogoContent {
  final String name;
  final String? logoAsset;
  final String? industry;

  const CustomerLogoContent({
    required this.name,
    this.logoAsset,
    this.industry,
  });
}

/// Testimonial content.
@immutable
class TestimonialContent {
  final String quote;
  final String author;
  final String role;
  final String company;
  final String? avatarAsset;

  const TestimonialContent({
    required this.quote,
    required this.author,
    required this.role,
    required this.company,
    this.avatarAsset,
  });
}

/// Social proof section content.
@immutable
class SocialProofContent {
  final String title;
  final List<CustomerLogoContent> logos;
  final List<TestimonialContent> testimonials;
  final String? statsHeadline;
  final Map<String, String>? stats;

  const SocialProofContent({
    required this.title,
    required this.logos,
    required this.testimonials,
    this.statsHeadline,
    this.stats,
  });

  /// Placeholder content (to be replaced with real customers)
  static const placeholder = SocialProofContent(
    title: 'Trusted by AI Teams',
    logos: [
      // Placeholder - replace with actual customer logos
      CustomerLogoContent(name: 'Enterprise Client', industry: 'Finance'),
      CustomerLogoContent(name: 'Tech Startup', industry: 'SaaS'),
      CustomerLogoContent(name: 'Healthcare Co', industry: 'Healthcare'),
    ],
    testimonials: [
      TestimonialContent(
        quote:
            'Integrity Studio gave us the visibility we needed to ship AI '
            'features with confidence. The compliance reports saved us weeks.',
        author: 'Engineering Lead',
        role: 'VP Engineering',
        company: 'Tech Company',
      ),
    ],
    statsHeadline: 'Enterprise-Grade Performance',
    stats: {
      'Traces Processed': '10M+',
      'Uptime': '99.9%',
      'Setup Time': '< 5 min',
    },
  );
}

// ============================================================================
// STATUS SECTION CONTENT
// ============================================================================

/// Status metric item for platform health/status display.
@immutable
class StatusMetricContent {
  final String label;
  final String value;
  final String? sublabel;
  final bool isOperational;

  const StatusMetricContent({
    required this.label,
    required this.value,
    this.sublabel,
    this.isOperational = true,
  });
}

/// Status service item showing individual service status.
@immutable
class StatusServiceContent {
  final String name;
  final String status;
  final bool isOperational;

  const StatusServiceContent({
    required this.name,
    required this.status,
    this.isOperational = true,
  });
}

/// Status section content configuration.
@immutable
class StatusContent {
  final String title;
  final String subtitle;
  final String statusBadge;
  final bool allOperational;
  final List<StatusMetricContent> metrics;
  final List<StatusServiceContent> services;
  final String statusPageUrl;
  final String statusPageCta;

  const StatusContent({
    required this.title,
    required this.subtitle,
    required this.statusBadge,
    required this.allOperational,
    required this.metrics,
    required this.services,
    required this.statusPageUrl,
    required this.statusPageCta,
  });

  /// Current production content
  /// Based on Brand Guidelines and Content Strategy metrics
  static const current = StatusContent(
    title: 'Platform Status',
    subtitle: 'Real-time operational health and performance metrics',
    statusBadge: 'All Systems Operational',
    allOperational: true,
    metrics: [
      StatusMetricContent(
        label: 'Uptime',
        value: '99.9%',
        sublabel: 'SLA Guaranteed',
      ),
      StatusMetricContent(
        label: 'Traces Processed',
        value: '10M+',
        sublabel: 'Daily',
      ),
      StatusMetricContent(
        label: 'AI Teams',
        value: '500+',
        sublabel: 'Trusted By',
      ),
      StatusMetricContent(
        label: 'Setup Time',
        value: '5 min',
        sublabel: 'Average',
      ),
    ],
    services: [
      StatusServiceContent(
        name: 'Trace Ingestion API',
        status: 'Operational',
      ),
      StatusServiceContent(
        name: 'Dashboard & Analytics',
        status: 'Operational',
      ),
      StatusServiceContent(
        name: 'Compliance Reporting',
        status: 'Operational',
      ),
      StatusServiceContent(
        name: 'Alerting System',
        status: 'Operational',
      ),
    ],
    statusPageUrl: 'https://status.integritystudio.ai',
    statusPageCta: 'View Full Status Page',
  );
}

// ============================================================================
// FOOTER CONTENT
// ============================================================================

/// Footer link group.
@immutable
class FooterLinkGroup {
  final String title;
  final List<FooterLink> links;

  const FooterLinkGroup({
    required this.title,
    required this.links,
  });
}

/// Individual footer link.
@immutable
class FooterLink {
  final String label;
  final String url;
  final bool isExternal;

  const FooterLink({
    required this.label,
    required this.url,
    this.isExternal = false,
  });
}

/// Footer content configuration.
@immutable
class FooterContent {
  final String companyName;
  final String tagline;
  final String copyright;
  final List<FooterLinkGroup> linkGroups;
  final String privacyLink;
  final String termsLink;
  final String cookieSettingsLabel;

  const FooterContent({
    required this.companyName,
    required this.tagline,
    required this.copyright,
    required this.linkGroups,
    required this.privacyLink,
    required this.termsLink,
    required this.cookieSettingsLabel,
  });

  static const current = FooterContent(
    companyName: 'Integrity Studio',
    tagline: 'AI Observability That Proves Compliance',
    copyright: '© 2024 Integrity Studio. All rights reserved.',
    linkGroups: [
      FooterLinkGroup(
        title: 'Product',
        links: [
          FooterLink(label: 'Features', url: '#features'),
          FooterLink(label: 'Pricing', url: '#pricing'),
          FooterLink(label: 'Documentation', url: '/docs'),
          FooterLink(label: 'Changelog', url: '/changelog'),
        ],
      ),
      FooterLinkGroup(
        title: 'Company',
        links: [
          FooterLink(label: 'About', url: '/about'),
          FooterLink(label: 'Blog', url: '/blog'),
          FooterLink(label: 'Careers', url: '/careers'),
          FooterLink(label: 'Contact', url: '/contact'),
        ],
      ),
      FooterLinkGroup(
        title: 'Resources',
        links: [
          FooterLink(label: 'EU AI Act Guide', url: '/eu-ai-act'),
          FooterLink(label: 'API Reference', url: '/api'),
          FooterLink(label: 'Status', url: 'https://status.integritystudio.ai', isExternal: true),
          FooterLink(label: 'Support', url: '/support'),
        ],
      ),
    ],
    privacyLink: '/privacy',
    termsLink: '/terms',
    cookieSettingsLabel: 'Cookie Settings',
  );
}

// ============================================================================
// CONTENT MANAGER
// ============================================================================

/// Centralized content manager for the application
///
/// Usage:
/// ```dart
/// final heroContent = AppContent.hero;
/// final pricingContent = AppContent.pricing;
/// ```
///
/// For A/B testing:
/// ```dart
/// final heroContent = abTestVariant == 'B'
///     ? HeroContent.variantAgentFirst
///     : HeroContent.current;
/// ```
class AppContent {
  // Private constructor - static access only
  AppContent._();

  /// Current hero section content
  static HeroContent get hero => HeroContent.current;

  /// Current pricing section content
  static PricingContent get pricing => PricingContent.current;

  /// Current features section content
  static FeaturesContent get features => FeaturesContent.current;

  /// Current CTA section content
  static CTAContent get cta => CTAContent.current;

  /// Current social proof content
  static SocialProofContent get socialProof => SocialProofContent.placeholder;

  /// Current status section content
  static StatusContent get status => StatusContent.current;

  /// Current footer content
  static FooterContent get footer => FooterContent.current;

  /// Get content variant by name (for A/B testing)
  static HeroContent getHeroVariant(String variant) {
    switch (variant) {
      case 'agent-first':
        return HeroContent.variantAgentFirst;
      case 'cost-focused':
        return HeroContent.variantCostFocused;
      case 'legacy':
        return HeroContent.legacy;
      default:
        return HeroContent.current;
    }
  }
}
