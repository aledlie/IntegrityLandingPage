/// Social proof section content.
library;

import 'models.dart';
import 'constants.dart';

/// Social proof content.
abstract final class SocialProofContentVariants {
  /// Placeholder content (to be replaced with real customers)
  static const placeholder = SocialProofContent(
    title: 'Trusted by AI Teams',
    logos: _placeholderLogos,
    testimonials: _placeholderTestimonials,
    statsHeadline: 'Enterprise-Grade Performance',
    stats: {
      'Traces Processed': PlatformMetrics.tracesProcessed,
      'Uptime': PlatformMetrics.uptime,
      'Setup Time': '< ${PlatformMetrics.setupTime}',
    },
  );

  static const _placeholderLogos = [
    CustomerLogoContent(name: 'Enterprise Client', industry: 'Finance'),
    CustomerLogoContent(name: 'Tech Startup', industry: 'SaaS'),
    CustomerLogoContent(name: 'Healthcare Co', industry: 'Healthcare'),
  ];

  static const _placeholderTestimonials = [
    TestimonialContent(
      quote: '${CompanyInfo.name} gave us the visibility we needed to ship AI '
          'features with confidence. The compliance reports saved us weeks.',
      author: 'Engineering Lead',
      role: 'VP Engineering',
      company: 'Tech Company',
    ),
  ];
}
