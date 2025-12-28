/// Shared constants used across content configuration.
///
/// DRY principle: Define once, use everywhere.
/// Update these values in one place to change them across the entire app.
library;

// =============================================================================
// COMPANY INFORMATION
// =============================================================================

/// Core company branding and identity constants.
abstract final class CompanyInfo {
  static const String name = 'Integrity Studio';
  static const String tagline = 'AI Observability That Proves Compliance';
  static const String copyright = '© 2024 Integrity Studio. All rights reserved.';
  static const String foundedYear = '2024';
  static const String locationCity = 'Austin';
  static const String locationRegion = 'Texas';
  static const String email = 'hello@integritystudio.ai';
  static const String phone = '(512) 829-1644';
}

// =============================================================================
// CALL-TO-ACTION STRINGS
// =============================================================================

/// Standardized CTA button text used across the application.
abstract final class CTAText {
  // Primary CTAs
  static const String startFreeTrial = 'Start Free Trial';
  static const String getStarted = 'Get Started';
  static const String scheduledDemo = 'Schedule Demo';
  static const String requestDemo = 'Request Demo';
  static const String contactSales = 'Contact Sales';
  static const String learnMore = 'Learn More';

  // Navigation CTAs
  static const String backToHome = 'Back to Home';
  static const String viewAll = 'View All';
  static const String viewDocs = 'View Documentation';

  // Form CTAs
  static const String sendMessage = 'Send Message';
  static const String downloadNow = 'Download Now';
  static const String calculateSavings = 'Calculate Savings';
}

// =============================================================================
// EXTERNAL URLS
// =============================================================================

/// External URLs and links used throughout the application.
abstract final class ExternalUrls {
  // Calendly
  static const String calendlyDemo = 'https://calendly.com/alyshialedlie/30min';

  // Status page
  static const String statusPage = 'https://integritystudio.ai/status';

  // Social media
  static const String linkedIn = 'https://linkedin.com/company/integrity-studio';
  static const String twitter = 'https://twitter.com/integritystudio';
  static const String github = 'https://github.com/integritystudio';

  // Personal (founder)
  static const String founderLinkedIn = 'https://linkedin.com/in/alyshialedlie';
  static const String founderTwitter = 'https://twitter.com/alyshialedlie';
}

// =============================================================================
// INTERNAL ROUTES
// =============================================================================

/// Internal route paths for navigation.
abstract final class Routes {
  // Main pages
  static const String home = '/';
  static const String blog = '/blog';
  static const String docs = '/docs';
  static const String pricing = '/pricing';
  static const String about = '/about';
  static const String contact = '/contact';
  static const String signup = '/signup';

  // Anchor sections
  static const String features = '#features';
  static const String pricingSection = '#pricing';
  static const String services = '#services';
  static const String demo = '#demo';

  // Documentation
  static const String docsQuickstart = '/docs/quickstart';
  static const String docsApi = '/docs/api';
  static const String docsCompliance = '/docs/compliance';
  static const String docsIntegrations = '/docs/integrations';
  static const String docsTracing = '/docs/tracing';
  static const String docsAgents = '/docs/agents';
  static const String docsAlerts = '/docs/alerts';

  // Resources
  static const String euAiAct = '/eu-ai-act';
  static const String changelog = '/changelog';
  static const String support = '/support';
  static const String api = '/api';
  static const String careers = '/careers';
  static const String privacy = '/privacy';
  static const String terms = '/terms';
  static const String cookies = '/cookies';
  static const String accessibility = '/accessibility';

  // Comparison pages
  static const String whylabsAlternative = '/whylabs-alternative';
  static const String arizeAlternative = '/compare/arize-ai-alternative';

  // Information pages
  static const String sources = '/sources';
}

// =============================================================================
// TRUST INDICATORS & SOCIAL PROOF
// =============================================================================

/// Standard trust indicators displayed throughout the site.
abstract final class TrustIndicators {
  /// Current production trust indicators (EU AI Act positioning)
  static const List<String> current = [
    'EU AI Act Ready',
    'Enterprise Security',
    '99.9% Uptime',
    '5-min Setup',
  ];

  /// Legacy trust indicators (trial-focused)
  static const List<String> legacy = [
    'No credit card required',
    '14-day free trial',
    'Cancel anytime',
  ];
}

// =============================================================================
// PLATFORM METRICS
// =============================================================================

/// Platform performance and scale metrics for social proof.
abstract final class PlatformMetrics {
  static const String uptime = '99.9%';
  static const String uptimeSla = 'SLA Guaranteed';
  static const String tracesProcessed = '10M+';
  static const String tracesProcessedPeriod = 'Daily';
  static const String aiTeams = '500+';
  static const String setupTime = '5 min';
  static const String setupTimeLabel = 'Average';
}

// =============================================================================
// PRICING CONSTANTS
// =============================================================================

/// Pricing-related constants.
abstract final class PricingConstants {
  static const String annualDiscount = 'Save 20%';
  static const String monthlyLabel = 'Monthly';
  static const String annualLabel = 'Annual';
  static const String enterpriseNote = 'Need custom solutions? ';
  static const String enterpriseLink = 'Contact our sales team';

  // Free tier limits
  static const String freeTracesLimit = '50K traces/month';
  static const String freeRetention = '7-day retention';

  // Team tier limits
  static const String teamTracesLimit = '500K traces/month';
  static const String teamRetention = '30-day retention';

  // Enterprise
  static const String unlimitedTraces = 'Unlimited traces';
  static const String enterpriseRetention = '1-year retention';
}

// =============================================================================
// FORM MESSAGES
// =============================================================================

/// Standard form success/error messages.
abstract final class FormMessages {
  static const String contactSuccess =
      "Thank you for reaching out! We'll get back to you within one business day.";
  static const String contactError =
      'Something went wrong. Please try again or email us directly at ${CompanyInfo.email}';
  static const String subscribeSuccess = 'Thanks for subscribing!';
  static const String subscribeError = 'Could not subscribe. Please try again.';
}

// =============================================================================
// PROMO CODES
// =============================================================================

/// Active promotional codes and offers.
abstract final class PromoCodes {
  static const String whylabsMigration = 'WHYLABS2025';
  static const String whylabsOfferDescription =
      'Get 3 months free on Team tier when you migrate from WhyLabs. '
      'Use code $whylabsMigration at checkout.';
}

// =============================================================================
// COMPLIANCE DISCLAIMERS
// =============================================================================

/// Legal disclaimers for compliance messaging.
abstract final class ComplianceDisclaimers {
  /// EU AI Act compliance disclaimer (full version).
  static const String euAiAct =
      'Integrity Studio provides tools designed to support EU AI Act compliance efforts. '
      'Actual compliance requires independent legal review, third-party assessment, and '
      'organization-specific implementation. This platform does not constitute legal advice '
      'or guarantee regulatory compliance.';

  /// Security disclaimer.
  static const String security =
      'Security certifications in progress. Current measures include encryption at rest '
      'and in transit, regular penetration testing, and adherence to OWASP guidelines.';

  /// Human oversight disclaimer.
  static const String humanOversight =
      'Human oversight tools provide technical infrastructure for approval workflows. '
      'Organizations are responsible for defining oversight policies, training reviewers, '
      'and ensuring meaningful human review of AI decisions.';

  /// General platform disclaimer for footer.
  static const String general =
      'This platform provides tools to support AI governance and observability. '
      'It does not guarantee regulatory compliance or constitute legal advice.';

  /// Short version for inline use.
  static const String euAiActShort = 'Tools to support EU AI Act compliance efforts.';
}

// =============================================================================
// CITED STATISTICS
// =============================================================================

/// Type of statistic for appropriate attribution display.
enum StatisticType {
  /// From industry reports (requires external citation)
  industry,

  /// From internal customer data (aggregated, anonymized)
  customerData,

  /// Platform metrics (internal measurement)
  platformMetric,

  /// Service level target (not a measured statistic)
  slaTarget,
}

/// A statistic with source attribution.
class CitedStatistic {
  final String value;
  final String label;
  final String source;
  final String? sourceUrl;
  final StatisticType type;

  const CitedStatistic({
    required this.value,
    required this.label,
    required this.source,
    this.sourceUrl,
    this.type = StatisticType.industry,
  });
}

/// Centralized statistics with source citations.
///
/// IMPORTANT: All statistics MUST be verifiable.
abstract final class AppStatistics {
  // Market Statistics (Industry Reports)
  static const marketSize = CitedStatistic(
    value: '\$2.9B+',
    label: 'market by 2030',
    source: 'Grand View Research, AI Observability Market Report 2024',
    sourceUrl: 'https://www.grandviewresearch.com/industry-analysis/ai-observability-market',
    type: StatisticType.industry,
  );

  static const marketGrowth = CitedStatistic(
    value: '25.47%',
    label: 'CAGR growth rate',
    source: 'Grand View Research, AI Observability Market Report 2024',
    sourceUrl: 'https://www.grandviewresearch.com/industry-analysis/ai-observability-market',
    type: StatisticType.industry,
  );

  static const enterpriseBudgets = CitedStatistic(
    value: '98%',
    label: 'enterprises increasing AI budgets',
    source: 'Gartner CIO Survey 2024',
    sourceUrl: 'https://www.gartner.com/en/information-technology/insights/cio-agenda',
    type: StatisticType.industry,
  );

  // Customer Results (Aggregated Internal Data)
  static const debuggingImprovement = CitedStatistic(
    value: '73%',
    label: 'faster debugging',
    source: 'Aggregated customer data, Q4 2024',
    type: StatisticType.customerData,
  );

  static const costReduction = CitedStatistic(
    value: '30-50%',
    label: 'LLM cost reduction',
    source: 'Customer-reported savings, 2024',
    type: StatisticType.customerData,
  );

  // Platform Metrics
  static const tracesProcessed = CitedStatistic(
    value: '10M+',
    label: 'traces processed',
    source: 'Platform metrics, December 2024',
    type: StatisticType.platformMetric,
  );

  static const setupTime = CitedStatistic(
    value: '5min',
    label: 'setup time',
    source: 'Median onboarding time, 2024',
    type: StatisticType.platformMetric,
  );

  // SLA Targets
  static const uptimeTarget = CitedStatistic(
    value: '99.9%',
    label: 'uptime SLA',
    source: 'Service Level Agreement target',
    type: StatisticType.slaTarget,
  );

  /// Footer disclaimer for statistics.
  static const sourceDisclaimer =
      'Statistics from customer data are aggregated and anonymized. '
      'Industry statistics sourced from third-party research reports. '
      'See integritystudio.ai/sources for full methodology and citations.';

  /// Get all industry statistics.
  static List<CitedStatistic> get industryStats => [
        marketSize,
        marketGrowth,
        enterpriseBudgets,
      ];

  /// Get all customer result statistics.
  static List<CitedStatistic> get customerStats => [
        debuggingImprovement,
        costReduction,
      ];
}

// =============================================================================
// CONTENT VARIANTS (A/B Testing)
// =============================================================================

/// A/B test variant identifiers.
abstract final class ContentVariants {
  static const String current = 'current';
  static const String legacy = 'legacy';
  static const String agentFirst = 'agent-first';
  static const String costFocused = 'cost-focused';
}
