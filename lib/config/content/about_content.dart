/// About section content.
library;

import 'package:lucide_icons/lucide_icons.dart';
import 'models.dart';
import 'constants.dart';

/// About section content.
abstract final class AboutContentVariants {
  /// Current production content
  static const current = AboutContent(
    sectionId: 'about',
    title: 'About ${CompanyInfo.name}',
    subtitle: 'Building Trust in AI Systems',
    missionStatement:
        'Empower enterprises to build trustworthy AI systems through comprehensive '
        'observability and governance tools.',
    visionStatement:
        'To be the standard for enterprise AI observability, enabling organizations '
        'to deploy AI confidently while meeting regulatory requirements.',
    story: _companyStory,
    values: _values,
    team: _team,
    locationCity: CompanyInfo.locationCity,
    locationRegion: CompanyInfo.locationRegion,
    foundedYear: CompanyInfo.foundedYear,
  );

  static const _companyStory =
      '${CompanyInfo.name} was founded with a clear purpose: to solve the visibility problem '
      'in production AI systems. As LLMs and AI agents became critical to business operations, '
      'we saw teams struggling with black-box AI decisions, unpredictable costs, and looming '
      'regulatory requirements like the EU AI Act.\n\n'
      'Our founders built observability tools at scale before, and recognized that AI systems '
      'needed purpose-built monitoring—not retrofitted APM solutions. We designed ${CompanyInfo.name} '
      'from the ground up for the unique challenges of LLM applications: token-level cost attribution, '
      'multi-step agent tracing, and compliance documentation that satisfies auditors.\n\n'
      'Today, we help AI teams ship reliable, compliant applications faster. Our platform provides '
      'the visibility they need to debug issues, optimize costs, and demonstrate governance to '
      'stakeholders—all from a single pane of glass.';

  static const _values = [
    CompanyValueContent(
      icon: LucideIcons.eye,
      title: 'Transparency',
      description:
          'We believe AI systems should be observable and explainable. Every decision, '
          'every cost, every outcome should be visible to the teams responsible for them.',
    ),
    CompanyValueContent(
      icon: LucideIcons.shieldCheck,
      title: 'Trust',
      description:
          'Trust is earned through reliability, security, and accountability. We build tools '
          'that help our customers demonstrate trustworthiness to their users and regulators.',
    ),
    CompanyValueContent(
      icon: LucideIcons.users,
      title: 'Developer-First',
      description:
          "Great tools should get out of the developer's way. We prioritize clean APIs, "
          'fast integration, and minimal overhead so teams can focus on building.',
    ),
    CompanyValueContent(
      icon: LucideIcons.scale,
      title: 'Compliance by Design',
      description:
          "Regulatory requirements shouldn't be an afterthought. We embed compliance "
          'capabilities into the platform so governance happens automatically.',
    ),
  ];

  static const _team = [
    TeamMemberContent(
      name: 'Alyshia Ledlie',
      role: 'Founder & CEO',
      bio:
          'Previously built observability infrastructure at scale. Passionate about making '
          'AI systems transparent and trustworthy for enterprises navigating regulatory change.',
      linkedInUrl: ExternalUrls.founderLinkedIn,
      twitterUrl: ExternalUrls.founderTwitter,
    ),
  ];
}
