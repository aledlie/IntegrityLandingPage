/// Centralized content configuration for the application.
///
/// This is the main barrel file that exports all content modules.
/// Import this file to access all content models and instances.
///
/// ## Architecture
///
/// Content is organized following DRY principles:
///
/// - **constants.dart**: Shared strings (CTAs, URLs, company info)
/// - **models.dart**: Pure data model classes
/// - **[section]_content.dart**: Static content instances for each section
///
/// ## Usage
///
/// ```dart
/// import 'package:integrity_studio_ai/config/content.dart';
///
/// // Access current content via AppContent
/// final hero = AppContent.hero;
/// final pricing = AppContent.pricing;
///
/// // Access specific variants for A/B testing
/// final heroB = HeroContentVariants.agentFirst;
///
/// // Access constants directly
/// final ctaText = CTAText.startFreeTrial;
/// final companyName = CompanyInfo.name;
/// ```
///
/// ## File Structure
///
/// ```
/// lib/config/
/// ├── content.dart           # This barrel file
/// └── content/
///     ├── constants.dart     # Shared strings and values
///     ├── models.dart        # Data model classes
///     ├── hero_content.dart
///     ├── pricing_content.dart
///     ├── features_content.dart
///     ├── cta_content.dart
///     ├── social_proof_content.dart
///     ├── status_content.dart
///     ├── footer_content.dart
///     ├── services_content.dart
///     ├── about_content.dart
///     ├── resources_content.dart
///     ├── contact_content.dart
///     └── comparison_content.dart
/// ```
library;

// Export constants
export 'content/constants.dart';

// Export models
export 'content/models.dart';

// Export content variants
export 'content/hero_content.dart';
export 'content/pricing_content.dart';
export 'content/features_content.dart';
export 'content/cta_content.dart';
export 'content/social_proof_content.dart';
export 'content/status_content.dart';
export 'content/footer_content.dart';
export 'content/services_content.dart';
export 'content/about_content.dart';
export 'content/resources_content.dart';
export 'content/contact_content.dart';
export 'content/comparison_content.dart';

// Import for AppContent class
import 'content/hero_content.dart';
import 'content/pricing_content.dart';
import 'content/features_content.dart';
import 'content/cta_content.dart';
import 'content/social_proof_content.dart';
import 'content/status_content.dart';
import 'content/footer_content.dart';
import 'content/services_content.dart';
import 'content/about_content.dart';
import 'content/resources_content.dart';
import 'content/contact_content.dart';
import 'content/comparison_content.dart';
import 'content/models.dart';

// =============================================================================
// CONTENT MANAGER
// =============================================================================

/// Centralized content manager providing access to current production content.
///
/// Usage:
/// ```dart
/// final heroContent = AppContent.hero;
/// final pricingContent = AppContent.pricing;
/// ```
///
/// For A/B testing, access variants directly:
/// ```dart
/// final heroVariant = HeroContentVariants.agentFirst;
/// ```
abstract final class AppContent {
  /// Current hero section content
  static HeroContent get hero => HeroContentVariants.current;

  /// Current pricing section content
  static PricingContent get pricing => PricingContentVariants.current;

  /// Current features section content
  static FeaturesContent get features => FeaturesContentVariants.current;

  /// Current CTA section content
  static CTAContent get cta => CTAContentVariants.current;

  /// Current social proof content
  static SocialProofContent get socialProof =>
      SocialProofContentVariants.placeholder;

  /// Current status section content
  static StatusContent get status => StatusContentVariants.current;

  /// Current footer content
  static FooterContent get footer => FooterContentVariants.current;

  /// Current services section content
  static ServicesContent get services => ServicesContentVariants.current;

  /// Current about section content
  static AboutContent get about => AboutContentVariants.current;

  /// Current resources section content
  static ResourcesContent get resources => ResourcesContentVariants.current;

  /// Current contact section content
  static ContactContent get contact => ContactContentVariants.current;

  /// WhyLabs comparison page content
  static ComparisonPageContent get whylabsComparison =>
      ComparisonPageVariants.whylabs;

  /// Arize AI comparison page content
  static ComparisonPageContent get arizeComparison =>
      ComparisonPageVariants.arize;

  /// Get hero content variant by name (for A/B testing)
  static HeroContent getHeroVariant(String variant) =>
      HeroContentVariants.getVariant(variant);
}
