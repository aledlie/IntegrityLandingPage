import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme/theme.dart';
import '../widgets/common/containers.dart';

/// Quick Start documentation page.
///
/// Covers getting started with Integrity Studio in under 5 minutes,
/// including SDK setup, basic instrumentation, and viewing traces.
class DocsQuickstartPage extends StatelessWidget {
  final VoidCallback? onBack;

  const DocsQuickstartPage({
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
              'Quick Start',
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
                color: AppColors.success.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                border: Border.all(
                  color: AppColors.success.withValues(alpha: 0.5),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    LucideIcons.rocket,
                    size: 16,
                    color: AppColors.success,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    '5-Minute Setup',
                    style: AppTypography.bodySM.copyWith(
                      color: AppColors.success,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            // Headline
            Text(
              'Get Started with Integrity Studio',
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
                'Start monitoring your LLM applications in under 5 minutes. Install the SDK, add a few lines of code, and see your first traces.',
                style: AppTypography.bodyLG,
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: AppSpacing.xl),

            // Steps Preview
            Wrap(
              spacing: AppSpacing.md,
              runSpacing: AppSpacing.md,
              alignment: WrapAlignment.center,
              children: const [
                _StepPreview(number: '1', label: 'Create Account'),
                _StepPreview(number: '2', label: 'Install SDK'),
                _StepPreview(number: '3', label: 'Add Code'),
                _StepPreview(number: '4', label: 'View Traces'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StepPreview extends StatelessWidget {
  final String number;
  final String label;

  const _StepPreview({required this.number, required this.label});

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
        border: Border.all(color: AppColors.gray700),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: AppColors.success.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: AppTypography.bodySM.copyWith(
                  color: AppColors.success,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(
            label,
            style: AppTypography.bodySM.copyWith(
              color: AppColors.gray300,
            ),
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
        // Prerequisites Section
        _DocSection(
          icon: LucideIcons.checkCircle,
          title: 'Prerequisites',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Before you begin, make sure you have:',
                style: AppTypography.bodyMD.copyWith(color: AppColors.gray300),
              ),
              const SizedBox(height: AppSpacing.md),
              _CheckList(items: const [
                'An Integrity Studio account (free tier available)',
                'Python 3.8+, Node.js 18+, or Go 1.20+',
                'An LLM application to instrument',
              ]),
              const SizedBox(height: AppSpacing.lg),
              _InfoCallout(
                title: 'No Account Yet?',
                message:
                    'Sign up at integritystudio.ai/signup to get your API key. The free tier includes 50K traces/month.',
              ),
            ],
          ),
        ),

        // Step 1: Get API Key
        _DocSection(
          icon: LucideIcons.key,
          title: 'Step 1: Get Your API Key',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _NumberedStep(
                number: '1',
                title: 'Log in to your dashboard',
                content: 'Navigate to integritystudio.ai and sign in.',
              ),
              const _NumberedStep(
                number: '2',
                title: 'Go to Settings \u2192 API Keys',
                content: 'Find the API Keys section in your account settings.',
              ),
              const _NumberedStep(
                number: '3',
                title: 'Create a new key',
                content:
                    'Click "Create API Key" and select the scopes you need (traces:write for ingestion).',
              ),
              const _NumberedStep(
                number: '4',
                title: 'Copy and store securely',
                content: 'Save your API key in an environment variable.',
              ),
              const SizedBox(height: AppSpacing.lg),
              const _CodeBlock(
                title: 'Set Environment Variable',
                code: '''# Add to your shell profile (.bashrc, .zshrc, etc.)
export INTEGRITY_API_KEY="your-api-key-here"

# Or use a .env file
INTEGRITY_API_KEY=your-api-key-here''',
              ),
            ],
          ),
        ),

        // Step 2: Install SDK
        _DocSection(
          icon: LucideIcons.download,
          title: 'Step 2: Install the SDK',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Choose your language and install the SDK:',
                style: AppTypography.bodyMD.copyWith(color: AppColors.gray300),
              ),
              const SizedBox(height: AppSpacing.lg),
              const _LanguageTab(
                languages: ['Python', 'TypeScript', 'Go'],
                codeBlocks: [
                  '''# Using pip
pip install integrity-studio

# Using poetry
poetry add integrity-studio

# Using uv
uv add integrity-studio''',
                  '''# Using npm
npm install @integrity-studio/sdk

# Using yarn
yarn add @integrity-studio/sdk

# Using pnpm
pnpm add @integrity-studio/sdk''',
                  '''# Using go get
go get github.com/integrity-studio/sdk-go

# Add to go.mod
require github.com/integrity-studio/sdk-go v1.0.0''',
                ],
              ),
            ],
          ),
        ),

        // Step 3: Initialize
        _DocSection(
          icon: LucideIcons.play,
          title: 'Step 3: Initialize the SDK',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add initialization code at your application startup:',
                style: AppTypography.bodyMD.copyWith(color: AppColors.gray300),
              ),
              const SizedBox(height: AppSpacing.lg),
              const _LanguageTab(
                languages: ['Python', 'TypeScript', 'Go'],
                codeBlocks: [
                  '''from integrity_studio import IntegrityStudio

# Initialize the client
client = IntegrityStudio(
    api_key=os.environ["INTEGRITY_API_KEY"],
    service_name="my-llm-app",
)

# Enable auto-instrumentation for popular libraries
client.instrument_openai()      # OpenAI
client.instrument_anthropic()   # Anthropic
client.instrument_langchain()   # LangChain''',
                  '''import { IntegrityStudio } from '@integrity-studio/sdk';

// Initialize the client
const client = new IntegrityStudio({
  apiKey: process.env.INTEGRITY_API_KEY,
  serviceName: 'my-llm-app',
});

// Enable auto-instrumentation
client.instrumentOpenAI();
client.instrumentAnthropic();
client.instrumentLangChain();''',
                  '''package main

import (
    "os"
    integrity "github.com/integrity-studio/sdk-go"
)

func main() {
    // Initialize the client
    client := integrity.NewClient(
        integrity.WithAPIKey(os.Getenv("INTEGRITY_API_KEY")),
        integrity.WithServiceName("my-llm-app"),
    )
    defer client.Shutdown()

    // Your application code
}''',
                ],
              ),
            ],
          ),
        ),

        // Step 4: Instrument Your Code
        _DocSection(
          icon: LucideIcons.code,
          title: 'Step 4: Instrument Your Code',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Wrap your LLM calls to capture traces automatically:',
                style: AppTypography.bodyMD.copyWith(color: AppColors.gray300),
              ),
              const SizedBox(height: AppSpacing.lg),
              const _LanguageTab(
                languages: ['Python', 'TypeScript', 'Go'],
                codeBlocks: [
                  '''# Option 1: Auto-instrumentation (recommended)
# Just use your LLM client normally - traces are captured automatically
response = anthropic.messages.create(
    model="claude-3-opus-20240229",
    max_tokens=1024,
    messages=[{"role": "user", "content": "Hello!"}]
)

# Option 2: Manual instrumentation for custom spans
with client.trace("process_query") as span:
    span.set_attribute("query.type", "support")
    span.set_attribute("user.id", user_id)

    # Your processing logic
    result = process_user_query(query)

    span.set_attribute("result.status", "success")''',
                  '''// Option 1: Auto-instrumentation (recommended)
// Just use your LLM client normally
const response = await anthropic.messages.create({
  model: 'claude-3-opus-20240229',
  max_tokens: 1024,
  messages: [{ role: 'user', content: 'Hello!' }]
});

// Option 2: Manual instrumentation for custom spans
await client.trace('process_query', async (span) => {
  span.setAttribute('query.type', 'support');
  span.setAttribute('user.id', userId);

  // Your processing logic
  const result = await processUserQuery(query);

  span.setAttribute('result.status', 'success');
  return result;
});''',
                  '''// Manual instrumentation in Go
ctx, span := client.StartSpan(ctx, "process_query")
defer span.End()

span.SetAttribute("query.type", "support")
span.SetAttribute("user.id", userID)

// Your processing logic
result, err := processUserQuery(ctx, query)
if err != nil {
    span.RecordError(err)
    span.SetStatus(codes.Error, err.Error())
    return err
}

span.SetAttribute("result.status", "success")''',
                ],
              ),
            ],
          ),
        ),

        // Step 5: View Traces
        _DocSection(
          icon: LucideIcons.barChart3,
          title: 'Step 5: View Your Traces',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Once your application is running, traces will appear in your dashboard within seconds.',
                style: AppTypography.bodyMD.copyWith(color: AppColors.gray300),
              ),
              const SizedBox(height: AppSpacing.lg),
              const _FeatureGrid(),
              const SizedBox(height: AppSpacing.lg),
              _SuccessCallout(
                title: "You're All Set!",
                message:
                    'Your traces should now be flowing to Integrity Studio. Check your dashboard to see LLM calls, token usage, latency, and costs.',
              ),
            ],
          ),
        ),

        // What's Captured Section
        _DocSection(
          icon: LucideIcons.database,
          title: "What's Captured Automatically",
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'The SDK automatically captures these attributes on every LLM call:',
                style: AppTypography.bodyMD.copyWith(color: AppColors.gray300),
              ),
              const SizedBox(height: AppSpacing.lg),
              const _SimpleTable(
                headers: ['Attribute', 'Description', 'Example'],
                rows: [
                  ['gen_ai.system', 'LLM provider', 'anthropic, openai'],
                  ['gen_ai.request.model', 'Model used', 'claude-3-opus'],
                  ['gen_ai.usage.input_tokens', 'Prompt tokens', '1250'],
                  ['gen_ai.usage.output_tokens', 'Completion tokens', '380'],
                  ['gen_ai.response.finish_reason', 'Stop reason', 'end_turn'],
                  ['gen_ai.request.temperature', 'Temperature setting', '0.7'],
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              _InfoCallout(
                title: 'Cost Tracking',
                message:
                    'Token counts are automatically converted to cost estimates based on current model pricing.',
              ),
            ],
          ),
        ),

        // OpenTelemetry Section
        _DocSection(
          icon: LucideIcons.plug,
          title: 'OpenTelemetry Configuration',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Already using OpenTelemetry? Configure the OTLP exporter to send traces directly:',
                style: AppTypography.bodyMD.copyWith(color: AppColors.gray300),
              ),
              const SizedBox(height: AppSpacing.lg),
              const _CodeBlock(
                title: 'Environment Variables',
                code: '''# OTLP Configuration
export OTEL_EXPORTER_OTLP_ENDPOINT="https://ingest.integritystudio.ai"
export OTEL_EXPORTER_OTLP_HEADERS="Authorization=Bearer \$INTEGRITY_API_KEY"
export OTEL_EXPORTER_OTLP_PROTOCOL="http/protobuf"

# Service Identification
export OTEL_SERVICE_NAME="my-llm-app"
export OTEL_RESOURCE_ATTRIBUTES="deployment.environment=production"''',
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                'This works with any OpenTelemetry-instrumented application, including custom instrumentation.',
                style: AppTypography.bodyMD.copyWith(color: AppColors.gray300),
              ),
            ],
          ),
        ),

        // Troubleshooting Section
        _DocSection(
          icon: LucideIcons.helpCircle,
          title: 'Troubleshooting',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _TroubleshootItem(
                problem: 'Traces not appearing in dashboard',
                solutions: [
                  'Verify your API key is correct and has traces:write scope',
                  'Check that INTEGRITY_API_KEY environment variable is set',
                  'Ensure your firewall allows outbound HTTPS to *.integritystudio.ai',
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              const _TroubleshootItem(
                problem: 'Missing token counts',
                solutions: [
                  'Ensure you\'re using a supported LLM client version',
                  'Check that auto-instrumentation is enabled before making calls',
                  'For streaming responses, token counts appear after stream completes',
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              const _TroubleshootItem(
                problem: 'High latency on trace export',
                solutions: [
                  'Traces are batched and sent asynchronously (no impact on your app)',
                  'Check your network connection to the ingestion endpoint',
                  'Consider using the gzip compression option for large payloads',
                ],
              ),
            ],
          ),
        ),

        // Next Steps Section
        _DocSection(
          icon: LucideIcons.arrowRight,
          title: 'Next Steps',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _BulletList(items: const [
                'Set up alerts \u2014 /docs/alerts',
                'Configure integrations \u2014 /docs/integrations',
                'Explore the API \u2014 /docs/api',
                'Learn about compliance \u2014 /docs/tracing',
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
                  color: AppColors.success,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusSM),
                ),
                child: Icon(icon, color: Colors.white, size: 20),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  title,
                  style: AppTypography.headingSM.copyWith(
                    color: AppColors.success,
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
          title: 'Trace Explorer',
          description: 'Search and filter traces by service, operation, or time range.',
        ),
        _FeatureCard(
          icon: LucideIcons.dollarSign,
          title: 'Cost Dashboard',
          description: 'Track spend by model, team, or application.',
        ),
        _FeatureCard(
          icon: LucideIcons.gauge,
          title: 'Latency Metrics',
          description: 'Monitor P50, P95, P99 latencies in real-time.',
        ),
        _FeatureCard(
          icon: LucideIcons.bell,
          title: 'Alerting',
          description: 'Get notified when costs or errors exceed thresholds.',
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
              color: AppColors.success.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(AppSpacing.radiusSM),
            ),
            child: Icon(icon, color: AppColors.success, size: 18),
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

class _NumberedStep extends StatelessWidget {
  final String number;
  final String title;
  final String content;

  const _NumberedStep({
    required this.number,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: AppColors.success.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: AppTypography.bodySM.copyWith(
                  color: AppColors.success,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.bodyMD.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  content,
                  style: AppTypography.bodySM.copyWith(
                    color: AppColors.gray400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LanguageTab extends StatefulWidget {
  final List<String> languages;
  final List<String> codeBlocks;

  const _LanguageTab({
    required this.languages,
    required this.codeBlocks,
  });

  @override
  State<_LanguageTab> createState() => _LanguageTabState();
}

class _LanguageTabState extends State<_LanguageTab> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Tab buttons
        Wrap(
          spacing: AppSpacing.sm,
          children: widget.languages.asMap().entries.map((entry) {
            final isSelected = entry.key == _selectedIndex;
            return GestureDetector(
              onTap: () => setState(() => _selectedIndex = entry.key),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.success.withValues(alpha: 0.2)
                      : AppColors.gray700,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusSM),
                  border: Border.all(
                    color: isSelected ? AppColors.success : AppColors.gray600,
                  ),
                ),
                child: Text(
                  entry.value,
                  style: AppTypography.bodySM.copyWith(
                    color: isSelected ? AppColors.success : AppColors.gray400,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: AppSpacing.md),
        // Code block
        _CodeBlock(code: widget.codeBlocks[_selectedIndex]),
      ],
    );
  }
}

class _CodeBlock extends StatelessWidget {
  final String code;
  final String? title;

  const _CodeBlock({required this.code, this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          Text(
            title!,
            style: AppTypography.bodySM.copyWith(
              color: AppColors.gray400,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
        Container(
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
        ),
      ],
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
                        color: AppColors.success,
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

class _CheckList extends StatelessWidget {
  final List<String> items;

  const _CheckList({required this.items});

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
                    Icon(
                      LucideIcons.checkCircle,
                      size: 18,
                      color: AppColors.success,
                    ),
                    const SizedBox(width: AppSpacing.sm),
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

class _TroubleshootItem extends StatelessWidget {
  final String problem;
  final List<String> solutions;

  const _TroubleshootItem({
    required this.problem,
    required this.solutions,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(LucideIcons.alertCircle, size: 18, color: AppColors.warning),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                problem,
                style: AppTypography.bodyMD.copyWith(
                  color: AppColors.warning,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        ...solutions.map((solution) => Padding(
              padding: const EdgeInsets.only(left: AppSpacing.lg, bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '\u2022 ',
                    style: AppTypography.bodySM.copyWith(
                      color: AppColors.gray400,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      solution,
                      style: AppTypography.bodySM.copyWith(
                        color: AppColors.gray300,
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ],
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
          Text(
            message,
            style: AppTypography.bodyMD.copyWith(color: AppColors.gray300),
          ),
        ],
      ),
    );
  }
}
