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
    statusPageUrl: 'https://integritystudio.ai/status',
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
          FooterLink(label: 'Status', url: 'https://integritystudio.ai/status', isExternal: true),
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

  /// Current services section content
  static ServicesContent get services => ServicesContent.current;

  /// Current about section content
  static AboutContent get about => AboutContent.current;

  /// Current resources section content
  static ResourcesContent get resources => ResourcesContent.current;

  /// Current contact section content
  static ContactContent get contact => ContactContent.current;
}

// ============================================================================
// SERVICES SECTION CONTENT (#services)
// ============================================================================

/// Individual service offering.
@immutable
class ServiceItemContent {
  final IconData icon;
  final String title;
  final String description;
  final List<String> capabilities;
  final String? ctaText;
  final String? ctaUrl;

  const ServiceItemContent({
    required this.icon,
    required this.title,
    required this.description,
    required this.capabilities,
    this.ctaText,
    this.ctaUrl,
  });
}

/// Services section content configuration.
/// Aligned with Content Strategy positioning as "The EU AI Act-Ready Observability Platform"
@immutable
class ServicesContent {
  final String sectionId;
  final String title;
  final String subtitle;
  final String description;
  final List<ServiceItemContent> services;
  final String ctaText;
  final String ctaUrl;

  const ServicesContent({
    required this.sectionId,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.services,
    required this.ctaText,
    required this.ctaUrl,
  });

  /// Current production content
  /// Positioned for enterprise AI observability with EU AI Act compliance focus
  static const current = ServicesContent(
    sectionId: 'services',
    title: 'Platform Services',
    subtitle: 'Comprehensive AI Observability for Enterprise',
    description:
        'From real-time LLM monitoring to automated compliance reporting, '
        'Integrity Studio provides the complete toolkit for production AI systems. '
        'Built for teams who need visibility, governance, and audit-ready documentation.',
    services: [
      ServiceItemContent(
        icon: LucideIcons.activity,
        title: 'LLM Monitoring & Tracing',
        description:
            'Track every LLM call with sub-100ms latency. Capture prompts, completions, '
            'tokens, costs, and performance metrics in real-time across all your models.',
        capabilities: [
          'Full request/response capture with token attribution',
          'Cost tracking per request, model, and team',
          'Latency percentiles and performance baselines',
          'Multi-provider support (OpenAI, Anthropic, Google, AWS Bedrock)',
          'OpenTelemetry-native instrumentation',
        ],
        ctaText: 'View Tracing Docs',
        ctaUrl: '/docs/tracing',
      ),
      ServiceItemContent(
        icon: LucideIcons.bot,
        title: 'Agent Observability',
        description:
            'Monitor multi-step AI agents, tool calls, and reasoning chains. '
            'Debug complex autonomous workflows with full execution traces and decision visualization.',
        capabilities: [
          'Multi-turn conversation tracking',
          'Tool call monitoring with input/output capture',
          'Reasoning chain visualization',
          'Agent decision tree analysis',
          'LangChain, LlamaIndex, and custom agent support',
        ],
        ctaText: 'Explore Agent Features',
        ctaUrl: '/docs/agents',
      ),
      ServiceItemContent(
        icon: LucideIcons.shield,
        title: 'Compliance & Governance',
        description:
            'Built-in EU AI Act templates, automated audit trails, and framework mapping. '
            'Prepare for regulatory requirements with documentation that stands up to scrutiny.',
        capabilities: [
          'EU AI Act Article 12 traceability requirements',
          'Automated risk classification support',
          'Audit trail generation with immutable logs',
          'Human oversight tracking and approval workflows',
          'GDPR-compliant data handling and retention',
        ],
        ctaText: 'EU AI Act Guide',
        ctaUrl: '/eu-ai-act',
      ),
      ServiceItemContent(
        icon: LucideIcons.barChart3,
        title: 'Analytics & Dashboards',
        description:
            'Interactive dashboards for token usage, costs, latency distributions, '
            'and model comparison analytics. Export data for stakeholder reporting.',
        capabilities: [
          'Customizable KPI dashboards',
          'Historical trend analysis',
          'Model performance benchmarking',
          'Team and project attribution',
          'Export to CSV, JSON, and PDF',
        ],
        ctaText: 'See Dashboard Demo',
        ctaUrl: '#demo',
      ),
      ServiceItemContent(
        icon: LucideIcons.bell,
        title: 'Alerting & Incident Management',
        description:
            'Proactive alerting for anomalies, budget thresholds, and performance degradation. '
            'Intelligent routing to your existing incident management tools.',
        capabilities: [
          'Budget alerts before cost overruns',
          'Anomaly detection for response quality',
          'Performance regression warnings',
          'Slack, PagerDuty, and webhook integrations',
          'Custom alert thresholds and schedules',
        ],
        ctaText: 'Configure Alerts',
        ctaUrl: '/docs/alerts',
      ),
      ServiceItemContent(
        icon: LucideIcons.code,
        title: 'Developer Experience',
        description:
            'Drop-in SDKs for Python, TypeScript, and Go. OpenTelemetry-native with '
            'minimal instrumentation required. Get to value in under 5 minutes.',
        capabilities: [
          'Python, TypeScript, and Go SDKs',
          'Auto-instrumentation for popular frameworks',
          'OpenTelemetry compatibility',
          'Comprehensive API documentation',
          'Self-hosted and cloud deployment options',
        ],
        ctaText: 'Quick Start Guide',
        ctaUrl: '/docs/quickstart',
      ),
    ],
    ctaText: 'Start Free Trial',
    ctaUrl: '/signup',
  );
}

// ============================================================================
// ABOUT SECTION CONTENT (#about)
// ============================================================================

/// Team member profile.
@immutable
class TeamMemberContent {
  final String name;
  final String role;
  final String bio;
  final String? avatarAsset;
  final String? linkedInUrl;
  final String? twitterUrl;
  final String? githubUrl;

  const TeamMemberContent({
    required this.name,
    required this.role,
    required this.bio,
    this.avatarAsset,
    this.linkedInUrl,
    this.twitterUrl,
    this.githubUrl,
  });
}

/// Company value/principle.
@immutable
class CompanyValueContent {
  final IconData icon;
  final String title;
  final String description;

  const CompanyValueContent({
    required this.icon,
    required this.title,
    required this.description,
  });
}

/// About section content configuration.
/// Brand voice: Professional, Technical, Approachable, Forward-thinking
@immutable
class AboutContent {
  final String sectionId;
  final String title;
  final String subtitle;
  final String missionStatement;
  final String visionStatement;
  final String story;
  final List<CompanyValueContent> values;
  final List<TeamMemberContent> team;
  final String locationCity;
  final String locationRegion;
  final String foundedYear;

  const AboutContent({
    required this.sectionId,
    required this.title,
    required this.subtitle,
    required this.missionStatement,
    required this.visionStatement,
    required this.story,
    required this.values,
    required this.team,
    required this.locationCity,
    required this.locationRegion,
    required this.foundedYear,
  });

  /// Current production content
  /// Aligned with Brand Guidelines mission and vision statements
  static const current = AboutContent(
    sectionId: 'about',
    title: 'About Integrity Studio',
    subtitle: 'Building Trust in AI Systems',
    missionStatement:
        'Empower enterprises to build trustworthy AI systems through comprehensive '
        'observability and governance tools.',
    visionStatement:
        'To be the standard for enterprise AI observability, enabling organizations '
        'to deploy AI confidently while meeting regulatory requirements.',
    story:
        'Integrity Studio was founded with a clear purpose: to solve the visibility problem '
        'in production AI systems. As LLMs and AI agents became critical to business operations, '
        'we saw teams struggling with black-box AI decisions, unpredictable costs, and looming '
        'regulatory requirements like the EU AI Act.\n\n'
        'Our founders built observability tools at scale before, and recognized that AI systems '
        'needed purpose-built monitoring—not retrofitted APM solutions. We designed Integrity Studio '
        'from the ground up for the unique challenges of LLM applications: token-level cost attribution, '
        'multi-step agent tracing, and compliance documentation that satisfies auditors.\n\n'
        'Today, we help AI teams ship reliable, compliant applications faster. Our platform provides '
        'the visibility they need to debug issues, optimize costs, and demonstrate governance to '
        'stakeholders—all from a single pane of glass.',
    values: [
      CompanyValueContent(
        icon: LucideIcons.eye,
        title: 'Transparency',
        description:
            'We believe AI systems should be observable and explainable. Every decision, '
            'every cost, every outcome should be visible to the teams responsible for them.',
      ),
      CompanyValueContent(
        icon: LucideIcons.shieldCheck,
        title: 'Trust',
        description:
            'Trust is earned through reliability, security, and accountability. We build tools '
            'that help our customers demonstrate trustworthiness to their users and regulators.',
      ),
      CompanyValueContent(
        icon: LucideIcons.users,
        title: 'Developer-First',
        description:
            'Great tools should get out of the developer\'s way. We prioritize clean APIs, '
            'fast integration, and minimal overhead so teams can focus on building.',
      ),
      CompanyValueContent(
        icon: LucideIcons.scale,
        title: 'Compliance by Design',
        description:
            'Regulatory requirements shouldn\'t be an afterthought. We embed compliance '
            'capabilities into the platform so governance happens automatically.',
      ),
    ],
    team: [
      TeamMemberContent(
        name: 'Alyshia Ledlie',
        role: 'Founder & CEO',
        bio:
            'Previously built observability infrastructure at scale. Passionate about making '
            'AI systems transparent and trustworthy for enterprises navigating regulatory change.',
        linkedInUrl: 'https://linkedin.com/in/alyshialedlie',
        twitterUrl: 'https://twitter.com/alyshialedlie',
      ),
      // Additional team members can be added here
    ],
    locationCity: 'Austin',
    locationRegion: 'Texas',
    foundedYear: '2024',
  );
}

// ============================================================================
// RESOURCES SECTION CONTENT (#resources)
// ============================================================================

/// Blog post preview for resources section.
@immutable
class BlogPostPreviewContent {
  final String title;
  final String excerpt;
  final String category;
  final String publishDate;
  final String readTime;
  final String slug;
  final String? featuredImageAsset;
  final String? author;

  const BlogPostPreviewContent({
    required this.title,
    required this.excerpt,
    required this.category,
    required this.publishDate,
    required this.readTime,
    required this.slug,
    this.featuredImageAsset,
    this.author,
  });
}

/// Documentation category for resources section.
@immutable
class DocCategoryContent {
  final IconData icon;
  final String title;
  final String description;
  final String url;
  final List<String> popularTopics;

  const DocCategoryContent({
    required this.icon,
    required this.title,
    required this.description,
    required this.url,
    required this.popularTopics,
  });
}

/// Lead magnet/downloadable resource.
@immutable
class LeadMagnetContent {
  final IconData icon;
  final String title;
  final String description;
  final String format;
  final String ctaText;
  final String url;
  final bool requiresEmail;

  const LeadMagnetContent({
    required this.icon,
    required this.title,
    required this.description,
    required this.format,
    required this.ctaText,
    required this.url,
    this.requiresEmail = true,
  });
}

/// Resources section content configuration.
/// Content pillars: EU AI Act Compliance, LLM Cost Optimization, Agent Observability, Technical Tutorials
@immutable
class ResourcesContent {
  final String sectionId;
  final String title;
  final String subtitle;
  final List<DocCategoryContent> documentation;
  final List<BlogPostPreviewContent> featuredPosts;
  final List<LeadMagnetContent> leadMagnets;
  final String blogCtaText;
  final String blogCtaUrl;
  final String docsCtaText;
  final String docsCtaUrl;

  const ResourcesContent({
    required this.sectionId,
    required this.title,
    required this.subtitle,
    required this.documentation,
    required this.featuredPosts,
    required this.leadMagnets,
    required this.blogCtaText,
    required this.blogCtaUrl,
    required this.docsCtaText,
    required this.docsCtaUrl,
  });

  /// Current production content
  /// Based on Content Strategy content pillars and lead magnet strategy
  static const current = ResourcesContent(
    sectionId: 'resources',
    title: 'Resources',
    subtitle: 'Guides, Documentation & Insights',
    documentation: [
      DocCategoryContent(
        icon: LucideIcons.bookOpen,
        title: 'Getting Started',
        description:
            'Quick start guides and tutorials to get your first traces flowing in under 5 minutes.',
        url: '/docs/quickstart',
        popularTopics: [
          'Python SDK Setup',
          'TypeScript Integration',
          'OpenTelemetry Configuration',
          'Dashboard Overview',
        ],
      ),
      DocCategoryContent(
        icon: LucideIcons.code2,
        title: 'API Reference',
        description:
            'Complete API documentation with examples for all endpoints and SDK methods.',
        url: '/docs/api',
        popularTopics: [
          'Trace Ingestion API',
          'Query API',
          'Alerts API',
          'Authentication',
        ],
      ),
      DocCategoryContent(
        icon: LucideIcons.shield,
        title: 'Compliance Guides',
        description:
            'In-depth guides for EU AI Act preparation, audit trails, and governance configuration.',
        url: '/docs/compliance',
        popularTopics: [
          'EU AI Act Overview',
          'Risk Classification',
          'Audit Trail Setup',
          'Human Oversight Workflows',
        ],
      ),
      DocCategoryContent(
        icon: LucideIcons.puzzle,
        title: 'Integrations',
        description:
            'Connect Integrity Studio with your existing tools: Slack, PagerDuty, Datadog, and more.',
        url: '/docs/integrations',
        popularTopics: [
          'Slack Notifications',
          'PagerDuty Alerting',
          'Grafana Dashboards',
          'Webhook Configuration',
        ],
      ),
    ],
    featuredPosts: [
      BlogPostPreviewContent(
        title: 'End-to-End Agentic Observability: From Chaos to Control',
        excerpt:
            'Your AI agent just autonomously decided to email your entire customer database '
            'at 3 AM. Learn the Build, Test, Monitor, Analyze lifecycle that keeps agents '
            'reliable, compliant, and not accidentally ordering 10,000 pizzas.',
        category: 'Best Practices',
        publishDate: '2024-12-24',
        readTime: '12 min read',
        slug: 'end-to-end-agentic-observability-lifecycle',
        author: 'Alyshia Ledlie',
      ),
      BlogPostPreviewContent(
        title: 'EU AI Act: What Engineering Teams Need to Know',
        excerpt:
            'A practical guide to EU AI Act compliance for AI engineering teams. '
            'Understand Article 12 traceability requirements, risk classifications, '
            'and how to prepare your systems before enforcement begins.',
        category: 'Compliance',
        publishDate: '2024-12-15',
        readTime: '12 min read',
        slug: 'eu-ai-act-engineering-guide',
        author: 'Alyshia Ledlie',
      ),
      BlogPostPreviewContent(
        title: 'How to Reduce LLM Costs by 40%',
        excerpt:
            'Discover the optimization strategies that top AI teams use to cut their LLM API '
            'costs without sacrificing quality. From caching to model selection, learn what works.',
        category: 'Cost Optimization',
        publishDate: '2024-12-10',
        readTime: '8 min read',
        slug: 'reduce-llm-costs',
        author: 'Alyshia Ledlie',
      ),
      BlogPostPreviewContent(
        title: 'Complete Guide to AI Agent Observability',
        excerpt:
            'As autonomous AI agents become more complex, observability becomes critical. '
            'Learn how to trace multi-step workflows, debug tool calls, and monitor agent performance.',
        category: 'Best Practices',
        publishDate: '2024-12-05',
        readTime: '15 min read',
        slug: 'ai-agent-observability-guide',
        author: 'Alyshia Ledlie',
      ),
    ],
    leadMagnets: [
      LeadMagnetContent(
        icon: LucideIcons.clipboardCheck,
        title: 'EU AI Act Compliance Checklist',
        description:
            'A comprehensive checklist covering all EU AI Act requirements for high-risk AI systems. '
            'Includes Article 12 traceability, documentation templates, and timeline milestones.',
        format: 'PDF',
        ctaText: 'Download Checklist',
        url: '/resources/eu-ai-act-checklist',
      ),
      LeadMagnetContent(
        icon: LucideIcons.calculator,
        title: 'LLM Cost Calculator',
        description:
            'Calculate your potential savings with optimized LLM monitoring. '
            'Input your current spend and see projected ROI from implementing observability.',
        format: 'Interactive Tool',
        ctaText: 'Calculate Savings',
        url: '/tools/llm-cost-calculator',
        requiresEmail: false,
      ),
      LeadMagnetContent(
        icon: LucideIcons.fileText,
        title: 'State of AI Observability 2025',
        description:
            'Original research on AI observability trends, challenges, and best practices. '
            'Data from 500+ AI teams on monitoring, compliance, and cost management.',
        format: 'Report',
        ctaText: 'Get the Report',
        url: '/reports/state-of-ai-observability-2025',
      ),
    ],
    blogCtaText: 'View All Articles',
    blogCtaUrl: '/blog',
    docsCtaText: 'Browse Documentation',
    docsCtaUrl: '/docs',
  );
}

// ============================================================================
// CONTACT SECTION CONTENT (#contact)
// ============================================================================

/// Contact form field configuration.
@immutable
class ContactFormFieldContent {
  final String name;
  final String label;
  final String placeholder;
  final String type; // text, email, tel, select, textarea
  final bool required;
  final List<String>? options; // For select fields

  const ContactFormFieldContent({
    required this.name,
    required this.label,
    required this.placeholder,
    required this.type,
    this.required = false,
    this.options,
  });
}

/// Contact method (email, phone, calendar, etc.).
@immutable
class ContactMethodContent {
  final IconData icon;
  final String label;
  final String value;
  final String? url;
  final bool isPrimary;

  const ContactMethodContent({
    required this.icon,
    required this.label,
    required this.value,
    this.url,
    this.isPrimary = false,
  });
}

/// Contact section content configuration.
@immutable
class ContactContent {
  final String sectionId;
  final String title;
  final String subtitle;
  final String description;
  final List<ContactFormFieldContent> formFields;
  final List<ContactMethodContent> contactMethods;
  final String formSubmitText;
  final String formSuccessMessage;
  final String formErrorMessage;
  final String calendlyUrl;
  final String calendlyCtaText;

  const ContactContent({
    required this.sectionId,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.formFields,
    required this.contactMethods,
    required this.formSubmitText,
    required this.formSuccessMessage,
    required this.formErrorMessage,
    required this.calendlyUrl,
    required this.calendlyCtaText,
  });

  /// Current production content
  /// Designed for lead capture with enterprise qualification
  static const current = ContactContent(
    sectionId: 'contact',
    title: 'Get in Touch',
    subtitle: 'Let\'s discuss how we can help',
    description:
        'Whether you\'re evaluating AI observability solutions, have questions about '
        'EU AI Act compliance, or want to see a demo, our team is here to help. '
        'Reach out and we\'ll respond within one business day.',
    formFields: [
      ContactFormFieldContent(
        name: 'firstName',
        label: 'First Name',
        placeholder: 'John',
        type: 'text',
        required: true,
      ),
      ContactFormFieldContent(
        name: 'lastName',
        label: 'Last Name',
        placeholder: 'Smith',
        type: 'text',
        required: true,
      ),
      ContactFormFieldContent(
        name: 'email',
        label: 'Work Email',
        placeholder: 'john@company.com',
        type: 'email',
        required: true,
      ),
      ContactFormFieldContent(
        name: 'company',
        label: 'Company',
        placeholder: 'Acme Inc.',
        type: 'text',
        required: true,
      ),
      ContactFormFieldContent(
        name: 'companySize',
        label: 'Company Size',
        placeholder: 'Select...',
        type: 'select',
        required: true,
        options: [
          '1-10 employees',
          '11-50 employees',
          '51-200 employees',
          '201-1,000 employees',
          '1,000+ employees',
        ],
      ),
      ContactFormFieldContent(
        name: 'useCase',
        label: 'Primary Interest',
        placeholder: 'Select...',
        type: 'select',
        required: true,
        options: [
          'LLM Monitoring & Cost Tracking',
          'Agent Observability',
          'EU AI Act Compliance',
          'General AI Observability',
          'Enterprise Evaluation',
          'Partnership Inquiry',
        ],
      ),
      ContactFormFieldContent(
        name: 'message',
        label: 'Message',
        placeholder: 'Tell us about your AI observability needs...',
        type: 'textarea',
        required: false,
      ),
    ],
    contactMethods: [
      ContactMethodContent(
        icon: LucideIcons.mail,
        label: 'Email',
        value: 'hello@integritystudio.ai',
        url: 'mailto:hello@integritystudio.ai',
        isPrimary: true,
      ),
      ContactMethodContent(
        icon: LucideIcons.calendar,
        label: 'Schedule a Demo',
        value: 'Book a 30-minute call',
        url: 'https://calendly.com/alyshialedlie/30min',
        isPrimary: true,
      ),
      ContactMethodContent(
        icon: LucideIcons.mapPin,
        label: 'Location',
        value: 'Austin, Texas',
      ),
      ContactMethodContent(
        icon: LucideIcons.linkedin,
        label: 'LinkedIn',
        value: 'Follow us',
        url: 'https://linkedin.com/company/integrity-studio',
      ),
      ContactMethodContent(
        icon: LucideIcons.twitter,
        label: 'Twitter',
        value: '@integritystudio',
        url: 'https://twitter.com/integritystudio',
      ),
      ContactMethodContent(
        icon: LucideIcons.github,
        label: 'GitHub',
        value: 'integritystudio',
        url: 'https://github.com/integritystudio',
      ),
    ],
    formSubmitText: 'Send Message',
    formSuccessMessage:
        'Thank you for reaching out! We\'ll get back to you within one business day.',
    formErrorMessage:
        'Something went wrong. Please try again or email us directly at hello@integritystudio.ai',
    calendlyUrl: 'https://calendly.com/alyshialedlie/30min',
    calendlyCtaText: 'Schedule a Demo',
  );
}
