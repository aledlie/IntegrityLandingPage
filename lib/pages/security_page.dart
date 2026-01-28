import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../config/content.dart';
import '../theme/theme.dart';
import '../widgets/common/containers.dart';

/// Security page displaying security practices and commitments.
class SecurityPage extends StatelessWidget {
  final VoidCallback? onBack;

  const SecurityPage({
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
              SecurityContent.pageTitle,
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
                child: const _SecurityContent(),
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
                      SecurityContent.lastUpdated,
                      style: AppTypography.bodySM.copyWith(
                        color: AppColors.gray400,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      '${CompanyInfo.name} LLC',
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
                    LucideIcons.shieldCheck,
                    size: 16,
                    color: AppColors.blue400,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    SecurityContent.badge,
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
              SecurityContent.pageTitle,
              style: isMobile
                  ? AppTypography.headingLG.copyWith(fontSize: 32)
                  : AppTypography.headingXL,
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: AppSpacing.lg),

            // Subheadline
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Text(
                SecurityContent.subtitle,
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

class _SecurityContent extends StatelessWidget {
  const _SecurityContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Overview Stats
        _SecurityCard(
          icon: LucideIcons.lock,
          title: SecurityContent.commitmentTitle,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                SecurityContent.commitmentDescription,
                style: AppTypography.bodyMD.copyWith(color: AppColors.gray300),
              ),
              const SizedBox(height: AppSpacing.lg),
              Wrap(
                spacing: AppSpacing.md,
                runSpacing: AppSpacing.md,
                children: SecurityContent.stats
                    .map((stat) => _StatCard(
                          value: stat.value,
                          label: stat.label,
                        ))
                    .toList(),
              ),
            ],
          ),
        ),

        // Authentication Security
        _SecurityCard(
          icon: LucideIcons.user,
          title: SecurityContent.authTitle,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                SecurityContent.authDescription,
                style: AppTypography.bodyMD.copyWith(color: AppColors.gray300),
              ),
              const SizedBox(height: AppSpacing.lg),
              ...SecurityContent.authFeatures
                  .map((f) => _ChecklistItem(title: f.title, desc: f.desc))
                  ,
            ],
          ),
        ),

        // Data Protection
        _SecurityCard(
          icon: LucideIcons.database,
          title: SecurityContent.dataProtectionTitle,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                SecurityContent.dataProtectionDescription,
                style: AppTypography.bodyMD.copyWith(color: AppColors.gray300),
              ),
              const SizedBox(height: AppSpacing.lg),
              _SubSection(
                title: 'Encryption',
                items: SecurityContent.encryptionItems,
              ),
              const SizedBox(height: AppSpacing.lg),
              _SubSection(
                title: 'Database Security',
                items: SecurityContent.databaseSecurityItems,
              ),
              const SizedBox(height: AppSpacing.lg),
              _WarningAlert(
                message: SecurityContent.secretsWarning,
              ),
            ],
          ),
        ),

        // Access Control
        _SecurityCard(
          icon: LucideIcons.key,
          title: SecurityContent.accessControlTitle,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                SecurityContent.accessControlDescription,
                style: AppTypography.bodyMD.copyWith(color: AppColors.gray300),
              ),
              const SizedBox(height: AppSpacing.lg),
              _SubSection(
                title: 'Role-Based Permissions',
                items: SecurityContent.rolePermissions,
              ),
            ],
          ),
        ),

        // API Security
        _SecurityCard(
          icon: LucideIcons.plug,
          title: SecurityContent.apiSecurityTitle,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                SecurityContent.apiSecurityDescription,
                style: AppTypography.bodyMD.copyWith(color: AppColors.gray300),
              ),
              const SizedBox(height: AppSpacing.lg),
              ...SecurityContent.apiFeatures
                  .map((f) => _ChecklistItem(title: f.title, desc: f.desc))
                  ,
            ],
          ),
        ),

        // Best Practices
        _SecurityCard(
          icon: LucideIcons.bookOpen,
          title: SecurityContent.bestPracticesTitle,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                SecurityContent.bestPracticesDescription,
                style: AppTypography.bodyMD.copyWith(color: AppColors.gray300),
              ),
              const SizedBox(height: AppSpacing.lg),
              _SubSection(
                title: 'Development Practices',
                items: SecurityContent.devPractices,
              ),
              const SizedBox(height: AppSpacing.lg),
              _SubSection(
                title: 'Operational Security',
                items: SecurityContent.opsPractices,
              ),
              const SizedBox(height: AppSpacing.lg),
              _SubSection(
                title: 'For Users',
                items: SecurityContent.userPractices,
              ),
            ],
          ),
        ),

        // Production Checklist
        _SecurityCard(
          icon: LucideIcons.clipboardCheck,
          title: SecurityContent.checklistTitle,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                SecurityContent.checklistDescription,
                style: AppTypography.bodyMD.copyWith(color: AppColors.gray300),
              ),
              const SizedBox(height: AppSpacing.lg),
              ...SecurityContent.productionChecklist
                  .map((f) => _ChecklistItem(title: f.title, desc: f.desc))
                  ,
            ],
          ),
        ),

        // Reporting
        _SecurityCard(
          icon: LucideIcons.alertTriangle,
          title: SecurityContent.reportingTitle,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                SecurityContent.reportingDescription,
                style: AppTypography.bodyMD.copyWith(color: AppColors.gray300),
              ),
              const SizedBox(height: AppSpacing.lg),
              _DangerAlert(
                message: SecurityContent.vulnerabilityWarning,
              ),
              const SizedBox(height: AppSpacing.lg),
              _ContactBox(),
            ],
          ),
        ),
      ],
    );
  }
}

class _SecurityCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget child;

  const _SecurityCard({
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

class _StatCard extends StatelessWidget {
  final String value;
  final String label;

  const _StatCard({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.gray700,
        borderRadius: BorderRadius.circular(AppSpacing.radiusSM),
      ),
      child: Column(
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

class _ChecklistItem extends StatelessWidget {
  final String title;
  final String desc;

  const _ChecklistItem({required this.title, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.gray700),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: AppColors.success,
              shape: BoxShape.circle,
            ),
            child: const Icon(LucideIcons.check, color: Colors.white, size: 14),
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
                const SizedBox(height: AppSpacing.xs),
                Text(
                  desc,
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

class _SubSection extends StatelessWidget {
  final String title;
  final List<String> items;

  const _SubSection({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTypography.bodyMD.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        ...items.map((item) => Padding(
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
                    child: Text(
                      item,
                      style: AppTypography.bodyMD.copyWith(
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

class _WarningAlert extends StatelessWidget {
  final String message;

  const _WarningAlert({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.warning.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppSpacing.radiusSM),
        border: Border.all(color: AppColors.warning),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(LucideIcons.alertTriangle, color: AppColors.warning, size: 20),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              message,
              style: AppTypography.bodyMD.copyWith(
                color: AppColors.warning,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DangerAlert extends StatelessWidget {
  final String message;

  const _DangerAlert({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppSpacing.radiusSM),
        border: Border.all(color: AppColors.error),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(LucideIcons.alertTriangle, color: AppColors.error, size: 20),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              message,
              style: AppTypography.bodyMD.copyWith(
                color: AppColors.error,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ContactBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.blue500.withValues(alpha: 0.1),
            AppColors.blue600.withValues(alpha: 0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(AppSpacing.radiusSM),
        border: Border.all(color: AppColors.blue500),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Security Contact',
            style: AppTypography.bodyLG.copyWith(
              color: AppColors.blue400,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Email: ${SecurityContent.securityEmail}',
            style: AppTypography.bodyMD.copyWith(color: AppColors.gray300),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Please include:',
            style: AppTypography.bodyMD.copyWith(color: AppColors.gray300),
          ),
          const SizedBox(height: AppSpacing.sm),
          ...SecurityContent.reportingIncludes.map((item) => Padding(
                padding: const EdgeInsets.only(
                  left: AppSpacing.md,
                  bottom: AppSpacing.xs,
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
                      child: Text(
                        item,
                        style: AppTypography.bodyMD.copyWith(
                          color: AppColors.gray300,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          const SizedBox(height: AppSpacing.md),
          Text(
            SecurityContent.responseTime,
            style: AppTypography.bodySM.copyWith(
              color: AppColors.gray400,
            ),
          ),
        ],
      ),
    );
  }
}

/// Security page content constants.
abstract final class SecurityContent {
  static const pageTitle = 'Security';
  static const subtitle = 'How we protect your data and maintain trust';
  static const badge = 'Enterprise Security';
  static const lastUpdated = 'Last Updated: January 2026';

  // Overview
  static const commitmentTitle = 'Our Security Commitment';
  static const commitmentDescription =
      'At ${CompanyInfo.name}, security is foundational to everything we do. '
      'As an AI observability platform, we understand the sensitive nature of '
      'your data and the trust you place in us.';

  static const stats = [
    (value: '256-bit', label: 'SSL/TLS Encryption'),
    (value: 'SOC 2', label: 'Compliant Infrastructure'),
    (value: '90 Days', label: 'Token Rotation'),
  ];

  // Authentication
  static const authTitle = 'Authentication Security';
  static const authDescription =
      'We use Auth0, an industry-leading identity platform, to secure user authentication.';

  static const authFeatures = [
    (
      title: 'OAuth 2.0 & OpenID Connect',
      desc: 'Industry-standard authentication protocols for secure identity verification'
    ),
    (
      title: 'Multi-Factor Authentication (MFA)',
      desc: 'Optional but recommended additional layer of security for all accounts'
    ),
    (
      title: 'Secure Token Storage',
      desc: 'Credentials stored in system keychain, never in code or plaintext files'
    ),
    (
      title: 'Session Management',
      desc: 'Automatic session expiration after 24 hours of inactivity'
    ),
    (
      title: 'Secure Logout',
      desc: 'Complete session termination and token invalidation on logout'
    ),
  ];

  // Data Protection
  static const dataProtectionTitle = 'Data Protection';
  static const dataProtectionDescription =
      'Your data is protected at rest and in transit using enterprise-grade security measures.';

  static const encryptionItems = [
    'In Transit: All data transmitted over HTTPS with TLS 1.3',
    'At Rest: Database encryption using AES-256',
    'Backups: Encrypted backups stored in geographically distributed locations',
  ];

  static const databaseSecurityItems = [
    'PostgreSQL with SSL/TLS connections required',
    'Prepared statements to prevent SQL injection',
    'Role-based access control for all database operations',
    'Regular automated backups with point-in-time recovery',
    'Connection pooling with secure credential management',
  ];

  static const secretsWarning =
      'Never commit sensitive data to version control. '
      'All credentials, API keys, and secrets are stored securely using Doppler for secrets management.';

  // Access Control
  static const accessControlTitle = 'Access Control';
  static const accessControlDescription =
      'We implement strict access controls to ensure only authorized users can access resources.';

  static const rolePermissions = [
    'Admin: Full system access, user management, configuration',
    'User: Standard application access, personal data management',
    'Guest: Limited read-only access to public resources',
  ];

  // API Security
  static const apiSecurityTitle = 'API Security';
  static const apiSecurityDescription =
      'All API endpoints are protected with multiple layers of security.';

  static const apiFeatures = [
    (
      title: 'Bearer Token Authentication',
      desc: 'JWT tokens required for all authenticated API requests'
    ),
    (title: 'Rate Limiting', desc: 'Protection against abuse and denial-of-service attacks'),
    (title: 'Input Validation', desc: 'All inputs sanitized and validated before processing'),
    (title: 'CORS Configuration', desc: 'Strict cross-origin resource sharing policies'),
    (
      title: 'Error Handling',
      desc: 'Error messages designed to not expose sensitive system information'
    ),
  ];

  // Best Practices
  static const bestPracticesTitle = 'Security Best Practices';
  static const bestPracticesDescription =
      'We follow industry best practices and continuously improve our security posture.';

  static const devPractices = [
    'Code reviews required for all changes',
    'Automated security scanning in CI/CD pipeline',
    'Dependency vulnerability monitoring',
    'Regular security audits and penetration testing',
  ];

  static const opsPractices = [
    'Principle of least privilege for all access',
    'Regular credential rotation (90-day cycle)',
    'Comprehensive audit logging',
    'Incident response procedures documented and tested',
  ];

  static const userPractices = [
    'Enable MFA on your account',
    'Use strong, unique passwords',
    'Log out when using shared devices',
    'Report suspicious activity immediately',
  ];

  // Production Checklist
  static const checklistTitle = 'Production Security Checklist';
  static const checklistDescription =
      'Before any deployment to production, we verify the following:';

  static const productionChecklist = [
    (title: 'Credentials in Doppler', desc: 'All secrets managed through Doppler, never in code'),
    (title: 'SSL/TLS Enabled', desc: 'HTTPS enforced for all connections'),
    (title: 'Database Backups Configured', desc: 'Automated daily backups with retention policy'),
    (title: 'Connection Pooling Optimized', desc: 'Database connections managed efficiently'),
    (title: 'Indexes Verified', desc: 'Database performance and security indexes in place'),
    (title: 'Activity Monitoring', desc: 'User activity logging and anomaly detection enabled'),
    (
      title: 'Error Logging',
      desc: 'Comprehensive logging without sensitive data exposure'
    ),
    (title: 'Rate Limiting Active', desc: 'API rate limits configured and tested'),
    (title: 'Auth0 Production Tenant', desc: 'Separate production Auth0 configuration active'),
  ];

  // Reporting
  static const reportingTitle = 'Reporting Security Issues';
  static const reportingDescription =
      'We take security vulnerabilities seriously and appreciate responsible disclosure.';

  static const vulnerabilityWarning =
      'Found a security vulnerability? Please report it immediately. '
      'Do not disclose publicly until we\'ve had a chance to address it.';

  static const securityEmail = 'security@integritystudio.ai';

  static const reportingIncludes = [
    'Description of the vulnerability',
    'Steps to reproduce',
    'Potential impact assessment',
    'Your contact information for follow-up',
  ];

  static const responseTime =
      'We aim to respond to security reports within 24 hours and will keep you informed of our progress.';
}
