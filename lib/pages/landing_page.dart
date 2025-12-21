import 'package:flutter/material.dart';
import '../theme/theme.dart';
import '../services/analytics.dart';
import '../widgets/sections/hero_section.dart';
import '../widgets/sections/features_section.dart';
import '../widgets/sections/pricing_section.dart';
import '../widgets/sections/cta_section.dart';
import '../widgets/sections/footer_section.dart';

/// Main landing page composing all sections
///
/// Features:
/// - Smooth scroll navigation
/// - Section tracking for analytics
/// - Responsive layout
/// - Accessibility with semantic regions
///
/// Usage:
/// ```dart
/// LandingPage()
/// ```
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
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _featuresKey = GlobalKey();
  final GlobalKey _pricingKey = GlobalKey();
  final GlobalKey _ctaKey = GlobalKey();

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
    // Track scroll depth at 25%, 50%, 75%, 100%
    final maxScroll = _scrollController.position.maxScrollExtent;
    if (maxScroll > 0) {
      final percentage =
          ((_scrollController.offset / maxScroll) * 100).round();
      AnalyticsService.trackScrollDepth(percentage);
    }
  }

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void _scrollToPricing() => _scrollToSection(_pricingKey);
  void _scrollToCTA() => _scrollToSection(_ctaKey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray900,
      body: SelectionArea(
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            // Hero Section
            SliverToBoxAdapter(
              child: Semantics(
                label: 'Hero section',
                child: KeyedSubtree(
                  key: _heroKey,
                  child: HeroSection(
                    onGetStarted: _scrollToPricing,
                    onWatchDemo: () {
                      // TODO: Implement demo modal
                    },
                  ),
                ),
              ),
            ),

            // Features Section
            SliverToBoxAdapter(
              child: Semantics(
                label: 'Features section',
                child: KeyedSubtree(
                  key: _featuresKey,
                  child: const FeaturesSection(),
                ),
              ),
            ),

            // Pricing Section
            SliverToBoxAdapter(
              child: Semantics(
                label: 'Pricing section',
                child: KeyedSubtree(
                  key: _pricingKey,
                  child: PricingSection(
                    onSelectTier: (tier) {
                      // TODO: Navigate to signup with tier selection
                    },
                  ),
                ),
              ),
            ),

            // CTA Section
            SliverToBoxAdapter(
              child: Semantics(
                label: 'Call to action section',
                child: KeyedSubtree(
                  key: _ctaKey,
                  child: CTASection(
                    onGetStarted: _scrollToPricing,
                  ),
                ),
              ),
            ),

            // Footer
            SliverToBoxAdapter(
              child: Semantics(
                label: 'Footer section',
                child: FooterSection(
                  onCookieSettings: widget.onShowCookieSettings,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
