import 'package:flutter/material.dart';
import '../../config/content.dart';
import '../../theme/theme.dart';
import '../../services/analytics.dart';
import '../common/cards.dart';
import '../common/containers.dart';
import '../common/buttons.dart';

/// Contact section with form and contact methods.
///
/// Designed for enterprise lead capture with qualification fields.
///
/// Features:
/// - Contact form with validation
/// - Multiple contact methods (email, calendar, social)
/// - Calendly integration for demo scheduling
/// - Success/error messaging
///
/// Usage:
/// ```dart
/// ContactSection(
///   content: ContactContent.current, // or AppContent.contact
///   onFormSubmit: (data) => submitToBackend(data),
/// )
/// ```
class ContactSection extends StatefulWidget {
  final ContactContent content;
  final Future<bool> Function(Map<String, String>)? onFormSubmit;

  const ContactSection({
    super.key,
    this.content = const ContactContent(
      sectionId: 'contact',
      title: 'Contact',
      subtitle: '',
      description: '',
      formFields: [],
      contactMethods: [],
      formSubmitText: 'Submit',
      formSuccessMessage: 'Thank you!',
      formErrorMessage: 'Error',
      calendlyUrl: '',
      calendlyCtaText: 'Schedule Demo',
    ),
    this.onFormSubmit,
  });

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _formData = <String, String>{};
  bool _isSubmitting = false;
  bool? _submitSuccess;
  String? _errorMessage;

  // Use content from widget or fallback to AppContent
  ContactContent get _content =>
      widget.content.formFields.isEmpty ? AppContent.contact : widget.content;

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);

    return SectionContainer(
      id: _content.sectionId,
      backgroundColor: AppColors.gray800,
      child: Column(
        children: [
          // Section header
          SectionTitle(
            title: _content.title,
            subtitle: _content.subtitle,
          ),

          if (_content.description.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.lg),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 700),
              child: Text(
                _content.description,
                style: AppTypography.bodyLG,
                textAlign: TextAlign.center,
              ),
            ),
          ],

          SizedBox(height: AppSpacing.sectionPadding(context) * 0.5),

          // Contact form and methods
          isMobile
              ? _buildMobileLayout(context)
              : _buildDesktopLayout(context),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Contact form (2/3 width)
        Expanded(
          flex: 2,
          child: _buildContactForm(context),
        ),
        const SizedBox(width: AppSpacing.xxl),
        // Contact methods (1/3 width)
        Expanded(
          flex: 1,
          child: _buildContactMethods(context),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        _buildContactMethods(context),
        const SizedBox(height: AppSpacing.xxl),
        _buildContactForm(context),
      ],
    );
  }

  Widget _buildContactForm(BuildContext context) {
    return GlassCard(
      tier: GlassCardTier.secondary,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Send us a message',
              style: AppTypography.headingSM,
            ),
            const SizedBox(height: AppSpacing.lg),

            // Form fields
            ..._buildFormFields(),

            const SizedBox(height: AppSpacing.lg),

            // Submit button
            SizedBox(
              width: double.infinity,
              child: GradientButton(
                text: _isSubmitting ? 'Sending...' : _content.formSubmitText,
                onPressed: _isSubmitting ? null : _handleSubmit,
              ),
            ),

            // Success/error message
            if (_submitSuccess != null) ...[
              const SizedBox(height: AppSpacing.lg),
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: _submitSuccess!
                      ? AppColors.success.withValues(alpha: 0.1)
                      : AppColors.error.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
                  border: Border.all(
                    color: _submitSuccess!
                        ? AppColors.success.withValues(alpha: 0.3)
                        : AppColors.error.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      _submitSuccess!
                          ? Icons.check_circle_outline
                          : Icons.error_outline,
                      color: _submitSuccess! ? AppColors.success : AppColors.error,
                      size: 20,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        _submitSuccess!
                            ? _content.formSuccessMessage
                            : (_errorMessage ?? _content.formErrorMessage),
                        style: AppTypography.bodySM.copyWith(
                          color: _submitSuccess!
                              ? AppColors.success
                              : AppColors.error,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  List<Widget> _buildFormFields() {
    final fields = <Widget>[];
    final formFields = _content.formFields;

    // Group fields in rows of 2 for name fields
    for (int i = 0; i < formFields.length; i++) {
      final field = formFields[i];

      // Check if we can pair this field with the next one
      final canPair = i + 1 < formFields.length &&
          field.type == 'text' &&
          formFields[i + 1].type == 'text' &&
          (field.name.contains('Name') || field.name.contains('first') ||
              field.name.contains('last'));

      if (canPair) {
        fields.add(
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.md),
            child: Row(
              children: [
                Expanded(child: _buildField(field)),
                const SizedBox(width: AppSpacing.md),
                Expanded(child: _buildField(formFields[i + 1])),
              ],
            ),
          ),
        );
        i++; // Skip the next field since we already added it
      } else {
        fields.add(
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.md),
            child: _buildField(field),
          ),
        );
      }
    }

    return fields;
  }

  Widget _buildField(ContactFormFieldContent field) {
    switch (field.type) {
      case 'select':
        return DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelText: field.label,
            hintText: field.placeholder,
          ),
          items: field.options
                  ?.map((option) => DropdownMenuItem(
                        value: option,
                        child: Text(option),
                      ))
                  .toList() ??
              [],
          validator: field.required
              ? (value) => value == null ? 'Please select an option' : null
              : null,
          onChanged: (value) {
            if (value != null) {
              _formData[field.name] = value;
            }
          },
        );

      case 'textarea':
        return TextFormField(
          decoration: InputDecoration(
            labelText: field.label,
            hintText: field.placeholder,
            alignLabelWithHint: true,
          ),
          maxLines: 4,
          validator: field.required
              ? (value) =>
                  value?.isEmpty ?? true ? 'This field is required' : null
              : null,
          onChanged: (value) => _formData[field.name] = value,
        );

      case 'email':
        return TextFormField(
          decoration: InputDecoration(
            labelText: field.label,
            hintText: field.placeholder,
          ),
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (field.required && (value?.isEmpty ?? true)) {
              return 'This field is required';
            }
            if (value != null &&
                value.isNotEmpty &&
                !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
              return 'Please enter a valid email address';
            }
            return null;
          },
          onChanged: (value) => _formData[field.name] = value,
        );

      default:
        return TextFormField(
          decoration: InputDecoration(
            labelText: field.label,
            hintText: field.placeholder,
          ),
          validator: field.required
              ? (value) =>
                  value?.isEmpty ?? true ? 'This field is required' : null
              : null,
          onChanged: (value) => _formData[field.name] = value,
        );
    }
  }

  Widget _buildContactMethods(BuildContext context) {
    final primaryMethods =
        _content.contactMethods.where((m) => m.isPrimary).toList();
    final secondaryMethods =
        _content.contactMethods.where((m) => !m.isPrimary).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Primary contact methods
        GlassCard(
          tier: GlassCardTier.secondary,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Get in touch',
                style: AppTypography.headingSM,
              ),
              const SizedBox(height: AppSpacing.lg),
              ...primaryMethods.map((method) => Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.lg),
                    child: _ContactMethodItem(
                      method: method,
                      isPrimary: true,
                    ),
                  )),
            ],
          ),
        ),

        const SizedBox(height: AppSpacing.lg),

        // Schedule demo CTA
        if (_content.calendlyUrl.isNotEmpty)
          GlassCard(
            tier: GlassCardTier.primary,
            child: Column(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
                  ),
                  child: const Icon(
                    Icons.video_call_outlined,
                    size: 28,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  'Want a Live Demo?',
                  style: AppTypography.headingSM,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'See the platform in action with a personalized walkthrough.',
                  style: AppTypography.bodySM,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.lg),
                SizedBox(
                  width: double.infinity,
                  child: GradientButton(
                    text: _content.calendlyCtaText,
                    onPressed: () {
                      AnalyticsService.trackCTAClick(
                        buttonName: _content.calendlyCtaText,
                        location: 'contact_section',
                      );
                      // TODO: Open Calendly
                    },
                  ),
                ),
              ],
            ),
          ),

        const SizedBox(height: AppSpacing.lg),

        // Secondary contact methods (social links)
        if (secondaryMethods.isNotEmpty)
          GlassCard(
            tier: GlassCardTier.tertiary,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Follow us',
                  style: AppTypography.bodyMD.copyWith(
                    color: AppColors.gray300,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Wrap(
                  spacing: AppSpacing.md,
                  runSpacing: AppSpacing.md,
                  children: secondaryMethods
                      .map((method) => _ContactMethodItem(
                            method: method,
                            isPrimary: false,
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSubmitting = true;
      _submitSuccess = null;
      _errorMessage = null;
    });

    AnalyticsService.trackFormSubmit('contact_form');

    try {
      if (widget.onFormSubmit != null) {
        final success = await widget.onFormSubmit!(_formData);
        setState(() {
          _isSubmitting = false;
          _submitSuccess = success;
        });
      } else {
        // Simulate submission
        await Future<void>.delayed(const Duration(seconds: 1));
        setState(() {
          _isSubmitting = false;
          _submitSuccess = true;
        });
      }
    } catch (e) {
      setState(() {
        _isSubmitting = false;
        _submitSuccess = false;
        _errorMessage = e.toString();
      });
    }
  }
}

/// Individual contact method item.
class _ContactMethodItem extends StatelessWidget {
  final ContactMethodContent method;
  final bool isPrimary;

  const _ContactMethodItem({
    required this.method,
    required this.isPrimary,
  });

  @override
  Widget build(BuildContext context) {
    if (!isPrimary) {
      // Compact social link button
      return Tooltip(
        message: method.label,
        child: InkWell(
          onTap: method.url != null
              ? () {
                  // TODO: Launch URL
                }
              : null,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.gray700.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
            ),
            child: Icon(
              method.icon,
              size: 20,
              color: AppColors.gray300,
            ),
          ),
        ),
      );
    }

    // Primary contact method with full details
    return InkWell(
      onTap: method.url != null
          ? () {
              // TODO: Launch URL
            }
          : null,
      borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.blue500.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
            ),
            child: Icon(
              method.icon,
              size: 22,
              color: AppColors.blue400,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  method.label,
                  style: AppTypography.bodySM.copyWith(
                    color: AppColors.gray400,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  method.value,
                  style: AppTypography.bodyMD.copyWith(
                    color: method.url != null
                        ? AppColors.blue400
                        : AppColors.textPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          if (method.url != null)
            const Icon(
              Icons.arrow_forward,
              size: 18,
              color: AppColors.gray500,
            ),
        ],
      ),
    );
  }
}
