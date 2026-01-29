import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'theme/theme.dart';
import 'routing/app_router.dart';
import 'services/analytics.dart';
import 'services/consent_manager.dart';
import 'services/tracking.dart';

class IntegrityStudioApp extends StatefulWidget {
  const IntegrityStudioApp({super.key});

  @override
  State<IntegrityStudioApp> createState() => _IntegrityStudioAppState();
}

class _IntegrityStudioAppState extends State<IntegrityStudioApp> {
  bool _showCookieBanner = false;
  late GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = _createRouter();
    _checkConsent();
  }

  GoRouter _createRouter() {
    return createAppRouter(
      showCookieBanner: _showCookieBanner,
      onConsentGiven: _handleConsentGiven,
      onShowCookieSettings: _showCookieSettings,
    );
  }

  Future<void> _checkConsent() async {
    final hasConsent = ConsentManager.hasConsent();
    if (!hasConsent) {
      setState(() {
        _showCookieBanner = true;
        _router = _createRouter();
      });
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
    setState(() {
      _showCookieBanner = false;
      _router = _createRouter();
    });
  }

  void _showCookieSettings() {
    setState(() {
      _showCookieBanner = true;
      _router = _createRouter();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Integrity Studio - Enterprise AI Observability',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      routerConfig: _router,
    );
  }
}
