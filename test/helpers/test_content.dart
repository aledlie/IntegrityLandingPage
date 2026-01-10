/// Test content for widget tests.
///
/// This provides a minimal YAML content structure that allows widgets
/// to render without requiring actual asset loading.
library;

import 'package:integrity_studio_ai/services/content_loader.dart';

/// Minimal test content YAML that satisfies all Content getters.
const testContentYaml = '''
company:
  name: "Test Company"
  tagline: "Test Tagline"
  copyright: "© 2024 Test Company"
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
    - "EU AI Act Ready"
    - "Enterprise Security"
    - "99.9% Uptime"
    - "5-min Setup"
  legacy:
    - "No credit card required"
    - "14-day free trial"

platform_metrics:
  uptime: "99.9%"
  traces_processed: "10M+"
  ai_teams: "500+"
  setup_time: "5 min"

pricing_constants:
  annual_discount: "Save 20%"

pricing:
  title: "Simple, Transparent Pricing"
  subtitle: "Start free, scale as you grow"
  tiers:
    - name: "Starter"
      monthly_price: "Free"
      annual_price: "Free"
      description: "For individual developers"
      cta_text: "Get Started"
      features:
        - "50K traces/month"
        - "7-day retention"
        - "Basic dashboards"
    - name: "Team"
      monthly_price: "\$99"
      annual_price: "\$79"
      period: "/month"
      description: "For growing teams"
      is_popular: true
      cta_text: "Start Free Trial"
      features:
        - "500K traces/month"
        - "30-day retention"
        - "Advanced analytics"
    - name: "Enterprise"
      monthly_price: "Custom"
      annual_price: "Custom"
      description: "For large organizations"
      cta_text: "Contact Sales"
      features:
        - "Unlimited traces"
        - "1-year retention"
        - "SSO/SAML"

hero:
  current:
    badge: "EU AI Act Ready"
    headline: "AI Observability That\\nProves Compliance"
    subheadline: "Full traceability for every LLM decision."
    primary_cta: "Start Free Trial"
    secondary_cta: "Request Demo"
  variants:
    agent_first:
      badge: "AI Observability Platform"
      headline: "See Every Decision"
      subheadline: "End-to-end visibility"
      primary_cta: "Start Free Trial"
      secondary_cta: "Request Demo"

features:
  title: "Platform Capabilities"
  subtitle: "Comprehensive tools for AI application observability"
  items:
    - icon: "activity"
      title: "LLM Monitoring"
      description: "Track every LLM call with detailed metrics."
      bullets:
        - "Token usage tracking"
        - "Latency monitoring"
    - icon: "git-branch"
      title: "Distributed Tracing"
      description: "End-to-end visibility across your AI application."
      bullets:
        - "Request correlation"
        - "Service mapping"
    - icon: "shield"
      title: "Compliance Reporting"
      description: "Automated documentation for EU AI Act."
      bullets:
        - "Audit trails"
        - "Risk classification"

services:
  title: "Platform Services"
  subtitle: "Comprehensive AI Observability"
  description: "From real-time LLM monitoring to compliance reporting."
  items:
    - icon: "activity"
      title: "LLM Monitoring & Tracing"
      description: "Track every LLM call with sub-100ms latency."
      cta_text: "View Docs"
      cta_url: "/docs/tracing"
      capabilities:
        - "Full request/response capture"
        - "Cost tracking per request"
    - icon: "shield"
      title: "Compliance & Governance"
      description: "Built-in EU AI Act templates."
      cta_text: "EU AI Act Guide"
      cta_url: "/eu-ai-act"
      disclaimer: "Tools to support compliance efforts."
      capabilities:
        - "Article 12 traceability"
        - "Audit trail generation"

cta:
  headline: "Ready to Gain Visibility Into Your AI?"
  subheadline: "Join teams who trust us for AI observability."

about:
  title: "About Integrity Studio"
  subtitle: "Building Trust in AI Systems"
  mission_statement: "Empower enterprises to build trustworthy AI systems."
  vision_statement: "To be the standard for enterprise AI observability."
  story: "Integrity Studio was founded to solve the visibility problem."
  values:
    - icon: "eye"
      title: "Transparency"
      description: "We believe AI systems should be observable."
    - icon: "shield-check"
      title: "Trust"
      description: "Trust is earned through reliability."
  team:
    - name: "Test Person"
      role: "CEO"
      bio: "Test bio"
      linkedin_url: "https://linkedin.com/in/test"

contact:
  title: "Get in Touch"
  subtitle: "Let's discuss how we can help"
  description: "Our team is here to help."
  form:
    fields:
      - name: "email"
        label: "Email"
        placeholder: "your@email.com"
        type: "email"
        required: true
      - name: "message"
        label: "Message"
        placeholder: "Your message"
        type: "textarea"
        required: false
    success_message: "Thank you for reaching out!"
    error_message: "Something went wrong."
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
    - title: "Company"
      links:
        - label: "About"
          url: "/about"
        - label: "Contact"
          url: "/contact"

status:
  title: "Platform Status"
  subtitle: "Real-time operational health"
  status_badge: "All Systems Operational"
  metrics:
    - label: "Uptime"
      value: "99.9%"
      sublabel: "SLA Guaranteed"
    - label: "Traces"
      value: "10M+"
      sublabel: "Daily"
  services:
    - name: "Trace Ingestion API"
      status: "Operational"
    - name: "Dashboard"
      status: "Operational"

resources:
  title: "Resources"
  subtitle: "Guides, Documentation & Insights"
  documentation:
    - icon: "book-open"
      title: "Getting Started"
      description: "Quick start guides."
      url: "/docs/quickstart"
      popular_topics:
        - "Python SDK"
        - "TypeScript"
  featured_posts:
    - title: "Best LLM Monitoring Tools"
      excerpt: "A comprehensive guide."
      category: "Guide"
      publish_date: "2024-12-24"
      read_time: "18 min"
      slug: "best-llm-monitoring"
      author: "Test Author"
  lead_magnets:
    - icon: "clipboard-check"
      title: "EU AI Act Checklist"
      description: "A comprehensive checklist."
      format: "PDF"
      cta_text: "Download"
      url: "/resources/checklist"
      requires_email: true

social_proof:
  title: "Trusted by AI Teams"
  stats:
    traces_processed: "10M+"
    uptime: "99.9%"
    setup_time: "< 5 min"
  testimonials:
    - quote: "Great product!"
      author: "Engineering Lead"
      role: "VP Engineering"
      company: "Tech Company"

disclaimers:
  eu_ai_act: "Tools to support EU AI Act compliance efforts."
  eu_ai_act_short: "EU AI Act support tools."
  security: "Security certifications in progress."
  general: "This platform provides AI governance tools."

promo_codes:
  whylabs_migration:
    code: "WHYLABS2025"
    description: "Get 3 months free on Team tier."
''';

/// Initialize test content before running widget tests.
///
/// Call this in setUpAll or setUp for test files that use Content.
void initializeTestContent() {
  Content.loadFromString(testContentYaml);
}

/// Reset content state after tests.
///
/// Call this in tearDownAll or tearDown if needed.
void resetTestContent() {
  Content.reset();
}
