import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/landing_controller.dart';

/// Application-wide provider configuration
///
/// This file sets up all providers for the application.
/// Providers enable dependency injection and state management.
///
/// Usage:
/// ```dart
/// // In main.dart or app.dart
/// runApp(
///   AppProviders(
///     child: IntegrityStudioApp(),
///   ),
/// );
///
/// // In any widget
/// final controller = context.read<LandingController>();
/// ```
class AppProviders extends StatelessWidget {
  final Widget child;

  const AppProviders({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Landing page controller
        ChangeNotifierProvider<LandingController>(
          create: (_) => LandingController()..initialize(),
        ),

        // Content variant controller for A/B testing
        ChangeNotifierProvider<ContentVariantController>(
          create: (_) => ContentVariantController(),
        ),
      ],
      child: child,
    );
  }
}

/// Convenience extension for accessing controllers
extension ProviderExtensions on BuildContext {
  /// Get the landing controller
  LandingController get landingController => read<LandingController>();

  /// Watch the landing controller for changes
  LandingController get watchLandingController => watch<LandingController>();

  /// Get the content variant controller
  ContentVariantController get variantController =>
      read<ContentVariantController>();

  /// Watch the content variant controller for changes
  ContentVariantController get watchVariantController =>
      watch<ContentVariantController>();
}
