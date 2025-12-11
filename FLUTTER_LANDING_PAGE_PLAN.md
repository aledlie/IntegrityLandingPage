# Flutter Landing Page Implementation Plan for IntegrityStudio.ai2

## Executive Summary

This document provides a comprehensive implementation plan for rebuilding IntegrityStudio.ai as a Flutter web application (`IntegrityStudio.ai2`). The new site will pivot messaging from nonprofit AI consulting to **AI Observability Platform** positioning, incorporating insights from the AI Observability Platform Strategy research report while maintaining the proven design patterns from the existing React/Tailwind implementation.

---

## Phase 1: Strategic Messaging Alignment

### 1.1 Key Insights from AI Observability Platform Strategy

**Market Opportunity:**
- Market projected to grow from $1B to $2.9B+ with 25.47% CAGR through 2030
- Enterprise governance budgets increasing 24% YoY
- 98% of organizations expanding AI oversight spending
- MLOps infrastructure market: $1.7B expanding to $39-129B by 2034

**Target Audience & Pain Points:**
- Enterprises with advanced AI adoption (86% experiencing governance gaps)
- Organizations struggling with AI ROI evaluation (51% cannot assess returns)
- Companies needing to verify AI decisions (69% still require human verification)
- Regulated industries preparing for August 2026 EU AI Act deadline

**Key Differentiators to Highlight:**
1. Compliance-first features (EU AI Act templates, audit trails, framework mapping)
2. Speed to market before regulatory deadline
3. Developer-friendly access with product-led growth
4. Enterprise scalability with hybrid PLG + sales motion

**Go-to-Market Metrics:**
- Target: 15-20 design partners from regulated sectors
- Benchmark: 9-15% free-to-paid conversion
- Goal: $500K ARR within 6 months
- Reference: 91% adoption rate among mature SaaS companies using PLG

### 1.2 New Value Proposition

**Primary Tagline:** "AI Observability That Enterprises Trust"

**Secondary Messaging:**
- "Monitor. Govern. Comply. Scale."
- "From LLM Calls to Compliance Reports in Minutes"
- "The Platform Built for EU AI Act Readiness"

---

## Phase 2: Project Structure

### 2.1 Flutter Web Project Setup

```
integritystudio.ai2/
├── lib/
│   ├── main.dart
│   ├── app.dart
│   │
│   ├── core/
│   │   ├── theme/
│   │   │   ├── app_theme.dart
│   │   │   ├── app_colors.dart
│   │   │   ├── app_typography.dart
│   │   │   ├── app_spacing.dart
│   │   │   └── app_shadows.dart
│   │   │
│   │   ├── constants/
│   │   │   ├── app_constants.dart
│   │   │   ├── asset_paths.dart
│   │   │   └── route_paths.dart
│   │   │
│   │   ├── utils/
│   │   │   ├── responsive_utils.dart
│   │   │   ├── animation_utils.dart
│   │   │   └── seo_utils.dart
│   │   │
│   │   └── extensions/
│   │       ├── context_extensions.dart
│   │       └── widget_extensions.dart
│   │
│   ├── data/
│   │   ├── models/
│   │   │   ├── feature_model.dart
│   │   │   ├── testimonial_model.dart
│   │   │   ├── pricing_model.dart
│   │   │   ├── blog_post_model.dart
│   │   │   └── contact_form_model.dart
│   │   │
│   │   ├── repositories/
│   │   │   ├── content_repository.dart
│   │   │   └── analytics_repository.dart
│   │   │
│   │   └── services/
│   │       ├── analytics_service.dart
│   │       ├── sentry_service.dart
│   │       └── contact_service.dart
│   │
│   ├── presentation/
│   │   ├── landing_page/
│   │   │   ├── landing_page.dart
│   │   │   └── landing_page_controller.dart
│   │   │
│   │   ├── sections/
│   │   │   ├── hero/
│   │   │   │   ├── hero_section.dart
│   │   │   │   └── hero_widgets/
│   │   │   │       ├── hero_headline.dart
│   │   │   │       ├── hero_stats.dart
│   │   │   │       ├── hero_cta_buttons.dart
│   │   │   │       └── hero_demo_card.dart
│   │   │   │
│   │   │   ├── features/
│   │   │   │   ├── features_section.dart
│   │   │   │   └── feature_card.dart
│   │   │   │
│   │   │   ├── platform/
│   │   │   │   ├── platform_section.dart
│   │   │   │   ├── observability_showcase.dart
│   │   │   │   └── integration_grid.dart
│   │   │   │
│   │   │   ├── compliance/
│   │   │   │   ├── compliance_section.dart
│   │   │   │   └── eu_ai_act_countdown.dart
│   │   │   │
│   │   │   ├── pricing/
│   │   │   │   ├── pricing_section.dart
│   │   │   │   └── pricing_card.dart
│   │   │   │
│   │   │   ├── testimonials/
│   │   │   │   ├── testimonials_section.dart
│   │   │   │   └── testimonial_card.dart
│   │   │   │
│   │   │   ├── resources/
│   │   │   │   ├── resources_section.dart
│   │   │   │   └── blog_card.dart
│   │   │   │
│   │   │   ├── contact/
│   │   │   │   ├── contact_section.dart
│   │   │   │   └── contact_form.dart
│   │   │   │
│   │   │   └── footer/
│   │   │       └── footer_section.dart
│   │   │
│   │   ├── widgets/
│   │   │   ├── common/
│   │   │   │   ├── gradient_button.dart
│   │   │   │   ├── outline_button.dart
│   │   │   │   ├── glass_card.dart
│   │   │   │   ├── animated_orb.dart
│   │   │   │   ├── gradient_text.dart
│   │   │   │   ├── stat_counter.dart
│   │   │   │   ├── icon_container.dart
│   │   │   │   └── section_title.dart
│   │   │   │
│   │   │   ├── navigation/
│   │   │   │   ├── app_header.dart
│   │   │   │   ├── nav_link.dart
│   │   │   │   └── mobile_menu.dart
│   │   │   │
│   │   │   └── decorative/
│   │   │       ├── noise_texture.dart
│   │   │       ├── grid_background.dart
│   │   │       ├── gradient_border.dart
│   │   │       └── spotlight_effect.dart
│   │   │
│   │   └── animations/
│   │       ├── fade_in_up.dart
│   │       ├── stagger_animation.dart
│   │       ├── shimmer_text.dart
│   │       ├── pulse_animation.dart
│   │       └── float_animation.dart
│   │
│   └── config/
│       ├── environment.dart
│       └── analytics_config.dart
│
├── web/
│   ├── index.html
│   ├── manifest.json
│   ├── robots.txt
│   └── favicon.ico
│
├── assets/
│   ├── images/
│   │   ├── logo.png
│   │   ├── hero/
│   │   ├── features/
│   │   └── testimonials/
│   │
│   ├── icons/
│   │   └── svg/
│   │
│   └── fonts/
│       └── inter/
│
├── test/
│   ├── widget_test/
│   ├── unit_test/
│   └── integration_test/
│
├── pubspec.yaml
├── analysis_options.yaml
└── README.md
```

### 2.2 Dependencies (pubspec.yaml)

```yaml
name: integrity_studio_ai
description: AI Observability Platform Landing Page
publish_to: 'none'
version: 1.0.0+1

environment:
  sdk: '>=3.0.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter

  # State Management
  flutter_riverpod: ^2.4.9
  riverpod_annotation: ^2.3.3

  # Routing
  go_router: ^13.0.0

  # UI/UX
  flutter_animate: ^4.3.0
  shimmer: ^3.0.0
  visibility_detector: ^0.4.0+2

  # Forms & Validation
  flutter_form_builder: ^9.2.0
  form_builder_validators: ^9.1.0

  # Analytics
  firebase_analytics: ^10.7.4
  firebase_core: ^2.24.2

  # Error Tracking
  sentry_flutter: ^7.14.0

  # Networking
  dio: ^5.4.0

  # Utilities
  url_launcher: ^6.2.2
  intl: ^0.19.0
  collection: ^1.18.0

  # Icons
  lucide_icons: ^0.257.0
  flutter_svg: ^2.0.9

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.1
  riverpod_generator: ^2.3.9
  build_runner: ^2.4.8
  mockito: ^5.4.4
  golden_toolkit: ^0.15.0

flutter:
  uses-material-design: true

  assets:
    - assets/images/
    - assets/icons/
    - assets/fonts/

  fonts:
    - family: Inter
      fonts:
        - asset: assets/fonts/inter/Inter-Regular.ttf
          weight: 400
        - asset: assets/fonts/inter/Inter-Medium.ttf
          weight: 500
        - asset: assets/fonts/inter/Inter-SemiBold.ttf
          weight: 600
        - asset: assets/fonts/inter/Inter-Bold.ttf
          weight: 700
```

---

## Phase 3: Landing Page Sections

### 3.1 Hero Section

**Purpose:** Capture attention with clear AI Observability value proposition

**Content Structure:**
```dart
// Hero content aligned with AI Observability positioning
class HeroContent {
  final String title = "AI Observability";
  final String titleHighlight = "That Enterprises Trust";
  final String subtitle = "Monitor LLM performance, ensure compliance with EU AI Act, and gain complete visibility into your AI systems with our enterprise-grade observability platform.";

  final List<HeroStat> stats = [
    HeroStat(value: "99.9%", label: "Uptime SLA"),
    HeroStat(value: "<100ms", label: "Trace Latency"),
    HeroStat(value: "EU AI Act", label: "Compliance Ready"),
    HeroStat(value: "SOC 2", label: "Type II Certified"),
  ];

  final PrimaryButton primaryCta = PrimaryButton(
    text: "Start Free Trial",
    href: "#pricing",
  );

  final SecondaryButton secondaryCta = SecondaryButton(
    text: "View Demo",
    href: "#demo",
  );
}
```

**Visual Elements:**
- Animated gradient orbs (blue/indigo/purple palette)
- Noise texture overlay for depth
- Live demo card showing observability dashboard preview
- Staggered fade-in-up animations
- Shimmer text effect on highlight

**Technical Implementation:**
```dart
class HeroSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.gray900,
            AppColors.gray800,
            AppColors.gray900,
          ],
        ),
      ),
      child: Stack(
        children: [
          // Decorative orbs
          AnimatedOrb(
            color: AppColors.blue500.withOpacity(0.2),
            size: 256,
            position: Offset(-80, -80),
          ),
          AnimatedOrb(
            color: AppColors.indigo500.withOpacity(0.2),
            size: 256,
            position: Offset(MediaQuery.of(context).size.width - 100, 200),
            animationType: OrbAnimationType.pulse,
          ),

          // Noise texture
          NoiseTexture(opacity: 0.05),

          // Content
          ResponsiveContainer(
            child: HeroContent(),
          ),
        ],
      ),
    );
  }
}
```

### 3.2 Features/Platform Section

**Purpose:** Showcase AI Observability capabilities

**Feature Cards (6 items):**

1. **LLM Monitoring & Tracing**
   - Icon: Activity
   - Description: "Track every LLM call with sub-100ms latency. Capture prompts, completions, tokens, costs, and performance metrics in real-time."
   - Features: Token usage tracking, Cost attribution, Latency monitoring

2. **Agent Observability**
   - Icon: Bot
   - Description: "Monitor multi-step AI agents, tool calls, and reasoning chains. Debug complex workflows with full execution traces."
   - Features: Tool call tracking, Reasoning chain visualization, Error detection

3. **Compliance & Governance**
   - Icon: Shield
   - Description: "Built-in EU AI Act templates, audit trails, and framework mapping. Stay ahead of regulatory requirements."
   - Features: EU AI Act readiness, Audit trail generation, Framework compliance

4. **Performance Analytics**
   - Icon: BarChart3
   - Description: "Interactive dashboards for token usage, costs, latency distributions, and model comparison analytics."
   - Features: Custom KPI dashboards, ROI analysis, Model benchmarking

5. **Alert & Incident Management**
   - Icon: Bell
   - Description: "Proactive alerting for anomalies, budget thresholds, and performance degradation with intelligent routing."
   - Features: Budget alerts, Anomaly detection, PagerDuty integration

6. **Developer Experience**
   - Icon: Code
   - Description: "Drop-in SDKs for Python, TypeScript, and Go. OpenTelemetry-native with minimal instrumentation required."
   - Features: <5 min integration, OpenTelemetry support, Auto-instrumentation

**Visual Design:**
- Glass morphism cards with hover effects
- Icon containers with gradient backgrounds
- Feature lists with blue bullet points
- Card hover lift animation

### 3.3 AI Observability Platform Showcase

**Purpose:** Visual demonstration of platform capabilities

**Components:**
1. **Dashboard Preview**
   - Animated metrics visualization
   - Token usage charts
   - Cost breakdown pie chart
   - Latency distribution graph

2. **Trace Viewer Demo**
   - Expandable trace hierarchy
   - Token/cost badges per span
   - Status indicators (success/error)

3. **Integration Logos Grid**
   - OpenAI, Anthropic, Google AI
   - LangChain, LlamaIndex
   - Datadog, Grafana, PagerDuty
   - AWS, GCP, Azure

### 3.4 EU AI Act Compliance Section

**Purpose:** Urgency around regulatory compliance deadline

**Content:**
```dart
class ComplianceSection {
  final String title = "EU AI Act Ready Before August 2026";
  final String subtitle = "86% of organizations report governance gaps. Don't be caught unprepared when regulations take effect.";

  final DateTime deadline = DateTime(2026, 8, 1);

  final List<ComplianceFeature> features = [
    ComplianceFeature(
      title: "Risk Classification",
      description: "Automatic AI system risk categorization per EU AI Act framework",
    ),
    ComplianceFeature(
      title: "Documentation Generation",
      description: "Automated technical documentation and conformity assessments",
    ),
    ComplianceFeature(
      title: "Audit Trails",
      description: "Immutable logs of all AI decisions for regulatory review",
    ),
    ComplianceFeature(
      title: "Human Oversight",
      description: "Built-in approval workflows and intervention tracking",
    ),
  ];
}
```

**Visual Elements:**
- Countdown timer to EU AI Act deadline
- Compliance checklist visualization
- Framework mapping diagram
- Trust badges (SOC 2, GDPR, etc.)

### 3.5 Pricing Section

**Purpose:** Drive conversions with clear PLG-focused pricing

**Pricing Tiers:**

| Tier | Price | Target | Features |
|------|-------|--------|----------|
| **Developer** | Free | Individual developers | 10K traces/month, 7-day retention, Community support |
| **Team** | $99/month | Small teams | 100K traces/month, 30-day retention, Slack support |
| **Business** | $499/month | Growing companies | 1M traces/month, 90-day retention, Priority support, SSO |
| **Enterprise** | Custom | Large enterprises | Unlimited traces, 1-year retention, Dedicated support, SLA |

**Conversion Optimization:**
- "Most Popular" badge on Team tier
- Annual discount toggle (20% off)
- Feature comparison table
- "No credit card required" for free tier
- Enterprise contact form CTA

### 3.6 Testimonials/Social Proof Section

**Purpose:** Build trust with enterprise credibility

**Elements:**
- Design partner quotes (target: regulated industries)
- Company logos (finance, healthcare, legal tech)
- Case study snippets with metrics
- "Trusted by X+ AI teams" counter

**Content Strategy:**
```dart
class Testimonial {
  final String quote;
  final String name;
  final String title;
  final String company;
  final String industry; // Finance, Healthcare, Legal, Government
  final String? metric; // "Reduced debugging time by 80%"
  final String? avatarUrl;
}
```

### 3.7 Resources/Blog Section

**Purpose:** Establish thought leadership

**Featured Content Categories:**
1. AI Observability best practices
2. EU AI Act compliance guides
3. LLM monitoring tutorials
4. Industry-specific use cases

**Card Design:**
- Thumbnail image
- Category tag badge
- Title with 2-line clamp
- Excerpt with 3-line clamp
- Read time and date meta
- "Read More" CTA with arrow

### 3.8 Contact Section

**Purpose:** Capture leads, especially enterprise inquiries

**Form Fields:**
- Name (required)
- Work Email (required, validated)
- Company Name (required)
- Company Size (dropdown: 1-10, 11-50, 51-200, 201-1000, 1000+)
- Use Case (dropdown: LLM Monitoring, Agent Observability, Compliance, Other)
- Message (optional)

**Contact Info:**
- Email: hello@integritystudio.ai
- Calendly integration for demos
- Austin, Texas location

### 3.9 Footer Section

**Structure:**
- Company info with logo
- Navigation columns (Platform, Resources, Company, Legal)
- Social links (LinkedIn, Twitter, GitHub)
- Newsletter signup
- Copyright and legal links

---

## Phase 4: Design System

### 4.1 Color Palette

```dart
class AppColors {
  // Primary Brand Colors
  static const Color blue400 = Color(0xFF60A5FA);
  static const Color blue500 = Color(0xFF3B82F6);
  static const Color blue600 = Color(0xFF2563EB);
  static const Color blue900 = Color(0xFF1E3A8A);

  // Secondary Colors
  static const Color indigo400 = Color(0xFF818CF8);
  static const Color indigo500 = Color(0xFF6366F1);
  static const Color indigo600 = Color(0xFF4F46E5);

  // Accent Colors
  static const Color purple400 = Color(0xFFC084FC);
  static const Color purple500 = Color(0xFFA855F7);
  static const Color purple600 = Color(0xFF9333EA);

  // Neutrals (Dark Theme)
  static const Color gray900 = Color(0xFF111827);
  static const Color gray800 = Color(0xFF1F2937);
  static const Color gray700 = Color(0xFF374151);
  static const Color gray600 = Color(0xFF4B5563);
  static const Color gray500 = Color(0xFF6B7280);
  static const Color gray400 = Color(0xFF9CA3AF);
  static const Color gray300 = Color(0xFFD1D5DB);

  // Semantic Colors
  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [blue500, indigo600],
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [blue500, indigo500, purple600],
  );
}
```

### 4.2 Typography Scale

```dart
class AppTypography {
  static const String fontFamily = 'Inter';

  // Headings
  static TextStyle get headingXL => TextStyle(
    fontFamily: fontFamily,
    fontSize: 64,
    fontWeight: FontWeight.bold,
    height: 1.1,
    letterSpacing: -0.02,
    color: Colors.white,
  );

  static TextStyle get headingLg => TextStyle(
    fontFamily: fontFamily,
    fontSize: 48,
    fontWeight: FontWeight.bold,
    height: 1.15,
    letterSpacing: -0.01,
    color: Colors.white,
  );

  static TextStyle get headingMd => TextStyle(
    fontFamily: fontFamily,
    fontSize: 36,
    fontWeight: FontWeight.bold,
    height: 1.2,
    color: Colors.white,
  );

  static TextStyle get headingSm => TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.semiBold,
    height: 1.3,
    color: Colors.white,
  );

  // Body
  static TextStyle get bodyLg => TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.normal,
    height: 1.6,
    color: AppColors.gray300,
  );

  static TextStyle get bodyMd => TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.normal,
    height: 1.5,
    color: AppColors.gray300,
  );

  static TextStyle get bodySm => TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.normal,
    height: 1.5,
    color: AppColors.gray400,
  );

  // Special
  static TextStyle get buttonText => TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.semiBold,
    height: 1.0,
    letterSpacing: 0.01,
  );

  static TextStyle get caption => TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.medium,
    height: 1.4,
    color: AppColors.gray400,
  );

  static TextStyle get statValue => TextStyle(
    fontFamily: fontFamily,
    fontSize: 36,
    fontWeight: FontWeight.bold,
    height: 1.0,
  );
}
```

### 4.3 Spacing System

```dart
class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;
  static const double xxxl = 64;
  static const double section = 80;

  // Container
  static const double containerMaxWidth = 1280;
  static const double containerPaddingMobile = 16;
  static const double containerPaddingTablet = 24;
  static const double containerPaddingDesktop = 32;

  // Section
  static const double sectionVertical = 80;
  static const double sectionVerticalMobile = 48;
}
```

### 4.4 Component Library

#### Gradient Button
```dart
class GradientButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: AppColors.blue500.withOpacity(0.3),
            blurRadius: 16,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(text, style: AppTypography.buttonText.copyWith(color: Colors.white)),
                if (icon != null) ...[
                  SizedBox(width: 8),
                  Icon(icon, size: 20, color: Colors.white),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
```

#### Glass Card
```dart
class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final bool enableHover;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: AppColors.gray900.withOpacity(0.8),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.gray700.withOpacity(0.5),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.gray900.withOpacity(0.3),
            blurRadius: 24,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Padding(
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }
}
```

#### Animated Orb
```dart
class AnimatedOrb extends StatefulWidget {
  final Color color;
  final double size;
  final Offset position;
  final OrbAnimationType animationType;

  @override
  State<AnimatedOrb> createState() => _AnimatedOrbState();
}

class _AnimatedOrbState extends State<AnimatedOrb>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.position.dx,
      top: widget.position.dy,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.translate(
            offset: _calculateOffset(),
            child: Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.color,
                boxShadow: [
                  BoxShadow(
                    color: widget.color,
                    blurRadius: 80,
                    spreadRadius: 20,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
```

---

## Phase 5: Technical Specifications

### 5.1 Responsive Design Approach

**Breakpoints:**
```dart
class Breakpoints {
  static const double mobile = 0;
  static const double tablet = 768;
  static const double desktop = 1024;
  static const double wide = 1440;
}

class ResponsiveUtils {
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < Breakpoints.tablet;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= Breakpoints.tablet &&
      MediaQuery.of(context).size.width < Breakpoints.desktop;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= Breakpoints.desktop;
}
```

**Responsive Container:**
```dart
class ResponsiveContainer extends StatelessWidget {
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: AppSpacing.containerMaxWidth),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveUtils.isMobile(context)
                ? AppSpacing.containerPaddingMobile
                : ResponsiveUtils.isTablet(context)
                    ? AppSpacing.containerPaddingTablet
                    : AppSpacing.containerPaddingDesktop,
          ),
          child: child,
        ),
      ),
    );
  }
}
```

### 5.2 Animation/Interaction Patterns

**Fade In Up Animation:**
```dart
class FadeInUp extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final double offset;

  @override
  State<FadeInUp> createState() => _FadeInUpState();
}

class _FadeInUpState extends State<FadeInUp>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<Offset> _position;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _position = Tween<Offset>(
      begin: Offset(0, widget.offset),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    Future.delayed(widget.delay, () => _controller.forward());
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Opacity(
        opacity: _opacity.value,
        child: Transform.translate(
          offset: _position.value,
          child: widget.child,
        ),
      ),
    );
  }
}
```

**Stagger Animation Helper:**
```dart
Widget staggeredList(List<Widget> children, {Duration baseDelay = Duration.zero}) {
  return Column(
    children: children.asMap().entries.map((entry) {
      return FadeInUp(
        delay: baseDelay + Duration(milliseconds: entry.key * 100),
        child: entry.value,
      );
    }).toList(),
  );
}
```

### 5.3 SEO Considerations for Flutter Web

**HTML Meta Tags (web/index.html):**
```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">

  <!-- Primary Meta Tags -->
  <title>Integrity Studio - AI Observability Platform | Enterprise LLM Monitoring</title>
  <meta name="title" content="Integrity Studio - AI Observability Platform | Enterprise LLM Monitoring">
  <meta name="description" content="Monitor LLM performance, ensure EU AI Act compliance, and gain complete visibility into your AI systems. Enterprise-grade observability for production AI.">
  <meta name="keywords" content="AI observability, LLM monitoring, AI compliance, EU AI Act, MLOps, AI governance, agent observability">

  <!-- Open Graph / Facebook -->
  <meta property="og:type" content="website">
  <meta property="og:url" content="https://integritystudio.ai/">
  <meta property="og:title" content="Integrity Studio - AI Observability Platform">
  <meta property="og:description" content="Monitor LLM performance, ensure EU AI Act compliance, and gain complete visibility into your AI systems.">
  <meta property="og:image" content="https://integritystudio.ai/images/og-image.png">

  <!-- Twitter -->
  <meta property="twitter:card" content="summary_large_image">
  <meta property="twitter:url" content="https://integritystudio.ai/">
  <meta property="twitter:title" content="Integrity Studio - AI Observability Platform">
  <meta property="twitter:description" content="Monitor LLM performance, ensure EU AI Act compliance, and gain complete visibility into your AI systems.">
  <meta property="twitter:image" content="https://integritystudio.ai/images/og-image.png">

  <!-- Canonical -->
  <link rel="canonical" href="https://integritystudio.ai/">

  <!-- Favicon -->
  <link rel="icon" type="image/png" href="favicon.png">
  <link rel="apple-touch-icon" href="icons/Icon-192.png">

  <!-- Structured Data -->
  <script type="application/ld+json">
  {
    "@context": "https://schema.org",
    "@type": "SoftwareApplication",
    "name": "Integrity Studio",
    "applicationCategory": "BusinessApplication",
    "description": "AI Observability Platform for enterprise LLM monitoring and EU AI Act compliance",
    "operatingSystem": "Web",
    "offers": {
      "@type": "Offer",
      "price": "0",
      "priceCurrency": "USD",
      "description": "Free tier available"
    },
    "creator": {
      "@type": "Organization",
      "name": "Integrity Studio",
      "url": "https://integritystudio.ai"
    }
  }
  </script>

  <!-- Preload critical fonts -->
  <link rel="preload" href="assets/fonts/inter/Inter-Regular.ttf" as="font" type="font/ttf" crossorigin>
  <link rel="preload" href="assets/fonts/inter/Inter-Bold.ttf" as="font" type="font/ttf" crossorigin>
</head>
<body>
  <noscript>
    <h1>Integrity Studio - AI Observability Platform</h1>
    <p>Monitor LLM performance, ensure EU AI Act compliance, and gain complete visibility into your AI systems.</p>
    <p>Please enable JavaScript to use this application.</p>
  </noscript>
  <script src="main.dart.js" type="application/javascript"></script>
</body>
</html>
```

**Flutter Web SEO Utility:**
```dart
class SeoUtils {
  static void updatePageTitle(String title) {
    html.document.title = title;
  }

  static void updateMetaDescription(String description) {
    final meta = html.document.querySelector('meta[name="description"]');
    meta?.setAttribute('content', description);
  }

  static void updateCanonicalUrl(String url) {
    final link = html.document.querySelector('link[rel="canonical"]');
    link?.setAttribute('href', url);
  }
}
```

### 5.4 Performance Optimization

**Build Configuration:**
```yaml
# flutter build web --release --web-renderer canvaskit
# OR for better SEO/initial load:
# flutter build web --release --web-renderer html
```

**Lazy Loading:**
```dart
class LazySection extends StatefulWidget {
  final Widget child;
  final String sectionId;

  @override
  State<LazySection> createState() => _LazySectionState();
}

class _LazySectionState extends State<LazySection> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(widget.sectionId),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.1 && !_isVisible) {
          setState(() => _isVisible = true);
        }
      },
      child: _isVisible
          ? widget.child
          : SizedBox(height: 400), // Placeholder height
    );
  }
}
```

**Image Optimization:**
- Use WebP format for all images
- Implement responsive image loading
- Lazy load images below the fold
- Use appropriate image dimensions per breakpoint

### 5.5 Analytics Integration

**GA4 Setup:**
```dart
class AnalyticsService {
  static Future<void> initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  static void trackPageView(String pageName) {
    FirebaseAnalytics.instance.setCurrentScreen(screenName: pageName);
  }

  static void trackCTAClick({
    required String buttonName,
    required String location,
    required String ctaType,
  }) {
    FirebaseAnalytics.instance.logEvent(
      name: 'cta_click',
      parameters: {
        'button_name': buttonName,
        'location': location,
        'cta_type': ctaType,
      },
    );
  }

  static void trackFormSubmission({
    required String formType,
    required bool success,
  }) {
    FirebaseAnalytics.instance.logEvent(
      name: 'form_submission',
      parameters: {
        'form_type': formType,
        'success': success.toString(),
      },
    );
  }

  static void trackPricingView(String tier) {
    FirebaseAnalytics.instance.logEvent(
      name: 'pricing_tier_view',
      parameters: {'tier': tier},
    );
  }
}
```

**Facebook Pixel (via HTML):**
```html
<!-- In web/index.html -->
<script>
  !function(f,b,e,v,n,t,s)
  {if(f.fbq)return;n=f.fbq=function(){n.callMethod?
  n.callMethod.apply(n,arguments):n.queue.push(arguments)};
  if(!f._fbq)f._fbq=n;n.push=n;n.loaded=!0;n.version='2.0';
  n.queue=[];t=b.createElement(e);t.async=!0;
  t.src=v;s=b.getElementsByTagName(e)[0];
  s.parentNode.insertBefore(t,s)}(window, document,'script',
  'https://connect.facebook.net/en_US/fbevents.js');
  fbq('init', 'YOUR_PIXEL_ID');
  fbq('track', 'PageView');
</script>
```

---

## Phase 6: Implementation Roadmap

### Week 1-2: Foundation
- [ ] Flutter project setup
- [ ] Design system implementation (colors, typography, spacing)
- [ ] Base component library (buttons, cards, containers)
- [ ] Responsive utilities
- [ ] Animation foundation

### Week 3-4: Core Sections
- [ ] Hero section with animations
- [ ] Features/Platform section
- [ ] Navigation header (sticky, mobile menu)
- [ ] Footer section

### Week 5-6: Advanced Sections
- [ ] AI Observability showcase
- [ ] EU AI Act compliance section
- [ ] Pricing section with toggle
- [ ] Contact form with validation

### Week 7: Polish & Integration
- [ ] Analytics integration (GA4, Facebook Pixel)
- [ ] Error tracking (Sentry)
- [ ] SEO optimization
- [ ] Performance optimization
- [ ] Accessibility audit

### Week 8: Testing & Launch
- [ ] Cross-browser testing
- [ ] Mobile responsiveness testing
- [ ] Performance benchmarking
- [ ] Cloudflare Pages deployment
- [ ] DNS cutover from v1 site

---

## Phase 7: Content Migration Guide

### 7.1 Content That Transfers
- Logo and brand assets
- Contact information
- Legal pages (Privacy Policy, Terms)
- Blog posts (reformatted for new theme)

### 7.2 Content Requiring Updates
- Hero messaging (nonprofit -> AI observability)
- Services section -> Features section
- About section -> Platform section
- Stats (update metrics for platform positioning)

### 7.3 New Content Required
- Pricing tier details
- Integration partner logos
- Platform screenshot/demo
- EU AI Act compliance content
- Testimonials from design partners

---

## Appendix A: Migration Checklist

- [ ] Export all assets from current site
- [ ] Redirect map from old URLs to new
- [ ] 301 redirects configuration
- [ ] DNS TTL reduction before cutover
- [ ] Backup of current site
- [ ] Analytics property migration
- [ ] Form submission endpoint updates
- [ ] SSL certificate verification

## Appendix B: Environment Variables

```dart
// lib/config/environment.dart
class Environment {
  static const String sentryDsn = String.fromEnvironment('SENTRY_DSN');
  static const String firebaseProjectId = String.fromEnvironment('FIREBASE_PROJECT_ID');
  static const String firebaseAppId = String.fromEnvironment('FIREBASE_APP_ID');
  static const String apiBaseUrl = String.fromEnvironment('API_BASE_URL');
  static const String calendlyUrl = 'https://calendly.com/alyshialedlie/15min';
}
```

## Appendix C: Deployment Configuration

**Cloudflare Pages Build Settings:**
```
Build command: flutter build web --release --web-renderer html
Build output directory: build/web
Root directory: /
```

**_redirects file:**
```
/*    /index.html   200
```

**_headers file:**
```
/*
  X-Frame-Options: DENY
  X-Content-Type-Options: nosniff
  Referrer-Policy: strict-origin-when-cross-origin
  Content-Security-Policy: default-src 'self'; script-src 'self' 'unsafe-inline' https://www.googletagmanager.com https://connect.facebook.net; style-src 'self' 'unsafe-inline'; img-src 'self' data: https:; font-src 'self' data:;
```

---

*Document Version: 1.0*
*Created: December 2024*
*Author: Quality Control Agent*
*Project: IntegrityStudio.ai Flutter Rebuild*
