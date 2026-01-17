/**
 * Tests for Integrity Studio Contact Form Worker
 *
 * Tests email submission triggers, validation, and Resend integration.
 * Run with: npm test
 */

import { describe, it, expect, vi, beforeEach } from 'vitest';

// Mock Resend
vi.mock('resend', () => ({
  Resend: vi.fn().mockImplementation(() => ({
    emails: {
      send: vi.fn(),
    },
  })),
}));

import { Resend } from 'resend';

// Import the worker handler
import worker from './index';

// Mock environment
const mockEnv = {
  RESEND_API_KEY: 'test_resend_api_key',
  RECIPIENT_EMAIL: 'test@integritystudio.ai',
  SENDER_EMAIL: 'contact@integritystudio.ai',
};

// Helper to create mock Request
function createRequest(
  method: string,
  body?: object
): Request {
  return new Request('https://worker.test/', {
    method,
    headers: { 'Content-Type': 'application/json' },
    body: body ? JSON.stringify(body) : undefined,
  });
}

describe('Contact Form Worker', () => {
  let mockResendInstance: { emails: { send: ReturnType<typeof vi.fn> } };

  beforeEach(() => {
    vi.clearAllMocks();
    mockResendInstance = {
      emails: {
        send: vi.fn(),
      },
    };
    (Resend as unknown as ReturnType<typeof vi.fn>).mockImplementation(
      () => mockResendInstance
    );
  });

  describe('HTTP Methods', () => {
    it('handles OPTIONS preflight requests', async () => {
      const request = createRequest('OPTIONS');
      const response = await worker.fetch(request, mockEnv);

      expect(response.status).toBe(200);
      expect(response.headers.get('Access-Control-Allow-Origin')).toBe('*');
      expect(response.headers.get('Access-Control-Allow-Methods')).toContain('POST');
    });

    it('rejects GET requests with 405', async () => {
      const request = createRequest('GET');
      const response = await worker.fetch(request, mockEnv);

      expect(response.status).toBe(405);
      const data = await response.json();
      expect(data.error).toBe('Method not allowed');
    });

    it('rejects PUT requests with 405', async () => {
      const request = createRequest('PUT');
      const response = await worker.fetch(request, mockEnv);

      expect(response.status).toBe(405);
    });

    it('rejects DELETE requests with 405', async () => {
      const request = createRequest('DELETE');
      const response = await worker.fetch(request, mockEnv);

      expect(response.status).toBe(405);
    });
  });

  describe('Form Validation', () => {
    it('returns 400 for missing name', async () => {
      const request = createRequest('POST', {
        email: 'test@example.com',
        message: 'This is a test message.',
      });

      const response = await worker.fetch(request, mockEnv);

      expect(response.status).toBe(400);
      const data = await response.json();
      expect(data.error).toContain('Name');
    });

    it('returns 400 for empty name', async () => {
      const request = createRequest('POST', {
        name: '',
        email: 'test@example.com',
        message: 'This is a test message.',
      });

      const response = await worker.fetch(request, mockEnv);

      expect(response.status).toBe(400);
      const data = await response.json();
      expect(data.error).toContain('Name');
    });

    it('returns 400 for whitespace-only name', async () => {
      const request = createRequest('POST', {
        name: '   ',
        email: 'test@example.com',
        message: 'This is a test message.',
      });

      const response = await worker.fetch(request, mockEnv);

      expect(response.status).toBe(400);
    });

    it('returns 400 for missing email', async () => {
      const request = createRequest('POST', {
        name: 'John Doe',
        message: 'This is a test message.',
      });

      const response = await worker.fetch(request, mockEnv);

      expect(response.status).toBe(400);
      const data = await response.json();
      expect(data.error).toContain('Email');
    });

    it('returns 400 for invalid email format', async () => {
      const request = createRequest('POST', {
        name: 'John Doe',
        email: 'invalid-email',
        message: 'This is a test message.',
      });

      const response = await worker.fetch(request, mockEnv);

      expect(response.status).toBe(400);
      const data = await response.json();
      expect(data.error).toContain('email');
    });

    it('returns 400 for missing message', async () => {
      const request = createRequest('POST', {
        name: 'John Doe',
        email: 'test@example.com',
      });

      const response = await worker.fetch(request, mockEnv);

      expect(response.status).toBe(400);
      const data = await response.json();
      expect(data.error).toContain('Message');
    });

    it('returns 400 for message shorter than 10 characters', async () => {
      const request = createRequest('POST', {
        name: 'John Doe',
        email: 'test@example.com',
        message: 'Short',
      });

      const response = await worker.fetch(request, mockEnv);

      expect(response.status).toBe(400);
      const data = await response.json();
      expect(data.error).toContain('10');
    });

    it('accepts valid form data', async () => {
      mockResendInstance.emails.send.mockResolvedValue({
        data: { id: 'email_123' },
        error: null,
      });

      const request = createRequest('POST', {
        name: 'John Doe',
        email: 'john@example.com',
        message: 'This is a valid message for testing.',
      });

      const response = await worker.fetch(request, mockEnv);

      expect(response.status).toBe(200);
    });

    it('accepts optional organization field', async () => {
      mockResendInstance.emails.send.mockResolvedValue({
        data: { id: 'email_123' },
        error: null,
      });

      const request = createRequest('POST', {
        name: 'John Doe',
        email: 'john@example.com',
        organization: 'ACME Corp',
        message: 'This is a valid message for testing.',
      });

      const response = await worker.fetch(request, mockEnv);

      expect(response.status).toBe(200);
    });
  });

  describe('Email Submission Triggers', () => {
    it('sends email via Resend on valid submission', async () => {
      mockResendInstance.emails.send.mockResolvedValue({
        data: { id: 'email_123' },
        error: null,
      });

      const request = createRequest('POST', {
        name: 'John Doe',
        email: 'john@example.com',
        message: 'I would like to learn more about your platform.',
      });

      await worker.fetch(request, mockEnv);

      expect(mockResendInstance.emails.send).toHaveBeenCalledTimes(1);
      expect(mockResendInstance.emails.send).toHaveBeenCalledWith(
        expect.objectContaining({
          from: expect.stringContaining(mockEnv.SENDER_EMAIL),
          to: [mockEnv.RECIPIENT_EMAIL],
          replyTo: 'john@example.com',
          subject: expect.stringContaining('John Doe'),
        })
      );
    });

    it('includes organization in subject when provided', async () => {
      mockResendInstance.emails.send.mockResolvedValue({
        data: { id: 'email_123' },
        error: null,
      });

      const request = createRequest('POST', {
        name: 'Jane Doe',
        email: 'jane@company.com',
        organization: 'ACME Corp',
        message: 'Enterprise inquiry about AI observability.',
      });

      await worker.fetch(request, mockEnv);

      expect(mockResendInstance.emails.send).toHaveBeenCalledWith(
        expect.objectContaining({
          subject: expect.stringContaining('ACME Corp'),
        })
      );
    });

    it('includes message content in email body', async () => {
      mockResendInstance.emails.send.mockResolvedValue({
        data: { id: 'email_123' },
        error: null,
      });

      const testMessage = 'This is my specific test message content.';
      const request = createRequest('POST', {
        name: 'John Doe',
        email: 'john@example.com',
        message: testMessage,
      });

      await worker.fetch(request, mockEnv);

      expect(mockResendInstance.emails.send).toHaveBeenCalledWith(
        expect.objectContaining({
          html: expect.stringContaining(testMessage),
          text: expect.stringContaining(testMessage),
        })
      );
    });

    it('returns success response with submission ID', async () => {
      mockResendInstance.emails.send.mockResolvedValue({
        data: { id: 'resend_email_abc123' },
        error: null,
      });

      const request = createRequest('POST', {
        name: 'John Doe',
        email: 'john@example.com',
        message: 'This is a valid message for testing.',
      });

      const response = await worker.fetch(request, mockEnv);
      const data = await response.json();

      expect(response.status).toBe(200);
      expect(data.success).toBe(true);
      expect(data.submissionId).toBe('resend_email_abc123');
      expect(data.message).toContain('Thank you');
    });

    it('returns success with fallback ID when Resend returns no ID', async () => {
      mockResendInstance.emails.send.mockResolvedValue({
        data: {},
        error: null,
      });

      const request = createRequest('POST', {
        name: 'John Doe',
        email: 'john@example.com',
        message: 'This is a valid message for testing.',
      });

      const response = await worker.fetch(request, mockEnv);
      const data = await response.json();

      expect(response.status).toBe(200);
      expect(data.success).toBe(true);
      expect(data.submissionId).toMatch(/^sub_\d+$/);
    });
  });

  describe('Error Handling', () => {
    it('returns 500 when Resend API fails', async () => {
      mockResendInstance.emails.send.mockResolvedValue({
        data: null,
        error: { message: 'Rate limit exceeded' },
      });

      const request = createRequest('POST', {
        name: 'John Doe',
        email: 'john@example.com',
        message: 'This is a valid message for testing.',
      });

      const response = await worker.fetch(request, mockEnv);
      const data = await response.json();

      expect(response.status).toBe(500);
      expect(data.error).toContain('Failed to send email');
    });

    it('returns 500 on network error', async () => {
      mockResendInstance.emails.send.mockRejectedValue(
        new Error('Network error')
      );

      const request = createRequest('POST', {
        name: 'John Doe',
        email: 'john@example.com',
        message: 'This is a valid message for testing.',
      });

      const response = await worker.fetch(request, mockEnv);
      const data = await response.json();

      expect(response.status).toBe(500);
      expect(data.error).toContain('unexpected error');
    });

    it('returns 500 for invalid JSON body', async () => {
      const request = new Request('https://worker.test/', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: 'invalid json {',
      });

      const response = await worker.fetch(request, mockEnv);

      expect(response.status).toBe(500);
    });
  });

  describe('CORS Headers', () => {
    it('includes CORS headers on success response', async () => {
      mockResendInstance.emails.send.mockResolvedValue({
        data: { id: 'email_123' },
        error: null,
      });

      const request = createRequest('POST', {
        name: 'John Doe',
        email: 'john@example.com',
        message: 'This is a valid message for testing.',
      });

      const response = await worker.fetch(request, mockEnv);

      expect(response.headers.get('Access-Control-Allow-Origin')).toBe('*');
    });

    it('includes CORS headers on error response', async () => {
      const request = createRequest('POST', {
        name: '',
        email: 'invalid',
        message: '',
      });

      const response = await worker.fetch(request, mockEnv);

      expect(response.headers.get('Access-Control-Allow-Origin')).toBe('*');
    });
  });

  describe('XSS Prevention', () => {
    it('escapes HTML in name field', async () => {
      mockResendInstance.emails.send.mockResolvedValue({
        data: { id: 'email_123' },
        error: null,
      });

      const request = createRequest('POST', {
        name: '<script>alert("xss")</script>',
        email: 'test@example.com',
        message: 'This is a valid message for testing.',
      });

      await worker.fetch(request, mockEnv);

      expect(mockResendInstance.emails.send).toHaveBeenCalledWith(
        expect.objectContaining({
          html: expect.not.stringContaining('<script>'),
        })
      );
    });

    it('escapes HTML in message field', async () => {
      mockResendInstance.emails.send.mockResolvedValue({
        data: { id: 'email_123' },
        error: null,
      });

      const request = createRequest('POST', {
        name: 'John Doe',
        email: 'test@example.com',
        message: '<img src=x onerror=alert("xss")>Test message',
      });

      await worker.fetch(request, mockEnv);

      expect(mockResendInstance.emails.send).toHaveBeenCalledWith(
        expect.objectContaining({
          html: expect.not.stringContaining('<img'),
        })
      );
    });
  });
});
