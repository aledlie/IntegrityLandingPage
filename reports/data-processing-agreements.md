# Data Processing Agreements (DPAs) Registry

**Organization:** Integrity Studio LLC
**Last Updated:** January 29, 2026
**Document Owner:** Privacy/Compliance
**Review Frequency:** Annual

---

## Overview

This document maintains a registry of Data Processing Agreements (DPAs) with third-party service providers who process personal data on behalf of Integrity Studio LLC. DPAs are required under GDPR Article 28 and support CCPA service provider compliance.

---

## DPA Summary Matrix

| Vendor | Service Category | DPA Status | DPA Type | Personal Data Processed | Review Date |
|--------|-----------------|------------|----------|------------------------|-------------|
| Google (Analytics) | Analytics | Active | Online Acceptance | Usage data, device info, anonymized IP | Jan 29, 2026 |
| Calendly | Scheduling | Active | Online Acceptance | Name, email, scheduling preferences | Jan 29, 2026 |
| Meta (Facebook) | Marketing | Active | Accepted by Default | Device identifiers, ad interactions | Jan 29, 2026 |
| SigNoz | Observability | Active | Online Acceptance | Telemetry data, trace IDs | Jan 29, 2026 |
| Sentry | Error Tracking | Active | Online Acceptance | Error logs, device info, user context | Jan 29, 2026 |
| Resend | Email Service | Active | Online Acceptance | Email addresses, message content | Jan 29, 2026 |
| Cloudflare | CDN/Security | Active | Accepted by Default | IP addresses, request metadata | Jan 29, 2026 |

---

## Detailed DPA Records

### 1. Google Analytics (GA4)

| Field | Value |
|-------|-------|
| **Legal Entity** | Google LLC |
| **Service** | Google Analytics 4, Google Tag Manager |
| **DPA Location** | https://business.safety.google/adsprocessorterms/ |
| **DPA Type** | Google Ads Data Processing Terms (incorporated by reference) |
| **Acceptance Method** | Online acceptance via Google Admin Console |
| **Acceptance Date** | January 29, 2026 |
| **Data Processed** | Page views, session data, device/browser info, anonymized IP, user interactions |
| **Data Location** | United States (Google Cloud) |
| **Transfer Mechanism** | EU-US Data Privacy Framework (Google LLC certified) |
| **Sub-processors** | Google Cloud Platform infrastructure |
| **Retention** | 14 months (configurable in GA4 settings) |
| **Security Measures** | SOC 2 Type II, ISO 27001, encryption in transit/at rest |

**Configuration Notes:**
- IP anonymization enabled
- Data sharing disabled
- Advertising features disabled
- User-ID feature not implemented

**Relevant Clauses:**
- Section 5: Data Security
- Section 7: Data Subject Rights
- Section 10: Sub-processing
- Appendix 2: Security Measures

---

### 2. Calendly

| Field | Value |
|-------|-------|
| **Legal Entity** | Calendly LLC |
| **Service** | Online Scheduling Platform |
| **DPA Location** | https://calendly.com/legal/dpa |
| **DPA Type** | Standard DPA with SCCs |
| **Acceptance Method** | Online acceptance during account setup |
| **Acceptance Date** | January 29, 2026 |
| **Data Processed** | Name, email address, scheduling preferences, meeting notes, timezone |
| **Data Location** | United States (AWS) |
| **Transfer Mechanism** | Standard Contractual Clauses (Module 2: Controller to Processor) |
| **Sub-processors** | AWS, Twilio, Zoom (for integrations) |
| **Retention** | Duration of account + 30 days after deletion request |
| **Security Measures** | SOC 2 Type II, encryption, access controls |

**Sub-processor List:** https://calendly.com/legal/subprocessors

**Relevant Clauses:**
- Section 2: Scope and Roles
- Section 4: Data Subject Rights
- Section 6: Security Measures
- Section 8: International Transfers
- Annex I: Processing Details
- Annex II: Technical and Organizational Measures

---

### 3. Meta (Facebook Pixel)

| Field | Value |
|-------|-------|
| **Legal Entity** | Meta Platforms, Inc. |
| **Service** | Facebook Pixel, Conversion API |
| **DPA Location** | https://www.facebook.com/legal/terms/dataprocessing |
| **DPA Type** | Data Processing Terms (Accepted by Default) |
| **Acceptance Method** | Automatically accepted upon Pixel implementation |
| **Acceptance Date** | January 29, 2026 |
| **Data Processed** | Device identifiers, browser data, page interactions, conversion events |
| **Data Location** | United States and other Meta data centers |
| **Transfer Mechanism** | EU-US Data Privacy Framework (Meta Platforms certified) |
| **Sub-processors** | Meta infrastructure |
| **Retention** | Per Meta data retention policies |
| **Security Measures** | ISO 27001, SOC 2, encryption |

**Important Notes:**
- Meta acts as joint controller for certain data uses
- Data Processing Terms automatically apply when using Meta Business Tools
- Limited Events Measurement implemented for privacy compliance
- Pixel only fires after user consent (analytics/marketing cookies accepted)

**Configuration:**
- Consent Mode enabled
- Limited Data Use enabled for California users
- Advanced Matching disabled

**Relevant Clauses:**
- Meta Business Tools Terms: https://www.facebook.com/legal/terms/businesstools
- Data Processing Terms: Controller-to-Controller and Controller-to-Processor provisions
- EU Data Transfer Addendum incorporated

---

### 4. SigNoz

| Field | Value |
|-------|-------|
| **Legal Entity** | SigNoz Inc. |
| **Service** | Observability Platform (Traces, Metrics, Logs) |
| **DPA Location** | https://signoz.io/legal/dpa |
| **DPA Type** | Standard DPA |
| **Acceptance Method** | Online acceptance via SigNoz Cloud signup |
| **Acceptance Date** | January 29, 2026 |
| **Data Processed** | Application traces, metrics, logs, span attributes, service metadata |
| **Data Location** | United States (SigNoz Cloud - US region) |
| **Transfer Mechanism** | Standard Contractual Clauses |
| **Sub-processors** | Cloud infrastructure providers |
| **Retention** | 15 days (default), configurable per plan |
| **Security Measures** | Encryption in transit (TLS 1.3), encryption at rest, access controls |

**Data Classification:**
- Telemetry data (traces, metrics, logs)
- No PII transmitted by default
- Custom attributes may contain business data

**Configuration Notes:**
- Content capture enabled for LLM observability
- Sensitive data scrubbing configured for PII patterns
- Retention set to 15 days for traces, 30 days for metrics

**Relevant Clauses:**
- Section 3: Processing Instructions
- Section 5: Security Obligations
- Section 7: Data Deletion
- Exhibit A: Data Processing Details

---

### 5. Sentry

| Field | Value |
|-------|-------|
| **Legal Entity** | Functional Software, Inc. (dba Sentry) |
| **Service** | Application Error Monitoring |
| **DPA Location** | https://sentry.io/legal/dpa/ |
| **DPA Type** | Standard DPA with SCCs |
| **Acceptance Method** | Online acceptance during account creation |
| **Acceptance Date** | January 29, 2026 |
| **Data Processed** | Error stack traces, device info, browser data, user context (if configured), breadcrumbs |
| **Data Location** | United States (Sentry SaaS) |
| **Transfer Mechanism** | Standard Contractual Clauses (Module 2) |
| **Sub-processors** | Google Cloud Platform, AWS |
| **Retention** | 90 days (default), configurable |
| **Security Measures** | SOC 2 Type II, encryption, audit logging |

**Sub-processor List:** https://sentry.io/legal/subprocessors/

**Data Scrubbing Configuration:**
- IP address scrubbing: Enabled
- User data scrubbing: Enabled
- Credit card scrubbing: Enabled
- Password scrubbing: Enabled
- Custom PII patterns: Configured

**Relevant Clauses:**
- Section 2: Scope of Processing
- Section 5: Data Security
- Section 6: Sub-processing
- Section 9: Data Subject Rights
- Schedule 1: Processing Details
- Schedule 2: Security Measures
- Schedule 3: Standard Contractual Clauses

---

### 6. Resend

| Field | Value |
|-------|-------|
| **Legal Entity** | Resend, Inc. |
| **Service** | Transactional Email API |
| **DPA Location** | https://resend.com/legal/dpa |
| **DPA Type** | Standard DPA |
| **Acceptance Method** | Online acceptance during account setup |
| **Acceptance Date** | January 29, 2026 |
| **Data Processed** | Email addresses, email content, delivery metadata, recipient interactions |
| **Data Location** | United States (AWS) |
| **Transfer Mechanism** | Standard Contractual Clauses |
| **Sub-processors** | AWS (infrastructure), SendGrid (delivery) |
| **Retention** | 30 days for logs, immediate delivery |
| **Security Measures** | TLS encryption, API key authentication, SOC 2 |

**Use Cases:**
- Contact form submission confirmations
- Consultation booking confirmations
- Transactional notifications

**Configuration:**
- DKIM/SPF configured
- Bounce handling enabled
- Unsubscribe links included where applicable

**Relevant Clauses:**
- Section 1: Definitions
- Section 3: Data Processing
- Section 5: Security Measures
- Section 7: Audit Rights
- Annex A: Processing Description

---

### 7. Cloudflare

| Field | Value |
|-------|-------|
| **Legal Entity** | Cloudflare, Inc. |
| **Service** | CDN, DDoS Protection, DNS, Web Application Firewall |
| **DPA Location** | https://www.cloudflare.com/cloudflare-customer-dpa/ |
| **DPA Type** | Customer DPA (Accepted by Default) |
| **Acceptance Method** | Automatically incorporated into Terms of Service |
| **Acceptance Date** | January 29, 2026 |
| **Data Processed** | IP addresses, HTTP headers, request URLs, cookies (in transit) |
| **Data Location** | Global edge network (processed at nearest PoP) |
| **Transfer Mechanism** | EU-US Data Privacy Framework (Cloudflare certified), Binding Corporate Rules |
| **Sub-processors** | Cloudflare global infrastructure |
| **Retention** | Logs: 72 hours (default), Analytics: 30 days |
| **Security Measures** | SOC 2 Type II, ISO 27001, PCI DSS Level 1, encryption |

**Important Notes:**
- Cloudflare DPA automatically applies to all customers
- Acts as processor for customer zone data
- Binding Corporate Rules approved by EU DPAs
- Privacy-first analytics (no cookies required)

**Services Enabled:**
- CDN and caching
- SSL/TLS termination
- DDoS protection
- Web Application Firewall (WAF)
- Bot management

**Certifications:**
- SOC 2 Type II
- ISO 27001
- ISO 27701
- PCI DSS Level 1
- CSA STAR

**Relevant Clauses:**
- Section 2: Cloudflare as Processor
- Section 4: Security Measures
- Section 6: International Transfers
- Section 8: Audit Rights
- Annex 1: Processing Details
- Annex 2: Security Measures
- Annex 3: Standard Contractual Clauses

---

## Transfer Mechanism Summary

| Vendor | Primary Mechanism | Backup Mechanism |
|--------|------------------|------------------|
| Google Analytics | EU-US DPF | SCCs |
| Calendly | SCCs | - |
| Meta | EU-US DPF | SCCs |
| SigNoz | SCCs | - |
| Sentry | SCCs | - |
| Resend | SCCs | - |
| Cloudflare | EU-US DPF + BCRs | SCCs |

**EU-US Data Privacy Framework Status:**
- Framework adequacy decision: July 10, 2023
- Annual review of vendor certifications required

---

## Compliance Checklist

### GDPR Article 28 Requirements

| Requirement | Status |
|-------------|--------|
| Written contract/DPA in place | Complete |
| Processing only on documented instructions | Complete |
| Confidentiality obligations | Complete |
| Security measures implemented | Complete |
| Sub-processor approval mechanism | Complete |
| Assistance with data subject rights | Complete |
| Assistance with security obligations | Complete |
| Deletion/return of data provisions | Complete |
| Audit rights | Complete |

### CCPA Service Provider Requirements

| Requirement | Status |
|-------------|--------|
| Written contract in place | Complete |
| Prohibition on selling personal information | Verified |
| Prohibition on unauthorized use | Verified |
| Certification of understanding | Complete |

---

## Annual Review Schedule

| Vendor | Next Review Date | Reviewer |
|--------|-----------------|----------|
| Google Analytics | January 2027 | Privacy/Compliance |
| Calendly | January 2027 | Privacy/Compliance |
| Meta | January 2027 | Privacy/Compliance |
| SigNoz | January 2027 | Privacy/Compliance |
| Sentry | January 2027 | Privacy/Compliance |
| Resend | January 2027 | Privacy/Compliance |
| Cloudflare | January 2027 | Privacy/Compliance |

---

## Document History

| Version | Date | Changes | Author |
|---------|------|---------|--------|
| 1.0 | January 29, 2026 | Initial DPA registry | Privacy/Compliance |

---

## References

- GDPR Article 28: Processor obligations
- GDPR Article 46: Transfers subject to appropriate safeguards
- CCPA 1798.140(ag): Service provider definition
- EU-US Data Privacy Framework: https://www.dataprivacyframework.gov/
- Standard Contractual Clauses (2021): Commission Decision 2021/914
