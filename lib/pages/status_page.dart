import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import '../config/content.dart';
import '../theme/theme.dart';
import '../services/analytics.dart';
import '../widgets/common/containers.dart';
import '../widgets/docs/doc_components.dart';
import '../widgets/sections/footer_section.dart';

/// Status page displaying platform operational health and internal observability.
///
/// Based on internal-observability.md v1.6.0 (2026-01-29).
/// Covers the observability-toolkit MCP server's self-monitoring capabilities.
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
            SliverToBoxAdapter(child: _ArchitectureSection(isMobile: isMobile)),
            SliverToBoxAdapter(child: _QueryTimingSection(isMobile: isMobile)),
            SliverToBoxAdapter(child: _CacheMetricsSection(isMobile: isMobile)),
            SliverToBoxAdapter(child: _CircuitBreakerSection(isMobile: isMobile)),
            SliverToBoxAdapter(child: _HealthCheckSection(isMobile: isMobile)),
            SliverToBoxAdapter(child: _DebuggingGuideSection(isMobile: isMobile)),
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

class _ArchitectureSection extends StatelessWidget {
  final bool isMobile;

  const _ArchitectureSection({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? AppSpacing.xl : AppSpacing.xxl,
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 900),
        child: DocSection(
          icon: LucideIcons.layers,
          title: 'Internal Observability Architecture',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'The observability-toolkit MCP server includes internal observability features that provide visibility into its own operations.',
                style: AppTypography.bodyMD.copyWith(color: AppColors.gray300),
              ),
              const SizedBox(height: AppSpacing.lg),
              const DocCodeBlock(
                code: '''observability-toolkit
+-------------+  +-------------+  +-------------------------+
|   Server    |  |  Backends   |  |        Tools            |
|             |  |             |  |                         |
| Rate Limit  |  | LocalJsonl  |  |  obs_health_check       |
| Error Stack |  | SigNozApi   |  |  (cache stats output)   |
+-------------+  +-------------+  +-------------------------+
        |               |                      |
        v               v                      v
+-------------------------------------------------------------+
|              Internal Observability Layer                   |
+-------------+-------------+-------------+------------------+
| Query Timer | Cache Stats | Circuit Log | Health Metrics   |
|             |             |             |                  |
| >500ms warn | hit/miss/   | state       | cache in output  |
|             | evict/rate  | transitions |                  |
+-------------+-------------+-------------+------------------+''',
              ),
              const SizedBox(height: AppSpacing.lg),
              const Wrap(
                spacing: AppSpacing.md,
                runSpacing: AppSpacing.md,
                children: [
                  DocFeatureCard(
                    icon: LucideIcons.timer,
                    title: 'Query Timing',
                    description: 'All query methods instrumented with timing, warns on slow queries >500ms.',
                  ),
                  DocFeatureCard(
                    icon: LucideIcons.database,
                    title: 'Cache Metrics',
                    description: 'Track hits, misses, evictions, and hit rate across all query caches.',
                  ),
                  DocFeatureCard(
                    icon: LucideIcons.shieldAlert,
                    title: 'Circuit Breaker',
                    description: 'State transition logging for failure protection patterns.',
                  ),
                  DocFeatureCard(
                    icon: LucideIcons.heartPulse,
                    title: 'Health Metrics',
                    description: 'Cache statistics included in obs_health_check output.',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QueryTimingSection extends StatelessWidget {
  final bool isMobile;

  const _QueryTimingSection({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      backgroundColor: AppColors.gray800,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? AppSpacing.xl : AppSpacing.xxl,
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 900),
        child: DocSection(
          icon: LucideIcons.timer,
          title: 'Query Timing',
          accentColor: AppColors.purple500,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'All query methods are instrumented with timing. Queries exceeding the threshold trigger warnings.',
                style: AppTypography.bodyMD.copyWith(color: AppColors.gray300),
              ),
              const SizedBox(height: AppSpacing.lg),
              const DocCodeBlock(
                code: '''const timer = startTiming();
try {
  // query logic
} finally {
  const durationMs = timer.end();
  if (durationMs > SLOW_QUERY_THRESHOLD_MS) {
    console.warn(`[obs-toolkit] Slow query: \${method} took \${durationMs.toFixed(1)}ms`);
  }
}''',
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                'Instrumented Methods',
                style: AppTypography.headingSM.copyWith(color: Colors.white),
              ),
              const SizedBox(height: AppSpacing.md),
              const DocTable(
                headers: ['Backend', 'Methods'],
                rows: [
                  ['LocalJsonlBackend', 'queryTraces(), queryLogs(), queryMetrics(), queryLLMEvents()'],
                  ['SigNozApiBackend', 'queryTraces(), queryLogs(), queryMetrics()'],
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              const DocCallout.warning(
                title: 'Example Warning Output',
                message: '[obs-toolkit] Slow query: queryTraces took 1234.5ms',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CacheMetricsSection extends StatelessWidget {
  final bool isMobile;

  const _CacheMetricsSection({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? AppSpacing.xl : AppSpacing.xxl,
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 900),
        child: DocSection(
          icon: LucideIcons.database,
          title: 'Cache Metrics',
          accentColor: AppColors.success,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'The QueryCache class tracks detailed statistics for performance monitoring.',
                style: AppTypography.bodyMD.copyWith(color: AppColors.gray300),
              ),
              const SizedBox(height: AppSpacing.lg),
              const DocCodeBlock(
                code: '''interface CacheStats {
  hits: number;      // Successful cache lookups
  misses: number;    // Cache misses (key not found or TTL expired)
  evictions: number; // Entries removed due to max size limit
  size: number;      // Current number of cached entries
  hitRate: number;   // hits / (hits + misses)
}''',
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                'Caches Tracked',
                style: AppTypography.headingSM.copyWith(color: Colors.white),
              ),
              const SizedBox(height: AppSpacing.md),
              const DocBulletList(
                items: [
                  'traceCache - Trace query results',
                  'logCache - Log query results',
                  'metricCache - Metric query results',
                  'llmEventCache - LLM event query results',
                ],
                bulletColor: AppColors.success,
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                'Cache Hit Rate Interpretation',
                style: AppTypography.headingSM.copyWith(color: Colors.white),
              ),
              const SizedBox(height: AppSpacing.md),
              const DocTable(
                headers: ['Rate', 'Status', 'Action'],
                rows: [
                  ['>80%', 'Excellent', 'Cache is effective'],
                  ['50-80%', 'Good', 'Normal operation'],
                  ['20-50%', 'Fair', 'Consider increasing TTL'],
                  ['<20%', 'Poor', 'Review query patterns'],
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                'Cache Evictions Interpretation',
                style: AppTypography.headingSM.copyWith(color: Colors.white),
              ),
              const SizedBox(height: AppSpacing.md),
              const DocTable(
                headers: ['Evictions', 'Status', 'Action'],
                rows: [
                  ['0', 'Normal', 'Cache not full'],
                  ['<10%', 'Normal', 'Normal turnover'],
                  ['>30%', 'High', 'Increase max size'],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CircuitBreakerSection extends StatelessWidget {
  final bool isMobile;

  const _CircuitBreakerSection({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      backgroundColor: AppColors.gray800,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? AppSpacing.xl : AppSpacing.xxl,
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 900),
        child: DocSection(
          icon: LucideIcons.shieldAlert,
          title: 'Circuit Breaker Logging',
          accentColor: AppColors.warning,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'The circuit breaker protects against cascading failures when external services are unavailable. State transitions are logged for visibility.',
                style: AppTypography.bodyMD.copyWith(color: AppColors.gray300),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                'State Transitions',
                style: AppTypography.headingSM.copyWith(color: Colors.white),
              ),
              const SizedBox(height: AppSpacing.md),
              const DocTable(
                headers: ['Transition', 'Level', 'Message'],
                rows: [
                  ['closed -> open', 'WARN', 'Circuit breaker OPENED after N consecutive failures'],
                  ['open -> half-open', 'INFO', 'Circuit breaker entering HALF-OPEN state'],
                  ['half-open -> open', 'WARN', 'Circuit breaker OPENED after N consecutive failures'],
                  ['half-open -> closed', 'INFO', 'Circuit breaker CLOSED after successful request'],
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                'Circuit Breaker States',
                style: AppTypography.headingSM.copyWith(color: Colors.white),
              ),
              const SizedBox(height: AppSpacing.md),
              Wrap(
                spacing: AppSpacing.md,
                runSpacing: AppSpacing.md,
                children: [
                  _CircuitStateCard(
                    state: 'Closed',
                    description: 'Normal operation - requests flow through',
                    icon: LucideIcons.checkCircle,
                    color: AppColors.success,
                  ),
                  _CircuitStateCard(
                    state: 'Half-Open',
                    description: 'Testing recovery - limited requests',
                    icon: LucideIcons.alertCircle,
                    color: AppColors.warning,
                  ),
                  _CircuitStateCard(
                    state: 'Open',
                    description: 'Failing over - requests blocked',
                    icon: LucideIcons.xCircle,
                    color: AppColors.error,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              const DocCallout.info(
                title: 'Configuration',
                items: [
                  'Max failures before open: 3',
                  'Reset timeout: 30 seconds',
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CircuitStateCard extends StatelessWidget {
  final String state;
  final String description;
  final IconData icon;
  final Color color;

  const _CircuitStateCard({
    required this.state,
    required this.description,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.gray700,
        borderRadius: BorderRadius.circular(AppSpacing.radiusSM),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: AppSpacing.sm),
              Text(
                state,
                style: AppTypography.bodyMD.copyWith(
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            description,
            style: AppTypography.bodySM.copyWith(color: AppColors.gray400),
          ),
        ],
      ),
    );
  }
}

class _HealthCheckSection extends StatelessWidget {
  final bool isMobile;

  const _HealthCheckSection({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? AppSpacing.xl : AppSpacing.xxl,
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 900),
        child: DocSection(
          icon: LucideIcons.heartPulse,
          title: 'Health Check Cache Stats',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'The obs_health_check tool includes cache statistics in its output for monitoring observability pipeline health.',
                style: AppTypography.bodyMD.copyWith(color: AppColors.gray300),
              ),
              const SizedBox(height: AppSpacing.lg),
              const DocCodeBlock(
                code: '''{
  "status": "ok",
  "backends": {
    "local": { ... },
    "signoz": { ... }
  },
  "cache": {
    "traces": {
      "hits": 156,
      "misses": 23,
      "evictions": 0,
      "size": 45,
      "hitRate": 0.871
    },
    "logs": {
      "hits": 89,
      "misses": 34,
      "evictions": 5,
      "size": 100,
      "hitRate": 0.723
    },
    "metrics": {
      "hits": 12,
      "misses": 8,
      "evictions": 0,
      "size": 20,
      "hitRate": 0.6
    },
    "llmEvents": {
      "hits": 5,
      "misses": 2,
      "evictions": 0,
      "size": 7,
      "hitRate": 0.714
    }
  },
  "today": "2026-01-29"
}''',
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                'Health Check Components',
                style: AppTypography.headingSM.copyWith(color: Colors.white),
              ),
              const SizedBox(height: AppSpacing.md),
              Wrap(
                spacing: AppSpacing.md,
                runSpacing: AppSpacing.md,
                children: ObservabilityHealthContent.healthComponents.map((component) {
                  return _HealthComponentChip(name: component);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DebuggingGuideSection extends StatelessWidget {
  final bool isMobile;

  const _DebuggingGuideSection({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      backgroundColor: AppColors.gray800,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? AppSpacing.xl : AppSpacing.xxl,
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 900),
        child: DocSection(
          icon: LucideIcons.bug,
          title: 'Debugging Guide',
          accentColor: AppColors.purple500,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'High Cache Miss Rate',
                style: AppTypography.headingSM.copyWith(color: Colors.white),
              ),
              const SizedBox(height: AppSpacing.md),
              const DocNumberedList(
                items: [
                  'Check query patterns - are queries too specific?',
                  'Check TTL - is it too short for use case?',
                  'Check cache size - is it evicting too often?',
                ],
                accentColor: AppColors.purple500,
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                'Frequent Slow Queries',
                style: AppTypography.headingSM.copyWith(color: Colors.white),
              ),
              const SizedBox(height: AppSpacing.md),
              const DocNumberedList(
                items: [
                  'Check file sizes in telemetry directory',
                  'Enable indexing for frequently queried files',
                  'Review date range filters - narrow if possible',
                  'Check for regex patterns causing backtracking',
                ],
                accentColor: AppColors.purple500,
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                'Circuit Breaker Opening',
                style: AppTypography.headingSM.copyWith(color: Colors.white),
              ),
              const SizedBox(height: AppSpacing.md),
              const DocNumberedList(
                items: [
                  'Check SigNoz connectivity',
                  'Check API key validity',
                  'Review SigNoz health status',
                  'Check network conditions',
                ],
                accentColor: AppColors.purple500,
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                'Slow Query Thresholds',
                style: AppTypography.headingSM.copyWith(color: Colors.white),
              ),
              const SizedBox(height: AppSpacing.md),
              const DocTable(
                headers: ['Duration', 'Status', 'Action'],
                rows: [
                  ['500-1000ms', 'Moderate', 'Monitor'],
                  ['1000-5000ms', 'Slow', 'Investigate file size'],
                  ['>5000ms', 'Very slow', 'Consider indexing'],
                ],
              ),
            ],
          ),
        ),
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


class _ConfigurationSection extends StatelessWidget {
  final bool isMobile;

  const _ConfigurationSection({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? AppSpacing.xl : AppSpacing.xxl,
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 900),
        child: DocSection(
          icon: LucideIcons.settings,
          title: 'Configuration',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Environment Variables',
                style: AppTypography.headingSM.copyWith(color: Colors.white),
              ),
              const SizedBox(height: AppSpacing.md),
              const DocTable(
                headers: ['Variable', 'Description', 'Default'],
                rows: [
                  ['CACHE_TTL_MS', 'Cache entry time-to-live', '60000 (1 minute)'],
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                'Constants',
                style: AppTypography.headingSM.copyWith(color: Colors.white),
              ),
              const SizedBox(height: AppSpacing.md),
              const DocTable(
                headers: ['Constant', 'Value', 'Location'],
                rows: [
                  ['SLOW_QUERY_THRESHOLD_MS', '500', 'local-jsonl.ts, signoz-api.ts'],
                  ['MAX_CACHE_SIZE', '100', 'QueryCache constructor'],
                  ['CIRCUIT_MAX_FAILURES', '3', 'CircuitBreaker class'],
                  ['CIRCUIT_RESET_MS', '30000', 'CircuitBreaker class'],
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                'Future Enhancements',
                style: AppTypography.headingSM.copyWith(color: Colors.white),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                'Phase 2 (Planned)',
                style: AppTypography.bodyMD.copyWith(
                  color: AppColors.gray300,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              const DocBulletList(
                items: [
                  'Structured logging with consistent JSON format',
                  'Parse failure statistics during streaming',
                  'API response time histograms',
                  'Error categorization (user vs system)',
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                'Phase 3 (Future)',
                style: AppTypography.bodyMD.copyWith(
                  color: AppColors.gray300,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              const DocBulletList(
                items: [
                  'OpenTelemetry SDK integration (self-tracing)',
                  'Metrics export to same backends (dogfooding)',
                  'Dashboard recommendations',
                  'Alert configuration examples',
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              const DocCallout.info(
                title: 'Version',
                message: 'This documentation reflects observability-toolkit v1.6.0 (2026-01-29).',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
