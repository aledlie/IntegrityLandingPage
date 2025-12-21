import 'package:flutter/material.dart';
import 'theme/theme.dart';
import 'pages/landing_page.dart';
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
      home: Stack(
        children: [
          LandingPage(onShowCookieSettings: _showCookieSettings),
          if (_showCookieBanner)
            CookieBanner(onConsentGiven: _handleConsentGiven),
        ],
      ),
    );
  }
}
