import 'package:flutter/material.dart';
import '../widgets/consent/cookie_banner.dart';

/// Shell widget that wraps all routes with a cookie consent banner overlay.
///
/// Used with GoRouter's ShellRoute to provide consistent cookie banner
/// behavior across all pages without code duplication.
class CookieBannerShell extends StatelessWidget {
  const CookieBannerShell({
    required this.child,
    required this.showBanner,
    required this.onConsentGiven,
    super.key,
  });

  /// The child page content from the current route.
  final Widget child;

  /// Whether to show the cookie consent banner.
  final bool showBanner;

  /// Callback when user gives consent.
  final VoidCallback onConsentGiven;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (showBanner) CookieBanner(onConsentGiven: onConsentGiven),
      ],
    );
  }
}
