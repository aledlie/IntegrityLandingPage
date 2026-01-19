import 'dart:async';
import 'package:google_fonts/google_fonts.dart';

/// Global test configuration that runs before all tests.
///
/// This file is automatically detected by the Flutter test framework.
Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  // Disable Google Fonts network fetching in tests to avoid flaky tests
  // and network-related errors.
  GoogleFonts.config.allowRuntimeFetching = false;

  await testMain();
}
