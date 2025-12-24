/// Features section content.
library;

import 'package:lucide_icons/lucide_icons.dart';
import 'models.dart';

/// Features content variants.
abstract final class FeaturesContentVariants {
  /// Current production content
  /// Enhanced with compliance/EU AI Act features
  static const current = FeaturesContent(
    title: 'Platform Capabilities',
    subtitle: 'Comprehensive tools for AI application observability',
    features: _currentFeatures,
  );

  /// Legacy content (pre-audit)
  static const legacy = FeaturesContent(
    title: 'Platform Capabilities',
    subtitle: 'Comprehensive tools for AI application observability',
    features: _legacyFeatures,
  );

  static const _currentFeatures = [
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
  ];

  static const _legacyFeatures = [
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
  ];
}
