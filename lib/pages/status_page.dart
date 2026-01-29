import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import '../config/content.dart';
import '../theme/theme.dart';
import '../services/analytics.dart';
import '../widgets/common/containers.dart';
import '../widgets/sections/footer_section.dart';

/// Status page displaying platform operational health and metrics.
class StatusPage extends StatefulWidget {
  final VoidCallback? onBack;
  final VoidCallback? onShowCookieSettings;

  const StatusPage({
    super.key,
    this.onBack,
    this.onShowCookieSettings,
  });

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  @override
  void initState() {
    super.initState();
    AnalyticsService.trackPageView('status');
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    final content = StatusContentVariants.current;

    return Scaffold(
      backgroundColor: AppColors.gray900,
      body: SelectionArea(
        child: CustomScrollView(
          slivers: [
            _buildAppBar(context, isMobile),
            SliverToBoxAdapter(child: _HeroSection(isMobile: isMobile, content: content)),
            SliverToBoxAdapter(child: _MetricsSection(isMobile: isMobile, content: content)),
            SliverToBoxAdapter(child: _ServicesSection(isMobile: isMobile, content: content)),
            SliverToBoxAdapter(child: _HealthComponentsSection(isMobile: isMobile)),
            SliverToBoxAdapter(child: _CachePerformanceSection(isMobile: isMobile)),
            SliverToBoxAdapter(child: _ConfigurationSection(isMobile: isMobile)),
            SliverToBoxAdapter(
              child: FooterSection(onCookieSettings: widget.onShowCookieSettings),
            ),
          ],
        ),
      ),
    );
  }

  SliverAppBar _buildAppBar(BuildContext context, bool isMobile) {
    return SliverAppBar(
      backgroundColor: AppColors.gray900.withValues(alpha: 0.95),
      floating: true,
      pinned: true,
      elevation: 0,
      toolbarHeight: isMobile ? 56 : 64,
      leading: IconButton(
        icon: const Icon(LucideIcons.arrowLeft, color: Colors.white),
        onPressed: widget.onBack ?? () => Navigator.of(context).pop(),
        tooltip: 'Back',
      ),
      title: GestureDetector(
        onTap: () => context.go('/'),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(LucideIcons.shield, color: AppColors.blue500, size: isMobile ? 24 : 28),
            const SizedBox(width: AppSpacing.sm),
            Flexible(
              child: Text(
                CompanyInfo.name,
                style: (isMobile ? AppTypography.headingSM : AppTypography.headingMD)
                    .copyWith(color: Colors.white),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      actions: [
        if (!isMobile)
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.md),
            child: TextButton(
              onPressed: () => _launchStatusPage(),
              style: TextButton.styleFrom(
                backgroundColor: AppColors.blue600,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.sm,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
                ),
              ),
              child: Text(
                'External Status Page',
                style: AppTypography.bodySM.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Future<void> _launchStatusPage() async {
    final uri = Uri.parse(ExternalUrls.statusPage);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}

class _HeroSection extends StatelessWidget {
  final bool isMobile;
  final StatusContent content;

  const _HeroSection({required this.isMobile, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.containerPadding(context),
        vertical: isMobile ? 48 : 80,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.gray800, AppColors.gray900],
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: AppColors.success.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: AppColors.success.withValues(alpha: 0.5)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(LucideIcons.checkCircle, size: 18, color: AppColors.success),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  content.statusBadge,
                  style: AppTypography.bodyMD.copyWith(
                    color: AppColors.success,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            content.title,
            style: (isMobile ? AppTypography.headingLG : AppTypography.headingXL)
                .copyWith(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.md),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Text(
              content.subtitle,
              style: AppTypography.bodyLG.copyWith(color: AppColors.gray400),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricsSection extends StatelessWidget {
  final bool isMobile;
  final StatusContent content;

  const _MetricsSection({required this.isMobile, required this.content});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? AppSpacing.xl : AppSpacing.xxl,
      ),
      child: Column(
        children: [
          Text(
            'Key Metrics',
            style: AppTypography.headingMD.copyWith(color: Colors.white),
          ),
          const SizedBox(height: AppSpacing.xl),
          Wrap(
            spacing: AppSpacing.lg,
            runSpacing: AppSpacing.lg,
            alignment: WrapAlignment.center,
            children: content.metrics.map((metric) {
              return _MetricCard(metric: metric);
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final StatusMetricContent metric;

  const _MetricCard({required this.metric});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.gray800,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
        border: Border.all(color: AppColors.gray700),
      ),
      child: Column(
        children: [
          Text(
            metric.value,
            style: AppTypography.headingLG.copyWith(
              color: AppColors.blue400,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            metric.label,
            style: AppTypography.bodyMD.copyWith(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          if (metric.sublabel != null) ...[
            const SizedBox(height: AppSpacing.xs),
            Text(
              metric.sublabel!,
              style: AppTypography.bodySM.copyWith(color: AppColors.gray400),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}

class _ServicesSection extends StatelessWidget {
  final bool isMobile;
  final StatusContent content;

  const _ServicesSection({required this.isMobile, required this.content});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      backgroundColor: AppColors.gray800,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? AppSpacing.xl : AppSpacing.xxl,
      ),
      child: Column(
        children: [
          Text(
            'Service Status',
            style: AppTypography.headingMD.copyWith(color: Colors.white),
          ),
          const SizedBox(height: AppSpacing.xl),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              children: content.services.map((service) {
                return _ServiceRow(service: service);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _ServiceRow extends StatelessWidget {
  final StatusServiceContent service;

  const _ServiceRow({required this.service});

  @override
  Widget build(BuildContext context) {
    final isOperational = service.status == 'Operational';
    final statusColor = isOperational ? AppColors.success : AppColors.warning;

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.gray900,
        borderRadius: BorderRadius.circular(AppSpacing.radiusSM),
        border: Border.all(color: AppColors.gray700),
      ),
      child: Row(
        children: [
          Icon(
            isOperational ? LucideIcons.checkCircle : LucideIcons.alertCircle,
            size: 18,
            color: statusColor,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              service.name,
              style: AppTypography.bodyMD.copyWith(color: Colors.white),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: AppSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(AppSpacing.radiusSM),
            ),
            child: Text(
              service.status,
              style: AppTypography.bodySM.copyWith(
                color: statusColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HealthComponentsSection extends StatelessWidget {
  final bool isMobile;

  const _HealthComponentsSection({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? AppSpacing.xl : AppSpacing.xxl,
      ),
      child: Column(
        children: [
          _buildSectionHeader(
            icon: LucideIcons.heartPulse,
            title: 'Health Check Components',
            description: 'Core system components monitored for availability',
          ),
          const SizedBox(height: AppSpacing.xl),
          Wrap(
            spacing: AppSpacing.md,
            runSpacing: AppSpacing.md,
            alignment: WrapAlignment.center,
            children: ObservabilityHealthContent.healthComponents.map((component) {
              return _HealthComponentChip(name: component);
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _HealthComponentChip extends StatelessWidget {
  final String name;

  const _HealthComponentChip({required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: AppColors.gray800,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
        border: Border.all(color: AppColors.success.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(LucideIcons.check, size: 16, color: AppColors.success),
          const SizedBox(width: AppSpacing.sm),
          Text(
            name,
            style: AppTypography.bodyMD.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class _CachePerformanceSection extends StatelessWidget {
  final bool isMobile;

  const _CachePerformanceSection({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      backgroundColor: AppColors.gray800,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? AppSpacing.xl : AppSpacing.xxl,
      ),
      child: Column(
        children: [
          _buildSectionHeader(
            icon: LucideIcons.database,
            title: 'Cache Performance Thresholds',
            description: 'How to interpret cache hit rate metrics',
          ),
          const SizedBox(height: AppSpacing.xl),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              children: ObservabilityHealthContent.cacheHitRateLabels.entries.map((entry) {
                return _ThresholdRow(
                  level: entry.key,
                  description: entry.value,
                  isGood: entry.key == 'excellent' || entry.key == 'good',
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          _buildSectionHeader(
            icon: LucideIcons.timer,
            title: 'Query Latency Thresholds',
            description: 'Expected response time guidelines',
          ),
          const SizedBox(height: AppSpacing.xl),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              children: ObservabilityHealthContent.queryLatencyLabels.entries.map((entry) {
                return _ThresholdRow(
                  level: entry.key,
                  description: entry.value,
                  isGood: entry.key == 'normal',
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _ThresholdRow extends StatelessWidget {
  final String level;
  final String description;
  final bool isGood;

  const _ThresholdRow({
    required this.level,
    required this.description,
    required this.isGood,
  });

  @override
  Widget build(BuildContext context) {
    final color = isGood ? AppColors.success : AppColors.warning;

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.gray900,
        borderRadius: BorderRadius.circular(AppSpacing.radiusSM),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              description,
              style: AppTypography.bodyMD.copyWith(color: AppColors.gray300),
            ),
          ),
        ],
      ),
    );
  }
}

class _ConfigurationSection extends StatelessWidget {
  final bool isMobile;

  const _ConfigurationSection({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? AppSpacing.xl : AppSpacing.xxl,
      ),
      child: Column(
        children: [
          _buildSectionHeader(
            icon: LucideIcons.settings,
            title: 'Configuration Defaults',
            description: 'Default settings for observability components',
          ),
          const SizedBox(height: AppSpacing.xl),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              children: ObservabilityHealthContent.configDefaults.entries.map((entry) {
                return _ConfigRow(name: entry.key, value: entry.value);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _ConfigRow extends StatelessWidget {
  final String name;
  final String value;

  const _ConfigRow({required this.name, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.gray800,
        borderRadius: BorderRadius.circular(AppSpacing.radiusSM),
        border: Border.all(color: AppColors.gray700),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              _formatConfigName(name),
              style: AppTypography.bodyMD.copyWith(color: AppColors.gray300),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: AppColors.blue500.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(AppSpacing.radiusSM),
            ),
            child: Text(
              value,
              style: AppTypography.bodySM.copyWith(
                color: AppColors.blue400,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatConfigName(String name) {
    // Convert camelCase to Title Case with spaces
    return name.replaceAllMapped(
      RegExp(r'([A-Z])'),
      (match) => ' ${match.group(1)}',
    ).replaceFirstMapped(RegExp(r'^.'), (m) => m.group(0)!.toUpperCase());
  }
}

Widget _buildSectionHeader({
  required IconData icon,
  required String title,
  required String description,
}) {
  return Column(
    children: [
      Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.blue500.withValues(alpha: 0.2),
              AppColors.purple500.withValues(alpha: 0.2),
            ],
          ),
          borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
        ),
        child: Icon(icon, color: AppColors.blue400, size: 28),
      ),
      const SizedBox(height: AppSpacing.lg),
      Text(
        title,
        style: AppTypography.headingMD.copyWith(color: Colors.white),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: AppSpacing.sm),
      Text(
        description,
        style: AppTypography.bodyMD.copyWith(color: AppColors.gray400),
        textAlign: TextAlign.center,
      ),
    ],
  );
}
