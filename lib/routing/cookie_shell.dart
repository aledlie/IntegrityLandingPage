import 'package:flutter/material.dart';
import '../widgets/consent/cookie_banner.dart';

/// Global notifier for cookie banner visibility.
///
/// This allows the banner state to change without recreating the router,
/// which is critical for preserving the current route on direct URL access.
final cookieBannerNotifier = ValueNotifier<bool>(false);

/// Shell widget that wraps all routes with a cookie consent banner overlay.
///
/// Used with GoRouter's ShellRoute to provide consistent cookie banner
/// behavior across all pages without code duplication.
class CookieBannerShell extends StatelessWidget {
  const CookieBannerShell({
    required this.child,
    required this.onConsentGiven,
    super.key,
  });

  /// The child page content from the current route.
  final Widget child;

  /// Callback when user gives consent.
  final VoidCallback onConsentGiven;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        ValueListenableBuilder<bool>(
          valueListenable: cookieBannerNotifier,
          builder: (context, showBanner, _) {
            if (!showBanner) return const SizedBox.shrink();
            return CookieBanner(onConsentGiven: onConsentGiven);
          },
        ),
      ],
    );
  }
}
