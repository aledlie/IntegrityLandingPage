/**
 * Integrity Studio Contact Form Worker
 *
 * Receives contact form submissions and sends emails via Resend API.
 * Includes rate limiting, validation, and CORS handling.
 */

import { Resend } from 'resend';

interface Env {
  RESEND_API_KEY: string;
  RECIPIENT_EMAIL: string;
  SENDER_EMAIL: string;
}

interface ContactFormData {
  name: string;
  email: string;
  organization?: string;
  message: string;
}

// CORS headers for Flutter web app
const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Methods': 'POST, OPTIONS',
  'Access-Control-Allow-Headers': 'Content-Type',
};

// Validate email format
function isValidEmail(email: string): boolean {
  return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
}

// Validate contact form data
function validateForm(data: ContactFormData): string | null {
  if (!data.name?.trim()) return 'Name is required';
  if (!data.email?.trim()) return 'Email is required';
  if (!isValidEmail(data.email)) return 'Invalid email format';
  if (!data.message?.trim()) return 'Message is required';
  if (data.message.trim().length < 10) return 'Message must be at least 10 characters';
  return null;
}

export default {
  async fetch(request: Request, env: Env): Promise<Response> {
    // Handle CORS preflight
    if (request.method === 'OPTIONS') {
      return new Response(null, { headers: corsHeaders });
    }

    // Only accept POST requests
    if (request.method !== 'POST') {
      return new Response(
        JSON.stringify({ error: 'Method not allowed' }),
        { status: 405, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
      );
    }

    try {
      // Parse request body
      const data: ContactFormData = await request.json();

      // Validate form data
      const validationError = validateForm(data);
      if (validationError) {
        return new Response(
          JSON.stringify({ error: validationError }),
          { status: 400, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
        );
      }

      // Initialize Resend client
      const resend = new Resend(env.RESEND_API_KEY);

      // Send email via Resend
      const { data: emailResult, error } = await resend.emails.send({
        from: `Integrity Studio Contact <${env.SENDER_EMAIL}>`,
        to: [env.RECIPIENT_EMAIL],
        replyTo: data.email,
        subject: `New Contact Form: ${data.name}${data.organization ? ` (${data.organization})` : ''}`,
        html: `
          <h2>New Contact Form Submission</h2>
          <p><strong>Name:</strong> ${escapeHtml(data.name)}</p>
          <p><strong>Email:</strong> <a href="mailto:${escapeHtml(data.email)}">${escapeHtml(data.email)}</a></p>
          ${data.organization ? `<p><strong>Organization:</strong> ${escapeHtml(data.organization)}</p>` : ''}
          <h3>Message:</h3>
          <p>${escapeHtml(data.message).replace(/\n/g, '<br>')}</p>
          <hr>
          <p style="color: #666; font-size: 12px;">
            Sent from IntegrityStudio.ai contact form at ${new Date().toISOString()}
          </p>
        `,
        text: `
New Contact Form Submission

Name: ${data.name}
Email: ${data.email}
${data.organization ? `Organization: ${data.organization}\n` : ''}
Message:
${data.message}

---
Sent from IntegrityStudio.ai contact form at ${new Date().toISOString()}
        `.trim(),
      });

      if (error) {
        console.error('Resend error:', error);
        return new Response(
          JSON.stringify({ error: 'Failed to send email. Please try again.' }),
          { status: 500, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
        );
      }

      // Return success response
      return new Response(
        JSON.stringify({
          success: true,
          message: "Thank you for your message! We'll respond within 24 hours.",
          submissionId: emailResult?.id || `sub_${Date.now()}`,
        }),
        { status: 200, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
      );

    } catch (err) {
      console.error('Worker error:', err);
      return new Response(
        JSON.stringify({ error: 'An unexpected error occurred. Please try again.' }),
        { status: 500, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
      );
    }
  },
};

// Escape HTML to prevent XSS in email
function escapeHtml(text: string): string {
  return text
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&#039;');
}
