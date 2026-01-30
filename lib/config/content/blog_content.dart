/// Blog content configuration.
///
/// Contains blog post models and content for the blog listing page.
library;

/// A single blog post entry.
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

/// An article within a blog series.
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

/// Blog content provider.
abstract final class BlogContent {
  /// All blog posts, ordered by date (newest first).
  static const List<BlogPost> posts = [
    // Comparison/Migration articles (internal navigation)
    BlogPost(
      title: 'WhyLabs Alternative: Migrate to Integrity Studio',
      subtitle: 'WhyLabs Is Shutting Down—Here\'s Your Migration Path',
      description:
          'WhyLabs announced shutdown in December 2024. This guide covers migrating '
          'your AI observability to Integrity Studio with privacy-first monitoring, '
          'EU AI Act compliance, and seamless data migration—most teams complete it '
          'in under an hour.',
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
      description:
          'Comparing Integrity Studio and Arize AI for AI observability. Learn about '
          'transparent pricing, EU AI Act compliance, and developer-friendly integration. '
          'Find the right platform for your LLM monitoring needs.',
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

    // External blog articles
    BlogPost(
      title: 'Setting Up Compliance Logging for EU AI Act',
      subtitle: 'Technical Guide to Article 12-Compliant Logging',
      description:
          'A practical guide to implementing Article 12-compliant logging for LLM '
          'systems, with code examples and production-ready patterns. Covers ISO 24970 '
          'standards, data schemas, and implementation for high-risk AI compliance.',
      date: 'December 26, 2024',
      readTime: '15 min read',
      category: 'Compliance',
      url: '/blog/eu-ai-act-compliance-logging-setup.html',
      stats: [
        'August 2026 deadline',
        'ISO 24970 aligned',
        'Production code',
      ],
    ),
    BlogPost(
      title: 'Best LLM Monitoring Tools (2025 Guide)',
      subtitle: 'We Tested 11 Platforms So You Don\'t Have To',
      description:
          'The definitive guide to LLM monitoring and observability tools. Includes '
          'pricing, features, and honest recommendations for startups to enterprises. '
          'Covers Langfuse, LangSmith, Helicone, Arize, Datadog, and more.',
      date: 'December 2025',
      readTime: '18 min read',
      category: 'Guide',
      url: '/blog/best-llm-monitoring-tools-2025.html',
      stats: [
        '11 tools compared',
        '\$1.97B market 2025',
        'Startup to Enterprise',
      ],
    ),
    BlogPost(
      title: 'End-to-End Agentic Observability: From Chaos to Control',
      subtitle: 'A Practical Guide to the 4-Stage Observability Lifecycle',
      description:
          'Your AI agent just autonomously decided to email your entire customer '
          'database at 3 AM. With a coupon code that doesn\'t exist. In French. '
          'Learn the Build, Test, Monitor, Analyze lifecycle that keeps agents '
          'reliable and compliant.',
      date: 'December 24, 2024',
      readTime: '12 min read',
      category: 'Best Practices',
      url: '/blog/end-to-end-agentic-observability-lifecycle.html',
      stats: [
        '73% faster debugging',
        '4-stage lifecycle',
        'EU AI Act ready',
      ],
    ),
    BlogPost(
      title: 'AI Observability Platform Strategy',
      subtitle:
          'Enhanced Research Report: Market Analysis, Regulatory Compliance & Competitive Intelligence',
      description:
          'Comprehensive market research and strategic analysis for AI Observability '
          'and Trust Platform positioning, with regulatory compliance insights and '
          'competitive landscape analysis.',
      date: 'December 8, 2024',
      readTime: '45 min read',
      category: 'Strategy',
      url: '/blog/ai-observability-platform-strategy/index.html',
      isSeries: true,
      seriesArticles: [
        SeriesArticle(
          title: 'Market Analysis',
          description:
              'Market size validation, enterprise budget trends, and growth projections',
          url: '/blog/ai-observability-platform-strategy/market-analysis.html',
        ),
        SeriesArticle(
          title: 'Regulatory Drivers',
          description:
              'EU AI Act compliance timeline and requirements breakdown',
          url: '/blog/ai-observability-platform-strategy/regulatory-drivers.html',
        ),
        SeriesArticle(
          title: 'Competitive Landscape',
          description:
              'Competitor analysis with funding data and market segmentation',
          url: '/blog/ai-observability-platform-strategy/competitive-landscape.html',
        ),
        SeriesArticle(
          title: 'Growth Strategy',
          description: 'Product-led growth validation and pricing benchmarks',
          url: '/blog/ai-observability-platform-strategy/growth-strategy.html',
        ),
        SeriesArticle(
          title: 'Recommendations',
          description:
              'Prioritized actions with validation metrics and risk analysis',
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
}
