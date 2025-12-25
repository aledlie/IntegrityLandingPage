import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../config/content.dart';
import '../theme/theme.dart';
import '../widgets/common/containers.dart';

/// Legal page type enum.
enum LegalPageType { privacy, terms }

/// Legal page displaying Privacy Policy or Terms of Service.
///
/// Provides consistent styling for legal content with:
/// - Responsive layout
/// - Proper heading hierarchy
/// - Section organization
/// - Back navigation
class LegalPage extends StatelessWidget {
  final LegalPageType type;
  final VoidCallback? onBack;

  const LegalPage({
    super.key,
    required this.type,
    this.onBack,
  });

  /// Factory constructor for Privacy Policy page.
  factory LegalPage.privacy({VoidCallback? onBack}) => LegalPage(
        type: LegalPageType.privacy,
        onBack: onBack,
      );

  /// Factory constructor for Terms of Service page.
  factory LegalPage.terms({VoidCallback? onBack}) => LegalPage(
        type: LegalPageType.terms,
        onBack: onBack,
      );

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    final content = type == LegalPageType.privacy
        ? _PrivacyPolicyContent()
        : _TermsOfServiceContent();

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
              type == LegalPageType.privacy
                  ? 'Privacy Policy'
                  : 'Terms of Service',
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
            child: _HeroSection(
              type: type,
              isMobile: isMobile,
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: SectionContainer(
              padding: EdgeInsets.symmetric(
                vertical: isMobile ? AppSpacing.xl : AppSpacing.xxl,
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: content,
              ),
            ),
          ),

          // Footer spacing
          const SliverToBoxAdapter(
            child: SizedBox(height: AppSpacing.xxxl),
          ),
        ],
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  final LegalPageType type;
  final bool isMobile;

  const _HeroSection({required this.type, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final isPrivacy = type == LegalPageType.privacy;

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
                    isPrivacy ? LucideIcons.shield : LucideIcons.fileText,
                    size: 16,
                    color: AppColors.blue400,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    isPrivacy ? 'Your Privacy Matters' : 'Legal Agreement',
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
              isPrivacy ? 'Privacy Policy' : 'Terms of Service',
              style: isMobile
                  ? AppTypography.headingLG.copyWith(fontSize: 32)
                  : AppTypography.headingXL,
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: AppSpacing.lg),

            // Last updated
            Text(
              'Last updated: December 24, 2024',
              style: AppTypography.bodySM.copyWith(
                color: AppColors.gray400,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: AppSpacing.md),

            // Subheadline
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Text(
                isPrivacy
                    ? 'This policy describes how ${CompanyInfo.name} collects, uses, and protects your personal information.'
                    : 'Please read these terms carefully before using the ${CompanyInfo.name} platform.',
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

/// Privacy Policy content.
class _PrivacyPolicyContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _LegalSection(
          title: '1. Information We Collect',
          content: '''
When you use Integrity Studio, we collect information to provide and improve our services:

**Account Information**: When you create an account, we collect your name, email address, company name, and payment information.

**Usage Data**: We collect data about how you use our platform, including API calls, feature usage, and performance metrics.

**Technical Data**: We automatically collect device information, IP addresses, browser type, and operating system.

**Communications**: We retain records of communications with our support team and feedback you provide.
''',
        ),
        _LegalSection(
          title: '2. How We Use Your Information',
          content: '''
We use collected information to:

- Provide, maintain, and improve our AI observability platform
- Process transactions and send related information
- Send technical notices, updates, and support messages
- Respond to your comments, questions, and customer service requests
- Monitor and analyze trends, usage, and activities
- Detect, investigate, and prevent fraudulent or unauthorized activities
- Personalize and improve your experience
- Comply with legal obligations
''',
        ),
        _LegalSection(
          title: '3. Data Sharing and Disclosure',
          content: '''
We do not sell your personal information. We may share information in these circumstances:

**Service Providers**: With third parties who perform services on our behalf (payment processing, hosting, analytics).

**Legal Requirements**: When required by law or to protect our rights, privacy, safety, or property.

**Business Transfers**: In connection with a merger, acquisition, or sale of assets.

**With Your Consent**: When you direct us to share your information.
''',
        ),
        _LegalSection(
          title: '4. Data Security',
          content: '''
We implement industry-standard security measures to protect your data:

- Encryption in transit (TLS 1.3) and at rest (AES-256)
- Regular security audits and penetration testing
- Access controls and authentication requirements
- Employee security training and background checks
- Incident response procedures

While we strive to protect your information, no method of transmission or storage is 100% secure.
''',
        ),
        _LegalSection(
          title: '5. Data Retention',
          content: '''
We retain your information for as long as your account is active or as needed to provide services. We also retain information to:

- Comply with legal obligations
- Resolve disputes
- Enforce our agreements

You may request deletion of your account and associated data by contacting ${CompanyInfo.email}.
''',
        ),
        _LegalSection(
          title: '6. Your Rights',
          content: '''
Depending on your location, you may have rights including:

**Access**: Request a copy of your personal data
**Correction**: Request correction of inaccurate data
**Deletion**: Request deletion of your data
**Portability**: Request transfer of your data
**Objection**: Object to processing of your data
**Restriction**: Request restriction of processing

To exercise these rights, contact us at ${CompanyInfo.email}.
''',
        ),
        _LegalSection(
          title: '7. Cookies and Tracking',
          content: '''
We use cookies and similar technologies to:

- Remember your preferences and settings
- Understand how you use our platform
- Improve our services
- Provide analytics

You can control cookies through your browser settings and our cookie consent banner. Essential cookies are required for platform functionality.
''',
        ),
        _LegalSection(
          title: '8. International Data Transfers',
          content: '''
Your information may be transferred to and processed in countries other than your own. We ensure appropriate safeguards are in place for such transfers, including:

- Standard contractual clauses
- Data processing agreements
- Compliance with applicable data protection laws
''',
        ),
        _LegalSection(
          title: '9. Changes to This Policy',
          content: '''
We may update this privacy policy from time to time. We will notify you of any material changes by:

- Posting the new policy on this page
- Updating the "Last updated" date
- Sending an email notification for significant changes

We encourage you to review this policy periodically.
''',
        ),
        _LegalSection(
          title: '10. Contact Us',
          content: '''
If you have questions about this privacy policy or our practices, please contact us:

**Email**: ${CompanyInfo.email}
**Location**: ${CompanyInfo.locationCity}, ${CompanyInfo.locationRegion}

For EU residents, you also have the right to lodge a complaint with your local data protection authority.
''',
        ),
      ],
    );
  }
}

/// Terms of Service content.
class _TermsOfServiceContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _LegalSection(
          title: '1. Acceptance of Terms',
          content: '''
By accessing or using the ${CompanyInfo.name} platform ("Service"), you agree to be bound by these Terms of Service ("Terms"). If you disagree with any part of the terms, you may not access the Service.

These Terms apply to all visitors, users, and others who access or use the Service.
''',
        ),
        _LegalSection(
          title: '2. Description of Service',
          content: '''
${CompanyInfo.name} provides an AI observability platform that enables you to:

- Monitor and trace LLM (Large Language Model) applications
- Track costs, performance, and usage metrics
- Debug and analyze AI system behavior
- Generate compliance reports and audit trails

We reserve the right to modify, suspend, or discontinue any aspect of the Service at any time.
''',
        ),
        _LegalSection(
          title: '3. User Accounts',
          content: '''
**Account Creation**: You must provide accurate, complete, and current information when creating an account.

**Account Security**: You are responsible for maintaining the confidentiality of your account credentials and for all activities under your account.

**Account Termination**: We may terminate or suspend your account immediately, without prior notice, for conduct that violates these Terms or is harmful to other users or us.
''',
        ),
        _LegalSection(
          title: '4. Acceptable Use',
          content: '''
You agree not to use the Service to:

- Violate any applicable laws or regulations
- Infringe on intellectual property rights
- Transmit malware or other harmful code
- Attempt to gain unauthorized access to our systems
- Interfere with or disrupt the Service
- Collect user data without consent
- Engage in any fraudulent or deceptive practices

We reserve the right to investigate and take appropriate action against violations.
''',
        ),
        _LegalSection(
          title: '5. Intellectual Property',
          content: '''
**Our IP**: The Service and its original content, features, and functionality are owned by ${CompanyInfo.name} and are protected by international copyright, trademark, and other intellectual property laws.

**Your Data**: You retain ownership of data you submit to the Service. You grant us a license to use this data solely to provide and improve the Service.

**Feedback**: Any feedback you provide may be used by us without obligation to you.
''',
        ),
        _LegalSection(
          title: '6. Payment Terms',
          content: '''
**Billing**: Paid plans are billed in advance on a monthly or annual basis.

**Refunds**: We do not provide refunds for partial months of service or unused features.

**Price Changes**: We may modify pricing with 30 days notice. Continued use after price changes constitutes acceptance.

**Taxes**: You are responsible for all applicable taxes except those based on our net income.
''',
        ),
        _LegalSection(
          title: '7. Service Level Agreement',
          content: '''
For paid plans, we commit to:

- 99.9% uptime SLA (excluding scheduled maintenance)
- Data processing within stated latency targets
- Response times for support requests per your plan tier

SLA credits are available for qualifying downtime as described in our SLA documentation.
''',
        ),
        _LegalSection(
          title: '8. Limitation of Liability',
          content: '''
TO THE MAXIMUM EXTENT PERMITTED BY LAW:

The Service is provided "AS IS" without warranties of any kind. We do not warrant that the Service will be uninterrupted, secure, or error-free.

IN NO EVENT SHALL ${CompanyInfo.name.toUpperCase()} BE LIABLE FOR ANY INDIRECT, INCIDENTAL, SPECIAL, CONSEQUENTIAL, OR PUNITIVE DAMAGES, OR ANY LOSS OF PROFITS OR REVENUES.

Our total liability shall not exceed the amount you paid us in the twelve (12) months preceding the claim.
''',
        ),
        _LegalSection(
          title: '9. Indemnification',
          content: '''
You agree to indemnify and hold harmless ${CompanyInfo.name}, its officers, directors, employees, and agents from any claims, damages, losses, or expenses arising from:

- Your use of the Service
- Your violation of these Terms
- Your violation of any third-party rights
- Your data or content submitted to the Service
''',
        ),
        _LegalSection(
          title: '10. Governing Law',
          content: '''
These Terms shall be governed by the laws of the State of Texas, United States, without regard to its conflict of law provisions.

Any disputes arising from these Terms or the Service shall be resolved in the courts located in ${CompanyInfo.locationCity}, ${CompanyInfo.locationRegion}.
''',
        ),
        _LegalSection(
          title: '11. Changes to Terms',
          content: '''
We reserve the right to modify these Terms at any time. We will provide notice of material changes by:

- Posting the updated Terms on our website
- Updating the "Last updated" date
- Sending email notification for significant changes

Continued use of the Service after changes constitutes acceptance of the modified Terms.
''',
        ),
        _LegalSection(
          title: '12. Contact Information',
          content: '''
For questions about these Terms, please contact us:

**Email**: ${CompanyInfo.email}
**Location**: ${CompanyInfo.locationCity}, ${CompanyInfo.locationRegion}
''',
        ),
      ],
    );
  }
}

/// A legal section with title and content.
class _LegalSection extends StatelessWidget {
  final String title;
  final String content;

  const _LegalSection({
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xxl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTypography.headingSM.copyWith(
              color: Colors.white,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          _MarkdownText(content: content),
        ],
      ),
    );
  }
}

/// Simple markdown-like text rendering.
class _MarkdownText extends StatelessWidget {
  final String content;

  const _MarkdownText({required this.content});

  @override
  Widget build(BuildContext context) {
    final lines = content.trim().split('\n');
    final widgets = <Widget>[];

    for (final line in lines) {
      if (line.trim().isEmpty) {
        widgets.add(const SizedBox(height: AppSpacing.md));
      } else if (line.trim().startsWith('- ')) {
        // Bullet point
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(
              left: AppSpacing.md,
              bottom: AppSpacing.sm,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '• ',
                  style: AppTypography.bodyMD.copyWith(
                    color: AppColors.blue400,
                  ),
                ),
                Expanded(
                  child: _parseInlineFormatting(
                    line.trim().substring(2),
                    context,
                  ),
                ),
              ],
            ),
          ),
        );
      } else if (line.trim().startsWith('**') && line.trim().endsWith('**')) {
        // Bold heading-like line
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(
              top: AppSpacing.sm,
              bottom: AppSpacing.xs,
            ),
            child: Text(
              line.trim().replaceAll('**', ''),
              style: AppTypography.bodyMD.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      } else {
        // Regular paragraph
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: _parseInlineFormatting(line.trim(), context),
          ),
        );
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }

  Widget _parseInlineFormatting(String text, BuildContext context) {
    // Simple bold text parsing
    final boldPattern = RegExp(r'\*\*(.+?)\*\*');
    final matches = boldPattern.allMatches(text).toList();

    if (matches.isEmpty) {
      return Text(
        text,
        style: AppTypography.bodyMD.copyWith(
          color: AppColors.gray300,
          height: 1.6,
        ),
      );
    }

    final spans = <TextSpan>[];
    var lastEnd = 0;

    for (final match in matches) {
      // Add text before match
      if (match.start > lastEnd) {
        spans.add(TextSpan(
          text: text.substring(lastEnd, match.start),
          style: AppTypography.bodyMD.copyWith(
            color: AppColors.gray300,
            height: 1.6,
          ),
        ));
      }
      // Add bold text
      spans.add(TextSpan(
        text: match.group(1),
        style: AppTypography.bodyMD.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          height: 1.6,
        ),
      ));
      lastEnd = match.end;
    }

    // Add remaining text
    if (lastEnd < text.length) {
      spans.add(TextSpan(
        text: text.substring(lastEnd),
        style: AppTypography.bodyMD.copyWith(
          color: AppColors.gray300,
          height: 1.6,
        ),
      ));
    }

    return RichText(text: TextSpan(children: spans));
  }
}
