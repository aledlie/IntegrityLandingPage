import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integrity_studio_ai/theme/spacing.dart';

void main() {
  group('AppSpacing', () {
    group('spacing values', () {
      final spacingValues = <String, (double, double)>{
        // Base spacing
        'xs': (AppSpacing.xs, 4),
        'sm': (AppSpacing.sm, 8),
        'md': (AppSpacing.md, 16),
        'lg': (AppSpacing.lg, 24),
        'xl': (AppSpacing.xl, 32),
        'xxl': (AppSpacing.xxl, 48),
        'xxxl': (AppSpacing.xxxl, 64),
        'section': (AppSpacing.section, 80),
        // Container constraints
        'containerMaxWidth': (AppSpacing.containerMaxWidth, 1280),
        'containerPaddingMobile': (AppSpacing.containerPaddingMobile, 16),
        'containerPaddingTablet': (AppSpacing.containerPaddingTablet, 24),
        'containerPaddingDesktop': (AppSpacing.containerPaddingDesktop, 32),
        // Section spacing
        'sectionVertical': (AppSpacing.sectionVertical, 80),
        'sectionVerticalMobile': (AppSpacing.sectionVerticalMobile, 48),
        // Card spacing
        'cardPadding': (AppSpacing.cardPadding, 24),
        'cardPaddingMobile': (AppSpacing.cardPaddingMobile, 16),
        'cardGap': (AppSpacing.cardGap, 24),
        'cardGapMobile': (AppSpacing.cardGapMobile, 16),
        // Form spacing
        'formFieldGap': (AppSpacing.formFieldGap, 16),
        'formSectionGap': (AppSpacing.formSectionGap, 32),
        // Border radius
        'radiusSM': (AppSpacing.radiusSM, 4),
        'radiusMD': (AppSpacing.radiusMD, 8),
        'radiusLG': (AppSpacing.radiusLG, 12),
        'radiusXL': (AppSpacing.radiusXL, 16),
        'radiusFull': (AppSpacing.radiusFull, 9999),
      };

      for (final entry in spacingValues.entries) {
        test('${entry.key} equals ${entry.value.$2}', () {
          expect(entry.value.$1, equals(entry.value.$2));
        });
      }
    });

    group('EdgeInsets helpers', () {
      final edgeInsetsValues = <String, (EdgeInsets, EdgeInsets)>{
        'paddingXS': (AppSpacing.paddingXS, const EdgeInsets.all(4)),
        'paddingSM': (AppSpacing.paddingSM, const EdgeInsets.all(8)),
        'paddingMD': (AppSpacing.paddingMD, const EdgeInsets.all(16)),
        'paddingLG': (AppSpacing.paddingLG, const EdgeInsets.all(24)),
        'paddingXL': (AppSpacing.paddingXL, const EdgeInsets.all(32)),
        'horizontalMD': (AppSpacing.horizontalMD, const EdgeInsets.symmetric(horizontal: 16)),
        'horizontalLG': (AppSpacing.horizontalLG, const EdgeInsets.symmetric(horizontal: 24)),
        'verticalMD': (AppSpacing.verticalMD, const EdgeInsets.symmetric(vertical: 16)),
        'verticalLG': (AppSpacing.verticalLG, const EdgeInsets.symmetric(vertical: 24)),
        'verticalSection': (AppSpacing.verticalSection, const EdgeInsets.symmetric(vertical: 80)),
      };

      for (final entry in edgeInsetsValues.entries) {
        test('${entry.key} returns correct EdgeInsets', () {
          expect(entry.value.$1, equals(entry.value.$2));
        });
      }
    });

    group('responsive helpers', () {
      testWidgets('containerPadding returns mobile value for small screens', (tester) async {
        tester.view.physicalSize = const Size(375, 667);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);

        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                expect(AppSpacing.containerPadding(context), equals(AppSpacing.containerPaddingMobile));
                return const SizedBox();
              },
            ),
          ),
        );
      });

      testWidgets('containerPadding returns tablet value for medium screens', (tester) async {
        tester.view.physicalSize = const Size(800, 600);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);

        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                expect(AppSpacing.containerPadding(context), equals(AppSpacing.containerPaddingTablet));
                return const SizedBox();
              },
            ),
          ),
        );
      });

      testWidgets('containerPadding returns desktop value for large screens', (tester) async {
        tester.view.physicalSize = const Size(1440, 900);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);

        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                expect(AppSpacing.containerPadding(context), equals(AppSpacing.containerPaddingDesktop));
                return const SizedBox();
              },
            ),
          ),
        );
      });

      testWidgets('sectionPadding returns mobile value for small screens', (tester) async {
        tester.view.physicalSize = const Size(375, 667);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);

        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                expect(AppSpacing.sectionPadding(context), equals(AppSpacing.sectionVerticalMobile));
                return const SizedBox();
              },
            ),
          ),
        );
      });

      testWidgets('sectionPadding returns desktop value for large screens', (tester) async {
        tester.view.physicalSize = const Size(1440, 900);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);

        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                expect(AppSpacing.sectionPadding(context), equals(AppSpacing.sectionVertical));
                return const SizedBox();
              },
            ),
          ),
        );
      });

      testWidgets('cardPaddingResponsive returns mobile value for small screens', (tester) async {
        tester.view.physicalSize = const Size(375, 667);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);

        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                expect(AppSpacing.cardPaddingResponsive(context), equals(AppSpacing.cardPaddingMobile));
                return const SizedBox();
              },
            ),
          ),
        );
      });

      testWidgets('cardPaddingResponsive returns desktop value for large screens', (tester) async {
        tester.view.physicalSize = const Size(1440, 900);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);

        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                expect(AppSpacing.cardPaddingResponsive(context), equals(AppSpacing.cardPadding));
                return const SizedBox();
              },
            ),
          ),
        );
      });

      testWidgets('cardGapResponsive returns mobile value for small screens', (tester) async {
        tester.view.physicalSize = const Size(375, 667);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);

        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                expect(AppSpacing.cardGapResponsive(context), equals(AppSpacing.cardGapMobile));
                return const SizedBox();
              },
            ),
          ),
        );
      });

      testWidgets('cardGapResponsive returns desktop value for large screens', (tester) async {
        tester.view.physicalSize = const Size(1440, 900);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);

        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                expect(AppSpacing.cardGapResponsive(context), equals(AppSpacing.cardGap));
                return const SizedBox();
              },
            ),
          ),
        );
      });
    });
  });

  group('Breakpoints', () {
    final breakpointValues = <String, (double, double)>{
      'mobile': (Breakpoints.mobile, 0),
      'mobileLarge': (Breakpoints.mobileLarge, 480),
      'tablet': (Breakpoints.tablet, 768),
      'tabletLarge': (Breakpoints.tabletLarge, 900),
      'desktop': (Breakpoints.desktop, 1024),
      'wide': (Breakpoints.wide, 1440),
      'ultraWide': (Breakpoints.ultraWide, 1920),
    };

    for (final entry in breakpointValues.entries) {
      test('${entry.key} equals ${entry.value.$2}', () {
        expect(entry.value.$1, equals(entry.value.$2));
      });
    }
  });

  group('ResponsiveUtils', () {
    testWidgets('isMobile returns true for mobile screens', (tester) async {
      tester.view.physicalSize = const Size(375, 667);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              expect(ResponsiveUtils.isMobile(context), isTrue);
              expect(ResponsiveUtils.isTablet(context), isFalse);
              expect(ResponsiveUtils.isDesktop(context), isFalse);
              return const SizedBox();
            },
          ),
        ),
      );
    });

    testWidgets('isTablet returns true for tablet screens', (tester) async {
      tester.view.physicalSize = const Size(800, 600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              expect(ResponsiveUtils.isMobile(context), isFalse);
              expect(ResponsiveUtils.isTablet(context), isTrue);
              expect(ResponsiveUtils.isDesktop(context), isFalse);
              return const SizedBox();
            },
          ),
        ),
      );
    });

    testWidgets('isDesktop returns true for desktop screens', (tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              expect(ResponsiveUtils.isMobile(context), isFalse);
              expect(ResponsiveUtils.isTablet(context), isFalse);
              expect(ResponsiveUtils.isDesktop(context), isTrue);
              return const SizedBox();
            },
          ),
        ),
      );
    });

    testWidgets('isWide returns true for wide screens', (tester) async {
      tester.view.physicalSize = const Size(1600, 900);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              expect(ResponsiveUtils.isWide(context), isTrue);
              return const SizedBox();
            },
          ),
        ),
      );
    });

    testWidgets('responsive returns correct value for mobile', (tester) async {
      tester.view.physicalSize = const Size(375, 667);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              final result = ResponsiveUtils.responsive(
                context,
                mobile: 'mobile',
                tablet: 'tablet',
                desktop: 'desktop',
                wide: 'wide',
              );
              expect(result, equals('mobile'));
              return const SizedBox();
            },
          ),
        ),
      );
    });

    testWidgets('responsive returns correct value for tablet', (tester) async {
      tester.view.physicalSize = const Size(800, 600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              final result = ResponsiveUtils.responsive(
                context,
                mobile: 'mobile',
                tablet: 'tablet',
                desktop: 'desktop',
              );
              expect(result, equals('tablet'));
              return const SizedBox();
            },
          ),
        ),
      );
    });

    testWidgets('responsive returns correct value for desktop', (tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              final result = ResponsiveUtils.responsive(
                context,
                mobile: 'mobile',
                tablet: 'tablet',
                desktop: 'desktop',
              );
              expect(result, equals('desktop'));
              return const SizedBox();
            },
          ),
        ),
      );
    });

    testWidgets('responsive returns correct value for wide', (tester) async {
      tester.view.physicalSize = const Size(1600, 900);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              final result = ResponsiveUtils.responsive(
                context,
                mobile: 'mobile',
                wide: 'wide',
              );
              expect(result, equals('wide'));
              return const SizedBox();
            },
          ),
        ),
      );
    });

    testWidgets('gridColumns returns correct values for all breakpoints', (tester) async {
      final screenConfigs = <String, (Size, int)>{
        'mobile': (const Size(375, 667), 1),
        'tablet': (const Size(800, 600), 2),
        'desktop': (const Size(1200, 800), 3),
        'wide': (const Size(1600, 900), 4),
      };

      for (final config in screenConfigs.entries) {
        tester.view.physicalSize = config.value.$1;
        tester.view.devicePixelRatio = 1.0;

        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                expect(
                  ResponsiveUtils.gridColumns(context),
                  equals(config.value.$2),
                  reason: '${config.key} should have ${config.value.$2} columns',
                );
                return const SizedBox();
              },
            ),
          ),
        );
      }

      addTearDown(tester.view.resetPhysicalSize);
    });
  });
}
