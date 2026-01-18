import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integrity_studio_ai/theme/spacing.dart';

void main() {
  group('AppSpacing', () {
    group('base values', () {
      test('xs is 4', () {
        expect(AppSpacing.xs, equals(4));
      });

      test('sm is 8', () {
        expect(AppSpacing.sm, equals(8));
      });

      test('md is 16', () {
        expect(AppSpacing.md, equals(16));
      });

      test('lg is 24', () {
        expect(AppSpacing.lg, equals(24));
      });

      test('xl is 32', () {
        expect(AppSpacing.xl, equals(32));
      });

      test('xxl is 48', () {
        expect(AppSpacing.xxl, equals(48));
      });

      test('xxxl is 64', () {
        expect(AppSpacing.xxxl, equals(64));
      });

      test('section is 80', () {
        expect(AppSpacing.section, equals(80));
      });
    });

    group('container constraints', () {
      test('containerMaxWidth is 1280', () {
        expect(AppSpacing.containerMaxWidth, equals(1280));
      });

      test('containerPaddingMobile is 16', () {
        expect(AppSpacing.containerPaddingMobile, equals(16));
      });

      test('containerPaddingTablet is 24', () {
        expect(AppSpacing.containerPaddingTablet, equals(24));
      });

      test('containerPaddingDesktop is 32', () {
        expect(AppSpacing.containerPaddingDesktop, equals(32));
      });
    });

    group('section spacing', () {
      test('sectionVertical is 80', () {
        expect(AppSpacing.sectionVertical, equals(80));
      });

      test('sectionVerticalMobile is 48', () {
        expect(AppSpacing.sectionVerticalMobile, equals(48));
      });
    });

    group('card spacing', () {
      test('cardPadding is 24', () {
        expect(AppSpacing.cardPadding, equals(24));
      });

      test('cardPaddingMobile is 16', () {
        expect(AppSpacing.cardPaddingMobile, equals(16));
      });

      test('cardGap is 24', () {
        expect(AppSpacing.cardGap, equals(24));
      });

      test('cardGapMobile is 16', () {
        expect(AppSpacing.cardGapMobile, equals(16));
      });
    });

    group('form spacing', () {
      test('formFieldGap is 16', () {
        expect(AppSpacing.formFieldGap, equals(16));
      });

      test('formSectionGap is 32', () {
        expect(AppSpacing.formSectionGap, equals(32));
      });
    });

    group('border radius', () {
      test('radiusSM is 4', () {
        expect(AppSpacing.radiusSM, equals(4));
      });

      test('radiusMD is 8', () {
        expect(AppSpacing.radiusMD, equals(8));
      });

      test('radiusLG is 12', () {
        expect(AppSpacing.radiusLG, equals(12));
      });

      test('radiusXL is 16', () {
        expect(AppSpacing.radiusXL, equals(16));
      });

      test('radiusFull is 9999', () {
        expect(AppSpacing.radiusFull, equals(9999));
      });
    });

    group('EdgeInsets helpers', () {
      test('paddingXS returns correct EdgeInsets', () {
        expect(AppSpacing.paddingXS, equals(const EdgeInsets.all(4)));
      });

      test('paddingSM returns correct EdgeInsets', () {
        expect(AppSpacing.paddingSM, equals(const EdgeInsets.all(8)));
      });

      test('paddingMD returns correct EdgeInsets', () {
        expect(AppSpacing.paddingMD, equals(const EdgeInsets.all(16)));
      });

      test('paddingLG returns correct EdgeInsets', () {
        expect(AppSpacing.paddingLG, equals(const EdgeInsets.all(24)));
      });

      test('paddingXL returns correct EdgeInsets', () {
        expect(AppSpacing.paddingXL, equals(const EdgeInsets.all(32)));
      });

      test('horizontalMD returns correct EdgeInsets', () {
        expect(
          AppSpacing.horizontalMD,
          equals(const EdgeInsets.symmetric(horizontal: 16)),
        );
      });

      test('horizontalLG returns correct EdgeInsets', () {
        expect(
          AppSpacing.horizontalLG,
          equals(const EdgeInsets.symmetric(horizontal: 24)),
        );
      });

      test('verticalMD returns correct EdgeInsets', () {
        expect(
          AppSpacing.verticalMD,
          equals(const EdgeInsets.symmetric(vertical: 16)),
        );
      });

      test('verticalLG returns correct EdgeInsets', () {
        expect(
          AppSpacing.verticalLG,
          equals(const EdgeInsets.symmetric(vertical: 24)),
        );
      });

      test('verticalSection returns correct EdgeInsets', () {
        expect(
          AppSpacing.verticalSection,
          equals(const EdgeInsets.symmetric(vertical: 80)),
        );
      });
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
                final padding = AppSpacing.containerPadding(context);
                expect(padding, equals(AppSpacing.containerPaddingMobile));
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
                final padding = AppSpacing.containerPadding(context);
                expect(padding, equals(AppSpacing.containerPaddingTablet));
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
                final padding = AppSpacing.containerPadding(context);
                expect(padding, equals(AppSpacing.containerPaddingDesktop));
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
                final padding = AppSpacing.sectionPadding(context);
                expect(padding, equals(AppSpacing.sectionVerticalMobile));
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
                final padding = AppSpacing.sectionPadding(context);
                expect(padding, equals(AppSpacing.sectionVertical));
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
                final padding = AppSpacing.cardPaddingResponsive(context);
                expect(padding, equals(AppSpacing.cardPaddingMobile));
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
                final padding = AppSpacing.cardPaddingResponsive(context);
                expect(padding, equals(AppSpacing.cardPadding));
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
                final gap = AppSpacing.cardGapResponsive(context);
                expect(gap, equals(AppSpacing.cardGapMobile));
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
                final gap = AppSpacing.cardGapResponsive(context);
                expect(gap, equals(AppSpacing.cardGap));
                return const SizedBox();
              },
            ),
          ),
        );
      });
    });
  });

  group('Breakpoints', () {
    test('mobile is 0', () {
      expect(Breakpoints.mobile, equals(0));
    });

    test('mobileLarge is 480', () {
      expect(Breakpoints.mobileLarge, equals(480));
    });

    test('tablet is 768', () {
      expect(Breakpoints.tablet, equals(768));
    });

    test('tabletLarge is 900', () {
      expect(Breakpoints.tabletLarge, equals(900));
    });

    test('desktop is 1024', () {
      expect(Breakpoints.desktop, equals(1024));
    });

    test('wide is 1440', () {
      expect(Breakpoints.wide, equals(1440));
    });

    test('ultraWide is 1920', () {
      expect(Breakpoints.ultraWide, equals(1920));
    });
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

    testWidgets('gridColumns returns correct values', (tester) async {
      // Mobile
      tester.view.physicalSize = const Size(375, 667);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              expect(ResponsiveUtils.gridColumns(context), equals(1));
              return const SizedBox();
            },
          ),
        ),
      );

      // Tablet
      tester.view.physicalSize = const Size(800, 600);
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              expect(ResponsiveUtils.gridColumns(context), equals(2));
              return const SizedBox();
            },
          ),
        ),
      );

      // Desktop
      tester.view.physicalSize = const Size(1200, 800);
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              expect(ResponsiveUtils.gridColumns(context), equals(3));
              return const SizedBox();
            },
          ),
        ),
      );

      // Wide
      tester.view.physicalSize = const Size(1600, 900);
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              expect(ResponsiveUtils.gridColumns(context), equals(4));
              return const SizedBox();
            },
          ),
        ),
      );

      addTearDown(tester.view.resetPhysicalSize);
    });
  });
}
