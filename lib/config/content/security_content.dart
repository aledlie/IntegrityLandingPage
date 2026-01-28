/// Security page content.
library;

import 'constants.dart';

/// Security feature item with title and description.
class SecurityFeatureItem {
  final String title;
  final String desc;

  const SecurityFeatureItem({required this.title, required this.desc});
}

/// Security stat item with value and label.
class SecurityStatItem {
  final String value;
  final String label;

  const SecurityStatItem({required this.value, required this.label});
}

/// Security page content constants.
abstract final class SecurityContent {
  // Page Header
  static const pageTitle = 'Security';
  static const subtitle = 'How we protect your data and maintain trust';
  static const badge = 'Enterprise Security';
  static const lastUpdated = 'Last Updated: January 2026';

  // Overview Section
  static const commitmentTitle = 'Our Security Commitment';
  static const commitmentDescription =
      'At ${CompanyInfo.name}, security is foundational to everything we do. '
      'As an AI observability platform, we understand the sensitive nature of '
      'your data and the trust you place in us.';

  static const stats = [
    SecurityStatItem(value: '256-bit', label: 'SSL/TLS Encryption'),
    SecurityStatItem(value: 'SOC 2', label: 'Compliant Infrastructure'),
    SecurityStatItem(value: '60 Days', label: 'Token Rotation'),
  ];

  // Authentication Section
  static const authTitle = 'Authentication Security';
  static const authDescription =
      'We use Auth0, an industry-leading identity platform, to secure user authentication.';

  static const authFeatures = [
    SecurityFeatureItem(
      title: 'OAuth 2.0 & OpenID Connect',
      desc: 'Industry-standard authentication protocols for secure identity verification',
    ),
    SecurityFeatureItem(
      title: 'Multi-Factor Authentication (MFA)',
      desc: 'Optional but recommended additional layer of security for all accounts',
    ),
    SecurityFeatureItem(
      title: 'Secure Token Storage',
      desc: 'Credentials stored in system keychain, never in code or plaintext files',
    ),
    SecurityFeatureItem(
      title: 'Session Management',
      desc: 'Automatic session expiration after 24 hours of inactivity',
    ),
    SecurityFeatureItem(
      title: 'Secure Logout',
      desc: 'Complete session termination and token invalidation on logout',
    ),
  ];

  // Data Protection Section
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
      'All credentials, API keys, and secrets are stored securely via a best in class, '
      'multi-layer and triple-factor authentication system.';

  // Access Control Section
  static const accessControlTitle = 'Access Control';
  static const accessControlDescription =
      'We implement strict access controls to ensure only authorized users can access resources.';

  static const rolePermissions = [
    'Admin: Full system access, user management, configuration',
    'User: Standard application access, personal data management',
    'Guest: Limited read-only access to public resources',
  ];

  // Enterprise Identity Section
  static const enterpriseIdentityTitle = 'Enterprise Identity & Access';
  static const enterpriseIdentityDescription =
      'For organizations that demand seamless integration with existing identity infrastructure, '
      'we provide enterprise-grade single sign-on and granular access controls that scale with your team.';

  static const enterpriseIdentityFeatures = [
    SecurityFeatureItem(
      title: 'SSO & SAML Integration',
      desc: 'Connect your existing identity provider—Okta, Azure AD, Google Workspace—for '
          'frictionless authentication across your organization',
    ),
    SecurityFeatureItem(
      title: 'Advanced RBAC',
      desc: 'Define custom roles with fine-grained permissions that map to your organizational '
          'structure, from individual contributors to security teams',
    ),
    SecurityFeatureItem(
      title: 'Comprehensive Audit Logging',
      desc: 'Every action is tracked and searchable—who accessed what, when, and from where—giving '
          'you complete visibility for security reviews and incident investigations',
    ),
  ];

  // Compliance & Governance Section
  static const complianceTitle = 'Compliance & Governance';
  static const complianceDescription =
      "Meeting regulatory requirements shouldn't slow you down. Our compliance framework is "
      'designed to give you confidence that your AI observability data meets the highest standards '
      'of security and privacy.';

  static const complianceFeatures = [
    SecurityFeatureItem(
      title: 'SOC 2 Type II Certified',
      desc: 'Independent verification of our security controls, ensuring your data is protected '
          'by processes that meet rigorous industry standards',
    ),
    SecurityFeatureItem(
      title: 'Intelligent Data Retention',
      desc: 'Configure retention policies that align with your compliance requirements—automatically '
          'archive or purge data based on age, sensitivity, or regulatory mandates',
    ),
    SecurityFeatureItem(
      title: 'PII Detection & Redaction',
      desc: 'AI-powered scanning automatically identifies and redacts sensitive personal information '
          'in your traces and logs before it ever hits storage',
    ),
    SecurityFeatureItem(
      title: 'Compliance Dashboards',
      desc: 'Real-time visibility into your compliance posture with exportable reports for auditors '
          'and stakeholders',
    ),
  ];

  // Enterprise Capabilities Section
  static const enterpriseCapabilitiesTitle = 'Enterprise-Grade Capabilities';
  static const enterpriseCapabilitiesDescription =
      'When your AI systems are mission-critical, you need observability that goes beyond monitoring. '
      'Our enterprise features help you stay ahead of issues before they impact your users.';

  static const enterpriseCapabilities = [
    SecurityFeatureItem(
      title: 'ML-Powered Anomaly Detection',
      desc: "Our algorithms learn your system's normal behavior and alert you to deviations—catching "
          'performance regressions, cost spikes, and quality drift before they become incidents',
    ),
    SecurityFeatureItem(
      title: 'SLA Dashboards & Reporting',
      desc: 'Track performance against your service level agreements with customizable dashboards, '
          'automated alerting on SLA breaches, and executive-ready reports',
    ),
    SecurityFeatureItem(
      title: 'VPC & Private Deployment',
      desc: 'For organizations with strict data residency requirements, deploy ${CompanyInfo.name} '
          'within your own cloud infrastructure with full data isolation',
    ),
  ];

  // API Security Section
  static const apiSecurityTitle = 'API Security';
  static const apiSecurityDescription =
      'All API endpoints are protected with multiple layers of security.';

  static const apiFeatures = [
    SecurityFeatureItem(
      title: 'Bearer Token Authentication',
      desc: 'JWT tokens required for all authenticated API requests',
    ),
    SecurityFeatureItem(
      title: 'Rate Limiting',
      desc: 'Protection against abuse and denial-of-service attacks',
    ),
    SecurityFeatureItem(
      title: 'Input Validation',
      desc: 'All inputs sanitized and validated before processing',
    ),
    SecurityFeatureItem(
      title: 'CORS Configuration',
      desc: 'Strict cross-origin resource sharing policies',
    ),
    SecurityFeatureItem(
      title: 'Error Handling',
      desc: 'Error messages designed to not expose sensitive system information',
    ),
  ];

  // Best Practices Section
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
    'Regular credential rotation (60-day cycle)',
    'Comprehensive audit logging',
    'Incident response procedures documented and tested',
  ];

  static const userPractices = [
    'Enable MFA on your account',
    'Use strong, unique passwords',
    'Log out when using shared devices',
    'Report suspicious activity immediately',
  ];

  // Production Checklist Section
  static const checklistTitle = 'Production Security Checklist';
  static const checklistDescription =
      'Before any deployment to production, we verify the following:';

  static const productionChecklist = [
    SecurityFeatureItem(
      title: 'Secure Credential Storage',
      desc: 'All secrets managed through multi-layer authentication, never in code',
    ),
    SecurityFeatureItem(
      title: 'SSL/TLS Enabled',
      desc: 'HTTPS enforced for all connections',
    ),
    SecurityFeatureItem(
      title: 'Database Backups Configured',
      desc: 'Automated daily backups with retention policy',
    ),
    SecurityFeatureItem(
      title: 'Connection Pooling Optimized',
      desc: 'Database connections managed efficiently',
    ),
    SecurityFeatureItem(
      title: 'Indexes Verified',
      desc: 'Database performance and security indexes in place',
    ),
    SecurityFeatureItem(
      title: 'Activity Monitoring',
      desc: 'User activity logging and anomaly detection enabled',
    ),
    SecurityFeatureItem(
      title: 'Error Logging',
      desc: 'Comprehensive logging without sensitive data exposure',
    ),
    SecurityFeatureItem(
      title: 'Rate Limiting Active',
      desc: 'API rate limits configured and tested',
    ),
    SecurityFeatureItem(
      title: 'Auth0 Production Tenant',
      desc: 'Separate production Auth0 configuration active',
    ),
  ];

  // Reporting Section
  static const reportingTitle = 'Reporting Security Issues';
  static const reportingDescription =
      'We take security vulnerabilities seriously and appreciate responsible disclosure.';

  static const vulnerabilityWarning =
      'Found a security vulnerability? Please report it immediately. '
      "Do not disclose publicly until we've had a chance to address it.";

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
