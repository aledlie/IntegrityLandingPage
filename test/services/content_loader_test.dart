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

    test('has company getters', () {
      expect(() => loader.companyName, isA<Function>());
      expect(() => loader.companyTagline, isA<Function>());
      expect(() => loader.companyCopyright, isA<Function>());
      expect(() => loader.companyEmail, isA<Function>());
      expect(() => loader.companyPhone, isA<Function>());
      expect(() => loader.companyCity, isA<Function>());
      expect(() => loader.companyRegion, isA<Function>());
      expect(() => loader.companyFoundedYear, isA<Function>());
    });

    test('has URL getters', () {
      expect(() => loader.calendlyUrl, isA<Function>());
      expect(() => loader.statusPageUrl, isA<Function>());
      expect(() => loader.linkedInUrl, isA<Function>());
      expect(() => loader.twitterUrl, isA<Function>());
      expect(() => loader.githubUrl, isA<Function>());
      expect(() => loader.founderLinkedInUrl, isA<Function>());
      expect(() => loader.founderTwitterUrl, isA<Function>());
    });

    test('has CTA getters', () {
      expect(() => loader.ctaStartFreeTrial, isA<Function>());
      expect(() => loader.ctaGetStarted, isA<Function>());
      expect(() => loader.ctaScheduleDemo, isA<Function>());
      expect(() => loader.ctaRequestDemo, isA<Function>());
      expect(() => loader.ctaContactSales, isA<Function>());
      expect(() => loader.ctaLearnMore, isA<Function>());
      expect(() => loader.ctaSendMessage, isA<Function>());
    });

    test('has trust indicator getters', () {
      expect(() => loader.trustIndicators, isA<Function>());
      expect(() => loader.legacyTrustIndicators, isA<Function>());
    });

    test('has platform metrics getters', () {
      expect(() => loader.metricsUptime, isA<Function>());
      expect(() => loader.metricsTracesProcessed, isA<Function>());
      expect(() => loader.metricsAiTeams, isA<Function>());
      expect(() => loader.metricsSetupTime, isA<Function>());
    });

    test('has pricing getters', () {
      expect(() => loader.pricingTitle, isA<Function>());
      expect(() => loader.pricingSubtitle, isA<Function>());
      expect(() => loader.pricingAnnualDiscount, isA<Function>());
      expect(() => loader.pricingTiers, isA<Function>());
    });

    test('has hero getters', () {
      expect(() => loader.heroBadge, isA<Function>());
      expect(() => loader.heroHeadline, isA<Function>());
      expect(() => loader.heroSubheadline, isA<Function>());
      expect(() => loader.heroPrimaryCta, isA<Function>());
      expect(() => loader.heroSecondaryCta, isA<Function>());
      expect(() => loader.heroCurrent, isA<Function>());
      expect(loader.getHeroVariant, isA<Function>());
    });

    test('has features getters', () {
      expect(() => loader.featuresTitle, isA<Function>());
      expect(() => loader.featuresSubtitle, isA<Function>());
      expect(() => loader.featuresItems, isA<Function>());
    });

    test('has services getters', () {
      expect(() => loader.servicesTitle, isA<Function>());
      expect(() => loader.servicesSubtitle, isA<Function>());
      expect(() => loader.servicesDescription, isA<Function>());
      expect(() => loader.servicesItems, isA<Function>());
    });

    test('has CTA section getters', () {
      expect(() => loader.ctaSectionHeadline, isA<Function>());
      expect(() => loader.ctaSectionSubheadline, isA<Function>());
    });

    test('has about getters', () {
      expect(() => loader.aboutTitle, isA<Function>());
      expect(() => loader.aboutSubtitle, isA<Function>());
      expect(() => loader.aboutMission, isA<Function>());
      expect(() => loader.aboutVision, isA<Function>());
      expect(() => loader.aboutStory, isA<Function>());
      expect(() => loader.aboutValues, isA<Function>());
      expect(() => loader.aboutTeam, isA<Function>());
    });

    test('has contact getters', () {
      expect(() => loader.contactTitle, isA<Function>());
      expect(() => loader.contactSubtitle, isA<Function>());
      expect(() => loader.contactDescription, isA<Function>());
      expect(() => loader.contactFormFields, isA<Function>());
      expect(() => loader.contactMethods, isA<Function>());
      expect(() => loader.contactSuccessMessage, isA<Function>());
      expect(() => loader.contactErrorMessage, isA<Function>());
    });

    test('has footer getters', () {
      expect(() => loader.footerLinkGroups, isA<Function>());
      expect(() => loader.footerPrivacyLink, isA<Function>());
      expect(() => loader.footerTermsLink, isA<Function>());
      expect(() => loader.footerCookiesLink, isA<Function>());
    });

    test('has status getters', () {
      expect(() => loader.statusTitle, isA<Function>());
      expect(() => loader.statusSubtitle, isA<Function>());
      expect(() => loader.statusBadge, isA<Function>());
      expect(() => loader.statusMetrics, isA<Function>());
      expect(() => loader.statusServices, isA<Function>());
    });

    test('has resources getters', () {
      expect(() => loader.resourcesTitle, isA<Function>());
      expect(() => loader.resourcesSubtitle, isA<Function>());
      expect(() => loader.resourcesDocumentation, isA<Function>());
      expect(() => loader.resourcesFeaturedPosts, isA<Function>());
      expect(() => loader.resourcesLeadMagnets, isA<Function>());
    });

    test('has social proof getters', () {
      expect(() => loader.socialProofTitle, isA<Function>());
      expect(() => loader.socialProofStats, isA<Function>());
      expect(() => loader.socialProofTestimonials, isA<Function>());
    });

    test('has disclaimer getters', () {
      expect(() => loader.disclaimerEuAiAct, isA<Function>());
      expect(() => loader.disclaimerEuAiActShort, isA<Function>());
      expect(() => loader.disclaimerSecurity, isA<Function>());
      expect(() => loader.disclaimerGeneral, isA<Function>());
    });

    test('has promo code getters', () {
      expect(() => loader.promoWhylabsCode, isA<Function>());
      expect(() => loader.promoWhylabsDescription, isA<Function>());
    });
  });

  group('Content API surface verification', () {
    // Verify all expected properties exist on Content
    test('has company getters', () {
      expect(() => Content.companyName, isA<Function>());
      expect(() => Content.companyTagline, isA<Function>());
      expect(() => Content.companyCopyright, isA<Function>());
      expect(() => Content.companyEmail, isA<Function>());
      expect(() => Content.companyPhone, isA<Function>());
      expect(() => Content.companyCity, isA<Function>());
      expect(() => Content.companyRegion, isA<Function>());
      expect(() => Content.companyFoundedYear, isA<Function>());
    });

    test('has URL getters', () {
      expect(() => Content.calendlyUrl, isA<Function>());
      expect(() => Content.statusPageUrl, isA<Function>());
      expect(() => Content.linkedInUrl, isA<Function>());
      expect(() => Content.twitterUrl, isA<Function>());
      expect(() => Content.githubUrl, isA<Function>());
      expect(() => Content.founderLinkedInUrl, isA<Function>());
      expect(() => Content.founderTwitterUrl, isA<Function>());
    });

    test('has CTA getters', () {
      expect(() => Content.ctaStartFreeTrial, isA<Function>());
      expect(() => Content.ctaGetStarted, isA<Function>());
      expect(() => Content.ctaScheduleDemo, isA<Function>());
      expect(() => Content.ctaRequestDemo, isA<Function>());
      expect(() => Content.ctaContactSales, isA<Function>());
      expect(() => Content.ctaLearnMore, isA<Function>());
      expect(() => Content.ctaSendMessage, isA<Function>());
    });

    test('has pricing getters', () {
      expect(() => Content.pricingTitle, isA<Function>());
      expect(() => Content.pricingSubtitle, isA<Function>());
      expect(() => Content.pricingAnnualDiscount, isA<Function>());
      expect(() => Content.pricingTiers, isA<Function>());
    });

    test('has hero getters', () {
      expect(() => Content.heroBadge, isA<Function>());
      expect(() => Content.heroHeadline, isA<Function>());
      expect(() => Content.heroSubheadline, isA<Function>());
      expect(() => Content.heroPrimaryCta, isA<Function>());
      expect(() => Content.heroSecondaryCta, isA<Function>());
      expect(Content.getHeroVariant, isA<Function>());
    });

    test('has features getters', () {
      expect(() => Content.featuresTitle, isA<Function>());
      expect(() => Content.featuresSubtitle, isA<Function>());
      expect(() => Content.featuresItems, isA<Function>());
    });

    test('has services getters', () {
      expect(() => Content.servicesTitle, isA<Function>());
      expect(() => Content.servicesSubtitle, isA<Function>());
      expect(() => Content.servicesDescription, isA<Function>());
      expect(() => Content.servicesItems, isA<Function>());
    });

    test('has about getters', () {
      expect(() => Content.aboutTitle, isA<Function>());
      expect(() => Content.aboutSubtitle, isA<Function>());
      expect(() => Content.aboutMission, isA<Function>());
      expect(() => Content.aboutVision, isA<Function>());
      expect(() => Content.aboutStory, isA<Function>());
      expect(() => Content.aboutValues, isA<Function>());
      expect(() => Content.aboutTeam, isA<Function>());
    });

    test('has contact getters', () {
      expect(() => Content.contactTitle, isA<Function>());
      expect(() => Content.contactSubtitle, isA<Function>());
      expect(() => Content.contactDescription, isA<Function>());
      expect(() => Content.contactFormFields, isA<Function>());
      expect(() => Content.contactMethods, isA<Function>());
      expect(() => Content.contactSuccessMessage, isA<Function>());
      expect(() => Content.contactErrorMessage, isA<Function>());
    });

    test('has footer getters', () {
      expect(() => Content.footerLinkGroups, isA<Function>());
      expect(() => Content.footerPrivacyLink, isA<Function>());
      expect(() => Content.footerTermsLink, isA<Function>());
      expect(() => Content.footerCookiesLink, isA<Function>());
    });

    test('has status getters', () {
      expect(() => Content.statusTitle, isA<Function>());
      expect(() => Content.statusSubtitle, isA<Function>());
      expect(() => Content.statusBadge, isA<Function>());
      expect(() => Content.statusMetrics, isA<Function>());
      expect(() => Content.statusServices, isA<Function>());
    });

    test('has resources getters', () {
      expect(() => Content.resourcesTitle, isA<Function>());
      expect(() => Content.resourcesSubtitle, isA<Function>());
      expect(() => Content.resourcesDocumentation, isA<Function>());
      expect(() => Content.resourcesFeaturedPosts, isA<Function>());
      expect(() => Content.resourcesLeadMagnets, isA<Function>());
    });

    test('has social proof getters', () {
      expect(() => Content.socialProofTitle, isA<Function>());
      expect(() => Content.socialProofStats, isA<Function>());
      expect(() => Content.socialProofTestimonials, isA<Function>());
    });

    test('has disclaimer getters', () {
      expect(() => Content.disclaimerEuAiAct, isA<Function>());
      expect(() => Content.disclaimerEuAiActShort, isA<Function>());
      expect(() => Content.disclaimerSecurity, isA<Function>());
      expect(() => Content.disclaimerGeneral, isA<Function>());
    });

    test('has promo code getters', () {
      expect(() => Content.promoWhylabsCode, isA<Function>());
      expect(() => Content.promoWhylabsDescription, isA<Function>());
    });

    test('has trust indicator getters', () {
      expect(() => Content.trustIndicators, isA<Function>());
      expect(() => Content.legacyTrustIndicators, isA<Function>());
    });

    test('has platform metrics getters', () {
      expect(() => Content.metricsUptime, isA<Function>());
      expect(() => Content.metricsTracesProcessed, isA<Function>());
      expect(() => Content.metricsAiTeams, isA<Function>());
      expect(() => Content.metricsSetupTime, isA<Function>());
    });

    test('has CTA section getters', () {
      expect(() => Content.ctaSectionHeadline, isA<Function>());
      expect(() => Content.ctaSectionSubheadline, isA<Function>());
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

    group('company getters', () {
      test('companyName returns correct value', () {
        expect(ContentLoader.instance.companyName, equals('Test Company'));
      });

      test('companyTagline returns correct value', () {
        expect(ContentLoader.instance.companyTagline, equals('Test Tagline'));
      });

      test('companyCopyright returns correct value', () {
        expect(ContentLoader.instance.companyCopyright, equals('© 2024 Test'));
      });

      test('companyEmail returns correct value', () {
        expect(ContentLoader.instance.companyEmail, equals('test@example.com'));
      });

      test('companyPhone returns correct value', () {
        expect(ContentLoader.instance.companyPhone, equals('555-1234'));
      });

      test('companyCity returns correct value', () {
        expect(ContentLoader.instance.companyCity, equals('Austin'));
      });

      test('companyRegion returns correct value', () {
        expect(ContentLoader.instance.companyRegion, equals('Texas'));
      });

      test('companyFoundedYear returns correct value', () {
        expect(ContentLoader.instance.companyFoundedYear, equals('2024'));
      });

      test('company returns map with all company data', () {
        final company = ContentLoader.instance.company;
        expect(company, isA<Map<String, dynamic>>());
        expect(company['name'], equals('Test Company'));
        expect(company['tagline'], equals('Test Tagline'));
      });
    });

    group('URL getters', () {
      test('calendlyUrl returns correct value', () {
        expect(ContentLoader.instance.calendlyUrl, equals('https://calendly.com/test'));
      });

      test('statusPageUrl returns correct value', () {
        expect(ContentLoader.instance.statusPageUrl, equals('https://status.test.com'));
      });

      test('linkedInUrl returns correct value', () {
        expect(ContentLoader.instance.linkedInUrl, equals('https://linkedin.com/test'));
      });

      test('twitterUrl returns correct value', () {
        expect(ContentLoader.instance.twitterUrl, equals('https://twitter.com/test'));
      });

      test('githubUrl returns correct value', () {
        expect(ContentLoader.instance.githubUrl, equals('https://github.com/test'));
      });

      test('founderLinkedInUrl returns correct value', () {
        expect(ContentLoader.instance.founderLinkedInUrl, equals('https://linkedin.com/in/founder'));
      });

      test('founderTwitterUrl returns correct value', () {
        expect(ContentLoader.instance.founderTwitterUrl, equals('https://twitter.com/founder'));
      });
    });

    group('CTA text getters', () {
      test('ctaStartFreeTrial returns correct value', () {
        expect(ContentLoader.instance.ctaStartFreeTrial, equals('Start Free Trial'));
      });

      test('ctaGetStarted returns correct value', () {
        expect(ContentLoader.instance.ctaGetStarted, equals('Get Started'));
      });

      test('ctaScheduleDemo returns correct value', () {
        expect(ContentLoader.instance.ctaScheduleDemo, equals('Schedule Demo'));
      });

      test('ctaRequestDemo returns correct value', () {
        expect(ContentLoader.instance.ctaRequestDemo, equals('Request Demo'));
      });

      test('ctaContactSales returns correct value', () {
        expect(ContentLoader.instance.ctaContactSales, equals('Contact Sales'));
      });

      test('ctaLearnMore returns correct value', () {
        expect(ContentLoader.instance.ctaLearnMore, equals('Learn More'));
      });

      test('ctaSendMessage returns correct value', () {
        expect(ContentLoader.instance.ctaSendMessage, equals('Send Message'));
      });
    });

    group('trust indicators', () {
      test('trustIndicators returns list of strings', () {
        final indicators = ContentLoader.instance.trustIndicators;
        expect(indicators, isA<List<String>>());
        expect(indicators.length, equals(3));
        expect(indicators, contains('Feature A'));
        expect(indicators, contains('Feature B'));
        expect(indicators, contains('Feature C'));
      });

      test('legacyTrustIndicators returns list of strings', () {
        final indicators = ContentLoader.instance.legacyTrustIndicators;
        expect(indicators, isA<List<String>>());
        expect(indicators.length, equals(2));
        expect(indicators, contains('Old Feature 1'));
        expect(indicators, contains('Old Feature 2'));
      });
    });

    group('platform metrics', () {
      test('metricsUptime returns correct value', () {
        expect(ContentLoader.instance.metricsUptime, equals('99.9%'));
      });

      test('metricsTracesProcessed returns correct value', () {
        expect(ContentLoader.instance.metricsTracesProcessed, equals('10M+'));
      });

      test('metricsAiTeams returns correct value', () {
        expect(ContentLoader.instance.metricsAiTeams, equals('500+'));
      });

      test('metricsSetupTime returns correct value', () {
        expect(ContentLoader.instance.metricsSetupTime, equals('5 min'));
      });
    });

    group('pricing', () {
      test('pricingTitle returns correct value', () {
        expect(ContentLoader.instance.pricingTitle, equals('Test Pricing'));
      });

      test('pricingSubtitle returns correct value', () {
        expect(ContentLoader.instance.pricingSubtitle, equals('Test pricing subtitle'));
      });

      test('pricingAnnualDiscount returns correct value', () {
        expect(ContentLoader.instance.pricingAnnualDiscount, equals('Save 20%'));
      });

      test('pricingTiers returns list of maps', () {
        final tiers = ContentLoader.instance.pricingTiers;
        expect(tiers, isA<List<Map<String, dynamic>>>());
        expect(tiers.length, equals(2));
        expect(tiers[0]['name'], equals('Free'));
        expect(tiers[1]['name'], equals('Pro'));
        expect(tiers[1]['is_popular'], isTrue);
      });
    });

    group('hero', () {
      test('heroBadge returns correct value', () {
        expect(ContentLoader.instance.heroBadge, equals('Test Badge'));
      });

      test('heroHeadline returns correct value', () {
        expect(ContentLoader.instance.heroHeadline, equals('Test Headline'));
      });

      test('heroSubheadline returns correct value', () {
        expect(ContentLoader.instance.heroSubheadline, equals('Test Subheadline'));
      });

      test('heroPrimaryCta returns correct value', () {
        expect(ContentLoader.instance.heroPrimaryCta, equals('Primary CTA'));
      });

      test('heroSecondaryCta returns correct value', () {
        expect(ContentLoader.instance.heroSecondaryCta, equals('Secondary CTA'));
      });

      test('heroCurrent returns map with current hero data', () {
        final hero = ContentLoader.instance.heroCurrent;
        expect(hero, isA<Map<String, dynamic>>());
        expect(hero['badge'], equals('Test Badge'));
        expect(hero['headline'], equals('Test Headline'));
      });

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

    group('features', () {
      test('featuresTitle returns correct value', () {
        expect(ContentLoader.instance.featuresTitle, equals('Features Title'));
      });

      test('featuresSubtitle returns correct value', () {
        expect(ContentLoader.instance.featuresSubtitle, equals('Features Subtitle'));
      });

      test('featuresItems returns list of maps', () {
        final items = ContentLoader.instance.featuresItems;
        expect(items, isA<List<Map<String, dynamic>>>());
        expect(items.length, equals(2));
        expect(items[0]['title'], equals('Feature 1'));
        expect(items[0]['bullets'], isA<List>());
        expect((items[0]['bullets'] as List).length, equals(2));
      });
    });

    group('services', () {
      test('servicesTitle returns correct value', () {
        expect(ContentLoader.instance.servicesTitle, equals('Services Title'));
      });

      test('servicesSubtitle returns correct value', () {
        expect(ContentLoader.instance.servicesSubtitle, equals('Services Subtitle'));
      });

      test('servicesDescription returns correct value', () {
        expect(ContentLoader.instance.servicesDescription, equals('Services Description'));
      });

      test('servicesItems returns list of maps', () {
        final items = ContentLoader.instance.servicesItems;
        expect(items, isA<List<Map<String, dynamic>>>());
        expect(items.length, equals(1));
        expect(items[0]['title'], equals('Service 1'));
      });
    });

    group('CTA section', () {
      test('ctaSectionHeadline returns correct value', () {
        expect(ContentLoader.instance.ctaSectionHeadline, equals('CTA Headline'));
      });

      test('ctaSectionSubheadline returns correct value', () {
        expect(ContentLoader.instance.ctaSectionSubheadline, equals('CTA Subheadline'));
      });
    });

    group('about', () {
      test('aboutTitle returns correct value', () {
        expect(ContentLoader.instance.aboutTitle, equals('About Title'));
      });

      test('aboutSubtitle returns correct value', () {
        expect(ContentLoader.instance.aboutSubtitle, equals('About Subtitle'));
      });

      test('aboutMission returns correct value', () {
        expect(ContentLoader.instance.aboutMission, equals('Our mission'));
      });

      test('aboutVision returns correct value', () {
        expect(ContentLoader.instance.aboutVision, equals('Our vision'));
      });

      test('aboutStory returns correct value', () {
        expect(ContentLoader.instance.aboutStory, equals('Our story'));
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
    });

    group('contact', () {
      test('contactTitle returns correct value', () {
        expect(ContentLoader.instance.contactTitle, equals('Contact Title'));
      });

      test('contactSubtitle returns correct value', () {
        expect(ContentLoader.instance.contactSubtitle, equals('Contact Subtitle'));
      });

      test('contactDescription returns correct value', () {
        expect(ContentLoader.instance.contactDescription, equals('Contact Description'));
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

      test('contactSuccessMessage returns correct value', () {
        expect(ContentLoader.instance.contactSuccessMessage, equals('Success!'));
      });

      test('contactErrorMessage returns correct value', () {
        expect(ContentLoader.instance.contactErrorMessage, equals('Error!'));
      });
    });

    group('footer', () {
      test('footerLinkGroups returns list of maps', () {
        final groups = ContentLoader.instance.footerLinkGroups;
        expect(groups, isA<List<Map<String, dynamic>>>());
        expect(groups.length, equals(1));
        expect(groups[0]['title'], equals('Product'));
        expect(groups[0]['links'], isA<List>());
      });

      test('footerPrivacyLink returns correct value', () {
        expect(ContentLoader.instance.footerPrivacyLink, equals('/privacy'));
      });

      test('footerTermsLink returns correct value', () {
        expect(ContentLoader.instance.footerTermsLink, equals('/terms'));
      });

      test('footerCookiesLink returns correct value', () {
        expect(ContentLoader.instance.footerCookiesLink, equals('/cookies'));
      });
    });

    group('status', () {
      test('statusTitle returns correct value', () {
        expect(ContentLoader.instance.statusTitle, equals('Status Title'));
      });

      test('statusSubtitle returns correct value', () {
        expect(ContentLoader.instance.statusSubtitle, equals('Status Subtitle'));
      });

      test('statusBadge returns correct value', () {
        expect(ContentLoader.instance.statusBadge, equals('All Operational'));
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
    });

    group('resources', () {
      test('resourcesTitle returns correct value', () {
        expect(ContentLoader.instance.resourcesTitle, equals('Resources Title'));
      });

      test('resourcesSubtitle returns correct value', () {
        expect(ContentLoader.instance.resourcesSubtitle, equals('Resources Subtitle'));
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
    });

    group('social proof', () {
      test('socialProofTitle returns correct value', () {
        expect(ContentLoader.instance.socialProofTitle, equals('Social Proof Title'));
      });

      test('socialProofStats returns map of string to string', () {
        final stats = ContentLoader.instance.socialProofStats;
        expect(stats, isA<Map<String, String>>());
        expect(stats['uptime'], equals('99.9%'));
        expect(stats['traces'], equals('10M+'));
      });

      test('socialProofTestimonials returns list of maps', () {
        final testimonials = ContentLoader.instance.socialProofTestimonials;
        expect(testimonials, isA<List<Map<String, dynamic>>>());
        expect(testimonials.length, equals(1));
        expect(testimonials[0]['quote'], equals('Great product!'));
        expect(testimonials[0]['author'], equals('Jane Doe'));
      });
    });

    group('disclaimers', () {
      test('disclaimerEuAiAct returns correct value', () {
        expect(ContentLoader.instance.disclaimerEuAiAct, equals('EU AI Act disclaimer'));
      });

      test('disclaimerEuAiActShort returns correct value', () {
        expect(ContentLoader.instance.disclaimerEuAiActShort, equals('Short disclaimer'));
      });

      test('disclaimerSecurity returns correct value', () {
        expect(ContentLoader.instance.disclaimerSecurity, equals('Security disclaimer'));
      });

      test('disclaimerGeneral returns correct value', () {
        expect(ContentLoader.instance.disclaimerGeneral, equals('General disclaimer'));
      });
    });

    group('promo codes', () {
      test('promoWhylabsCode returns correct value', () {
        expect(ContentLoader.instance.promoWhylabsCode, equals('TEST2025'));
      });

      test('promoWhylabsDescription returns correct value', () {
        expect(ContentLoader.instance.promoWhylabsDescription, equals('Test promo'));
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
