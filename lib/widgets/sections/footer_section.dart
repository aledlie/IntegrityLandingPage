import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../theme/theme.dart';
import '../common/containers.dart';

/// Footer section with links and legal information
///
/// LEGAL REQUIREMENT: Must include links to:
/// - Privacy Policy
/// - Terms of Service
/// - Cookie Settings (GDPR)
///
/// Usage:
/// ```dart
/// FooterSection(
///   onCookieSettings: () => showCookieBanner(),
/// )
/// ```
class FooterSection extends StatelessWidget {
  final VoidCallback? onCookieSettings;

  const FooterSection({
    super.key,
    this.onCookieSettings,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    final currentYear = DateTime.now().year;

    return Container(
      color: AppColors.gray900,
      child: SectionContainer(
        padding: EdgeInsets.symmetric(
          vertical: isMobile ? AppSpacing.xl : AppSpacing.xxl,
        ),
        child: Column(
          children: [
            if (isMobile) _buildMobileLayout() else _buildDesktopLayout(),
            const SizedBox(height: AppSpacing.xl),
            const Divider(color: AppColors.gray700),
            const SizedBox(height: AppSpacing.lg),
            _buildBottomBar(currentYear, isMobile),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Brand column
        Expanded(
          flex: 2,
          child: _buildBrandColumn(),
        ),
        // Link columns
        ..._linkSections.map((section) => Expanded(
              child: _buildLinkColumn(section),
            )),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBrandColumn(),
        const SizedBox(height: AppSpacing.xl),
        Wrap(
          spacing: AppSpacing.xl,
          runSpacing: AppSpacing.lg,
          children: _linkSections.map((section) {
            return SizedBox(
              width: 150,
              child: _buildLinkColumn(section),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildBrandColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'IntegrityStudio',
          style: AppTypography.headingSM.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 280),
          child: Text(
            'Enterprise-grade AI observability platform for monitoring, debugging, and optimizing LLM applications.',
            style: AppTypography.bodySM,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Row(
          children: [
            _SocialLink(
              icon: LucideIcons.twitter,
              url: 'https://twitter.com/integritystudio',
              label: 'Twitter',
            ),
            const SizedBox(width: AppSpacing.md),
            _SocialLink(
              icon: LucideIcons.linkedin,
              url: 'https://linkedin.com/company/integritystudio',
              label: 'LinkedIn',
            ),
            const SizedBox(width: AppSpacing.md),
            _SocialLink(
              icon: LucideIcons.github,
              url: 'https://github.com/integritystudio',
              label: 'GitHub',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLinkColumn(_LinkSection section) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          section.title,
          style: AppTypography.bodyMD.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        ...section.links.map((link) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: _FooterLink(
                text: link.text,
                onTap: link.isInternal
                    ? () {}
                    : () => launchUrl(Uri.parse(link.url)),
              ),
            )),
      ],
    );
  }

  Widget _buildBottomBar(int year, bool isMobile) {
    if (isMobile) {
      return Column(
        children: [
          Text(
            '$year Integrity Studio. All rights reserved.',
            style: AppTypography.caption,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _FooterLink(
                text: 'Privacy Policy',
                onTap: () => launchUrl(Uri.parse('/privacy')),
              ),
              const SizedBox(width: AppSpacing.md),
              _FooterLink(
                text: 'Terms',
                onTap: () => launchUrl(Uri.parse('/terms')),
              ),
              const SizedBox(width: AppSpacing.md),
              _FooterLink(
                text: 'Cookies',
                onTap: onCookieSettings,
              ),
            ],
          ),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$year Integrity Studio. All rights reserved.',
          style: AppTypography.caption,
        ),
        Row(
          children: [
            _FooterLink(
              text: 'Privacy Policy',
              onTap: () => launchUrl(Uri.parse('/privacy')),
            ),
            const SizedBox(width: AppSpacing.lg),
            _FooterLink(
              text: 'Terms of Service',
              onTap: () => launchUrl(Uri.parse('/terms')),
            ),
            const SizedBox(width: AppSpacing.lg),
            _FooterLink(
              text: 'Cookie Settings',
              onTap: onCookieSettings,
            ),
          ],
        ),
      ],
    );
  }
}

class _SocialLink extends StatelessWidget {
  final IconData icon;
  final String url;
  final String label;

  const _SocialLink({
    required this.icon,
    required this.url,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: label,
      child: IconButton(
        icon: Icon(icon, size: 20),
        color: AppColors.gray400,
        hoverColor: AppColors.gray700,
        onPressed: () => launchUrl(Uri.parse(url)),
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(
          minWidth: 36,
          minHeight: 36,
        ),
      ),
    );
  }
}

class _FooterLink extends StatefulWidget {
  final String text;
  final VoidCallback? onTap;

  const _FooterLink({
    required this.text,
    this.onTap,
  });

  @override
  State<_FooterLink> createState() => _FooterLinkState();
}

class _FooterLinkState extends State<_FooterLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Text(
          widget.text,
          style: AppTypography.bodySM.copyWith(
            color: _isHovered ? AppColors.textPrimary : AppColors.gray400,
          ),
        ),
      ),
    );
  }
}

class _LinkSection {
  final String title;
  final List<_LinkItem> links;

  const _LinkSection({
    required this.title,
    required this.links,
  });
}

class _LinkItem {
  final String text;
  final String url;
  final bool isInternal;

  const _LinkItem({
    required this.text,
    required this.url,
    this.isInternal = true,
  });
}

const List<_LinkSection> _linkSections = [
  _LinkSection(
    title: 'Product',
    links: [
      _LinkItem(text: 'Features', url: '#features'),
      _LinkItem(text: 'Pricing', url: '#pricing'),
      _LinkItem(text: 'Documentation', url: '/docs'),
      _LinkItem(text: 'API Reference', url: '/api'),
    ],
  ),
  _LinkSection(
    title: 'Company',
    links: [
      _LinkItem(text: 'About', url: '/about'),
      _LinkItem(text: 'Blog', url: '/blog'),
      _LinkItem(text: 'Careers', url: '/careers'),
      _LinkItem(text: 'Contact', url: '/contact'),
    ],
  ),
  _LinkSection(
    title: 'Resources',
    links: [
      _LinkItem(text: 'Help Center', url: '/help'),
      _LinkItem(text: 'Status', url: 'https://status.integritystudio.ai', isInternal: false),
      _LinkItem(text: 'Security', url: '/security'),
      _LinkItem(text: 'Changelog', url: '/changelog'),
    ],
  ),
];
