import 'package:flutter/material.dart';
import '../theme/theme.dart';
import '../services/analytics.dart';
import '../widgets/sections/hero_section.dart';
import '../widgets/sections/tabbed_features_section.dart';
import '../widgets/sections/social_proof_section.dart';
import '../widgets/sections/features_section.dart';
import '../widgets/sections/services_section.dart';
import '../widgets/sections/about_section.dart';
import '../widgets/sections/resources_section.dart';
import '../widgets/sections/contact_section.dart';
import '../widgets/sections/pricing_section.dart';
import '../widgets/sections/status_section.dart';
import '../widgets/sections/cta_section.dart';
import '../widgets/sections/footer_section.dart';

/// Main landing page composing all sections.
///
/// Features:
/// - Smooth scroll navigation between sections
/// - Scroll depth tracking for analytics
/// - Responsive layout with accessibility support
/// - Semantic regions for screen readers
class LandingPage extends StatefulWidget {
  final VoidCallback? onShowCookieSettings;

  const LandingPage({
    super.key,
    this.onShowCookieSettings,
  });

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final ScrollController _scrollController = ScrollController();

  // Section keys for scroll navigation
  final _sectionKeys = <String, GlobalKey>{
    'hero': GlobalKey(),
    'features-explorer': GlobalKey(),
    'social-proof': GlobalKey(),
    'features': GlobalKey(),
    'services': GlobalKey(),
    'about': GlobalKey(),
    'resources': GlobalKey(),
    'contact': GlobalKey(),
    'status': GlobalKey(),
    'pricing': GlobalKey(),
    'cta': GlobalKey(),
  };

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    AnalyticsService.trackPageView('landing');
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    if (maxScroll <= 0) return;

    final percentage = ((_scrollController.offset / maxScroll) * 100).round();
    AnalyticsService.trackScrollDepth(percentage);
  }

  void _scrollToSection(String sectionName) {
    final key = _sectionKeys[sectionName];
    if (key?.currentContext == null) return;

    Scrollable.ensureVisible(
      key!.currentContext!,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray900,
      body: SelectionArea(
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            _buildSection(
              key: _sectionKeys['hero']!,
              label: 'Hero section',
              child: HeroSection(
                onGetStarted: () => _scrollToSection('pricing'),
                onWatchDemo: _handleWatchDemo,
              ),
            ),
            // Tabbed feature explorer (AiSDR-inspired interactive tabs)
            _buildSection(
              key: _sectionKeys['features-explorer']!,
              label: 'Feature explorer section',
              child: const TabbedFeaturesSection(),
            ),
            // Social proof with quantified metrics (AiSDR-inspired)
            _buildSection(
              key: _sectionKeys['social-proof']!,
              label: 'Social proof section',
              child: const SocialProofSection(),
            ),
            _buildSection(
              key: _sectionKeys['features']!,
              label: 'Features section',
              child: const FeaturesSection(),
            ),
            // Services section (platform capabilities)
            _buildSection(
              key: _sectionKeys['services']!,
              label: 'Services section',
              child: const ServicesSection(),
            ),
            // About section (company story, values, team)
            _buildSection(
              key: _sectionKeys['about']!,
              label: 'About section',
              child: const AboutSection(),
            ),
            // Resources section (docs, blog, lead magnets)
            _buildSection(
              key: _sectionKeys['resources']!,
              label: 'Resources section',
              child: const ResourcesSection(),
            ),
            // Contact section (form, contact methods)
            _buildSection(
              key: _sectionKeys['contact']!,
              label: 'Contact section',
              child: const ContactSection(),
            ),
            _buildSection(
              key: _sectionKeys['status']!,
              label: 'Status section',
              child: const StatusSection(),
            ),
            _buildSection(
              key: _sectionKeys['pricing']!,
              label: 'Pricing section',
              child: PricingSection(
                onSelectTier: _handleSelectTier,
              ),
            ),
            _buildSection(
              key: _sectionKeys['cta']!,
              label: 'Call to action section',
              child: CTASection(
                onGetStarted: () => _scrollToSection('pricing'),
              ),
            ),
            _buildSection(
              label: 'Footer section',
              child: FooterSection(
                onCookieSettings: widget.onShowCookieSettings,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build a semantic sliver section.
  SliverToBoxAdapter _buildSection({
    GlobalKey? key,
    required String label,
    required Widget child,
  }) {
    Widget content = child;

    if (key != null) {
      content = KeyedSubtree(key: key, child: content);
    }

    return SliverToBoxAdapter(
      child: Semantics(
        label: label,
        child: content,
      ),
    );
  }

  void _handleWatchDemo() {
    // TODO: Implement demo modal or video player
    AnalyticsService.trackDemoRequest();
  }

  void _handleSelectTier(String tier) {
    // TODO: Navigate to signup with tier selection
    AnalyticsService.trackPricingView(tier);
  }
}
