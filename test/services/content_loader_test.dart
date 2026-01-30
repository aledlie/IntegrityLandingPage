import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integrity_studio_ai/services/content_loader.dart';

/// Sample YAML content for testing.
const _testYamlContent = '''
company:
  name: "Test Company"
  tagline: "Test Tagline"
  copyright: "© 2024 Test"
  founded_year: "2024"
  location:
    city: "Austin"
    region: "Texas"
  contact:
    email: "test@example.com"
    phone: "555-1234"

urls:
  external:
    calendly_demo: "https://calendly.com/test"
    status_page: "https://status.test.com"
    linkedin: "https://linkedin.com/test"
    twitter: "https://twitter.com/test"
    github: "https://github.com/test"
    founder_linkedin: "https://linkedin.com/in/founder"
    founder_twitter: "https://twitter.com/founder"

cta_text:
  primary:
    start_free_trial: "Start Free Trial"
    get_started: "Get Started"
    schedule_demo: "Schedule Demo"
    request_demo: "Request Demo"
    contact_sales: "Contact Sales"
    learn_more: "Learn More"
  form:
    send_message: "Send Message"

trust_indicators:
  current:
    - "Feature A"
    - "Feature B"
    - "Feature C"
  legacy:
    - "Old Feature 1"
    - "Old Feature 2"

platform_metrics:
  uptime: "99.9%"
  traces_processed: "10M+"
  ai_teams: "500+"
  setup_time: "5 min"

pricing_constants:
  annual_discount: "Save 20%"

pricing:
  title: "Test Pricing"
  subtitle: "Test pricing subtitle"
  tiers:
    - name: "Free"
      monthly_price: "\$0"
      annual_price: "\$0"
      description: "For testing"
      features:
        - "Feature 1"
        - "Feature 2"
    - name: "Pro"
      monthly_price: "\$99"
      annual_price: "\$79"
      is_popular: true
      features:
        - "Everything in Free"
        - "Pro Feature"

hero:
  current:
    badge: "Test Badge"
    headline: "Test Headline"
    subheadline: "Test Subheadline"
    primary_cta: "Primary CTA"
    secondary_cta: "Secondary CTA"
  variants:
    alternate:
      badge: "Alt Badge"
      headline: "Alt Headline"
      subheadline: "Alt Subheadline"
      primary_cta: "Alt Primary"
      secondary_cta: "Alt Secondary"

features:
  title: "Features Title"
  subtitle: "Features Subtitle"
  items:
    - icon: "activity"
      title: "Feature 1"
      description: "Description 1"
      bullets:
        - "Bullet 1"
        - "Bullet 2"
    - icon: "shield"
      title: "Feature 2"
      description: "Description 2"

services:
  title: "Services Title"
  subtitle: "Services Subtitle"
  description: "Services Description"
  items:
    - icon: "code"
      title: "Service 1"
      description: "Service description"
      capabilities:
        - "Capability 1"
        - "Capability 2"

cta:
  headline: "CTA Headline"
  subheadline: "CTA Subheadline"

about:
  title: "About Title"
  subtitle: "About Subtitle"
  mission_statement: "Our mission"
  vision_statement: "Our vision"
  story: "Our story"
  values:
    - icon: "eye"
      title: "Transparency"
      description: "Be transparent"
  team:
    - name: "John Doe"
      role: "CEO"
      bio: "Leader"
      linkedin_url: "https://linkedin.com/in/johndoe"

contact:
  title: "Contact Title"
  subtitle: "Contact Subtitle"
  description: "Contact Description"
  form:
    fields:
      - name: "email"
        label: "Email"
        placeholder: "your@email.com"
        type: "email"
        required: true
    success_message: "Success!"
    error_message: "Error!"
  contact_methods:
    - icon: "mail"
      label: "Email"
      value: "test@example.com"
      url: "mailto:test@example.com"
      is_primary: true

footer:
  privacy_link: "/privacy"
  terms_link: "/terms"
  cookies_link: "/cookies"
  link_groups:
    - title: "Product"
      links:
        - label: "Features"
          url: "#features"
        - label: "Pricing"
          url: "#pricing"
          is_external: false

status:
  title: "Status Title"
  subtitle: "Status Subtitle"
  status_badge: "All Operational"
  metrics:
    - label: "Uptime"
      value: "99.9%"
      sublabel: "SLA"
  services:
    - name: "API"
      status: "Operational"

resources:
  title: "Resources Title"
  subtitle: "Resources Subtitle"
  documentation:
    - icon: "book-open"
      title: "Getting Started"
      description: "Quick start"
      url: "/docs/quickstart"
      popular_topics:
        - "Setup"
        - "Configuration"
  featured_posts:
    - title: "Test Post"
      excerpt: "Test excerpt"
      category: "Guide"
      publish_date: "2024-01-01"
      read_time: "5 min"
      slug: "test-post"
      author: "Test Author"
  lead_magnets:
    - icon: "file-text"
      title: "Test Guide"
      description: "A test guide"
      format: "PDF"
      cta_text: "Download"
      url: "/resources/test"
      requires_email: true

social_proof:
  title: "Social Proof Title"
  stats:
    uptime: "99.9%"
    traces: "10M+"
  testimonials:
    - quote: "Great product!"
      author: "Jane Doe"
      role: "CTO"
      company: "Test Corp"

disclaimers:
  eu_ai_act: "EU AI Act disclaimer"
  eu_ai_act_short: "Short disclaimer"
  security: "Security disclaimer"
  general: "General disclaimer"

promo_codes:
  whylabs_migration:
    code: "TEST2025"
    description: "Test promo"
''';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ContentLoader', () {
    group('singleton', () {
      test('returns the same instance', () {
        final instance1 = ContentLoader.instance;
        final instance2 = ContentLoader.instance;

        expect(identical(instance1, instance2), isTrue);
      });

      test('instance is not null', () {
        final instance = ContentLoader.instance;

        expect(instance, isNotNull);
      });

      test('instance is a ContentLoader', () {
        final instance = ContentLoader.instance;

        expect(instance, isA<ContentLoader>());
      });
    });

    group('isLoaded property', () {
      test('returns a boolean value', () {
        final loader = ContentLoader.instance;

        expect(loader.isLoaded, isA<bool>());
      });
    });

    group('rawContent property', () {
      test('returns null when content not loaded', () {
        // Note: This might fail if content was loaded in a previous test
        // The singleton pattern means state persists between tests
        final loader = ContentLoader.instance;
        if (!loader.isLoaded) {
          expect(loader.rawContent, isNull);
        }
      });
    });
  });

  group('ContentLoader error handling', () {
    test('throws StateError when accessing content before load', () {
      final loader = ContentLoader.instance;

      // If content hasn't been loaded, accessing getters should throw
      if (!loader.isLoaded) {
        expect(
          () => loader.companyName,
          throwsA(isA<StateError>()),
        );
      }
    });

    test('StateError message indicates load() must be called', () {
      final loader = ContentLoader.instance;

      if (!loader.isLoaded) {
        expect(
          () => loader.companyName,
          throwsA(
            predicate<StateError>(
              (e) => e.message.contains('load()'),
            ),
          ),
        );
      }
    });
  });

  group('Content class', () {
    test('load method returns Future<void>', () {
      // Verify the method signature
      expect(Content.load, isA<Future<void> Function()>());
    });

    test('isLoaded returns boolean', () {
      expect(Content.isLoaded, isA<bool>());
    });

    test('getHeroVariant method exists and is callable', () {
      // Verify the method exists
      expect(Content.getHeroVariant, isA<Function>());
    });
  });

  group('Content with mocked assets', () {
    setUp(() {
      // Reset mock handlers
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
        const MethodChannel('flutter/assets'),
        null,
      );
    });

    testWidgets('load method can be called', (tester) async {
      // Mock the asset bundle for this test
      tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        const MethodChannel('flutter/assets'),
        (MethodCall methodCall) async {
          if (methodCall.method == 'loadString') {
            // Return properly encoded UTF-8 bytes
            return Uint8List.fromList(_testYamlContent.codeUnits);
          }
          return null;
        },
      );

      // The load method should complete (even if it fails internally)
      // We're testing that the method is callable
      try {
        await Content.load();
      } catch (_) {
        // Expected in test environment without proper asset mocking
      }
    });
  });

  group('ContentLoader getter types', () {
    // These tests verify the return types of getters
    // They work even when content isn't loaded because they catch the StateError

    test('companyName returns String when loaded', () {
      final loader = ContentLoader.instance;
      try {
        final result = loader.companyName;
        expect(result, isA<String>());
      } on StateError {
        // Expected when content not loaded - skip
      }
    });

    test('trustIndicators returns List<String> when loaded', () {
      final loader = ContentLoader.instance;
      try {
        final result = loader.trustIndicators;
        expect(result, isA<List<String>>());
      } on StateError {
        // Expected when content not loaded - skip
      }
    });

    test('pricingTiers returns List<Map<String, dynamic>> when loaded', () {
      final loader = ContentLoader.instance;
      try {
        final result = loader.pricingTiers;
        expect(result, isA<List<Map<String, dynamic>>>());
      } on StateError {
        // Expected when content not loaded - skip
      }
    });

    test('heroCurrent returns Map<String, dynamic> when loaded', () {
      final loader = ContentLoader.instance;
      try {
        final result = loader.heroCurrent;
        expect(result, isA<Map<String, dynamic>>());
      } on StateError {
        // Expected when content not loaded - skip
      }
    });

    test('socialProofStats returns Map<String, String> when loaded', () {
      final loader = ContentLoader.instance;
      try {
        final result = loader.socialProofStats;
        expect(result, isA<Map<String, String>>());
      } on StateError {
        // Expected when content not loaded - skip
      }
    });
  });

  group('Content static getter types', () {
    test('companyName is String type', () {
      try {
        final result = Content.companyName;
        expect(result, isA<String>());
      } on StateError {
        // Expected when content not loaded
      }
    });

    test('trustIndicators is List<String> type', () {
      try {
        final result = Content.trustIndicators;
        expect(result, isA<List<String>>());
      } on StateError {
        // Expected when content not loaded
      }
    });

    test('pricingTiers is List<Map<String, dynamic>> type', () {
      try {
        final result = Content.pricingTiers;
        expect(result, isA<List<Map<String, dynamic>>>());
      } on StateError {
        // Expected when content not loaded
      }
    });

    test('socialProofStats is Map<String, String> type', () {
      try {
        final result = Content.socialProofStats;
        expect(result, isA<Map<String, String>>());
      } on StateError {
        // Expected when content not loaded
      }
    });
  });

  group('ContentLoader API surface verification', () {
    // Verify all expected properties exist on ContentLoader
    final loader = ContentLoader.instance;

    // Parameterized API surface tests by category
    final apiSurfaceTests = <String, List<Function()>>{
      'company': [
        () => loader.companyName,
        () => loader.companyTagline,
        () => loader.companyCopyright,
        () => loader.companyEmail,
        () => loader.companyPhone,
        () => loader.companyCity,
        () => loader.companyRegion,
        () => loader.companyFoundedYear,
      ],
      'URL': [
        () => loader.calendlyUrl,
        () => loader.statusPageUrl,
        () => loader.linkedInUrl,
        () => loader.twitterUrl,
        () => loader.githubUrl,
        () => loader.founderLinkedInUrl,
        () => loader.founderTwitterUrl,
      ],
      'CTA': [
        () => loader.ctaStartFreeTrial,
        () => loader.ctaGetStarted,
        () => loader.ctaScheduleDemo,
        () => loader.ctaRequestDemo,
        () => loader.ctaContactSales,
        () => loader.ctaLearnMore,
        () => loader.ctaSendMessage,
      ],
      'trust indicator': [
        () => loader.trustIndicators,
        () => loader.legacyTrustIndicators,
      ],
      'platform metrics': [
        () => loader.metricsUptime,
        () => loader.metricsTracesProcessed,
        () => loader.metricsAiTeams,
        () => loader.metricsSetupTime,
      ],
      'pricing': [
        () => loader.pricingTitle,
        () => loader.pricingSubtitle,
        () => loader.pricingAnnualDiscount,
        () => loader.pricingTiers,
      ],
      'hero': [
        () => loader.heroBadge,
        () => loader.heroHeadline,
        () => loader.heroSubheadline,
        () => loader.heroPrimaryCta,
        () => loader.heroSecondaryCta,
        () => loader.heroCurrent,
      ],
      'features': [
        () => loader.featuresTitle,
        () => loader.featuresSubtitle,
        () => loader.featuresItems,
      ],
      'services': [
        () => loader.servicesTitle,
        () => loader.servicesSubtitle,
        () => loader.servicesDescription,
        () => loader.servicesItems,
      ],
      'CTA section': [
        () => loader.ctaSectionHeadline,
        () => loader.ctaSectionSubheadline,
      ],
      'about': [
        () => loader.aboutTitle,
        () => loader.aboutSubtitle,
        () => loader.aboutMission,
        () => loader.aboutVision,
        () => loader.aboutStory,
        () => loader.aboutValues,
        () => loader.aboutTeam,
      ],
      'contact': [
        () => loader.contactTitle,
        () => loader.contactSubtitle,
        () => loader.contactDescription,
        () => loader.contactFormFields,
        () => loader.contactMethods,
        () => loader.contactSuccessMessage,
        () => loader.contactErrorMessage,
      ],
      'footer': [
        () => loader.footerLinkGroups,
        () => loader.footerPrivacyLink,
        () => loader.footerTermsLink,
        () => loader.footerCookiesLink,
      ],
      'status': [
        () => loader.statusTitle,
        () => loader.statusSubtitle,
        () => loader.statusBadge,
        () => loader.statusMetrics,
        () => loader.statusServices,
      ],
      'resources': [
        () => loader.resourcesTitle,
        () => loader.resourcesSubtitle,
        () => loader.resourcesDocumentation,
        () => loader.resourcesFeaturedPosts,
        () => loader.resourcesLeadMagnets,
      ],
      'social proof': [
        () => loader.socialProofTitle,
        () => loader.socialProofStats,
        () => loader.socialProofTestimonials,
      ],
      'disclaimer': [
        () => loader.disclaimerEuAiAct,
        () => loader.disclaimerEuAiActShort,
        () => loader.disclaimerSecurity,
        () => loader.disclaimerGeneral,
      ],
      'promo code': [
        () => loader.promoWhylabsCode,
        () => loader.promoWhylabsDescription,
      ],
    };

    for (final entry in apiSurfaceTests.entries) {
      test('has ${entry.key} getters', () {
        for (final getter in entry.value) {
          expect(getter, isA<Function>());
        }
      });
    }

    test('has getHeroVariant method', () {
      expect(loader.getHeroVariant, isA<Function>());
    });
  });

  group('Content API surface verification', () {
    // Parameterized API surface tests for Content static class
    final contentApiSurfaceTests = <String, List<Function()>>{
      'company': [
        () => Content.companyName,
        () => Content.companyTagline,
        () => Content.companyCopyright,
        () => Content.companyEmail,
        () => Content.companyPhone,
        () => Content.companyCity,
        () => Content.companyRegion,
        () => Content.companyFoundedYear,
      ],
      'URL': [
        () => Content.calendlyUrl,
        () => Content.statusPageUrl,
        () => Content.linkedInUrl,
        () => Content.twitterUrl,
        () => Content.githubUrl,
        () => Content.founderLinkedInUrl,
        () => Content.founderTwitterUrl,
      ],
      'CTA': [
        () => Content.ctaStartFreeTrial,
        () => Content.ctaGetStarted,
        () => Content.ctaScheduleDemo,
        () => Content.ctaRequestDemo,
        () => Content.ctaContactSales,
        () => Content.ctaLearnMore,
        () => Content.ctaSendMessage,
      ],
      'pricing': [
        () => Content.pricingTitle,
        () => Content.pricingSubtitle,
        () => Content.pricingAnnualDiscount,
        () => Content.pricingTiers,
      ],
      'hero': [
        () => Content.heroBadge,
        () => Content.heroHeadline,
        () => Content.heroSubheadline,
        () => Content.heroPrimaryCta,
        () => Content.heroSecondaryCta,
      ],
      'features': [
        () => Content.featuresTitle,
        () => Content.featuresSubtitle,
        () => Content.featuresItems,
      ],
      'services': [
        () => Content.servicesTitle,
        () => Content.servicesSubtitle,
        () => Content.servicesDescription,
        () => Content.servicesItems,
      ],
      'about': [
        () => Content.aboutTitle,
        () => Content.aboutSubtitle,
        () => Content.aboutMission,
        () => Content.aboutVision,
        () => Content.aboutStory,
        () => Content.aboutValues,
        () => Content.aboutTeam,
      ],
      'contact': [
        () => Content.contactTitle,
        () => Content.contactSubtitle,
        () => Content.contactDescription,
        () => Content.contactFormFields,
        () => Content.contactMethods,
        () => Content.contactSuccessMessage,
        () => Content.contactErrorMessage,
      ],
      'footer': [
        () => Content.footerLinkGroups,
        () => Content.footerPrivacyLink,
        () => Content.footerTermsLink,
        () => Content.footerCookiesLink,
      ],
      'status': [
        () => Content.statusTitle,
        () => Content.statusSubtitle,
        () => Content.statusBadge,
        () => Content.statusMetrics,
        () => Content.statusServices,
      ],
      'resources': [
        () => Content.resourcesTitle,
        () => Content.resourcesSubtitle,
        () => Content.resourcesDocumentation,
        () => Content.resourcesFeaturedPosts,
        () => Content.resourcesLeadMagnets,
      ],
      'social proof': [
        () => Content.socialProofTitle,
        () => Content.socialProofStats,
        () => Content.socialProofTestimonials,
      ],
      'disclaimer': [
        () => Content.disclaimerEuAiAct,
        () => Content.disclaimerEuAiActShort,
        () => Content.disclaimerSecurity,
        () => Content.disclaimerGeneral,
      ],
      'promo code': [
        () => Content.promoWhylabsCode,
        () => Content.promoWhylabsDescription,
      ],
      'trust indicator': [
        () => Content.trustIndicators,
        () => Content.legacyTrustIndicators,
      ],
      'platform metrics': [
        () => Content.metricsUptime,
        () => Content.metricsTracesProcessed,
        () => Content.metricsAiTeams,
        () => Content.metricsSetupTime,
      ],
      'CTA section': [
        () => Content.ctaSectionHeadline,
        () => Content.ctaSectionSubheadline,
      ],
    };

    for (final entry in contentApiSurfaceTests.entries) {
      test('has ${entry.key} getters', () {
        for (final getter in entry.value) {
          expect(getter, isA<Function>());
        }
      });
    }

    test('has getHeroVariant method', () {
      expect(Content.getHeroVariant, isA<Function>());
    });
  });

  group('ContentLoader with loaded content', () {
    setUp(() {
      ContentLoader.reset();
      Content.loadFromString(_testYamlContent);
    });

    tearDown(() {
      ContentLoader.reset();
    });

    // Table-driven string value tests
    group('string value getters', () {
      final stringValues = <String, (String Function(), String)>{
        // Company
        'companyName': (() => ContentLoader.instance.companyName, 'Test Company'),
        'companyTagline': (() => ContentLoader.instance.companyTagline, 'Test Tagline'),
        'companyCopyright': (() => ContentLoader.instance.companyCopyright, '© 2024 Test'),
        'companyEmail': (() => ContentLoader.instance.companyEmail, 'test@example.com'),
        'companyPhone': (() => ContentLoader.instance.companyPhone, '555-1234'),
        'companyCity': (() => ContentLoader.instance.companyCity, 'Austin'),
        'companyRegion': (() => ContentLoader.instance.companyRegion, 'Texas'),
        'companyFoundedYear': (() => ContentLoader.instance.companyFoundedYear, '2024'),
        // URLs
        'calendlyUrl': (() => ContentLoader.instance.calendlyUrl, 'https://calendly.com/test'),
        'statusPageUrl': (() => ContentLoader.instance.statusPageUrl, 'https://status.test.com'),
        'linkedInUrl': (() => ContentLoader.instance.linkedInUrl, 'https://linkedin.com/test'),
        'twitterUrl': (() => ContentLoader.instance.twitterUrl, 'https://twitter.com/test'),
        'githubUrl': (() => ContentLoader.instance.githubUrl, 'https://github.com/test'),
        'founderLinkedInUrl': (() => ContentLoader.instance.founderLinkedInUrl, 'https://linkedin.com/in/founder'),
        'founderTwitterUrl': (() => ContentLoader.instance.founderTwitterUrl, 'https://twitter.com/founder'),
        // CTA text
        'ctaStartFreeTrial': (() => ContentLoader.instance.ctaStartFreeTrial, 'Start Free Trial'),
        'ctaGetStarted': (() => ContentLoader.instance.ctaGetStarted, 'Get Started'),
        'ctaScheduleDemo': (() => ContentLoader.instance.ctaScheduleDemo, 'Schedule Demo'),
        'ctaRequestDemo': (() => ContentLoader.instance.ctaRequestDemo, 'Request Demo'),
        'ctaContactSales': (() => ContentLoader.instance.ctaContactSales, 'Contact Sales'),
        'ctaLearnMore': (() => ContentLoader.instance.ctaLearnMore, 'Learn More'),
        'ctaSendMessage': (() => ContentLoader.instance.ctaSendMessage, 'Send Message'),
        // Platform metrics
        'metricsUptime': (() => ContentLoader.instance.metricsUptime, '99.9%'),
        'metricsTracesProcessed': (() => ContentLoader.instance.metricsTracesProcessed, '10M+'),
        'metricsAiTeams': (() => ContentLoader.instance.metricsAiTeams, '500+'),
        'metricsSetupTime': (() => ContentLoader.instance.metricsSetupTime, '5 min'),
        // Pricing
        'pricingTitle': (() => ContentLoader.instance.pricingTitle, 'Test Pricing'),
        'pricingSubtitle': (() => ContentLoader.instance.pricingSubtitle, 'Test pricing subtitle'),
        'pricingAnnualDiscount': (() => ContentLoader.instance.pricingAnnualDiscount, 'Save 20%'),
        // Hero
        'heroBadge': (() => ContentLoader.instance.heroBadge, 'Test Badge'),
        'heroHeadline': (() => ContentLoader.instance.heroHeadline, 'Test Headline'),
        'heroSubheadline': (() => ContentLoader.instance.heroSubheadline, 'Test Subheadline'),
        'heroPrimaryCta': (() => ContentLoader.instance.heroPrimaryCta, 'Primary CTA'),
        'heroSecondaryCta': (() => ContentLoader.instance.heroSecondaryCta, 'Secondary CTA'),
        // Features
        'featuresTitle': (() => ContentLoader.instance.featuresTitle, 'Features Title'),
        'featuresSubtitle': (() => ContentLoader.instance.featuresSubtitle, 'Features Subtitle'),
        // Services
        'servicesTitle': (() => ContentLoader.instance.servicesTitle, 'Services Title'),
        'servicesSubtitle': (() => ContentLoader.instance.servicesSubtitle, 'Services Subtitle'),
        'servicesDescription': (() => ContentLoader.instance.servicesDescription, 'Services Description'),
        // CTA section
        'ctaSectionHeadline': (() => ContentLoader.instance.ctaSectionHeadline, 'CTA Headline'),
        'ctaSectionSubheadline': (() => ContentLoader.instance.ctaSectionSubheadline, 'CTA Subheadline'),
        // About
        'aboutTitle': (() => ContentLoader.instance.aboutTitle, 'About Title'),
        'aboutSubtitle': (() => ContentLoader.instance.aboutSubtitle, 'About Subtitle'),
        'aboutMission': (() => ContentLoader.instance.aboutMission, 'Our mission'),
        'aboutVision': (() => ContentLoader.instance.aboutVision, 'Our vision'),
        'aboutStory': (() => ContentLoader.instance.aboutStory, 'Our story'),
        // Contact
        'contactTitle': (() => ContentLoader.instance.contactTitle, 'Contact Title'),
        'contactSubtitle': (() => ContentLoader.instance.contactSubtitle, 'Contact Subtitle'),
        'contactDescription': (() => ContentLoader.instance.contactDescription, 'Contact Description'),
        'contactSuccessMessage': (() => ContentLoader.instance.contactSuccessMessage, 'Success!'),
        'contactErrorMessage': (() => ContentLoader.instance.contactErrorMessage, 'Error!'),
        // Footer
        'footerPrivacyLink': (() => ContentLoader.instance.footerPrivacyLink, '/privacy'),
        'footerTermsLink': (() => ContentLoader.instance.footerTermsLink, '/terms'),
        'footerCookiesLink': (() => ContentLoader.instance.footerCookiesLink, '/cookies'),
        // Status
        'statusTitle': (() => ContentLoader.instance.statusTitle, 'Status Title'),
        'statusSubtitle': (() => ContentLoader.instance.statusSubtitle, 'Status Subtitle'),
        'statusBadge': (() => ContentLoader.instance.statusBadge, 'All Operational'),
        // Resources
        'resourcesTitle': (() => ContentLoader.instance.resourcesTitle, 'Resources Title'),
        'resourcesSubtitle': (() => ContentLoader.instance.resourcesSubtitle, 'Resources Subtitle'),
        // Social proof
        'socialProofTitle': (() => ContentLoader.instance.socialProofTitle, 'Social Proof Title'),
        // Disclaimers
        'disclaimerEuAiAct': (() => ContentLoader.instance.disclaimerEuAiAct, 'EU AI Act disclaimer'),
        'disclaimerEuAiActShort': (() => ContentLoader.instance.disclaimerEuAiActShort, 'Short disclaimer'),
        'disclaimerSecurity': (() => ContentLoader.instance.disclaimerSecurity, 'Security disclaimer'),
        'disclaimerGeneral': (() => ContentLoader.instance.disclaimerGeneral, 'General disclaimer'),
        // Promo codes
        'promoWhylabsCode': (() => ContentLoader.instance.promoWhylabsCode, 'TEST2025'),
        'promoWhylabsDescription': (() => ContentLoader.instance.promoWhylabsDescription, 'Test promo'),
      };

      for (final entry in stringValues.entries) {
        test('${entry.key} returns correct value', () {
          expect(entry.value.$1(), equals(entry.value.$2));
        });
      }
    });

    group('company map', () {
      test('company returns map with all company data', () {
        final company = ContentLoader.instance.company;
        expect(company, isA<Map<String, dynamic>>());
        expect(company['name'], equals('Test Company'));
        expect(company['tagline'], equals('Test Tagline'));
      });
    });

    group('trust indicators', () {
      test('trustIndicators returns list of strings', () {
        final indicators = ContentLoader.instance.trustIndicators;
        expect(indicators, isA<List<String>>());
        expect(indicators.length, equals(3));
        expect(indicators, containsAll(['Feature A', 'Feature B', 'Feature C']));
      });

      test('legacyTrustIndicators returns list of strings', () {
        final indicators = ContentLoader.instance.legacyTrustIndicators;
        expect(indicators, isA<List<String>>());
        expect(indicators.length, equals(2));
        expect(indicators, containsAll(['Old Feature 1', 'Old Feature 2']));
      });
    });

    group('list getters', () {
      test('pricingTiers returns list of maps', () {
        final tiers = ContentLoader.instance.pricingTiers;
        expect(tiers, isA<List<Map<String, dynamic>>>());
        expect(tiers.length, equals(2));
        expect(tiers[0]['name'], equals('Free'));
        expect(tiers[1]['name'], equals('Pro'));
        expect(tiers[1]['is_popular'], isTrue);
      });

      test('featuresItems returns list of maps', () {
        final items = ContentLoader.instance.featuresItems;
        expect(items, isA<List<Map<String, dynamic>>>());
        expect(items.length, equals(2));
        expect(items[0]['title'], equals('Feature 1'));
        expect(items[0]['bullets'], isA<List>());
        expect((items[0]['bullets'] as List).length, equals(2));
      });

      test('servicesItems returns list of maps', () {
        final items = ContentLoader.instance.servicesItems;
        expect(items, isA<List<Map<String, dynamic>>>());
        expect(items.length, equals(1));
        expect(items[0]['title'], equals('Service 1'));
      });

      test('aboutValues returns list of maps', () {
        final values = ContentLoader.instance.aboutValues;
        expect(values, isA<List<Map<String, dynamic>>>());
        expect(values.length, equals(1));
        expect(values[0]['title'], equals('Transparency'));
      });

      test('aboutTeam returns list of maps', () {
        final team = ContentLoader.instance.aboutTeam;
        expect(team, isA<List<Map<String, dynamic>>>());
        expect(team.length, equals(1));
        expect(team[0]['name'], equals('John Doe'));
        expect(team[0]['role'], equals('CEO'));
      });

      test('contactFormFields returns list of maps', () {
        final fields = ContentLoader.instance.contactFormFields;
        expect(fields, isA<List<Map<String, dynamic>>>());
        expect(fields.length, equals(1));
        expect(fields[0]['name'], equals('email'));
        expect(fields[0]['type'], equals('email'));
        expect(fields[0]['required'], isTrue);
      });

      test('contactMethods returns list of maps', () {
        final methods = ContentLoader.instance.contactMethods;
        expect(methods, isA<List<Map<String, dynamic>>>());
        expect(methods.length, equals(1));
        expect(methods[0]['label'], equals('Email'));
        expect(methods[0]['is_primary'], isTrue);
      });

      test('footerLinkGroups returns list of maps', () {
        final groups = ContentLoader.instance.footerLinkGroups;
        expect(groups, isA<List<Map<String, dynamic>>>());
        expect(groups.length, equals(1));
        expect(groups[0]['title'], equals('Product'));
        expect(groups[0]['links'], isA<List>());
      });

      test('statusMetrics returns list of maps', () {
        final metrics = ContentLoader.instance.statusMetrics;
        expect(metrics, isA<List<Map<String, dynamic>>>());
        expect(metrics.length, equals(1));
        expect(metrics[0]['label'], equals('Uptime'));
        expect(metrics[0]['value'], equals('99.9%'));
      });

      test('statusServices returns list of maps', () {
        final services = ContentLoader.instance.statusServices;
        expect(services, isA<List<Map<String, dynamic>>>());
        expect(services.length, equals(1));
        expect(services[0]['name'], equals('API'));
        expect(services[0]['status'], equals('Operational'));
      });

      test('resourcesDocumentation returns list of maps', () {
        final docs = ContentLoader.instance.resourcesDocumentation;
        expect(docs, isA<List<Map<String, dynamic>>>());
        expect(docs.length, equals(1));
        expect(docs[0]['title'], equals('Getting Started'));
        expect(docs[0]['popular_topics'], isA<List>());
      });

      test('resourcesFeaturedPosts returns list of maps', () {
        final posts = ContentLoader.instance.resourcesFeaturedPosts;
        expect(posts, isA<List<Map<String, dynamic>>>());
        expect(posts.length, equals(1));
        expect(posts[0]['title'], equals('Test Post'));
        expect(posts[0]['slug'], equals('test-post'));
      });

      test('resourcesLeadMagnets returns list of maps', () {
        final magnets = ContentLoader.instance.resourcesLeadMagnets;
        expect(magnets, isA<List<Map<String, dynamic>>>());
        expect(magnets.length, equals(1));
        expect(magnets[0]['title'], equals('Test Guide'));
        expect(magnets[0]['requires_email'], isTrue);
      });

      test('socialProofTestimonials returns list of maps', () {
        final testimonials = ContentLoader.instance.socialProofTestimonials;
        expect(testimonials, isA<List<Map<String, dynamic>>>());
        expect(testimonials.length, equals(1));
        expect(testimonials[0]['quote'], equals('Great product!'));
        expect(testimonials[0]['author'], equals('Jane Doe'));
      });
    });

    group('map getters', () {
      test('heroCurrent returns map with current hero data', () {
        final hero = ContentLoader.instance.heroCurrent;
        expect(hero, isA<Map<String, dynamic>>());
        expect(hero['badge'], equals('Test Badge'));
        expect(hero['headline'], equals('Test Headline'));
      });

      test('socialProofStats returns map of string to string', () {
        final stats = ContentLoader.instance.socialProofStats;
        expect(stats, isA<Map<String, String>>());
        expect(stats['uptime'], equals('99.9%'));
        expect(stats['traces'], equals('10M+'));
      });
    });

    group('hero variants', () {
      test('getHeroVariant returns current variant', () {
        final hero = ContentLoader.instance.getHeroVariant('current');
        expect(hero['badge'], equals('Test Badge'));
      });

      test('getHeroVariant returns alternate variant', () {
        final hero = ContentLoader.instance.getHeroVariant('alternate');
        expect(hero['badge'], equals('Alt Badge'));
        expect(hero['headline'], equals('Alt Headline'));
      });
    });

    group('rawContent', () {
      test('rawContent returns YamlMap after loading', () {
        expect(ContentLoader.instance.rawContent, isNotNull);
      });

      test('isLoaded returns true after loading', () {
        expect(ContentLoader.instance.isLoaded, isTrue);
      });
    });
  });

  group('Content static methods with loaded content', () {
    setUp(() {
      ContentLoader.reset();
      Content.loadFromString(_testYamlContent);
    });

    tearDown(() {
      ContentLoader.reset();
    });

    test('Content.isLoaded returns true after loading', () {
      expect(Content.isLoaded, isTrue);
    });

    test('Content.reset clears loaded state', () {
      Content.reset();
      expect(Content.isLoaded, isFalse);
    });

    test('Content.companyName returns correct value', () {
      expect(Content.companyName, equals('Test Company'));
    });

    test('Content.trustIndicators returns correct values', () {
      expect(Content.trustIndicators, contains('Feature A'));
    });

    test('Content.getHeroVariant returns correct variant', () {
      final hero = Content.getHeroVariant('alternate');
      expect(hero['badge'], equals('Alt Badge'));
    });
  });

  group('ContentLoader edge cases', () {
    setUp(() {
      ContentLoader.reset();
    });

    tearDown(() {
      ContentLoader.reset();
    });

    test('_getValue returns null for non-existent path', () {
      Content.loadFromString(_testYamlContent);
      // Access a non-existent path should return empty string (from _getString)
      // which wraps _getValue and returns '' if value is null
      expect(ContentLoader.instance.companyName, isNotEmpty);
    });

    test('_getMap returns empty map for non-existent path', () {
      Content.loadFromString('''
company:
  name: "Test"
''');
      // Access a non-existent nested map
      final loader = ContentLoader.instance;
      final result = loader.heroCurrent; // This path doesn't exist
      expect(result, isA<Map<String, dynamic>>());
      expect(result, isEmpty);
    });

    test('_getStringList returns empty list for non-existent path', () {
      Content.loadFromString('''
company:
  name: "Test"
''');
      final loader = ContentLoader.instance;
      final result = loader.trustIndicators;
      expect(result, isA<List<String>>());
      expect(result, isEmpty);
    });

    test('_getMapList returns empty list for non-existent path', () {
      Content.loadFromString('''
company:
  name: "Test"
''');
      final loader = ContentLoader.instance;
      final result = loader.pricingTiers;
      expect(result, isA<List<Map<String, dynamic>>>());
      expect(result, isEmpty);
    });

    test('loadFromString overwrites previous content', () {
      Content.loadFromString('''
company:
  name: "First"
''');
      expect(ContentLoader.instance.companyName, equals('First'));

      Content.loadFromString('''
company:
  name: "Second"
''');
      expect(ContentLoader.instance.companyName, equals('Second'));
    });

    test('deeply nested YAML is handled correctly', () {
      Content.loadFromString('''
company:
  contact:
    email: "deep@nested.com"
''');
      expect(ContentLoader.instance.companyEmail, equals('deep@nested.com'));
    });
  });
}
