import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../theme/theme.dart';
import '../../services/analytics.dart';
import '../common/cards.dart';
import '../common/containers.dart';

/// Features section showcasing platform capabilities
///
/// IMPORTANT: All feature claims should be verifiable.
/// Avoid unsubstantiated statistics.
///
/// Usage:
/// ```dart
/// FeaturesSection()
/// ```
class FeaturesSection extends StatelessWidget {
  const FeaturesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      id: 'features',
      backgroundColor: AppColors.gray900,
      child: Column(
        children: [
          // Section header
          const SectionTitle(
            title: 'Platform Capabilities',
            subtitle: 'Comprehensive tools for AI application observability',
          ),

          SizedBox(height: AppSpacing.sectionPadding(context) * 0.75),

          // Feature grid
          ResponsiveGrid(
            mobileColumns: 1,
            tabletColumns: 2,
            desktopColumns: 3,
            children: _features
                .map((feature) => FeatureCard(
                      icon: feature.icon,
                      title: feature.title,
                      description: feature.description,
                      features: feature.bullets,
                      onTap: () {
                        AnalyticsService.trackFeatureInteraction(feature.title);
                      },
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _FeatureData {
  final IconData icon;
  final String title;
  final String description;
  final List<String> bullets;

  const _FeatureData({
    required this.icon,
    required this.title,
    required this.description,
    required this.bullets,
  });
}

const List<_FeatureData> _features = [
  _FeatureData(
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
  _FeatureData(
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
  _FeatureData(
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
  _FeatureData(
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
  _FeatureData(
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
  _FeatureData(
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
