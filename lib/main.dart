import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'app.dart';
import 'services/consent_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Sentry for error tracking
  await SentryFlutter.init(
    (options) {
      options.dsn = const String.fromEnvironment('SENTRY_DSN');
      options.tracesSampleRate = 0.2;
      options.environment = const String.fromEnvironment(
        'ENVIRONMENT',
        defaultValue: 'development',
      );
    },
    appRunner: () => runApp(const IntegrityStudioApp()),
  );
}
