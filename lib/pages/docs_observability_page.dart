import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme/theme.dart';
import '../widgets/common/containers.dart';

/// Claude Code Observability Guide documentation page.
///
/// Covers context management, token optimization, and observability
/// using OpenTelemetry and SigNoz.
class DocsObservabilityPage extends StatelessWidget {
  final VoidCallback? onBack;

  const DocsObservabilityPage({
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
              'Observability Guide',
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
                color: AppColors.blue500.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                border: Border.all(
                  color: AppColors.blue500.withValues(alpha: 0.5),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    LucideIcons.layers,
                    size: 16,
                    color: AppColors.blue400,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    'Production-Ready Framework',
                    style: AppTypography.bodySM.copyWith(
                      color: AppColors.blue400,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            // Headline
            Text(
              'Claude Code Observability & Context Management',
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
                'Complete guide to token optimization, distributed tracing, and cost efficiency for Claude Code using OpenTelemetry and SigNoz.',
                style: AppTypography.bodyLG,
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: AppSpacing.xl),

            // Stats Grid
            Wrap(
              spacing: AppSpacing.md,
              runSpacing: AppSpacing.md,
              alignment: WrapAlignment.center,
              children: const [
                _StatCard(value: '81%', label: 'Cost Reduction'),
                _StatCard(value: '12', label: 'Instrumented Hooks'),
                _StatCard(value: '8', label: 'Dashboards'),
                _StatCard(value: '85%', label: 'MCP Token Savings'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value;
  final String label;

  const _StatCard({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 140, maxWidth: 160),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: AppColors.gray800,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
        border: Border.all(color: AppColors.gray700),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: AppTypography.headingMD.copyWith(
              color: AppColors.blue400,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            label,
            style: AppTypography.bodySM.copyWith(
              color: AppColors.gray400,
            ),
            textAlign: TextAlign.center,
          ),
        ],
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
          icon: LucideIcons.info,
          title: 'Overview',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Context management is "effectively the #1 job" for engineers building AI agents. As Anthropic emphasizes: "Claude is already smart enough\u2014intelligence is not the bottleneck, context is."',
                style: AppTypography.bodyMD.copyWith(color: AppColors.gray300),
              ),
              const SizedBox(height: AppSpacing.lg),
              const _FeatureGrid(),
              const SizedBox(height: AppSpacing.lg),
              _SuccessCallout(
                title: 'Key Results from Optimization',
                items: const [
                  '81% reduction in cost per session',
                  '84% reduction in tokens per session',
                  '85% reduction in MCP tool overhead',
                  '3x more work completed with same daily spend',
                ],
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
                '1. Environment Setup',
                style: AppTypography.headingSM.copyWith(color: Colors.white),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Add to ~/.claude/.envrc:',
                style: AppTypography.bodyMD.copyWith(color: AppColors.gray300),
              ),
              const SizedBox(height: AppSpacing.sm),
              const _CodeBlock(
                code: '''# Enable telemetry
export OTEL_ENABLED="true"
export SIGNOZ_ENABLED="true"

# SigNoz Cloud endpoint
export OTEL_EXPORTER_OTLP_ENDPOINT="https://ingest.us.signoz.cloud"
export OTEL_EXPORTER_OTLP_PROTOCOL="http/protobuf"

# Service identification
export OTEL_SERVICE_NAME="claude-code-hooks"''',
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                '2. Basic Usage',
                style: AppTypography.headingSM.copyWith(color: Colors.white),
              ),
              const SizedBox(height: AppSpacing.sm),
              const _CodeBlock(
                code: '''import { initTelemetry, withSpan, logger } from './lib/otel';

// Initialize at startup
initTelemetry();

// Wrap operations in spans
await withSpan('my-operation', { key: 'value' }, async (span) => {
  logger.info('Processing item', { itemId: 123 });
});''',
              ),
            ],
          ),
        ),

        // Token Optimization Section
        _DocSection(
          icon: LucideIcons.coins,
          title: 'Token Optimization Strategies',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Claude 4 models have built-in token-efficient tool use that saves an average of 14% in output tokens (up to 70%) while reducing latency.',
                style: AppTypography.bodyMD.copyWith(color: AppColors.gray300),
              ),
              const SizedBox(height: AppSpacing.lg),
              _InfoCallout(
                title: 'Results from Lazy Loading',
                items: const [
                  'Initial context reduced from 7,584 to 3,434 tokens (54% reduction)',
                  'Monthly cost for 5 developers doing 100 sessions/day: \$72 (62% savings)',
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                'Hybrid Model Approach',
                style: AppTypography.headingSM.copyWith(color: Colors.white),
              ),
              const SizedBox(height: AppSpacing.md),
              const _SimpleTable(
                headers: ['Model', 'Use For'],
                rows: [
                  ['Opus 4.5', 'High-level planning, architectural design, final code review'],
                  ['Sonnet/Haiku', 'Implementation work, syntax validation, data parsing, quick checks'],
                ],
              ),
            ],
          ),
        ),

        // Tool Usage Section
        _DocSection(
          icon: LucideIcons.wrench,
          title: 'Efficient Tool Usage',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _SimpleTable(
                headers: ['Scenario', 'Recommended Tool'],
                rows: [
                  ['Find files by name pattern', 'Glob'],
                  ['Search file contents', 'Grep'],
                  ['Read known file', 'Read (with offset/limit for large files)'],
                  ['Execute commands', 'Bash (with output truncation)'],
                  ['Open-ended exploration', 'Task/Subagent'],
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              _WarningCallout(
                message: 'Claude Code stores all bash output in memory for the entire session. Large outputs (90GB+ reported) can crash the application. Always truncate verbose commands.',
              ),
            ],
          ),
        ),

        // Context Window Section
        _DocSection(
          icon: LucideIcons.layoutGrid,
          title: 'Context Window Management',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _SimpleTable(
                headers: ['Tier', 'Context Window', 'Notes'],
                rows: [
                  ['Standard', '200,000 tokens', 'Default for most users'],
                  ['Advanced (Tier 4+)', '1,000,000 tokens', 'Premium pricing applies'],
                  ['Premium threshold', '>200K tokens', '2x input, 1.5x output pricing'],
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              _DangerCallout(
                message: 'Avoid using the final 20% of your context window for complex tasks. Quality notably declines for memory-intensive operations.',
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                'Built-in Commands',
                style: AppTypography.headingSM.copyWith(color: Colors.white),
              ),
              const SizedBox(height: AppSpacing.md),
              const _SimpleTable(
                headers: ['Command', 'Purpose'],
                rows: [
                  ['/context', 'Visualizes context usage'],
                  ['/clear', 'Wipes conversation history'],
                  ['/compact', 'Summarizes conversation'],
                  ['/cost', 'Shows token usage stats'],
                ],
              ),
            ],
          ),
        ),

        // MCP Optimization Section
        _DocSection(
          icon: LucideIcons.plug,
          title: 'MCP Server Optimization',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'MCP tool definitions can consume massive context:',
                style: AppTypography.bodyMD.copyWith(color: AppColors.gray300),
              ),
              const SizedBox(height: AppSpacing.sm),
              _BulletList(items: const [
                '5-server setup: ~55K tokens before conversation starts',
                'Jira alone: ~17K tokens',
                'One reported case: 134K tokens of tool definitions',
              ]),
              const SizedBox(height: AppSpacing.lg),
              Text(
                'MCP Tool Search reduces token overhead by 85% by loading tools on-demand rather than upfront.',
                style: AppTypography.bodyMD.copyWith(color: AppColors.gray300),
              ),
              const SizedBox(height: AppSpacing.lg),
              _SuccessCallout(
                title: 'Performance Improvements',
                items: const [
                  'Opus 4: 49% to 74% accuracy',
                  'Opus 4.5: 79.5% to 88.1% accuracy',
                  '46.9% reduction in total agent tokens (51K to 8.5K)',
                ],
              ),
            ],
          ),
        ),

        // Metrics Reference Section
        _DocSection(
          icon: LucideIcons.barChart3,
          title: 'Metrics Reference',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hook Metrics',
                style: AppTypography.headingSM.copyWith(color: Colors.white),
              ),
              const SizedBox(height: AppSpacing.md),
              const _SimpleTable(
                headers: ['Metric', 'Type', 'Description'],
                rows: [
                  ['hook.duration', 'Histogram', 'Execution time distribution'],
                  ['hook.executions', 'Counter', 'Total invocations'],
                  ['mcp.invocations', 'Counter', 'MCP tool calls'],
                  ['agent.invocations', 'Counter', 'Subagent spawns'],
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                'GenAI Metrics',
                style: AppTypography.headingSM.copyWith(color: Colors.white),
              ),
              const SizedBox(height: AppSpacing.md),
              const _SimpleTable(
                headers: ['Metric', 'Type', 'Description'],
                rows: [
                  ['gen_ai.client.token.usage', 'Counter', 'Tokens consumed'],
                  ['gen_ai.client.cost', 'Counter', 'Cost in USD'],
                  ['gen_ai.client.operation.duration', 'Histogram', 'LLM call latency'],
                ],
              ),
            ],
          ),
        ),

        // Cost Optimization Section
        _DocSection(
          icon: LucideIcons.trendingDown,
          title: 'Cost Optimization',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Session Strategy Comparison',
                style: AppTypography.headingSM.copyWith(color: Colors.white),
              ),
              const SizedBox(height: AppSpacing.md),
              const _SimpleTable(
                headers: ['Metric', 'Before (Dec)', 'After (Jan)', 'Change'],
                rows: [
                  ['Avg Sessions/Day', '7.3', '26.2', '+259%'],
                  ['Tokens/Session', '40,246', '6,503', '-84%'],
                  ['Cost/Session', '\$22.17', '\$3.64', '-84%'],
                  ['Cost/Message', '\$0.067', '\$0.021', '-69%'],
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              _InfoCallout(
                title: 'The Pattern',
                items: const [
                  'December: Fewer, longer sessions (avg 40K tokens) \u2192 expensive',
                  'January: More, shorter sessions (avg 6.5K tokens) \u2192 efficient',
                ],
              ),
            ],
          ),
        ),

        // Recommendations Section
        _DocSection(
          icon: LucideIcons.lightbulb,
          title: 'Recommendations',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Maintain the Gains',
                style: AppTypography.headingSM.copyWith(color: Colors.white),
              ),
              const SizedBox(height: AppSpacing.md),
              _BulletList(items: const [
                'Keep sessions short \u2014 Target <10K tokens/session',
                'Reset frequently \u2014 New session after major task completion',
                'Compact at 70% \u2014 Don\'t let context hit limits',
                'Monitor trends \u2014 Watch session.context.utilization in SigNoz',
              ]),
              const SizedBox(height: AppSpacing.lg),
              Text(
                'Daily Workflow',
                style: AppTypography.headingSM.copyWith(color: Colors.white),
              ),
              const SizedBox(height: AppSpacing.md),
              const _CodeBlock(
                code: '''1. Start session
   - /context to check baseline
   - Disable unused MCP servers

2. During work
   - Use subagents for verbose operations
   - Truncate bash output
   - Use Grep output_mode: "files_with_matches"

3. Between tasks
   - /clear if <50% context is relevant
   - /compact at 70% capacity

4. End of session
   - Document progress in .md file
   - /cost to review usage''',
              ),
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
                  color: AppColors.blue500,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusSM),
                ),
                child: Icon(icon, color: Colors.white, size: 20),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  title,
                  style: AppTypography.headingSM.copyWith(
                    color: AppColors.blue400,
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
          icon: LucideIcons.activity,
          title: 'Distributed Tracing',
          description: 'Track operations across hook invocations with OpenTelemetry spans.',
        ),
        _FeatureCard(
          icon: LucideIcons.barChart3,
          title: 'Metrics Collection',
          description: 'Monitor performance, token usage, and cost patterns.',
        ),
        _FeatureCard(
          icon: LucideIcons.fileText,
          title: 'Structured Logging',
          description: 'Debug issues with logs correlated to trace context.',
        ),
        _FeatureCard(
          icon: LucideIcons.bot,
          title: 'LLM Instrumentation',
          description: 'Track token usage, costs, and model performance.',
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
                  AppColors.blue500.withValues(alpha: 0.2),
                  AppColors.purple500.withValues(alpha: 0.2),
                ],
              ),
              borderRadius: BorderRadius.circular(AppSpacing.radiusSM),
            ),
            child: Icon(icon, color: AppColors.blue400, size: 18),
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
                        color: AppColors.blue400,
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

class _SuccessCallout extends StatelessWidget {
  final String title;
  final List<String> items;

  const _SuccessCallout({required this.title, required this.items});

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
          ...items.map((item) => Padding(
                padding: const EdgeInsets.only(left: AppSpacing.lg, bottom: 4),
                child: Text(
                  '\u2022 $item',
                  style: AppTypography.bodyMD.copyWith(color: AppColors.gray300),
                ),
              )),
        ],
      ),
    );
  }
}

class _InfoCallout extends StatelessWidget {
  final String title;
  final List<String> items;

  const _InfoCallout({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.blue500.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppSpacing.radiusSM),
        border: Border(
          left: BorderSide(color: AppColors.blue500, width: 3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(LucideIcons.lightbulb, color: AppColors.blue400, size: 18),
              const SizedBox(width: AppSpacing.sm),
              Text(
                title,
                style: AppTypography.bodyMD.copyWith(
                  color: AppColors.blue400,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          ...items.map((item) => Padding(
                padding: const EdgeInsets.only(left: AppSpacing.lg, bottom: 4),
                child: Text(
                  '\u2022 $item',
                  style: AppTypography.bodyMD.copyWith(color: AppColors.gray300),
                ),
              )),
        ],
      ),
    );
  }
}

class _WarningCallout extends StatelessWidget {
  final String message;

  const _WarningCallout({required this.message});

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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(LucideIcons.alertTriangle, color: AppColors.warning, size: 18),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              message,
              style: AppTypography.bodyMD.copyWith(color: AppColors.warning),
            ),
          ),
        ],
      ),
    );
  }
}

class _DangerCallout extends StatelessWidget {
  final String message;

  const _DangerCallout({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppSpacing.radiusSM),
        border: Border(
          left: BorderSide(color: AppColors.error, width: 3),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(LucideIcons.alertCircle, color: AppColors.error, size: 18),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              message,
              style: AppTypography.bodyMD.copyWith(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }
}
