import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme/theme.dart';
import '../widgets/common/containers.dart';

/// OpenTelemetry Interoperability documentation page.
///
/// Covers the hook-based architecture, dual export pattern, signal types,
/// backend compatibility, and integration mechanisms for the observability framework.
class DocsInteroperabilityPage extends StatelessWidget {
  final VoidCallback? onBack;

  const DocsInteroperabilityPage({
    super.key,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);

    return Scaffold(
      backgroundColor: AppColors.gray900,
      body: CustomScrollView(
        slivers: [
          // App bar
          SliverAppBar(
            backgroundColor: AppColors.gray900,
            floating: true,
            pinned: true,
            leading: IconButton(
              icon: const Icon(LucideIcons.arrowLeft, color: Colors.white),
              onPressed: onBack ?? () => Navigator.of(context).pop(),
            ),
            title: Text(
              'Integrations Guide',
              style: AppTypography.headingSM.copyWith(color: Colors.white),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: AppSpacing.md),
                child: TextButton(
                  onPressed: onBack ?? () => Navigator.of(context).pop(),
                  child: Text(
                    'Back to Home',
                    style: AppTypography.bodySM.copyWith(
                      color: AppColors.blue400,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Hero Section
          SliverToBoxAdapter(
            child: _HeroSection(isMobile: isMobile),
          ),

          // Content
          SliverToBoxAdapter(
            child: SectionContainer(
              padding: EdgeInsets.symmetric(
                vertical: isMobile ? AppSpacing.xl : AppSpacing.xxl,
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 900),
                child: const _DocsContent(),
              ),
            ),
          ),

          // Footer
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.xxxl),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      'Built with OpenTelemetry and SigNoz',
                      style: AppTypography.bodySM.copyWith(
                        color: AppColors.gray400,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      '\u00A9 2026 Integrity Studio LLC',
                      style: AppTypography.bodySM.copyWith(
                        color: AppColors.gray400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  final bool isMobile;

  const _HeroSection({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.gray900,
            AppColors.gray800.withValues(alpha: 0.5),
            AppColors.gray900,
          ],
        ),
      ),
      child: SectionContainer(
        padding: EdgeInsets.symmetric(
          vertical: isMobile ? AppSpacing.xxl : AppSpacing.xxxl,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Badge
            Container(
              margin: const EdgeInsets.only(bottom: AppSpacing.lg),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              decoration: BoxDecoration(
                color: AppColors.purple500.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                border: Border.all(
                  color: AppColors.purple500.withValues(alpha: 0.5),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    LucideIcons.plug,
                    size: 16,
                    color: AppColors.purple400,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    'OpenTelemetry Native',
                    style: AppTypography.bodySM.copyWith(
                      color: AppColors.purple400,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            // Headline
            Text(
              'Interoperability & Integrations',
              style: isMobile
                  ? AppTypography.headingLG.copyWith(fontSize: 28)
                  : AppTypography.headingXL,
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: AppSpacing.lg),

            // Subheadline
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 700),
              child: Text(
                'How the observability framework integrates with OpenTelemetry, Langtrace, and SigNoz Cloud through a hook-based architecture with dual export capabilities.',
                style: AppTypography.bodyLG,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DocsContent extends StatelessWidget {
  const _DocsContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Overview Section
        _DocSection(
          icon: LucideIcons.layers,
          title: 'Core Architecture',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'The observability framework uses OpenTelemetry as its foundation, with Langtrace for LLM-specific instrumentation, and SigNoz Cloud as the observability backend.',
                style: AppTypography.bodyMD.copyWith(color: AppColors.gray300),
              ),
              const SizedBox(height: AppSpacing.lg),
              const _FeatureGrid(),
              const SizedBox(height: AppSpacing.lg),
              _InfoCallout(
                title: 'Vendor Neutral',
                message:
                    'Built on OpenTelemetry standards, allowing you to switch backends or add additional exporters without code changes.',
              ),
            ],
          ),
        ),

        // Signal Types Section
        _DocSection(
          icon: LucideIcons.radio,
          title: 'Signal Types Supported',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'The framework captures three primary telemetry signal types, each optimized for different observability needs:',
                style: AppTypography.bodyMD.copyWith(color: AppColors.gray300),
              ),
              const SizedBox(height: AppSpacing.lg),
              const _SimpleTable(
                headers: ['Signal', 'Description', 'Use Case'],
                rows: [
                  [
                    'Traces',
                    'Spans with parent-child relationships',
                    'Request flow & latency analysis'
                  ],
                  [
                    'Metrics',
                    'Counters, histograms, gauges',
                    'Performance & cost tracking'
                  ],
                  [
                    'Logs',
                    'Structured logging output',
                    'Debugging & audit trails'
                  ],
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                'GenAI Semantic Conventions',
                style: AppTypography.headingSM.copyWith(color: Colors.white),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                '11 auto-instrumented LLM attributes standardize span data for consistent cross-tool analysis:',
                style: AppTypography.bodyMD.copyWith(color: AppColors.gray300),
              ),
              const SizedBox(height: AppSpacing.md),
              _BulletList(items: const [
                'gen_ai.system \u2014 Provider (anthropic, openai)',
                'gen_ai.request.model \u2014 Model identifier',
                'gen_ai.request.temperature \u2014 Sampling temperature',
                'gen_ai.usage.input_tokens \u2014 Prompt tokens',
                'gen_ai.usage.output_tokens \u2014 Completion tokens',
                'gen_ai.response.finish_reason \u2014 Stop reason',
              ]),
            ],
          ),
        ),

        // Dual Export Pattern Section
        _DocSection(
          icon: LucideIcons.gitFork,
          title: 'Dual Export Pattern',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Telemetry exports through two channels simultaneously for reliability and offline analysis:',
                style: AppTypography.bodyMD.copyWith(color: AppColors.gray300),
              ),
              const SizedBox(height: AppSpacing.lg),
              const _SimpleTable(
                headers: ['Export Channel', 'Destination', 'Purpose'],
                rows: [
                  [
                    'Local File',
                    '~/.claude/telemetry/',
                    'Offline analysis & backup'
                  ],
                  [
                    'Remote OTLP',
                    'SigNoz Cloud',
                    'Real-time dashboards & alerts'
                  ],
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              const _CodeBlock(
                code: '''# Data flow architecture
Claude Code Hooks → HookMonitor → Dual Export Pattern
                                   ├─ Local File Export (JSONL)
                                   └─ Remote OTLP (SigNoz Cloud)''',
              ),
              const SizedBox(height: AppSpacing.lg),
              _SuccessCallout(
                title: 'Resilient by Design',
                message:
                    'Circuit breaker protection prevents slowdowns during backend outages. Local JSONL files ensure no data loss.',
              ),
            ],
          ),
        ),

        // Hook Architecture Section
        _DocSection(
          icon: LucideIcons.webhook,
          title: 'Hook-Based Architecture',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'The system instruments 12 hook types across event categories, providing fine-grained observability into Claude Code operations.',
                style: AppTypography.bodyMD.copyWith(color: AppColors.gray300),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                'HookContext Interface',
                style: AppTypography.headingSM.copyWith(color: Colors.white),
              ),
              const SizedBox(height: AppSpacing.md),
              const _CodeBlock(
                code: '''// Available methods on HookContext
context.addAttribute(key, value)     // Add span attribute
context.addAttributes(attrs)         // Add multiple attributes
context.recordMetric(name, value, attrs)  // Record metric
context.startChildSpan(name, attrs)  // Create child span
context.logger.{trace,debug,info,warn,error}  // Structured logging''',
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                'Hook Event Types',
                style: AppTypography.headingSM.copyWith(color: Colors.white),
              ),
              const SizedBox(height: AppSpacing.md),
              _BulletList(items: const [
                'Session lifecycle \u2014 start, stop, pause, resume',
                'Tool execution \u2014 pre/post tool calls',
                'Model interaction \u2014 request/response',
                'Error handling \u2014 exceptions and retries',
                'User prompts \u2014 input processing',
                'Notification \u2014 stop signals and alerts',
              ]),
            ],
          ),
        ),

        // Backend Compatibility Section
        _DocSection(
          icon: LucideIcons.database,
          title: 'Backend Compatibility',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'SigNoz Cloud provides the primary observability backend with enterprise-grade features:',
                style: AppTypography.bodyMD.copyWith(color: AppColors.gray300),
              ),
              const SizedBox(height: AppSpacing.lg),
              const _SimpleTable(
                headers: ['Feature', 'Description'],
                rows: [
                  ['Pre-built Dashboards', '8 dashboards for visualization'],
                  ['Trace Correlation', 'Real-time search and linking'],
                  ['Gzip Compression', 'Reduced bandwidth for OTLP'],
                  [
                    'Circuit Breaker',
                    'Protection during outages'
                  ],
                  [
                    'Resource Detection',
                    'Auto-capture host/OS/process metadata'
                  ],
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              _InfoCallout(
                title: 'Alternative Backends',
                message:
                    'Any OpenTelemetry-compatible backend works: Jaeger, Grafana Tempo, Honeycomb, Datadog, or self-hosted collectors.',
              ),
            ],
          ),
        ),

        // Environment Configuration Section
        _DocSection(
          icon: LucideIcons.settings,
          title: 'Environment Configuration',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Environment variables manage configuration across layers:',
                style: AppTypography.bodyMD.copyWith(color: AppColors.gray300),
              ),
              const SizedBox(height: AppSpacing.lg),
              const _CodeBlock(
                code: '''# Required environment variables
OTEL_EXPORTER_OTLP_ENDPOINT="https://ingest.us.signoz.cloud"
SIGNOZ_INGESTION_KEY="<your-ingestion-key>"

# Optional: LLM-specific instrumentation
LANGTRACE_API_KEY="<your-langtrace-key>"

# Optional: Service identification
OTEL_SERVICE_NAME="claude-code-session"
OTEL_RESOURCE_ATTRIBUTES="deployment.environment=production"''',
              ),
              const SizedBox(height: AppSpacing.lg),
              _WarningCallout(
                title: 'Security Note',
                message:
                    'Store credentials in environment variables or a secrets manager. Never commit API keys to version control.',
              ),
            ],
          ),
        ),

        // PII Protection Section
        _DocSection(
          icon: LucideIcons.shield,
          title: 'PII Redaction Bridge',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Langtrace automatically redacts 10 sensitive data patterns before export, ensuring compliance across multiple retention systems:',
                style: AppTypography.bodyMD.copyWith(color: AppColors.gray300),
              ),
              const SizedBox(height: AppSpacing.lg),
              const _SimpleTable(
                headers: ['Pattern', 'Replacement'],
                rows: [
                  ['Email addresses', '[EMAIL]'],
                  ['Phone numbers', '[PHONE]'],
                  ['Credit card numbers', '[CREDIT_CARD]'],
                  ['Social Security numbers', '[SSN]'],
                  ['API keys (sk-*, key-*)', '[API_KEY]'],
                  ['JWT tokens', '[JWT_TOKEN]'],
                  ['IP addresses', '[IP_ADDRESS]'],
                  ['AWS credentials', '[AWS_KEY]'],
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              _SuccessCallout(
                title: 'GDPR & CCPA Ready',
                message:
                    'Automatic PII redaction helps maintain compliance with privacy regulations while preserving observability value.',
              ),
            ],
          ),
        ),

        // Quick Start Section
        _DocSection(
          icon: LucideIcons.rocket,
          title: 'Quick Start',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Get started with the observability framework in three steps:',
                style: AppTypography.bodyMD.copyWith(color: AppColors.gray300),
              ),
              const SizedBox(height: AppSpacing.lg),
              const _NumberedList(items: [
                'Set environment variables for your backend',
                'Initialize the telemetry SDK at application startup',
                'View traces and metrics in your dashboard',
              ]),
              const SizedBox(height: AppSpacing.lg),
              const _CodeBlock(
                code: '''// Initialize at application startup
import { initTelemetry, withSpan, shutdown } from './lib/otel';

initTelemetry();

// Wrap operations in spans
await withSpan('my.operation', {
  'custom.attribute': 'value'
}, async (span) => {
  // Your code here
  span.addEvent('checkpoint', { detail: 'processed' });
});

// Clean shutdown
await shutdown();''',
              ),
            ],
          ),
        ),

        // Related Docs Section
        _DocSection(
          icon: LucideIcons.bookOpen,
          title: 'Related Documentation',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _BulletList(items: const [
                'Distributed Tracing Guide \u2014 /docs/tracing',
                'Claude Code Observability \u2014 /docs/claude-code-observability',
                'OpenTelemetry Documentation \u2014 opentelemetry.io',
                'SigNoz Documentation \u2014 signoz.io/docs',
              ]),
            ],
          ),
        ),
      ],
    );
  }
}

// Reusable Components

class _DocSection extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget child;

  const _DocSection({
    required this.icon,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.lg),
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.gray800,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
        border: Border.all(color: AppColors.gray700),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.purple500,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusSM),
                ),
                child: Icon(icon, color: Colors.white, size: 20),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  title,
                  style: AppTypography.headingSM.copyWith(
                    color: AppColors.purple400,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          child,
        ],
      ),
    );
  }
}

class _FeatureGrid extends StatelessWidget {
  const _FeatureGrid();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.md,
      runSpacing: AppSpacing.md,
      children: const [
        _FeatureCard(
          icon: LucideIcons.layers,
          title: 'OpenTelemetry Foundation',
          description: 'Industry-standard instrumentation and export.',
        ),
        _FeatureCard(
          icon: LucideIcons.bot,
          title: 'Langtrace LLM Support',
          description: 'Automatic GenAI semantic conventions.',
        ),
        _FeatureCard(
          icon: LucideIcons.barChart3,
          title: 'SigNoz Backend',
          description: 'Real-time dashboards and alerting.',
        ),
        _FeatureCard(
          icon: LucideIcons.hardDrive,
          title: 'Local JSONL Backup',
          description: 'Offline analysis and data resilience.',
        ),
      ],
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.gray700,
        borderRadius: BorderRadius.circular(AppSpacing.radiusSM),
        border: Border.all(color: AppColors.gray600),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.purple500.withValues(alpha: 0.2),
                  AppColors.blue500.withValues(alpha: 0.2),
                ],
              ),
              borderRadius: BorderRadius.circular(AppSpacing.radiusSM),
            ),
            child: Icon(icon, color: AppColors.purple400, size: 18),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            title,
            style: AppTypography.bodyMD.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            description,
            style: AppTypography.bodySM.copyWith(color: AppColors.gray400),
          ),
        ],
      ),
    );
  }
}

class _CodeBlock extends StatelessWidget {
  final String code;

  const _CodeBlock({required this.code});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.gray900,
        borderRadius: BorderRadius.circular(AppSpacing.radiusSM),
        border: Border.all(color: AppColors.gray700),
      ),
      child: SelectableText(
        code,
        style: TextStyle(
          fontFamily: 'JetBrains Mono',
          fontSize: 13,
          color: AppColors.gray300,
          height: 1.5,
        ),
      ),
    );
  }
}

class _SimpleTable extends StatelessWidget {
  final List<String> headers;
  final List<List<String>> rows;

  const _SimpleTable({required this.headers, required this.rows});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSpacing.radiusSM),
        border: Border.all(color: AppColors.gray700),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSpacing.radiusSM),
        child: Table(
          border: TableBorder.symmetric(
            inside: BorderSide(color: AppColors.gray700),
          ),
          children: [
            TableRow(
              decoration: BoxDecoration(color: AppColors.gray800),
              children: headers
                  .map((h) => Padding(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        child: Text(
                          h,
                          style: AppTypography.bodySM.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ))
                  .toList(),
            ),
            ...rows.map(
              (row) => TableRow(
                children: row
                    .map((cell) => Padding(
                          padding: const EdgeInsets.all(AppSpacing.md),
                          child: Text(
                            cell,
                            style: AppTypography.bodySM.copyWith(
                              color: AppColors.gray300,
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BulletList extends StatelessWidget {
  final List<String> items;

  const _BulletList({required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items
          .map((item) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '\u2022 ',
                      style: AppTypography.bodyMD.copyWith(
                        color: AppColors.purple400,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        item,
                        style: AppTypography.bodyMD.copyWith(
                          color: AppColors.gray300,
                        ),
                      ),
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }
}

class _NumberedList extends StatelessWidget {
  final List<String> items;

  const _NumberedList({required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.asMap().entries.map((entry) {
        final index = entry.key + 1;
        final item = entry.value;
        return Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.md),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: AppColors.purple500.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '$index',
                    style: AppTypography.bodySM.copyWith(
                      color: AppColors.purple400,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Text(
                    item,
                    style: AppTypography.bodyMD.copyWith(
                      color: AppColors.gray300,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _SuccessCallout extends StatelessWidget {
  final String title;
  final String message;

  const _SuccessCallout({required this.title, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.success.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppSpacing.radiusSM),
        border: Border(
          left: BorderSide(color: AppColors.success, width: 3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(LucideIcons.checkCircle, color: AppColors.success, size: 18),
              const SizedBox(width: AppSpacing.sm),
              Text(
                title,
                style: AppTypography.bodyMD.copyWith(
                  color: AppColors.success,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            message,
            style: AppTypography.bodyMD.copyWith(color: AppColors.gray300),
          ),
        ],
      ),
    );
  }
}

class _InfoCallout extends StatelessWidget {
  final String title;
  final String message;

  const _InfoCallout({required this.title, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.purple500.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppSpacing.radiusSM),
        border: Border(
          left: BorderSide(color: AppColors.purple500, width: 3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(LucideIcons.lightbulb, color: AppColors.purple400, size: 18),
              const SizedBox(width: AppSpacing.sm),
              Text(
                title,
                style: AppTypography.bodyMD.copyWith(
                  color: AppColors.purple400,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            message,
            style: AppTypography.bodyMD.copyWith(color: AppColors.gray300),
          ),
        ],
      ),
    );
  }
}

class _WarningCallout extends StatelessWidget {
  final String title;
  final String message;

  const _WarningCallout({required this.title, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.warning.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppSpacing.radiusSM),
        border: Border(
          left: BorderSide(color: AppColors.warning, width: 3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(LucideIcons.alertTriangle, color: AppColors.warning, size: 18),
              const SizedBox(width: AppSpacing.sm),
              Text(
                title,
                style: AppTypography.bodyMD.copyWith(
                  color: AppColors.warning,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            message,
            style: AppTypography.bodyMD.copyWith(color: AppColors.warning),
          ),
        ],
      ),
    );
  }
}
