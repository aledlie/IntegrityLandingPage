import 'dart:math';

/// Contact form data model.
class ContactFormData {
  final String name;
  final String email;
  final String? organization;
  final String message;

  const ContactFormData({
    required this.name,
    required this.email,
    this.organization,
    required this.message,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        if (organization != null) 'organization': organization,
        'message': message,
      };
}

/// Contact form submission payload with security tokens.
class ContactFormPayload {
  final ContactFormData formData;
  final String? csrfToken;
  final int timestamp;
  final String? userAgent;

  ContactFormPayload({
    required this.formData,
    this.csrfToken,
    int? timestamp,
    this.userAgent,
  }) : timestamp = timestamp ?? DateTime.now().millisecondsSinceEpoch;
}

/// Contact form response.
sealed class ContactFormResponse {
  const ContactFormResponse();
}

/// Successful submission response.
class ContactFormSuccess extends ContactFormResponse {
  final String message;
  final String submissionId;

  const ContactFormSuccess({
    required this.message,
    required this.submissionId,
  });
}

/// Error response.
class ContactFormError extends ContactFormResponse {
  final String error;
  final Map<String, String>? fieldErrors;

  const ContactFormError({
    required this.error,
    this.fieldErrors,
  });
}

/// Contact form validation errors.
class ContactFormErrors {
  String? name;
  String? email;
  String? organization;
  String? message;

  ContactFormErrors({
    this.name,
    this.email,
    this.organization,
    this.message,
  });

  bool get hasErrors =>
      name != null || email != null || organization != null || message != null;

  Map<String, String> toMap() {
    final map = <String, String>{};
    if (name != null) map['name'] = name!;
    if (email != null) map['email'] = email!;
    if (organization != null) map['organization'] = organization!;
    if (message != null) map['message'] = message!;
    return map;
  }
}

/// Contact form service for submission and validation.
class ContactService {
  ContactService._();

  /// Validate email format.
  static bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    return emailRegex.hasMatch(email);
  }

  /// Validate contact form data.
  ///
  /// Returns validation errors or empty errors if valid.
  static ContactFormErrors validateForm(ContactFormData formData) {
    final errors = ContactFormErrors();

    // Validate name
    if (formData.name.trim().isEmpty) {
      errors.name = 'Please enter your full name';
    }

    // Validate email
    if (formData.email.trim().isEmpty) {
      errors.email = 'Please enter your email address';
    } else if (!isValidEmail(formData.email)) {
      errors.email = 'Please enter a valid email address';
    }

    // Validate message
    if (formData.message.trim().isEmpty) {
      errors.message = 'Please tell us about your needs';
    } else if (formData.message.trim().length < 10) {
      errors.message = 'Please provide more details (at least 10 characters)';
    }

    // Organization is optional - no validation

    return errors;
  }

  /// Check if form data is valid.
  static bool isFormValid(ContactFormData formData) {
    return !validateForm(formData).hasErrors;
  }

  /// Submit contact form.
  ///
  /// Sends contact form data to the backend API.
  /// Currently simulates API call for demonstration purposes.
  static Future<ContactFormResponse> submitForm(
    ContactFormPayload payload,
  ) async {
    // Validate form data first
    final errors = validateForm(payload.formData);
    if (errors.hasErrors) {
      return ContactFormError(
        error: 'Please fix the errors in the form',
        fieldErrors: errors.toMap(),
      );
    }

    // Simulate network delay
    await Future<void>.delayed(const Duration(seconds: 1));

    // TODO: Replace with actual API call when backend is ready
    // final response = await http.post(
    //   Uri.parse('/api/contact'),
    //   headers: {
    //     'Content-Type': 'application/json',
    //     if (payload.csrfToken != null) 'X-CSRF-Token': payload.csrfToken!,
    //   },
    //   body: jsonEncode({
    //     ...payload.formData.toJson(),
    //     'timestamp': payload.timestamp,
    //     'userAgent': payload.userAgent,
    //   }),
    // );

    // Simulate random errors (5% failure rate for testing)
    if (Random().nextDouble() < 0.05) {
      return const ContactFormError(
        error: 'Network error: Unable to submit form. Please try again.',
      );
    }

    // Return successful response
    return ContactFormSuccess(
      message: "Thank you for your message! We'll respond within 24 hours.",
      submissionId: 'sub_${DateTime.now().millisecondsSinceEpoch}',
    );
  }
}
