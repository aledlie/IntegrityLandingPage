import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme/theme.dart';
import '../widgets/common/buttons.dart';

/// Simple "Coming Soon" page for the demo route.
class DemoPage extends StatelessWidget {
  final VoidCallback? onBack;

  const DemoPage({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray900,
      appBar: AppBar(
        backgroundColor: AppColors.gray900,
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft, color: Colors.white),
          onPressed: onBack ?? () => context.go('/'),
        ),
        title: Text(
          'Demo',
          style: AppTypography.headingSM.copyWith(color: Colors.white),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                LucideIcons.rocket,
                size: 64,
                color: AppColors.blue400,
              ),
              const SizedBox(height: AppSpacing.xl),
              Text(
                'Coming Soon!',
                style: AppTypography.headingXL.copyWith(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                'Our interactive demo is currently in development.\nContact us for a personalized walkthrough.',
                style: AppTypography.bodyLG.copyWith(
                  color: AppColors.gray300,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xxl),
              GradientButton(
                text: 'Contact Us',
                onPressed: () => context.go('/contact'),
              ),
              const SizedBox(height: AppSpacing.md),
              TextButton(
                onPressed: onBack ?? () => context.go('/'),
                child: Text(
                  'Back to Home',
                  style: AppTypography.bodySM.copyWith(
                    color: AppColors.blue400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
