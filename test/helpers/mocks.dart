import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:integrity_studio_ai/models/consent_preferences.dart';

// =============================================================================
// Mock Storage Service
// =============================================================================

/// Abstract storage interface for testability.
///
/// Allows mocking localStorage which isn't available in tests.
abstract class StorageService {
  String? get(String key);
  void set(String key, String value);
  void remove(String key);
}

/// Mock implementation of storage service for tests.
class MockStorageService extends Mock implements StorageService {
  final Map<String, String> _storage = {};

  @override
  String? get(String key) => _storage[key];

  @override
  void set(String key, String value) => _storage[key] = value;

  @override
  void remove(String key) => _storage.remove(key);

  void clear() => _storage.clear();
}

// =============================================================================
// Mock Analytics Tracker
// =============================================================================

/// Tracks analytics calls for verification in tests.
class MockAnalyticsTracker {
  final List<AnalyticsCall> calls = [];
  bool initialized = false;
  bool enabled = true;

  void trackEvent(String name, Map<String, dynamic> params) {
    if (initialized && enabled) {
      calls.add(AnalyticsCall(name, params));
    }
  }

  void initialize() {
    initialized = true;
  }

  void disable() {
    enabled = false;
  }

  void enable() {
    enabled = true;
  }

  void reset() {
    calls.clear();
    initialized = false;
    enabled = true;
  }

  bool hasEvent(String eventName) {
    return calls.any((c) => c.name == eventName);
  }

  AnalyticsCall? getEvent(String eventName) {
    try {
      return calls.firstWhere((c) => c.name == eventName);
    } catch (_) {
      return null;
    }
  }

  List<AnalyticsCall> getEvents(String eventName) {
    return calls.where((c) => c.name == eventName).toList();
  }
}

class AnalyticsCall {
  final String name;
  final Map<String, dynamic> params;
  final DateTime timestamp;

  AnalyticsCall(this.name, this.params) : timestamp = DateTime.now();

  @override
  String toString() => 'AnalyticsCall($name, $params)';
}

// =============================================================================
// Mock URL Launcher
// =============================================================================

/// Tracks URL launches for verification in tests.
class MockUrlLauncher {
  final List<String> launchedUrls = [];
  bool shouldSucceed = true;

  Future<bool> launch(String url) async {
    if (shouldSucceed) {
      launchedUrls.add(url);
      return true;
    }
    return false;
  }

  void reset() {
    launchedUrls.clear();
    shouldSucceed = true;
  }

  bool hasLaunched(String url) => launchedUrls.contains(url);
}

// =============================================================================
// Mock Consent Manager
// =============================================================================

/// Mock consent manager for controlling consent state in tests.
class MockConsentManager extends ChangeNotifier {
  ConsentPreferences? _preferences;
  bool _hasConsent = false;

  bool get hasConsent => _hasConsent;
  ConsentPreferences? get preferences => _preferences;

  void setConsent(ConsentPreferences prefs) {
    _preferences = prefs;
    _hasConsent = true;
    notifyListeners();
  }

  void clearConsent() {
    _preferences = null;
    _hasConsent = false;
    notifyListeners();
  }

  Future<void> saveConsent(ConsentPreferences prefs) async {
    setConsent(prefs);
  }

  Future<ConsentPreferences?> getStoredConsent() async {
    return _preferences;
  }
}

