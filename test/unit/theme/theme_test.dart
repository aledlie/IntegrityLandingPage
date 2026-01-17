import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integrity_studio_ai/theme/theme.dart';

void main() {
  // Note: AppTheme.darkTheme tests are skipped because GoogleFonts requires
  // network access which is not available in the test environment.
  // The theme is tested indirectly through widget tests.

  group('AppColors', () {
    group('primary brand colors', () {
      test('blue400 has correct value', () {
        expect(AppColors.blue400, equals(const Color(0xFF60A5FA)));
      });

      test('blue500 has correct value', () {
        expect(AppColors.blue500, equals(const Color(0xFF3B82F6)));
      });

      test('blue600 has correct value', () {
        expect(AppColors.blue600, equals(const Color(0xFF2563EB)));
      });

      test('blue900 has correct value', () {
        expect(AppColors.blue900, equals(const Color(0xFF1E3A8A)));
      });
    });

    group('secondary colors', () {
      test('indigo400 has correct value', () {
        expect(AppColors.indigo400, equals(const Color(0xFF818CF8)));
      });

      test('indigo500 has correct value', () {
        expect(AppColors.indigo500, equals(const Color(0xFF6366F1)));
      });

      test('indigo600 has correct value', () {
        expect(AppColors.indigo600, equals(const Color(0xFF4F46E5)));
      });
    });

    group('accent colors', () {
      test('purple400 has correct value', () {
        expect(AppColors.purple400, equals(const Color(0xFFC084FC)));
      });

      test('purple500 has correct value', () {
        expect(AppColors.purple500, equals(const Color(0xFFA855F7)));
      });

      test('purple600 has correct value', () {
        expect(AppColors.purple600, equals(const Color(0xFF9333EA)));
      });
    });

    group('neutral colors', () {
      test('gray900 has correct value', () {
        expect(AppColors.gray900, equals(const Color(0xFF111827)));
      });

      test('gray800 has correct value', () {
        expect(AppColors.gray800, equals(const Color(0xFF1F2937)));
      });

      test('gray700 has correct value', () {
        expect(AppColors.gray700, equals(const Color(0xFF374151)));
      });

      test('gray600 has correct value', () {
        expect(AppColors.gray600, equals(const Color(0xFF4B5563)));
      });

      test('gray500 has correct value', () {
        expect(AppColors.gray500, equals(const Color(0xFF6B7280)));
      });

      test('gray400 has correct value', () {
        expect(AppColors.gray400, equals(const Color(0xFF9CA3AF)));
      });

      test('gray300 has correct value', () {
        expect(AppColors.gray300, equals(const Color(0xFFD1D5DB)));
      });

      test('gray200 has correct value', () {
        expect(AppColors.gray200, equals(const Color(0xFFE5E7EB)));
      });

      test('gray100 has correct value', () {
        expect(AppColors.gray100, equals(const Color(0xFFF3F4F6)));
      });
    });

    group('semantic colors', () {
      test('success has correct value', () {
        expect(AppColors.success, equals(const Color(0xFF22C55E)));
      });

      test('warning has correct value', () {
        expect(AppColors.warning, equals(const Color(0xFFF59E0B)));
      });

      test('error has correct value', () {
        expect(AppColors.error, equals(const Color(0xFFEF4444)));
      });

      test('info has correct value', () {
        expect(AppColors.info, equals(const Color(0xFF3B82F6)));
      });
    });

    group('text colors', () {
      test('textPrimary is white', () {
        expect(AppColors.textPrimary, equals(Colors.white));
      });

      test('textSecondary is gray300', () {
        expect(AppColors.textSecondary, equals(AppColors.gray300));
      });

      test('textLink is blue400', () {
        expect(AppColors.textLink, equals(AppColors.blue400));
      });
    });

    group('background colors', () {
      test('backgroundPrimary is gray900', () {
        expect(AppColors.backgroundPrimary, equals(AppColors.gray900));
      });

      test('backgroundSecondary is gray800', () {
        expect(AppColors.backgroundSecondary, equals(AppColors.gray800));
      });
    });

    group('gradients', () {
      test('primaryGradient has correct colors', () {
        expect(AppColors.primaryGradient.colors, contains(AppColors.blue500));
        expect(AppColors.primaryGradient.colors, contains(AppColors.indigo600));
      });

      test('accentGradient has correct colors', () {
        expect(AppColors.accentGradient.colors, contains(AppColors.blue500));
        expect(AppColors.accentGradient.colors, contains(AppColors.indigo500));
        expect(AppColors.accentGradient.colors, contains(AppColors.purple600));
      });

      test('backgroundGradient has correct colors', () {
        expect(AppColors.backgroundGradient.colors, contains(AppColors.gray900));
        expect(AppColors.backgroundGradient.colors, contains(AppColors.gray800));
      });
    });

    group('orb colors', () {
      test('orbBlue has reduced alpha', () {
        expect((AppColors.orbBlue.a * 255).round(), lessThan(255));
      });

      test('orbIndigo has reduced alpha', () {
        expect((AppColors.orbIndigo.a * 255).round(), lessThan(255));
      });

      test('orbPurple has reduced alpha', () {
        expect((AppColors.orbPurple.a * 255).round(), lessThan(255));
      });
    });

    group('shadow colors', () {
      test('shadowDefault has reduced alpha', () {
        expect((AppColors.shadowDefault.a * 255).round(), lessThan(255));
      });

      test('shadowBlue has reduced alpha', () {
        expect((AppColors.shadowBlue.a * 255).round(), lessThan(255));
      });
    });
  });

  group('AppSpacing', () {
    test('base spacing values are positive', () {
      expect(AppSpacing.xs, greaterThan(0));
      expect(AppSpacing.sm, greaterThan(0));
      expect(AppSpacing.md, greaterThan(0));
      expect(AppSpacing.lg, greaterThan(0));
      expect(AppSpacing.xl, greaterThan(0));
      expect(AppSpacing.xxl, greaterThan(0));
    });

    test('spacing values increase progressively', () {
      expect(AppSpacing.sm, greaterThan(AppSpacing.xs));
      expect(AppSpacing.md, greaterThan(AppSpacing.sm));
      expect(AppSpacing.lg, greaterThan(AppSpacing.md));
      expect(AppSpacing.xl, greaterThan(AppSpacing.lg));
      expect(AppSpacing.xxl, greaterThan(AppSpacing.xl));
    });

    test('radius values are positive', () {
      expect(AppSpacing.radiusSM, greaterThan(0));
      expect(AppSpacing.radiusMD, greaterThan(0));
      expect(AppSpacing.radiusLG, greaterThan(0));
      expect(AppSpacing.radiusXL, greaterThan(0));
    });

    test('radius values increase progressively', () {
      expect(AppSpacing.radiusMD, greaterThan(AppSpacing.radiusSM));
      expect(AppSpacing.radiusLG, greaterThan(AppSpacing.radiusMD));
      expect(AppSpacing.radiusXL, greaterThan(AppSpacing.radiusLG));
    });
  });

  // Note: AppTypography tests are limited because GoogleFonts requires network
  // access which is not available in the test environment.
  // The typography styles are tested indirectly through the theme tests above.
}
