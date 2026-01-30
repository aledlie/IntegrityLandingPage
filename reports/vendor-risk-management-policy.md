# Vendor Risk Management Policy

**Organization:** Integrity Studio LLC
**Effective Date:** January 29, 2026
**Document Version:** 1.0
**Document Owner:** Data Protection Officer
**Review Frequency:** Annual
**Framework Reference:** SOC 2 CC3.2, CC9.2, NIST 800-53 SA-9

---

## 1. Purpose and Scope

### 1.1 Purpose

This Vendor Risk Management Policy establishes requirements for evaluating, selecting, monitoring, and managing third-party vendors to ensure:

- Vendor relationships do not introduce unacceptable risk
- Customer data is protected when shared with vendors
- Regulatory compliance requirements are maintained
- Vendor security posture meets organizational standards

### 1.2 Scope

This policy applies to:

- All third-party vendors who access, store, process, or transmit organizational or customer data
- Vendors providing services that support critical business functions
- Cloud service providers and infrastructure vendors
- Software and SaaS providers
- Subcontractors and business partners
- Consultants and contractors with system access

### 1.3 SOC 2 Alignment

| Criteria | Requirement | This Policy Addresses |
|----------|-------------|----------------------|
| **CC3.2** | Risk identification including third parties | Vendor risk assessment process |
| **CC9.2** | Third-party risk management | Vendor evaluation, monitoring, contractual requirements |

---

## 2. Roles and Responsibilities

| Role | Responsibilities |
|------|------------------|
| **Data Protection Officer** | Policy ownership, risk assessment oversight, vendor approval authority |
| **Vendor Owner** | Primary contact for vendor relationship, day-to-day management |
| **Engineering Lead** | Technical security review, integration assessment |
| **Procurement/Finance** | Contract management, payment processing |
| **Legal Counsel** | Contract review, DPA negotiation |

---

## 3. Vendor Classification

### 3.1 Criticality Tiers

| Tier | Classification | Criteria | Examples |
|------|----------------|----------|----------|
| **Tier 1** | Critical | Access to sensitive/customer data; essential to operations; no alternative | Cloud infrastructure, payment processors, primary SaaS |
| **Tier 2** | Important | Access to business data; supports key functions; alternatives exist | Analytics, monitoring, email services |
| **Tier 3** | Standard | Limited data access; supports non-critical functions | General SaaS tools, office software |
| **Tier 4** | Low Risk | No data access; commoditized services | Office supplies, utilities |

### 3.2 Data Access Classification

| Level | Description | Requirements |
|-------|-------------|--------------|
| **Customer Data** | Access to customer PII, telemetry, or confidential data | Tier 1 or 2; DPA required; SOC 2 preferred |
| **Business Data** | Access to internal business information | Tier 2 or 3; Security review required |
| **Public Data** | Access to publicly available information only | Tier 3 or 4; Basic review |
| **No Data** | No access to organizational data | Tier 4; Minimal review |

### 3.3 Current Vendor Inventory

| Vendor | Service | Tier | Data Access | DPA Status | Last Assessment |
|--------|---------|------|-------------|------------|-----------------|
| Vercel | Hosting | 1 | Customer Data | Active | Jan 29, 2026 |
| Cloudflare | CDN/Security | 1 | Customer Data | Active | Jan 29, 2026 |
| SigNoz | Observability | 1 | Customer Data | Active | Jan 29, 2026 |
| Google Analytics | Analytics | 2 | Business Data | Active | Jan 29, 2026 |
| Sentry | Error Tracking | 2 | Business Data | Active | Jan 29, 2026 |
| Calendly | Scheduling | 3 | Business Data | Active | Jan 29, 2026 |
| Resend | Email | 2 | Customer Data | Active | Jan 29, 2026 |
| Meta (Facebook) | Marketing | 2 | Business Data | Active | Jan 29, 2026 |
| GitHub | Source Code | 2 | Business Data | Active | Jan 29, 2026 |
| Google Workspace | Business Tools | 2 | Business Data | Active | Jan 29, 2026 |

---

## 4. Vendor Assessment Process

### 4.1 Assessment Workflow

```
┌─────────────────┐
│ Vendor Need     │
│ Identified      │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ Initial         │
│ Screening       │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ Risk            │
│ Assessment      │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ Security        │
│ Review          │
└────────┬────────┘
         │
         ▼
┌─────────────────┐     ┌─────────────────┐
│ Approval        │────▶│ Contract &      │
│ Decision        │     │ Onboarding      │
└─────────────────┘     └────────┬────────┘
                                 │
                                 ▼
                        ┌─────────────────┐
                        │ Ongoing         │
                        │ Monitoring      │
                        └─────────────────┘
```

### 4.2 Initial Screening

**Required Information:**

- [ ] Company name, location, and contact information
- [ ] Description of services to be provided
- [ ] Data access requirements
- [ ] Proposed integration method
- [ ] Pricing and contract terms
- [ ] References (if available)

**Screening Criteria:**

| Criterion | Requirement |
|-----------|-------------|
| Business legitimacy | Established company with verifiable history |
| Service fit | Meets business requirements |
| Geographic location | Acceptable jurisdiction for data processing |
| Reputation | No significant adverse findings |

### 4.3 Risk Assessment

**Assessment Based on Tier:**

| Tier | Assessment Depth | Required Evidence |
|------|------------------|-------------------|
| **Tier 1** | Comprehensive | SOC 2 Type II, security questionnaire, penetration test results, DPA |
| **Tier 2** | Standard | SOC 2 (Type I or II), security questionnaire, DPA |
| **Tier 3** | Basic | Security certification or questionnaire, terms review |
| **Tier 4** | Minimal | Terms of service review |

### 4.4 Security Questionnaire

**Core Security Questions (Tier 1 & 2 Vendors):**

| Category | Questions |
|----------|-----------|
| **Security Program** | Do you have a documented security program? Who is responsible for security? |
| **Certifications** | Do you have SOC 2, ISO 27001, or equivalent certifications? |
| **Access Control** | How do you manage user access? Is MFA required? |
| **Encryption** | Is data encrypted in transit (TLS 1.2+) and at rest? |
| **Incident Response** | Do you have an incident response plan? What are notification timelines? |
| **Data Handling** | Where is data stored? Who has access? How is it protected? |
| **Subprocessors** | Do you use subprocessors? How are they managed? |
| **Business Continuity** | Do you have BCP/DR plans? What are your SLAs? |
| **Vulnerability Management** | How do you manage vulnerabilities? Frequency of scans/tests? |
| **Employee Security** | Do employees undergo background checks? Security training? |

### 4.5 Security Documentation Review

**Acceptable Security Evidence:**

| Evidence Type | Weight | Notes |
|---------------|--------|-------|
| **SOC 2 Type II Report** | Highest | Preferred; covers design and operating effectiveness |
| **SOC 2 Type I Report** | High | Acceptable for new vendors; Type II required at renewal |
| **ISO 27001 Certificate** | High | Acceptable; supplement with questionnaire |
| **SOC 1 Report** | Medium | Limited scope; supplement with questionnaire |
| **Penetration Test Results** | Medium | Supplement; not standalone |
| **Security Questionnaire** | Medium | Required when no certifications available |
| **Privacy Policy/Terms** | Low | Baseline requirement; not sufficient alone |

---

## 5. Risk Evaluation

### 5.1 Risk Scoring Matrix

**Likelihood × Impact = Risk Score**

| Factor | Low (1) | Medium (2) | High (3) |
|--------|---------|------------|----------|
| **Data Sensitivity** | Public data only | Business data | Customer PII, confidential |
| **Access Level** | Read-only, limited | Moderate access | Full access, admin |
| **Integration Depth** | Standalone | API integration | Deep system integration |
| **Vendor Security Posture** | Strong (SOC 2, ISO) | Moderate | Weak or unknown |
| **Replaceability** | Easily replaced | Alternatives exist | No alternatives |

**Risk Score Interpretation:**

| Score | Risk Level | Approval Authority | Monitoring |
|-------|------------|-------------------|------------|
| 1-4 | Low | Vendor Owner | Annual |
| 5-8 | Medium | DPO | Semi-annual |
| 9-12 | High | DPO + Executive | Quarterly |
| 13+ | Critical | Executive + Board | Continuous |

### 5.2 Risk Treatment Options

| Option | When to Use | Documentation |
|--------|-------------|---------------|
| **Accept** | Risk within tolerance; strong controls | Risk acceptance memo |
| **Mitigate** | Additional controls needed | Mitigation plan |
| **Transfer** | Insurance or contractual protection | Contract terms, insurance |
| **Avoid** | Risk unacceptable; seek alternative | Vendor rejection |

---

## 6. Contractual Requirements

### 6.1 Required Contract Provisions

| Provision | Tier 1 | Tier 2 | Tier 3 | Tier 4 |
|-----------|--------|--------|--------|--------|
| Data Processing Agreement (DPA) | Required | Required | Recommended | - |
| Confidentiality/NDA | Required | Required | Required | Recommended |
| Security requirements | Required | Required | Recommended | - |
| Incident notification | Required | Required | Recommended | - |
| Right to audit | Required | Recommended | - | - |
| Termination/data return | Required | Required | Recommended | - |
| Insurance requirements | Required | Recommended | - | - |
| SLA with penalties | Required | Recommended | - | - |
| Subprocessor approval | Required | Required | - | - |

### 6.2 Data Processing Agreement Requirements

Per GDPR Article 28, DPAs must include:

- [ ] Subject matter and duration of processing
- [ ] Nature and purpose of processing
- [ ] Type of personal data and categories of data subjects
- [ ] Obligations and rights of the controller
- [ ] Processing only on documented instructions
- [ ] Confidentiality obligations
- [ ] Security measures
- [ ] Subprocessor requirements
- [ ] Assistance with data subject rights
- [ ] Deletion or return of data on termination
- [ ] Audit rights

**Reference:** See `reports/data-processing-agreements.md` for DPA registry.

### 6.3 Security Addendum Requirements

| Requirement | Description |
|-------------|-------------|
| Encryption | TLS 1.2+ in transit; AES-256 at rest |
| Access control | Role-based access, MFA for privileged users |
| Logging | Audit logging with minimum 90-day retention |
| Vulnerability management | Regular scanning, timely patching |
| Incident notification | 24-72 hours depending on severity |
| Background checks | For personnel with data access |
| Security training | Annual security awareness training |

---

## 7. Vendor Onboarding

### 7.1 Onboarding Checklist

| Step | Owner | Timeline |
|------|-------|----------|
| Risk assessment completed | DPO | Before contract |
| Security review completed | Engineering | Before contract |
| Approval obtained | Per risk level | Before contract |
| Contract executed | Legal/Procurement | Before onboarding |
| DPA executed (if required) | DPO | Before data sharing |
| Access provisioned | Engineering | As needed |
| Integration tested | Engineering | Before production |
| Vendor added to inventory | DPO | Within 1 week |
| Monitoring configured | Engineering | Within 1 week |

### 7.2 Onboarding Documentation

| Document | Retention |
|----------|-----------|
| Risk assessment | 3 years after relationship ends |
| Security questionnaire responses | 3 years after relationship ends |
| SOC 2/Security reports | Duration of relationship + 1 year |
| Contracts and DPAs | 7 years after termination |
| Approval records | 3 years after relationship ends |

---

## 8. Ongoing Monitoring

### 8.1 Monitoring Schedule

| Vendor Tier | Assessment Frequency | Activities |
|-------------|---------------------|------------|
| **Tier 1** | Quarterly | SOC 2 review (annual), security news monitoring, performance review |
| **Tier 2** | Semi-annually | SOC 2 review (annual), periodic security check |
| **Tier 3** | Annually | Terms review, basic security verification |
| **Tier 4** | Biennial | Terms review |

### 8.2 Continuous Monitoring Activities

| Activity | Frequency | Owner |
|----------|-----------|-------|
| Vendor status page monitoring | Continuous | Engineering |
| Security news/breach alerts | Continuous | DPO |
| Performance monitoring | Continuous | Engineering |
| Contract expiration tracking | Monthly | Procurement |
| SOC 2 report collection | Annual | DPO |
| Security questionnaire refresh | Per schedule | DPO |

### 8.3 Monitoring Triggers

| Event | Required Action | Timeline |
|-------|-----------------|----------|
| Vendor security breach | Assess impact, consider termination | Immediate |
| SOC 2 report with exceptions | Review exceptions, require remediation plan | 30 days |
| Service degradation | Review SLA, escalate if needed | Per SLA |
| Contract expiration approaching | Renewal assessment | 90 days before |
| Vendor acquisition/merger | Re-assess risk | 30 days |
| Significant service change | Re-assess integration and risk | Before implementation |

### 8.4 Annual Review Checklist

- [ ] Collect current SOC 2 report (if applicable)
- [ ] Review any reported incidents or breaches
- [ ] Verify DPA and contract terms still appropriate
- [ ] Assess vendor performance against SLAs
- [ ] Review access granted to vendor
- [ ] Update risk assessment if needed
- [ ] Document review completion

---

## 9. Vendor Offboarding

### 9.1 Offboarding Triggers

- Contract termination or non-renewal
- Vendor acquisition creating conflict
- Unacceptable security risk identified
- Business need no longer exists
- Better alternative identified

### 9.2 Offboarding Checklist

| Step | Owner | Timeline |
|------|-------|----------|
| Termination notice sent | Procurement | Per contract terms |
| Data return/deletion requested | DPO | With termination notice |
| Access revoked | Engineering | Before termination effective |
| Integrations disabled | Engineering | Before termination effective |
| Credentials rotated | Engineering | Immediately |
| Data deletion confirmed | DPO | Per DPA terms (typically 30 days) |
| Vendor removed from inventory | DPO | Upon completion |
| Documentation archived | DPO | Upon completion |

### 9.3 Data Handling at Termination

| Requirement | Details |
|-------------|---------|
| **Data Return** | Request export of all organizational data in usable format |
| **Data Deletion** | Obtain written confirmation of deletion per DPA terms |
| **Retention** | Ensure vendor does not retain data beyond contractual period |
| **Backup Deletion** | Confirm deletion from backups per vendor's retention schedule |

---

## 10. Subprocessor Management

### 10.1 Subprocessor Requirements

Vendors using subprocessors must:

- Maintain current subprocessor list (publicly available or on request)
- Notify of subprocessor changes (typically 30 days advance notice)
- Ensure subprocessors meet equivalent security requirements
- Remain liable for subprocessor actions
- Provide right to object to new subprocessors

### 10.2 Subprocessor Review Process

| Step | Action |
|------|--------|
| 1 | Receive notification of new/changed subprocessor |
| 2 | Review subprocessor details (location, service, data access) |
| 3 | Assess risk impact |
| 4 | Approve, object, or request more information |
| 5 | Document decision |

---

## 11. Risk Register Integration

### 11.1 Vendor-Related Risks

Vendor risks are tracked in the organizational risk register (`reports/risk-assessment-program.md`).

| Risk ID | Vendor Risk | Inherent Risk | Controls | Residual Risk |
|---------|-------------|---------------|----------|---------------|
| RISK-2026-002 | Third-party data breach | 8 (Medium) | DPAs, SOC 2 review, monitoring | 5 (Medium) |

### 11.2 Escalation Criteria

| Condition | Escalation |
|-----------|------------|
| Tier 1 vendor breach affecting our data | Immediate executive notification |
| Vendor non-compliance with security requirements | DPO within 24 hours |
| Vendor refusing to provide security evidence | DPO for relationship review |
| Critical vendor financial instability | Executive for contingency planning |

---

## 12. Metrics and Reporting

### 12.1 Key Metrics

| Metric | Target | Frequency |
|--------|--------|-----------|
| Vendors with current assessments | 100% | Quarterly |
| Tier 1 vendors with SOC 2 reports | 100% | Annual |
| DPA coverage (Tier 1 & 2) | 100% | Quarterly |
| Vendors with expired contracts | 0 | Monthly |
| Average time to complete assessment | < 2 weeks | Quarterly |
| Vendor-related incidents | 0 | Quarterly |

### 12.2 Quarterly Vendor Report

| Section | Content |
|---------|---------|
| Vendor inventory summary | Count by tier, new/removed |
| Assessment status | Completed, pending, overdue |
| Risk summary | High-risk vendors, exceptions |
| Incidents | Any vendor-related incidents |
| Upcoming renewals | Contracts expiring in 90 days |
| Recommendations | Process improvements, concerns |

---

## 13. Document Control

### 13.1 Version History

| Version | Date | Changes | Author |
|---------|------|---------|--------|
| 1.0 | January 29, 2026 | Initial vendor risk management policy | Compliance |

### 13.2 Approval

| Role | Name | Date |
|------|------|------|
| Data Protection Officer | Alyshia Ledlie | January 29, 2026 |
| Executive Approval | [Authorized Signatory] | [Date] |

### 13.3 Related Documents

- `reports/data-processing-agreements.md` - DPA Registry
- `reports/risk-assessment-program.md` - Risk Assessment Program
- `reports/incident-response-plan.md` - Incident Response Plan

---

## Appendix A: Vendor Assessment Template

### Vendor Information

```
VENDOR ASSESSMENT

Assessment Date: [Date]
Assessor: [Name]
Vendor Name: [Name]
Service Description: [Description]
Proposed Tier: [1/2/3/4]

CONTACT INFORMATION:
- Primary Contact: [Name, Email, Phone]
- Security Contact: [Name, Email]
- Website: [URL]
- Location: [City, Country]

DATA ACCESS:
- Data types accessed: [List]
- Access method: [API, UI, File transfer]
- Data location: [Where stored]

SECURITY EVIDENCE:
- [ ] SOC 2 Type II Report (Date: ___)
- [ ] SOC 2 Type I Report (Date: ___)
- [ ] ISO 27001 Certificate (Date: ___)
- [ ] Security Questionnaire Completed
- [ ] Penetration Test Results
- [ ] Privacy Policy Reviewed

RISK ASSESSMENT:
- Data Sensitivity: [1-3]
- Access Level: [1-3]
- Integration Depth: [1-3]
- Security Posture: [1-3]
- Replaceability: [1-3]
- Total Risk Score: [Sum]

FINDINGS:
[Document any concerns or gaps]

RECOMMENDATION:
[ ] Approve
[ ] Approve with conditions: [List conditions]
[ ] Reject: [Reason]

APPROVAL:
Assessor Signature: _________________ Date: _________
DPO Approval: _________________ Date: _________
Executive Approval (if required): _________________ Date: _________
```

---

## Appendix B: References

- [SOC 2 Third-Party Requirements](https://www.upguard.com/blog/soc-2-third-party-requirements) - UpGuard
- [AICPA SOC 2 Third-Party Risk](https://www.prevalent.net/blog/aicpa-soc-2-third-party-risk-management/) - Mitratech
- [Vendor Risk Management Best Practices](https://www.vanta.com/collection/tprm/third-party-risk-requirements-soc-2) - Vanta
- [SOC 2 Vendor Management](https://www.ispartnersllc.com/blog/soc-2-vendor-management/) - IS Partners
- GDPR Article 28 - Processor requirements
- NIST 800-53 SA-9 - External System Services

---

*This Vendor Risk Management Policy establishes procedures in accordance with SOC 2 CC3.2 and CC9.2 requirements for third-party risk management.*
