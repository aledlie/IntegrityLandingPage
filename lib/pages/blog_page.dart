import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/theme.dart';
import '../widgets/common/containers.dart';
import '../widgets/common/buttons.dart';

/// Blog listing page displaying available articles
///
/// Features:
/// - Responsive grid layout
/// - Blog post cards with metadata
/// - Links to static HTML blog content
/// - Maintains brand consistency
class BlogPage extends StatelessWidget {
  final VoidCallback? onBack;

  const BlogPage({
    super.key,
    this.onBack,
  });

  static const List<BlogPost> _posts = [
    BlogPost(
      title: 'WhyLabs Alternative: Migrate to Integrity Studio',
      subtitle: 'WhyLabs Is Shutting Down—Here\'s Your Migration Path',
      description: 'WhyLabs announced shutdown in December 2024. This guide covers migrating your AI observability to Integrity Studio with privacy-first monitoring, EU AI Act compliance, and seamless data migration—most teams complete it in under an hour.',
      date: 'January 2025',
      readTime: '8 min read',
      category: 'Migration',
      url: '/whylabs-alternative',
      isInternal: true,
      stats: [
        'Under 1 hour migration',
        'EU AI Act ready',
        'Privacy-first',
      ],
    ),
    BlogPost(
      title: 'Arize AI vs Integrity Studio: Comparison Guide',
      subtitle: 'A Simpler Path to AI Observability',
      description: 'Comparing Integrity Studio and Arize AI for AI observability. Learn about transparent pricing, EU AI Act compliance, and developer-friendly integration. Find the right platform for your LLM monitoring needs.',
      date: 'January 2025',
      readTime: '6 min read',
      category: 'Comparison',
      url: '/compare/arize-ai-alternative',
      isInternal: true,
      stats: [
        '5-minute setup',
        'Transparent pricing',
        'Compliance built-in',
      ],
    ),
    BlogPost(
      title: 'Setting Up Compliance Logging for EU AI Act',
      subtitle: 'Technical Guide to Article 12-Compliant Logging',
      description: 'A practical guide to implementing Article 12-compliant logging for LLM systems, with code examples and production-ready patterns. Covers ISO 24970 standards, data schemas, and implementation for high-risk AI compliance.',
      date: 'December 26, 2024',
      readTime: '15 min read',
      category: 'Compliance',
      url: '/blog/eu-ai-act-compliance-logging-setup.html',
      isSeries: false,
      stats: [
        'August 2026 deadline',
        'ISO 24970 aligned',
        'Production code',
      ],
    ),
    BlogPost(
      title: 'Best LLM Monitoring Tools (2025 Guide)',
      subtitle: 'We Tested 11 Platforms So You Don\'t Have To',
      description: 'The definitive guide to LLM monitoring and observability tools. Includes pricing, features, and honest recommendations for startups to enterprises. Covers Langfuse, LangSmith, Helicone, Arize, Datadog, and more.',
      date: 'December 2025',
      readTime: '18 min read',
      category: 'Guide',
      url: '/blog/best-llm-monitoring-tools-2025.html',
      isSeries: false,
      stats: [
        '11 tools compared',
        '\$1.97B market 2025',
        'Startup to Enterprise',
      ],
    ),
    BlogPost(
      title: 'End-to-End Agentic Observability: From Chaos to Control',
      subtitle: 'A Practical Guide to the 4-Stage Observability Lifecycle',
      description: 'Your AI agent just autonomously decided to email your entire customer database at 3 AM. With a coupon code that doesn\'t exist. In French. Learn the Build, Test, Monitor, Analyze lifecycle that keeps agents reliable and compliant.',
      date: 'December 24, 2024',
      readTime: '12 min read',
      category: 'Best Practices',
      url: '/blog/end-to-end-agentic-observability-lifecycle.html',
      isSeries: false,
      stats: [
        '73% faster debugging',
        '4-stage lifecycle',
        'EU AI Act ready',
      ],
    ),
    BlogPost(
      title: 'AI Observability Platform Strategy',
      subtitle: 'Enhanced Research Report: Market Analysis, Regulatory Compliance & Competitive Intelligence',
      description: 'Comprehensive market research and strategic analysis for AI Observability and Trust Platform positioning, with regulatory compliance insights and competitive landscape analysis.',
      date: 'December 8, 2024',
      readTime: '45 min read',
      category: 'Strategy',
      url: '/blog/ai-observability-platform-strategy/index.html',
      isSeries: true,
      seriesArticles: [
        SeriesArticle(
          title: 'Market Analysis',
          description: 'Market size validation, enterprise budget trends, and growth projections',
          url: '/blog/ai-observability-platform-strategy/market-analysis.html',
        ),
        SeriesArticle(
          title: 'Regulatory Drivers',
          description: 'EU AI Act compliance timeline and requirements breakdown',
          url: '/blog/ai-observability-platform-strategy/regulatory-drivers.html',
        ),
        SeriesArticle(
          title: 'Competitive Landscape',
          description: 'Competitor analysis with funding data and market segmentation',
          url: '/blog/ai-observability-platform-strategy/competitive-landscape.html',
        ),
        SeriesArticle(
          title: 'Growth Strategy',
          description: 'Product-led growth validation and pricing benchmarks',
          url: '/blog/ai-observability-platform-strategy/growth-strategy.html',
        ),
        SeriesArticle(
          title: 'Recommendations',
          description: 'Prioritized actions with validation metrics and risk analysis',
          url: '/blog/ai-observability-platform-strategy/recommendations.html',
        ),
        SeriesArticle(
          title: 'Sources',
          description: 'Complete reference list with all research sources',
          url: '/blog/ai-observability-platform-strategy/sources.html',
        ),
      ],
      stats: [
        '\$2.9B+ market size by 2030',
        '25.47% CAGR growth rate',
        '98% enterprises increasing budgets',
      ],
    ),
  ];

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
              onPressed: onBack ?? () => context.go('/'),
            ),
            title: Text(
              'Blog',
              style: AppTypography.headingSM.copyWith(color: Colors.white),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: AppSpacing.md),
                child: TextButton(
                  onPressed: onBack ?? () => context.go('/'),
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

          // Header
          SliverToBoxAdapter(
            child: SectionContainer(
              padding: EdgeInsets.symmetric(
                vertical: isMobile ? AppSpacing.xl : AppSpacing.xxl,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Insights & Research',
                    style: isMobile
                        ? AppTypography.headingLG.copyWith(fontSize: 32)
                        : AppTypography.headingLG,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: Text(
                      'Deep dives into AI observability, market trends, regulatory compliance, and strategic insights for building trustworthy AI systems.',
                      style: AppTypography.bodyLG,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Blog posts
          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? AppSpacing.md : AppSpacing.xl,
              vertical: AppSpacing.xl,
            ),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.xl),
                  child: _BlogPostCard(post: _posts[index]),
                ),
                childCount: _posts.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BlogPost {
  final String title;
  final String subtitle;
  final String description;
  final String date;
  final String readTime;
  final String category;
  final String url;
  final bool isSeries;
  final bool isInternal;
  final List<SeriesArticle> seriesArticles;
  final List<String> stats;

  const BlogPost({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.date,
    required this.readTime,
    required this.category,
    required this.url,
    this.isSeries = false,
    this.isInternal = false,
    this.seriesArticles = const [],
    this.stats = const [],
  });
}

class SeriesArticle {
  final String title;
  final String description;
  final String url;

  const SeriesArticle({
    required this.title,
    required this.description,
    required this.url,
  });
}

class _BlogPostCard extends StatefulWidget {
  final BlogPost post;

  const _BlogPostCard({required this.post});

  @override
  State<_BlogPostCard> createState() => _BlogPostCardState();
}

class _BlogPostCardState extends State<_BlogPostCard> {
  bool _isExpanded = false;
  bool _isHovered = false;

  void _navigateToPost(BuildContext context, String url, bool isInternal) {
    if (isInternal) {
      context.go(url);
    } else {
      final uri = Uri.parse(url);
      launchUrl(uri, webOnlyWindowName: '_blank');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: _isHovered
            ? Matrix4.translationValues(0, -4, 0)
            : Matrix4.identity(),
        decoration: BoxDecoration(
          color: AppColors.gray800,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLG),
          border: Border.all(
            color: _isHovered
                ? AppColors.blue500.withValues(alpha: 0.5)
                : AppColors.gray700,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: AppColors.blue500.withValues(alpha: 0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Main card content
            Padding(
              padding: EdgeInsets.all(isMobile ? AppSpacing.lg : AppSpacing.xl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category and meta
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.sm,
                          vertical: AppSpacing.xs,
                        ),
                        decoration: BoxDecoration(
                          gradient: AppColors.primaryGradient,
                          borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                        ),
                        child: Text(
                          widget.post.category,
                          style: AppTypography.caption.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      if (widget.post.isSeries)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.sm,
                            vertical: AppSpacing.xs,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.purple500.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                            border: Border.all(
                              color: AppColors.purple500.withValues(alpha: 0.5),
                            ),
                          ),
                          child: Text(
                            '${widget.post.seriesArticles.length} Part Series',
                            style: AppTypography.caption.copyWith(
                              color: AppColors.purple400,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      Text(
                        widget.post.date,
                        style: AppTypography.caption.copyWith(
                          color: AppColors.gray400,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: AppSpacing.lg),

                  // Title
                  Text(
                    widget.post.title,
                    style: AppTypography.headingSM.copyWith(
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: AppSpacing.xs),

                  // Subtitle
                  Text(
                    widget.post.subtitle,
                    style: AppTypography.bodyMD.copyWith(
                      color: AppColors.blue400,
                    ),
                  ),

                  const SizedBox(height: AppSpacing.md),

                  // Description
                  Text(
                    widget.post.description,
                    style: AppTypography.bodyMD.copyWith(
                      color: AppColors.gray300,
                    ),
                  ),

                  // Stats
                  if (widget.post.stats.isNotEmpty) ...[
                    const SizedBox(height: AppSpacing.lg),
                    Wrap(
                      spacing: AppSpacing.md,
                      runSpacing: AppSpacing.sm,
                      children: widget.post.stats.map((stat) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.sm,
                            vertical: AppSpacing.xs,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.gray900,
                            borderRadius: BorderRadius.circular(AppSpacing.radiusSM),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                LucideIcons.trendingUp,
                                size: 14,
                                color: AppColors.success,
                              ),
                              const SizedBox(width: AppSpacing.xs),
                              Flexible(
                                child: Text(
                                  stat,
                                  style: AppTypography.caption.copyWith(
                                    color: AppColors.gray300,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ],

                  const SizedBox(height: AppSpacing.lg),

                  // Read time and CTA
                  if (isMobile)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              LucideIcons.clock,
                              size: 14,
                              color: AppColors.gray400,
                            ),
                            const SizedBox(width: AppSpacing.xs),
                            Text(
                              widget.post.readTime,
                              style: AppTypography.caption.copyWith(
                                color: AppColors.gray400,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.md),
                        if (widget.post.isSeries)
                          TextButton.icon(
                            onPressed: () {
                              setState(() => _isExpanded = !_isExpanded);
                            },
                            icon: Icon(
                              _isExpanded
                                  ? LucideIcons.chevronUp
                                  : LucideIcons.chevronDown,
                              size: 16,
                            ),
                            label: Text(_isExpanded ? 'Hide Articles' : 'View Articles'),
                            style: TextButton.styleFrom(
                              foregroundColor: AppColors.blue400,
                            ),
                          )
                        else
                          GradientButton(
                            text: 'Read Article',
                            icon: LucideIcons.arrowRight,
                            onPressed: () => _navigateToPost(context, widget.post.url, widget.post.isInternal),
                          ),
                      ],
                    )
                  else
                    Row(
                      children: [
                        const Icon(
                          LucideIcons.clock,
                          size: 14,
                          color: AppColors.gray400,
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Text(
                          widget.post.readTime,
                          style: AppTypography.caption.copyWith(
                            color: AppColors.gray400,
                          ),
                        ),
                        const Spacer(),
                        if (widget.post.isSeries)
                          TextButton.icon(
                            onPressed: () {
                              setState(() => _isExpanded = !_isExpanded);
                            },
                            icon: Icon(
                              _isExpanded
                                  ? LucideIcons.chevronUp
                                  : LucideIcons.chevronDown,
                              size: 16,
                            ),
                            label: Text(_isExpanded ? 'Hide Articles' : 'View Articles'),
                            style: TextButton.styleFrom(
                              foregroundColor: AppColors.blue400,
                            ),
                          )
                        else
                          GradientButton(
                            text: 'Read Article',
                            icon: LucideIcons.arrowRight,
                            onPressed: () => _navigateToPost(context, widget.post.url, widget.post.isInternal),
                          ),
                      ],
                    ),
                ],
              ),
            ),

            // Expandable series articles
            if (widget.post.isSeries)
              AnimatedCrossFade(
                firstChild: const SizedBox.shrink(),
                secondChild: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.gray900,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(AppSpacing.radiusLG),
                      bottomRight: Radius.circular(AppSpacing.radiusLG),
                    ),
                  ),
                  child: Column(
                    children: [
                      const Divider(color: AppColors.gray700, height: 1),
                      // Overview link
                      _SeriesArticleItem(
                        title: 'Overview',
                        description: 'Executive summary and key findings',
                        url: widget.post.url,
                        isFirst: true,
                      ),
                      ...widget.post.seriesArticles.asMap().entries.map((entry) {
                        return _SeriesArticleItem(
                          title: entry.value.title,
                          description: entry.value.description,
                          url: entry.value.url,
                          isLast: entry.key == widget.post.seriesArticles.length - 1,
                        );
                      }),
                    ],
                  ),
                ),
                crossFadeState: _isExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 200),
              ),
          ],
        ),
      ),
    );
  }
}

class _SeriesArticleItem extends StatefulWidget {
  final String title;
  final String description;
  final String url;
  final bool isFirst;
  final bool isLast;

  const _SeriesArticleItem({
    required this.title,
    required this.description,
    required this.url,
    this.isFirst = false,
    this.isLast = false,
  });

  @override
  State<_SeriesArticleItem> createState() => _SeriesArticleItemState();
}

class _SeriesArticleItemState extends State<_SeriesArticleItem> {
  bool _isHovered = false;

  Future<void> _launchUrl() async {
    final uri = Uri.parse(widget.url);
    await launchUrl(uri, webOnlyWindowName: '_blank');
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: _launchUrl,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.md,
          ),
          decoration: BoxDecoration(
            color: _isHovered ? AppColors.gray800 : Colors.transparent,
            borderRadius: widget.isLast
                ? const BorderRadius.only(
                    bottomLeft: Radius.circular(AppSpacing.radiusLG),
                    bottomRight: Radius.circular(AppSpacing.radiusLG),
                  )
                : null,
          ),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: _isHovered
                      ? AppColors.blue500.withValues(alpha: 0.2)
                      : AppColors.gray800,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusSM),
                ),
                child: Icon(
                  LucideIcons.fileText,
                  size: 16,
                  color: _isHovered ? AppColors.blue400 : AppColors.gray400,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: AppTypography.bodySM.copyWith(
                        color: _isHovered ? Colors.white : AppColors.gray300,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      widget.description,
                      style: AppTypography.caption.copyWith(
                        color: AppColors.gray400,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                LucideIcons.externalLink,
                size: 16,
                color: _isHovered ? AppColors.blue400 : AppColors.gray500,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
