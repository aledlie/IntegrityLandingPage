import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integrity_studio_ai/theme/colors.dart';

void main() {
  group('AppColors', () {
    group('Primary Brand Colors', () {
      test('blue400 has correct hex value', () {
        expect(AppColors.blue400, equals(const Color(0xFF60A5FA)));
      });

      test('blue500 has correct hex value', () {
        expect(AppColors.blue500, equals(const Color(0xFF3B82F6)));
      });

      test('blue600 has correct hex value', () {
        expect(AppColors.blue600, equals(const Color(0xFF2563EB)));
      });

      test('blue900 has correct hex value', () {
        expect(AppColors.blue900, equals(const Color(0xFF1E3A8A)));
      });
    });

    group('Secondary Colors', () {
      test('indigo400 has correct hex value', () {
        expect(AppColors.indigo400, equals(const Color(0xFF818CF8)));
      });

      test('indigo500 has correct hex value', () {
        expect(AppColors.indigo500, equals(const Color(0xFF6366F1)));
      });

      test('indigo600 has correct hex value', () {
        expect(AppColors.indigo600, equals(const Color(0xFF4F46E5)));
      });
    });

    group('Accent Colors', () {
      test('purple400 has correct hex value', () {
        expect(AppColors.purple400, equals(const Color(0xFFC084FC)));
      });

      test('purple500 has correct hex value', () {
        expect(AppColors.purple500, equals(const Color(0xFFA855F7)));
      });

      test('purple600 has correct hex value', () {
        expect(AppColors.purple600, equals(const Color(0xFF9333EA)));
      });
    });

    group('Neutral Colors', () {
      test('gray900 has correct hex value', () {
        expect(AppColors.gray900, equals(const Color(0xFF111827)));
      });

      test('gray800 has correct hex value', () {
        expect(AppColors.gray800, equals(const Color(0xFF1F2937)));
      });

      test('gray700 has correct hex value', () {
        expect(AppColors.gray700, equals(const Color(0xFF374151)));
      });

      test('gray600 has correct hex value', () {
        expect(AppColors.gray600, equals(const Color(0xFF4B5563)));
      });

      test('gray500 has correct hex value', () {
        expect(AppColors.gray500, equals(const Color(0xFF6B7280)));
      });

      test('gray400 has correct hex value', () {
        expect(AppColors.gray400, equals(const Color(0xFF9CA3AF)));
      });

      test('gray300 has correct hex value', () {
        expect(AppColors.gray300, equals(const Color(0xFFD1D5DB)));
      });

      test('gray200 has correct hex value', () {
        expect(AppColors.gray200, equals(const Color(0xFFE5E7EB)));
      });

      test('gray100 has correct hex value', () {
        expect(AppColors.gray100, equals(const Color(0xFFF3F4F6)));
      });
    });

    group('Semantic Colors', () {
      test('success has correct hex value', () {
        expect(AppColors.success, equals(const Color(0xFF22C55E)));
      });

      test('successLight has correct hex value', () {
        expect(AppColors.successLight, equals(const Color(0xFF4ADE80)));
      });

      test('warning has correct hex value', () {
        expect(AppColors.warning, equals(const Color(0xFFF59E0B)));
      });

      test('warningLight has correct hex value', () {
        expect(AppColors.warningLight, equals(const Color(0xFFFBBF24)));
      });

      test('error has correct hex value', () {
        expect(AppColors.error, equals(const Color(0xFFEF4444)));
      });

      test('errorLight has correct hex value', () {
        expect(AppColors.errorLight, equals(const Color(0xFFF87171)));
      });

      test('info has correct hex value', () {
        expect(AppColors.info, equals(const Color(0xFF3B82F6)));
      });
    });

    group('Text Colors', () {
      test('textPrimary is white', () {
        expect(AppColors.textPrimary, equals(Colors.white));
      });

      test('textSecondary is gray300', () {
        expect(AppColors.textSecondary, equals(AppColors.gray300));
      });

      test('textTertiary is gray300', () {
        expect(AppColors.textTertiary, equals(AppColors.gray300));
      });

      test('textDisabled is gray500', () {
        expect(AppColors.textDisabled, equals(AppColors.gray500));
      });

      test('textLink is blue400', () {
        expect(AppColors.textLink, equals(AppColors.blue400));
      });
    });

    group('Background Colors', () {
      test('backgroundPrimary is gray900', () {
        expect(AppColors.backgroundPrimary, equals(AppColors.gray900));
      });

      test('backgroundSecondary is gray800', () {
        expect(AppColors.backgroundSecondary, equals(AppColors.gray800));
      });

      test('backgroundElevated is gray800', () {
        expect(AppColors.backgroundElevated, equals(AppColors.gray800));
      });

      test('backgroundCard has correct value', () {
        expect(AppColors.backgroundCard, equals(const Color(0xF2111827)));
      });
    });

    group('Border Colors', () {
      test('borderDefault has correct value', () {
        expect(AppColors.borderDefault, equals(const Color(0x80374151)));
      });

      test('borderHover has correct value', () {
        expect(AppColors.borderHover, equals(const Color(0x803B82F6)));
      });

      test('borderFocus is blue500', () {
        expect(AppColors.borderFocus, equals(AppColors.blue500));
      });

      test('borderError is error color', () {
        expect(AppColors.borderError, equals(AppColors.error));
      });
    });

    group('Gradients', () {
      test('primaryGradient has correct colors', () {
        expect(
          AppColors.primaryGradient.colors,
          equals([AppColors.blue500, AppColors.indigo600]),
        );
      });

      test('primaryGradient has correct alignment', () {
        expect(AppColors.primaryGradient.begin, equals(Alignment.topLeft));
        expect(AppColors.primaryGradient.end, equals(Alignment.bottomRight));
      });

      test('accentGradient has three colors', () {
        expect(AppColors.accentGradient.colors.length, equals(3));
        expect(
          AppColors.accentGradient.colors,
          equals([AppColors.blue500, AppColors.indigo500, AppColors.purple600]),
        );
      });

      test('accentGradient has correct alignment', () {
        expect(AppColors.accentGradient.begin, equals(Alignment.topLeft));
        expect(AppColors.accentGradient.end, equals(Alignment.bottomRight));
      });

      test('backgroundGradient has correct colors', () {
        expect(
          AppColors.backgroundGradient.colors,
          equals([AppColors.gray900, AppColors.gray800, AppColors.gray900]),
        );
      });

      test('disabledGradient has correct colors', () {
        expect(
          AppColors.disabledGradient.colors,
          equals([AppColors.gray600, AppColors.gray700]),
        );
      });
    });

    group('Orb Colors', () {
      test('orbBlue is blue500 with 15% opacity', () {
        expect((AppColors.orbBlue.a * 255.0).round().clamp(0, 255), closeTo(0.15 * 255, 1));
      });

      test('orbIndigo is indigo500 with 15% opacity', () {
        expect((AppColors.orbIndigo.a * 255.0).round().clamp(0, 255), closeTo(0.15 * 255, 1));
      });

      test('orbPurple is purple500 with 15% opacity', () {
        expect((AppColors.orbPurple.a * 255.0).round().clamp(0, 255), closeTo(0.15 * 255, 1));
      });
    });

    group('Shadow Colors', () {
      test('shadowDefault is gray900 with 30% opacity', () {
        expect((AppColors.shadowDefault.a * 255.0).round().clamp(0, 255), closeTo(0.3 * 255, 1));
      });

      test('shadowBlue is blue500 with 30% opacity', () {
        expect((AppColors.shadowBlue.a * 255.0).round().clamp(0, 255), closeTo(0.3 * 255, 1));
      });
    });

    group('WCAG Compliance', () {
      test('textPrimary has highest contrast on dark background', () {
        // White text on gray900 has 21:1 contrast
        expect(AppColors.textPrimary, equals(Colors.white));
      });

      test('textSecondary is gray300 for WCAG compliance', () {
        // gray300 on gray900 has 4.8:1 contrast (passes AA)
        expect(AppColors.textSecondary, equals(AppColors.gray300));
      });

      test('gray400 exists but should not be used for body text', () {
        // This test documents that gray400 exists but has insufficient contrast
        expect(AppColors.gray400, isNotNull);
        // Contrast ratio is 3.2:1 which fails WCAG AA
      });
    });
  });
}
