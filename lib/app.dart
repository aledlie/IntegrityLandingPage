import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'theme/theme.dart';
import 'pages/landing_page.dart';
import 'pages/blog_page.dart';
import 'pages/comparison_page.dart';
import 'pages/sources_page.dart';
import 'pages/legal_page.dart';
import 'pages/about_page.dart';
import 'pages/signup_page.dart';
import 'pages/pricing_page.dart';
import 'pages/contact_page.dart';
import 'pages/careers_page.dart';
import 'pages/security_page.dart';
import 'services/analytics.dart';
import 'services/consent_manager.dart';
import 'services/tracking.dart';
import 'widgets/consent/cookie_banner.dart';

class IntegrityStudioApp extends StatefulWidget {
  const IntegrityStudioApp({super.key});

  @override
  State<IntegrityStudioApp> createState() => _IntegrityStudioAppState();
}

class _IntegrityStudioAppState extends State<IntegrityStudioApp> {
  bool _showCookieBanner = false;

  @override
  void initState() {
    super.initState();
    _checkConsent();
  }

  Future<void> _checkConsent() async {
    final hasConsent = ConsentManager.hasConsent();
    if (!hasConsent) {
      setState(() => _showCookieBanner = true);
    } else {
      // Re-initialize tracking for returning users with saved consent
      final prefs = await ConsentManager.getStoredConsent();
      if (prefs != null && kIsWeb) {
        // Update Consent Mode with stored preferences
        TrackingWeb.updateConsent(
          analytics: prefs.analytics,
          marketing: prefs.marketing,
        );

        // Initialize analytics if previously consented
        if (prefs.analytics) {
          await AnalyticsService.initialize();
        }

        // Initialize Facebook Pixel if marketing was consented
        if (prefs.marketing) {
          TrackingWeb.injectFacebookPixel();
          TrackingWeb.sendFBPageView();
        }
      }
    }
  }

  void _handleConsentGiven() {
    setState(() => _showCookieBanner = false);
  }

  void _showCookieSettings() {
    setState(() => _showCookieBanner = true);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Integrity Studio - Enterprise AI Observability',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        // Handle blog routes
        if (settings.name == '/blog') {
          return MaterialPageRoute(
            builder: (context) => Stack(
              children: [
                BlogPage(onBack: () => Navigator.of(context).pushReplacementNamed('/')),
                if (_showCookieBanner)
                  CookieBanner(onConsentGiven: _handleConsentGiven),
              ],
            ),
          );
        }

        // Handle WhyLabs alternative page
        if (settings.name == '/whylabs-alternative') {
          return MaterialPageRoute(
            builder: (context) => Stack(
              children: [
                ComparisonPage.whylabs(
                  onBack: () => Navigator.of(context).pushReplacementNamed('/'),
                ),
                if (_showCookieBanner)
                  CookieBanner(onConsentGiven: _handleConsentGiven),
              ],
            ),
          );
        }

        // Handle Arize alternative page
        if (settings.name == '/compare/arize-ai-alternative') {
          return MaterialPageRoute(
            builder: (context) => Stack(
              children: [
                ComparisonPage.arize(
                  onBack: () => Navigator.of(context).pushReplacementNamed('/'),
                ),
                if (_showCookieBanner)
                  CookieBanner(onConsentGiven: _handleConsentGiven),
              ],
            ),
          );
        }

        // Handle Sources page
        if (settings.name == '/sources') {
          return MaterialPageRoute(
            builder: (context) => Stack(
              children: [
                SourcesPage(
                  onBack: () => Navigator.of(context).pushReplacementNamed('/'),
                ),
                if (_showCookieBanner)
                  CookieBanner(onConsentGiven: _handleConsentGiven),
              ],
            ),
          );
        }

        // Handle About page
        if (settings.name == '/about') {
          return MaterialPageRoute(
            builder: (context) => Stack(
              children: [
                AboutPage(
                  onBack: () => Navigator.of(context).pushReplacementNamed('/'),
                  onShowCookieSettings: _showCookieSettings,
                ),
                if (_showCookieBanner)
                  CookieBanner(onConsentGiven: _handleConsentGiven),
              ],
            ),
          );
        }

        // Handle Pricing page
        if (settings.name == '/pricing') {
          return MaterialPageRoute(
            builder: (context) => Stack(
              children: [
                PricingPage(
                  onBack: () => Navigator.of(context).pushReplacementNamed('/'),
                  onShowCookieSettings: _showCookieSettings,
                ),
                if (_showCookieBanner)
                  CookieBanner(onConsentGiven: _handleConsentGiven),
              ],
            ),
          );
        }

        // Handle Contact page
        if (settings.name == '/contact') {
          return MaterialPageRoute(
            builder: (context) => Stack(
              children: [
                ContactPage(
                  onBack: () => Navigator.of(context).pushReplacementNamed('/'),
                  onShowCookieSettings: _showCookieSettings,
                ),
                if (_showCookieBanner)
                  CookieBanner(onConsentGiven: _handleConsentGiven),
              ],
            ),
          );
        }

        // Handle Careers page
        if (settings.name == '/careers') {
          return MaterialPageRoute(
            builder: (context) => Stack(
              children: [
                CareersPage(
                  onBack: () => Navigator.of(context).pushReplacementNamed('/'),
                  onShowCookieSettings: _showCookieSettings,
                ),
                if (_showCookieBanner)
                  CookieBanner(onConsentGiven: _handleConsentGiven),
              ],
            ),
          );
        }

        // Handle Signup page with tier parameter
        if (settings.name?.startsWith('/signup') == true) {
          final uri = Uri.parse(settings.name!);
          final tier = uri.queryParameters['tier'] ?? 'starter';
          return MaterialPageRoute(
            builder: (context) => Stack(
              children: [
                SignupPage(
                  tier: tier,
                  onBack: () => Navigator.of(context).pushReplacementNamed('/'),
                ),
                if (_showCookieBanner)
                  CookieBanner(onConsentGiven: _handleConsentGiven),
              ],
            ),
          );
        }

        // Handle Privacy Policy page
        if (settings.name == '/privacy') {
          return MaterialPageRoute(
            builder: (context) => Stack(
              children: [
                LegalPage.privacy(
                  onBack: () => Navigator.of(context).pushReplacementNamed('/'),
                ),
                if (_showCookieBanner)
                  CookieBanner(onConsentGiven: _handleConsentGiven),
              ],
            ),
          );
        }

        // Handle Terms of Service page
        if (settings.name == '/terms') {
          return MaterialPageRoute(
            builder: (context) => Stack(
              children: [
                LegalPage.terms(
                  onBack: () => Navigator.of(context).pushReplacementNamed('/'),
                ),
                if (_showCookieBanner)
                  CookieBanner(onConsentGiven: _handleConsentGiven),
              ],
            ),
          );
        }

        // Handle Cookies Policy page
        if (settings.name == '/cookies') {
          return MaterialPageRoute(
            builder: (context) => Stack(
              children: [
                LegalPage.cookies(
                  onBack: () => Navigator.of(context).pushReplacementNamed('/'),
                ),
                if (_showCookieBanner)
                  CookieBanner(onConsentGiven: _handleConsentGiven),
              ],
            ),
          );
        }

        // Handle Accessibility Statement page
        if (settings.name == '/accessibility') {
          return MaterialPageRoute(
            builder: (context) => Stack(
              children: [
                LegalPage.accessibility(
                  onBack: () => Navigator.of(context).pushReplacementNamed('/'),
                ),
                if (_showCookieBanner)
                  CookieBanner(onConsentGiven: _handleConsentGiven),
              ],
            ),
          );
        }

        // Handle Security page
        if (settings.name == '/security') {
          return MaterialPageRoute(
            builder: (context) => Stack(
              children: [
                SecurityPage(
                  onBack: () => Navigator.of(context).pushReplacementNamed('/'),
                ),
                if (_showCookieBanner)
                  CookieBanner(onConsentGiven: _handleConsentGiven),
              ],
            ),
          );
        }

        // Default to landing page
        return MaterialPageRoute(
          builder: (context) => Stack(
            children: [
              LandingPage(onShowCookieSettings: _showCookieSettings),
              if (_showCookieBanner)
                CookieBanner(onConsentGiven: _handleConsentGiven),
            ],
          ),
        );
      },
    );
  }
}
