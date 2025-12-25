import 'package:flutter/material.dart';
import 'theme/theme.dart';
import 'pages/landing_page.dart';
import 'pages/blog_page.dart';
import 'pages/comparison_page.dart';
import 'pages/sources_page.dart';
import 'pages/legal_page.dart';
import 'services/consent_manager.dart';
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
      // Initialize analytics if consent was previously given
      final prefs = await ConsentManager.getStoredConsent();
      if (prefs?.analytics == true) {
        // Analytics will be initialized by ConsentManager
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
