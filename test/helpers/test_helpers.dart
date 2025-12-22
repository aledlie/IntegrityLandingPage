import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:integrity_studio_ai/theme/colors.dart';
import 'package:integrity_studio_ai/controllers/landing_controller.dart';
import 'mocks.dart';

// Default theme for testing
final ThemeData testTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColors.gray900,
  colorScheme: ColorScheme.dark(
    primary: AppColors.blue500,
    secondary: AppColors.purple500,
    surface: AppColors.gray800,
  ),
);

// =============================================================================
// Widget Test Wrappers
// =============================================================================

/// Wraps a widget in MaterialApp for testing.
Widget testableWidget(Widget child, {ThemeData? theme}) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: theme ?? testTheme,
    home: Scaffold(body: child),
  );
}

/// Wraps a section widget for testing.
///
/// Provides scroll context since sections are typically in ScrollView.
Widget testableSection(Widget section, {ThemeData? theme}) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: theme ?? testTheme,
    home: Scaffold(
      body: SingleChildScrollView(
        child: section,
      ),
    ),
  );
}

/// Wraps widget with providers for testing.
Widget testableWidgetWithProviders(
  Widget child, {
  LandingController? landingController,
  MockConsentManager? consentManager,
}) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: testTheme,
    home: MultiProvider(
      providers: [
        if (landingController != null)
          ChangeNotifierProvider<LandingController>.value(
            value: landingController,
          ),
        if (consentManager != null)
          ChangeNotifierProvider<MockConsentManager>.value(
            value: consentManager,
          ),
      ],
      child: Scaffold(body: child),
    ),
  );
}

// =============================================================================
// WidgetTester Extensions
// =============================================================================

extension WidgetTesterX on WidgetTester {
  /// Pump widget wrapped in MaterialApp.
  Future<void> pumpApp(Widget widget) async {
    await pumpWidget(testableWidget(widget));
    await pumpAndSettle();
  }

  /// Pump section widget with scroll support.
  Future<void> pumpSection(Widget section) async {
    await pumpWidget(testableSection(section));
    await pumpAndSettle();
  }

  /// Pump widget with providers.
  Future<void> pumpAppWithProviders(
    Widget widget, {
    LandingController? landingController,
    MockConsentManager? consentManager,
  }) async {
    await pumpWidget(
      testableWidgetWithProviders(
        widget,
        landingController: landingController,
        consentManager: consentManager,
      ),
    );
    await pumpAndSettle();
  }

  /// Scroll until widget is visible.
  Future<void> scrollUntilVisible(
    Finder finder, {
    double delta = 100,
    int maxScrolls = 50,
  }) async {
    int scrollCount = 0;
    while (!finder.evaluate().isNotEmpty && scrollCount < maxScrolls) {
      await drag(find.byType(SingleChildScrollView), Offset(0, -delta));
      await pumpAndSettle();
      scrollCount++;
    }
  }

  /// Wait for animations to complete with timeout.
  Future<void> pumpAndSettleWithTimeout({
    Duration timeout = const Duration(seconds: 5),
  }) async {
    await pumpAndSettle(
      const Duration(milliseconds: 100),
      EnginePhase.sendSemanticsUpdate,
      timeout,
    );
  }
}

// =============================================================================
// Finder Extensions
// =============================================================================

extension FinderX on CommonFinders {
  /// Find widget by semantic label.
  Finder bySemanticsLabel(String label) {
    return find.bySemanticsLabel(label);
  }

  /// Find text widget containing substring.
  Finder textContaining(String substring) {
    return find.textContaining(substring);
  }

  /// Find widget by type and text.
  Finder widgetWithText<T extends Widget>(String text) {
    return find.widgetWithText(T, text);
  }
}

// =============================================================================
// Test Utilities
// =============================================================================

/// Creates a test window size for responsive testing.
void setScreenSize(WidgetTester tester, Size size) {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1.0;
  addTearDown(() {
    tester.view.resetPhysicalSize();
    tester.view.resetDevicePixelRatio();
  });
}

/// Common screen sizes for responsive testing.
class TestScreenSizes {
  static const Size mobile = Size(375, 812); // iPhone X
  static const Size tablet = Size(768, 1024); // iPad
  static const Size desktop = Size(1440, 900); // Laptop
  static const Size desktopLarge = Size(1920, 1080); // Full HD
}

/// Set mobile viewport.
void setMobileSize(WidgetTester tester) {
  setScreenSize(tester, TestScreenSizes.mobile);
}

/// Set tablet viewport.
void setTabletSize(WidgetTester tester) {
  setScreenSize(tester, TestScreenSizes.tablet);
}

/// Set desktop viewport.
void setDesktopSize(WidgetTester tester) {
  setScreenSize(tester, TestScreenSizes.desktop);
}

// =============================================================================
// Assertion Helpers
// =============================================================================

/// Verify widget has expected text style.
void expectTextStyle(
  WidgetTester tester,
  Finder finder, {
  Color? color,
  double? fontSize,
  FontWeight? fontWeight,
}) {
  final widget = tester.widget<Text>(finder);
  final style = widget.style;

  if (color != null) {
    expect(style?.color, equals(color));
  }
  if (fontSize != null) {
    expect(style?.fontSize, equals(fontSize));
  }
  if (fontWeight != null) {
    expect(style?.fontWeight, equals(fontWeight));
  }
}

/// Verify container has expected decoration.
void expectContainerDecoration(
  WidgetTester tester,
  Finder finder, {
  Color? color,
  BorderRadius? borderRadius,
}) {
  final widget = tester.widget<Container>(finder);
  final decoration = widget.decoration as BoxDecoration?;

  if (color != null) {
    expect(decoration?.color, equals(color));
  }
  if (borderRadius != null) {
    expect(decoration?.borderRadius, equals(borderRadius));
  }
}

// =============================================================================
// Test Data Generators
// =============================================================================

/// Generate test consent preferences.
class TestData {
  static Map<String, dynamic> consentJson({
    bool essential = true,
    bool analytics = true,
    bool marketing = false,
  }) {
    return {
      'essential': essential,
      'analytics': analytics,
      'marketing': marketing,
      'timestamp': DateTime.now().toIso8601String(),
      'consentVersion': '1.0',
    };
  }

  static Map<String, dynamic> acceptAllConsentJson() {
    return consentJson(analytics: true, marketing: true);
  }

  static Map<String, dynamic> essentialOnlyConsentJson() {
    return consentJson(analytics: false, marketing: false);
  }
}
