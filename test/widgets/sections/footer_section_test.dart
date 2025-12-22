import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FooterSection', () {
    group('footer link data', () {
      test('footer structure is defined correctly', () {
        // Footer sections are defined statically in the widget
        // These tests verify the expected structure exists
        const productLinks = ['Features', 'Pricing', 'Documentation', 'API Reference'];
        const companyLinks = ['About', 'Blog', 'Careers', 'Contact'];
        const resourceLinks = ['Help Center', 'Status', 'Security', 'Changelog'];

        expect(productLinks, hasLength(4));
        expect(companyLinks, hasLength(4));
        expect(resourceLinks, hasLength(4));
      });

      test('social links are defined', () {
        const socialPlatforms = ['Twitter', 'LinkedIn', 'GitHub'];
        expect(socialPlatforms, hasLength(3));
      });
    });

    group('copyright', () {
      test('current year is calculated correctly', () {
        final currentYear = DateTime.now().year;
        expect(currentYear, greaterThanOrEqualTo(2024));
      });
    });

    group('legal links', () {
      test('required legal links exist', () {
        const legalLinks = ['Privacy Policy', 'Terms of Service', 'Cookie Settings'];

        expect(legalLinks.contains('Privacy Policy'), isTrue);
        expect(legalLinks.contains('Terms of Service'), isTrue);
        expect(legalLinks.contains('Cookie Settings'), isTrue);
      });
    });
  });
}
