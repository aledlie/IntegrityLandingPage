import 'package:dio/dio.dart';

/// Mock contact service for integration tests.
///
/// Tracks method calls without making actual HTTP requests.
class MockContactService {
  bool submitCalled = false;
  bool validateCalled = false;
  Map<String, dynamic>? lastSubmittedData;

  void reset() {
    submitCalled = false;
    validateCalled = false;
    lastSubmittedData = null;
  }
}

/// Mock analytics tracker for integration tests.
class MockAnalyticsTracker {
  final List<String> pageViews = [];
  final List<Map<String, dynamic>> events = [];

  void trackPageView(String page) {
    pageViews.add(page);
  }

  void trackEvent(String name, Map<String, dynamic> properties) {
    events.add({'name': name, ...properties});
  }

  void reset() {
    pageViews.clear();
    events.clear();
  }

  bool hasPageView(String page) => pageViews.contains(page);
  bool hasEvent(String name) => events.any((e) => e['name'] == name);
}

/// Mock consent manager for integration tests.
class MockConsentManager {
  bool _hasConsent = false;
  Map<String, bool> _preferences = {};

  bool hasConsent() => _hasConsent;

  void saveConsent({
    required bool analytics,
    required bool marketing,
  }) {
    _hasConsent = true;
    _preferences = {
      'analytics': analytics,
      'marketing': marketing,
    };
  }

  void revokeConsent() {
    _hasConsent = false;
    _preferences.clear();
  }

  Map<String, bool> get preferences => _preferences;

  void reset() {
    _hasConsent = false;
    _preferences.clear();
  }
}

/// Creates a mock Dio instance for testing contact service.
Dio createMockDio({
  int statusCode = 200,
  Map<String, dynamic>? responseData,
}) {
  final dio = Dio();
  dio.options.baseUrl = 'https://test.example.com';
  return dio;
}

/// Global mocks instance for tests.
class IntegrationMocks {
  static final contactService = MockContactService();
  static final analytics = MockAnalyticsTracker();
  static final consent = MockConsentManager();

  static void resetAll() {
    contactService.reset();
    analytics.reset();
    consent.reset();
  }
}
