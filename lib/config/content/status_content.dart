/// Status section content.
library;

import 'models.dart';
import 'constants.dart';

/// Status section content.
abstract final class StatusContentVariants {
  /// Current production content
  static const current = StatusContent(
    title: 'Platform Status',
    subtitle: 'Real-time operational health and performance metrics',
    statusBadge: 'All Systems Operational',
    allOperational: true,
    metrics: _metrics,
    services: _services,
    statusPageUrl: ExternalUrls.statusPage,
    statusPageCta: 'View Full Status Page',
  );

  static const _metrics = [
    StatusMetricContent(
      label: 'Uptime',
      value: PlatformMetrics.uptime,
      sublabel: PlatformMetrics.uptimeSla,
    ),
    StatusMetricContent(
      label: 'Traces Processed',
      value: PlatformMetrics.tracesProcessed,
      sublabel: PlatformMetrics.tracesProcessedPeriod,
    ),
    StatusMetricContent(
      label: 'AI Teams',
      value: PlatformMetrics.aiTeams,
      sublabel: 'Trusted By',
    ),
    StatusMetricContent(
      label: 'Setup Time',
      value: PlatformMetrics.setupTime,
      sublabel: PlatformMetrics.setupTimeLabel,
    ),
  ];

  static const _services = [
    StatusServiceContent(
      name: 'Trace Ingestion API',
      status: 'Operational',
    ),
    StatusServiceContent(
      name: 'Dashboard & Analytics',
      status: 'Operational',
    ),
    StatusServiceContent(
      name: 'Compliance Reporting',
      status: 'Operational',
    ),
    StatusServiceContent(
      name: 'Alerting System',
      status: 'Operational',
    ),
  ];
}
