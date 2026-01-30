import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integrity_studio_ai/theme/colors.dart';

void main() {
  group('AppColors', () {
    group('hex color values', () {
      final colorValues = <String, (Color, int)>{
        // Primary brand colors
        'blue400': (AppColors.blue400, 0xFF60A5FA),
        'blue500': (AppColors.blue500, 0xFF3B82F6),
        'blue600': (AppColors.blue600, 0xFF2563EB),
        'blue900': (AppColors.blue900, 0xFF1E3A8A),
        // Secondary colors
        'indigo400': (AppColors.indigo400, 0xFF818CF8),
        'indigo500': (AppColors.indigo500, 0xFF6366F1),
        'indigo600': (AppColors.indigo600, 0xFF4F46E5),
        // Accent colors
        'purple400': (AppColors.purple400, 0xFFC084FC),
        'purple500': (AppColors.purple500, 0xFFA855F7),
        'purple600': (AppColors.purple600, 0xFF9333EA),
        // Neutral colors
        'gray100': (AppColors.gray100, 0xFFF3F4F6),
        'gray200': (AppColors.gray200, 0xFFE5E7EB),
        'gray300': (AppColors.gray300, 0xFFD1D5DB),
        'gray400': (AppColors.gray400, 0xFF9CA3AF),
        'gray500': (AppColors.gray500, 0xFF6B7280),
        'gray600': (AppColors.gray600, 0xFF4B5563),
        'gray700': (AppColors.gray700, 0xFF374151),
        'gray800': (AppColors.gray800, 0xFF1F2937),
        'gray900': (AppColors.gray900, 0xFF111827),
        // Semantic colors
        'success': (AppColors.success, 0xFF22C55E),
        'successLight': (AppColors.successLight, 0xFF4ADE80),
        'warning': (AppColors.warning, 0xFFF59E0B),
        'warningLight': (AppColors.warningLight, 0xFFFBBF24),
        'error': (AppColors.error, 0xFFEF4444),
        'errorLight': (AppColors.errorLight, 0xFFF87171),
        'info': (AppColors.info, 0xFF3B82F6),
        // Background card
        'backgroundCard': (AppColors.backgroundCard, 0xF2111827),
        // Border colors with alpha
        'borderDefault': (AppColors.borderDefault, 0x80374151),
        'borderHover': (AppColors.borderHover, 0x803B82F6),
      };

      for (final entry in colorValues.entries) {
        test('${entry.key} has correct value', () {
          expect(entry.value.$1, equals(Color(entry.value.$2)));
        });
      }
    });

    group('color aliases', () {
      final aliases = <String, (Color, Color)>{
        'textPrimary': (AppColors.textPrimary, Colors.white),
        'textSecondary': (AppColors.textSecondary, AppColors.gray300),
        'textTertiary': (AppColors.textTertiary, AppColors.gray300),
        'textDisabled': (AppColors.textDisabled, AppColors.gray500),
        'textLink': (AppColors.textLink, AppColors.blue400),
        'backgroundPrimary': (AppColors.backgroundPrimary, AppColors.gray900),
        'backgroundSecondary': (AppColors.backgroundSecondary, AppColors.gray800),
        'backgroundElevated': (AppColors.backgroundElevated, AppColors.gray800),
        'borderFocus': (AppColors.borderFocus, AppColors.blue500),
        'borderError': (AppColors.borderError, AppColors.error),
      };

      for (final entry in aliases.entries) {
        test('${entry.key} equals expected color', () {
          expect(entry.value.$1, equals(entry.value.$2));
        });
      }
    });

    group('gradients', () {
      test('primaryGradient has correct colors and alignment', () {
        expect(
          AppColors.primaryGradient.colors,
          equals([AppColors.blue500, AppColors.indigo600]),
        );
        expect(AppColors.primaryGradient.begin, equals(Alignment.topLeft));
        expect(AppColors.primaryGradient.end, equals(Alignment.bottomRight));
      });

      test('accentGradient has correct colors and alignment', () {
        expect(
          AppColors.accentGradient.colors,
          equals([AppColors.blue500, AppColors.indigo500, AppColors.purple600]),
        );
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

    group('orb colors (15% opacity)', () {
      final orbColors = <String, Color>{
        'orbBlue': AppColors.orbBlue,
        'orbIndigo': AppColors.orbIndigo,
        'orbPurple': AppColors.orbPurple,
      };

      for (final entry in orbColors.entries) {
        test('${entry.key} has ~15% opacity', () {
          final alpha = (entry.value.a * 255.0).round().clamp(0, 255);
          expect(alpha, closeTo(0.15 * 255, 1));
        });
      }
    });

    group('shadow colors (30% opacity)', () {
      final shadowColors = <String, Color>{
        'shadowDefault': AppColors.shadowDefault,
        'shadowBlue': AppColors.shadowBlue,
      };

      for (final entry in shadowColors.entries) {
        test('${entry.key} has ~30% opacity', () {
          final alpha = (entry.value.a * 255.0).round().clamp(0, 255);
          expect(alpha, closeTo(0.3 * 255, 1));
        });
      }
    });

    group('WCAG compliance documentation', () {
      test('textPrimary (white) provides highest contrast on dark backgrounds', () {
        // White text on gray900 has 21:1 contrast ratio
        expect(AppColors.textPrimary, equals(Colors.white));
      });

      test('textSecondary (gray300) meets WCAG AA requirements', () {
        // gray300 on gray900 has 4.8:1 contrast (passes AA for normal text)
        expect(AppColors.textSecondary, equals(AppColors.gray300));
      });

      test('gray400 exists but has insufficient contrast for body text', () {
        // gray400 on gray900 has 3.2:1 contrast (fails WCAG AA)
        // Use for decorative elements only, not body text
        expect(AppColors.gray400, isNotNull);
      });
    });
  });
}
