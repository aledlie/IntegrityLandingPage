import 'package:flutter/material.dart';
import '../../config/content.dart';
import '../../theme/theme.dart';
import '../../services/analytics.dart';
import '../common/cards.dart';
import '../common/containers.dart';

/// Features section showcasing platform capabilities
///
/// IMPORTANT: All feature claims should be verifiable.
/// Avoid unsubstantiated statistics.
///
/// Features:
/// - Externalized content via FeaturesContent (supports A/B testing)
/// - Responsive grid layout
/// - Analytics tracking on feature interactions
///
/// Usage:
/// ```dart
/// FeaturesSection(
///   content: FeaturesContent.current, // or AppContent.features
/// )
/// ```
class FeaturesSection extends StatelessWidget {
  final FeaturesContent content;

  const FeaturesSection({
    super.key,
    this.content = const FeaturesContent(
      title: 'Platform Capabilities',
      subtitle: 'Comprehensive tools for AI application observability',
      features: [],
    ),
  });

  // Use content from widget or fallback to AppContent
  FeaturesContent get _content =>
      content.features.isEmpty ? AppContent.features : content;

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      id: 'features',
      backgroundColor: AppColors.gray900,
      child: Column(
        children: [
          // Section header
          SectionTitle(
            title: _content.title,
            subtitle: _content.subtitle,
          ),

          SizedBox(height: AppSpacing.sectionPadding(context) * 0.75),

          // Feature grid
          ResponsiveGrid(
            mobileColumns: 1,
            tabletColumns: 2,
            desktopColumns: 3,
            children: _content.features
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
