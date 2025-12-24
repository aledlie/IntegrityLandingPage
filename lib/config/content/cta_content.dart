/// CTA section content.
library;

import 'models.dart';
import 'constants.dart';

/// CTA section content variants.
abstract final class CTAContentVariants {
  /// Current production content
  static const current = CTAContent(
    headline: 'Ready to Gain Visibility Into Your AI?',
    subheadline: 'Join teams who trust ${CompanyInfo.name} for AI observability '
        'with compliance built-in.',
    primaryCTA: CTAText.startFreeTrial,
    secondaryCTA: CTAText.scheduledDemo,
  );

  /// Legacy content
  static const legacy = CTAContent(
    headline: 'Ready to Gain Visibility Into Your AI?',
    subheadline: 'Join thousands of teams who trust ${CompanyInfo.name} for '
        'their AI observability needs.',
    primaryCTA: CTAText.startFreeTrial,
    secondaryCTA: CTAText.scheduledDemo,
  );
}
