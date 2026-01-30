# Incident Response Plan

**Organization:** Integrity Studio LLC
**Effective Date:** January 29, 2026
**Document Version:** 1.0
**Document Owner:** Data Protection Officer
**Review Frequency:** Annual
**Framework Reference:** NIST SP 800-61 Rev 3, NIST CSF 2.0

---

## 1. Purpose and Scope

### 1.1 Purpose

This Incident Response Plan (IRP) establishes procedures for detecting, responding to, and recovering from cybersecurity incidents affecting Integrity Studio's AI observability platform and business operations.

### 1.2 Scope

This plan applies to:

- All information systems and infrastructure
- Customer data and telemetry processed by the platform
- Third-party services and integrations
- Personnel with access to systems or data
- Physical facilities and equipment

### 1.3 Objectives

| Objective | Description |
|-----------|-------------|
| **Minimize Impact** | Reduce damage to systems, data, and business operations |
| **Rapid Recovery** | Restore normal operations as quickly as possible |
| **Evidence Preservation** | Maintain forensic integrity for investigation |
| **Regulatory Compliance** | Meet notification requirements (GDPR 72-hour, CCPA, etc.) |
| **Continuous Improvement** | Learn from incidents to prevent recurrence |

---

## 2. Incident Classification

### 2.1 Incident Definition

A security incident is any event that:

- Compromises the confidentiality, integrity, or availability of information
- Violates security policies or acceptable use policies
- Results in unauthorized access to systems or data
- Causes or threatens harm to the organization or customers

### 2.2 Incident Categories

| Category | Description | Examples |
|----------|-------------|----------|
| **Data Breach** | Unauthorized access to or disclosure of personal/confidential data | Exfiltration, accidental exposure, lost device |
| **Malware** | Malicious software infection | Ransomware, trojans, cryptominers |
| **Unauthorized Access** | Illegitimate system or account access | Credential compromise, privilege escalation |
| **Denial of Service** | Disruption of service availability | DDoS, resource exhaustion |
| **Insider Threat** | Malicious or negligent internal actor | Data theft, sabotage, policy violation |
| **Phishing/Social Engineering** | Deceptive attempts to obtain information | Spear phishing, business email compromise |
| **System Compromise** | Exploitation of vulnerabilities | Web application attacks, API abuse |
| **Physical Security** | Unauthorized physical access | Facility breach, device theft |

### 2.3 Severity Levels

| Severity | Impact | Response Time | Examples |
|----------|--------|---------------|----------|
| **Critical (P1)** | Confirmed data breach; complete service outage; active attacker | Immediate (< 1 hour) | Customer data exfiltration, ransomware, production down |
| **High (P2)** | Significant security risk; partial service degradation | < 4 hours | Credential compromise, malware detected, targeted attack |
| **Medium (P3)** | Contained security event; minimal business impact | < 24 hours | Phishing attempt, policy violation, suspicious activity |
| **Low (P4)** | Minor security event; no immediate threat | < 72 hours | Failed login attempts, minor policy deviation |

---

## 3. Incident Response Team

### 3.1 Team Structure

| Role | Primary | Backup | Responsibilities |
|------|---------|--------|------------------|
| **Incident Commander** | Alyshia Ledlie (DPO) | [Designated Backup] | Overall coordination, escalation decisions, external communications |
| **Technical Lead** | [Engineering Lead] | [Senior Engineer] | Technical investigation, containment, remediation |
| **Communications Lead** | Alyshia Ledlie | [Designated Backup] | Customer notification, regulatory reporting, PR |
| **Legal Counsel** | [External Counsel] | - | Legal guidance, breach notification requirements |
| **Executive Sponsor** | [CEO/Owner] | - | Resource authorization, major decisions |

### 3.2 Contact Information

| Role | Name | Email | Phone | Escalation |
|------|------|-------|-------|------------|
| Incident Commander | Alyshia Ledlie | privacy@integritystudio.ai | [Phone] | Primary |
| Technical Lead | [Name] | [Email] | [Phone] | 15 min no response |
| Executive Sponsor | [Name] | [Email] | [Phone] | P1/P2 incidents |
| Legal Counsel | [Firm Name] | [Email] | [Phone] | Data breach confirmed |

### 3.3 External Contacts

| Contact | Purpose | Contact Info |
|---------|---------|--------------|
| **Cloudflare Support** | DDoS mitigation, WAF | Enterprise support portal |
| **SigNoz Support** | Observability platform issues | support@signoz.io |
| **Sentry Support** | Error tracking | support@sentry.io |
| **Cyber Insurance** | [Provider] | [Policy #, Phone] |
| **FBI IC3** | Cybercrime reporting | ic3.gov |
| **CISA** | Critical infrastructure | cisa.gov/report |

---

## 4. Incident Response Lifecycle

### 4.1 Overview (Aligned with NIST CSF 2.0)

```
┌─────────────────────────────────────────────────────────────────────┐
│                         GOVERN                                       │
│  (Policy, Roles, Resources, Risk Management Integration)            │
└─────────────────────────────────────────────────────────────────────┘
         │                    │                    │
         ▼                    ▼                    ▼
┌─────────────┐      ┌─────────────┐      ┌─────────────┐
│  IDENTIFY   │      │   PROTECT   │      │   DETECT    │
│             │      │             │      │             │
│ • Assets    │      │ • Controls  │      │ • Monitor   │
│ • Risk      │      │ • Training  │      │ • Analyze   │
│ • Baseline  │      │ • Hardening │      │ • Alert     │
└─────────────┘      └─────────────┘      └──────┬──────┘
                                                  │
                     ┌────────────────────────────┘
                     ▼
              ┌─────────────┐
              │   RESPOND   │
              │             │
              │ • Triage    │
              │ • Contain   │
              │ • Eradicate │
              │ • Notify    │
              └──────┬──────┘
                     │
                     ▼
              ┌─────────────┐
              │   RECOVER   │
              │             │
              │ • Restore   │
              │ • Validate  │
              │ • Lessons   │
              └─────────────┘
```

---

## 5. Phase 1: Preparation

### 5.1 Preventive Measures

| Control | Implementation | Owner |
|---------|----------------|-------|
| Endpoint protection | [Antivirus/EDR solution] | Engineering |
| Network monitoring | Cloudflare WAF, access logs | Engineering |
| Application monitoring | Sentry error tracking, SigNoz observability | Engineering |
| Access controls | SSO, MFA, least privilege | DPO |
| Security training | Annual awareness program | DPO |
| Vulnerability management | Dependency updates, security patches | Engineering |

### 5.2 Detection Capabilities

| Source | What It Detects | Alert Mechanism |
|--------|-----------------|-----------------|
| **Cloudflare** | DDoS, bot attacks, WAF violations | Email, dashboard |
| **Sentry** | Application errors, exceptions | Email, Slack |
| **SigNoz** | Performance anomalies, trace analysis | Dashboard, alerts |
| **Application Logs** | Authentication failures, API abuse | Log aggregation |
| **Cloud Provider** | Infrastructure alerts, billing anomalies | Email, console |

### 5.3 Preparation Checklist

- [ ] Contact list current and tested quarterly
- [ ] Runbooks reviewed and updated annually
- [ ] Backup restoration tested quarterly
- [ ] Tabletop exercise conducted annually
- [ ] Legal counsel relationship established
- [ ] Cyber insurance policy current
- [ ] Regulatory notification templates prepared
- [ ] Forensic tools and procedures documented

---

## 6. Phase 2: Detection and Analysis

### 6.1 Detection Sources

| Priority | Source | Typical Indicators |
|----------|--------|-------------------|
| 1 | Security alerts | WAF blocks, authentication failures, anomalies |
| 2 | System monitoring | Performance degradation, resource exhaustion |
| 3 | User reports | Suspicious emails, unusual behavior, access issues |
| 4 | External notification | Customer reports, vendor alerts, threat intelligence |
| 5 | Threat intelligence | Industry alerts, vulnerability disclosures |

### 6.2 Initial Triage

**Within 15 minutes of detection:**

1. **Acknowledge** - Log incident receipt, assign initial responder
2. **Assess** - Determine category and preliminary severity
3. **Escalate** - Notify appropriate team members per severity
4. **Document** - Begin incident log with timestamp, source, initial observations

### 6.3 Analysis Questions

| Question | Purpose |
|----------|---------|
| What systems/data are affected? | Scope determination |
| When did it start? How was it detected? | Timeline establishment |
| Is the incident ongoing or contained? | Urgency assessment |
| What is the potential business impact? | Severity validation |
| Is customer data involved? | Breach determination |
| What evidence exists? | Forensic planning |

### 6.4 Incident Log Template

```
INCIDENT ID: INC-YYYY-NNN
STATUS: [Open | Contained | Resolved | Closed]
SEVERITY: [P1 | P2 | P3 | P4]
CATEGORY: [Data Breach | Malware | Unauthorized Access | ...]

TIMELINE:
[YYYY-MM-DD HH:MM] - Event description
[YYYY-MM-DD HH:MM] - Action taken
...

AFFECTED SYSTEMS:
- System 1: [Description]
- System 2: [Description]

AFFECTED DATA:
- Data type: [Description]
- Volume: [Estimate]
- Customers affected: [Count/Unknown]

TEAM MEMBERS:
- Incident Commander: [Name]
- Technical Lead: [Name]
- Others: [Names]

ACTIONS TAKEN:
1. [Action with timestamp]
2. [Action with timestamp]

EVIDENCE PRESERVED:
- [Evidence item with location]

NOTIFICATIONS:
- [Stakeholder]: [Date/Time] - [Method]

ROOT CAUSE: [To be determined/Description]

LESSONS LEARNED: [Post-incident]
```

---

## 7. Phase 3: Containment

### 7.1 Containment Strategies

| Incident Type | Immediate Actions | Short-term Containment |
|---------------|-------------------|----------------------|
| **Data Breach** | Revoke compromised credentials; isolate affected systems | Implement additional access controls; preserve evidence |
| **Malware** | Isolate infected systems; block C2 domains | Full malware scan; patch exploited vulnerabilities |
| **Unauthorized Access** | Disable compromised accounts; force password reset | Review access logs; implement additional MFA |
| **DDoS** | Enable Cloudflare Under Attack mode; rate limiting | Scale infrastructure; analyze attack patterns |
| **Insider Threat** | Revoke access immediately; secure evidence | HR involvement; legal consultation |

### 7.2 Containment Decision Matrix

| Factor | Contain Immediately | Investigate First |
|--------|--------------------|--------------------|
| Active data exfiltration | Yes | - |
| Production system compromise | Yes | - |
| Attacker still present | Depends on evidence needs | If evidence critical |
| Historical compromise | - | Yes |
| Low-severity event | - | Yes |

### 7.3 Evidence Preservation

**Before taking containment actions:**

1. Document current system state (screenshots, logs)
2. Capture volatile data (memory, network connections)
3. Preserve relevant logs (authentication, access, application)
4. Record all actions taken with timestamps
5. Maintain chain of custody documentation

**Evidence to preserve:**

| Evidence Type | Location | Retention |
|---------------|----------|-----------|
| Application logs | Log aggregation system | 90 days minimum |
| Access logs | Cloudflare, cloud provider | 90 days minimum |
| Authentication logs | Identity provider | 90 days minimum |
| Database audit logs | Database systems | 90 days minimum |
| System snapshots | Cloud provider | As needed |
| Network captures | Security tools | As needed |

---

## 8. Phase 4: Eradication and Recovery

### 8.1 Eradication Steps

| Step | Actions | Verification |
|------|---------|--------------|
| **Identify root cause** | Forensic analysis, log review | Document findings |
| **Remove threat** | Delete malware, close vulnerabilities | Scan confirmation |
| **Reset credentials** | Force password changes, rotate keys | Audit access |
| **Patch systems** | Apply security updates | Vulnerability scan |
| **Harden configuration** | Review and tighten settings | Configuration audit |

### 8.2 Recovery Steps

| Step | Actions | Criteria for Success |
|------|---------|---------------------|
| **Restore systems** | From clean backups or rebuild | System operational |
| **Validate integrity** | Verify data and system integrity | Checksums match |
| **Monitor closely** | Enhanced monitoring for recurrence | No anomalies for 48 hours |
| **Gradual restoration** | Phased return to normal operations | Services stable |
| **User communication** | Notify users of restoration | Acknowledgment received |

### 8.3 Recovery Priorities

| Priority | Systems | RTO Target |
|----------|---------|------------|
| 1 | Production platform (customer-facing) | 4 hours |
| 2 | Authentication and access control | 4 hours |
| 3 | Monitoring and observability | 8 hours |
| 4 | Internal tools and communications | 24 hours |
| 5 | Development and test environments | 72 hours |

---

## 9. Phase 5: Post-Incident Activity

### 9.1 Post-Incident Review

**Timing:** Within 5 business days of incident closure

**Participants:** All incident responders, relevant stakeholders

**Agenda:**

1. Incident timeline review
2. What worked well?
3. What could be improved?
4. Root cause analysis
5. Action items and owners
6. Documentation updates needed

### 9.2 Lessons Learned Template

```
INCIDENT: INC-YYYY-NNN
DATE OF REVIEW: [Date]
PARTICIPANTS: [Names]

INCIDENT SUMMARY:
[Brief description]

ROOT CAUSE:
[Technical and process root cause]

WHAT WORKED WELL:
1. [Item]
2. [Item]

WHAT COULD BE IMPROVED:
1. [Item with recommendation]
2. [Item with recommendation]

ACTION ITEMS:
| Item | Owner | Due Date | Status |
|------|-------|----------|--------|
| [Action] | [Name] | [Date] | [Status] |

METRICS:
- Time to detect: [Duration]
- Time to contain: [Duration]
- Time to resolve: [Duration]
- Total incident duration: [Duration]
- Customer impact: [Description]
```

### 9.3 Metrics Tracking

| Metric | Target | Measurement |
|--------|--------|-------------|
| Mean Time to Detect (MTTD) | < 1 hour (P1/P2) | Detection time - incident start |
| Mean Time to Contain (MTTC) | < 4 hours (P1/P2) | Containment time - detection time |
| Mean Time to Resolve (MTTR) | < 24 hours (P1/P2) | Resolution time - detection time |
| Incidents per quarter | Trending down | Count by severity |
| Repeat incidents | 0 | Same root cause recurrence |

---

## 10. Communication and Notification

### 10.1 Internal Communication

| Severity | Notify | Method | Timing |
|----------|--------|--------|--------|
| **P1** | Executive Sponsor, All IRT | Phone + Email | Immediate |
| **P2** | Incident Commander, Technical Lead | Email + Slack | Within 1 hour |
| **P3** | Incident Commander | Email | Within 4 hours |
| **P4** | Log only | Incident log | Next business day |

### 10.2 External Notification Requirements

| Regulation | Trigger | Deadline | Recipient |
|------------|---------|----------|-----------|
| **GDPR** | Personal data breach likely to result in risk | 72 hours | Supervisory authority |
| **GDPR** | High risk to individuals | Without undue delay | Affected individuals |
| **CCPA** | Breach of unencrypted personal information | "Expedient" / "Without unreasonable delay" | Affected California residents |
| **Contractual** | Per customer agreements | Per agreement | Affected customers |

### 10.3 Breach Notification Workflow

```
Breach Confirmed
      │
      ▼
┌─────────────────┐
│ Assess Scope    │
│ • Data types    │
│ • Volume        │
│ • Individuals   │
└────────┬────────┘
         │
         ▼
┌─────────────────┐     Yes    ┌─────────────────┐
│ Risk to         │───────────▶│ Notify Authority │
│ Individuals?    │            │ within 72 hours  │
└────────┬────────┘            └─────────────────┘
         │ No
         ▼
┌─────────────────┐     Yes    ┌─────────────────┐
│ High Risk to    │───────────▶│ Notify Affected  │
│ Individuals?    │            │ Individuals      │
└────────┬────────┘            └─────────────────┘
         │
         ▼
┌─────────────────┐
│ Document        │
│ Decision        │
└─────────────────┘
```

### 10.4 Notification Templates

**Regulatory Authority Notification (GDPR Article 33):**

```
BREACH NOTIFICATION TO SUPERVISORY AUTHORITY

Organization: Integrity Studio LLC
DPO Contact: privacy@integritystudio.ai

1. Nature of breach: [Description]
2. Categories of data: [List]
3. Approximate number of individuals: [Count]
4. Approximate number of records: [Count]
5. Name and contact of DPO: Alyshia Ledlie, privacy@integritystudio.ai
6. Likely consequences: [Description]
7. Measures taken/proposed: [Description]

Date: [Date]
Submitted by: [Name, Title]
```

**Customer Notification Template:**

```
Subject: Security Incident Notification - Integrity Studio

Dear [Customer],

We are writing to inform you of a security incident that may have affected
your data.

WHAT HAPPENED:
[Brief, factual description]

WHEN IT HAPPENED:
[Date/time range]

WHAT INFORMATION WAS INVOLVED:
[Specific data types]

WHAT WE ARE DOING:
[Actions taken and planned]

WHAT YOU CAN DO:
[Recommended actions for customer]

FOR MORE INFORMATION:
Contact our Data Protection Officer at privacy@integritystudio.ai

We sincerely apologize for any concern this may cause and are committed to
protecting your information.

Sincerely,
Integrity Studio LLC
```

---

## 11. Incident Response Runbooks

### 11.1 Runbook: Suspected Data Breach

| Step | Action | Owner | Time |
|------|--------|-------|------|
| 1 | Confirm breach - verify unauthorized access or exfiltration | Technical Lead | 30 min |
| 2 | Identify scope - systems, data types, volume, individuals | Technical Lead | 2 hours |
| 3 | Contain - revoke access, isolate systems | Technical Lead | 1 hour |
| 4 | Preserve evidence - logs, snapshots, forensic data | Technical Lead | Ongoing |
| 5 | Assess notification requirements | DPO + Legal | 4 hours |
| 6 | Notify supervisory authority if required | DPO | Within 72 hours |
| 7 | Notify affected individuals if high risk | DPO | ASAP after assessment |
| 8 | Eradicate threat and remediate | Technical Lead | Variable |
| 9 | Document and conduct post-incident review | Incident Commander | 5 days |

### 11.2 Runbook: DDoS Attack

| Step | Action | Owner | Time |
|------|--------|-------|------|
| 1 | Confirm DDoS - check Cloudflare analytics | Technical Lead | 15 min |
| 2 | Enable Cloudflare "Under Attack" mode | Technical Lead | Immediate |
| 3 | Review and tighten rate limiting rules | Technical Lead | 30 min |
| 4 | Scale infrastructure if needed | Technical Lead | As needed |
| 5 | Monitor attack patterns and adjust | Technical Lead | Ongoing |
| 6 | Communicate status to stakeholders | Communications Lead | Hourly |
| 7 | Document attack details for analysis | Technical Lead | Post-attack |
| 8 | Review and update DDoS mitigation strategy | Technical Lead | 1 week |

### 11.3 Runbook: Compromised Credentials

| Step | Action | Owner | Time |
|------|--------|-------|------|
| 1 | Disable compromised account immediately | Technical Lead | Immediate |
| 2 | Revoke all active sessions | Technical Lead | 15 min |
| 3 | Review account activity logs | Technical Lead | 1 hour |
| 4 | Identify scope of access and actions taken | Technical Lead | 2 hours |
| 5 | Reset credentials and enable MFA | Technical Lead | 30 min |
| 6 | Check for lateral movement or persistence | Technical Lead | 4 hours |
| 7 | Notify affected user securely | DPO | 1 hour |
| 8 | Assess if data breach occurred | DPO | 4 hours |
| 9 | Implement additional controls if needed | Technical Lead | Variable |

---

## 12. Testing and Maintenance

### 12.1 Testing Schedule

| Activity | Frequency | Participants | Last Completed | Next Scheduled |
|----------|-----------|--------------|----------------|----------------|
| Contact list verification | Quarterly | All IRT | - | April 2026 |
| Tabletop exercise | Annual | All IRT + Executives | - | Q2 2026 |
| Technical drill | Semi-annual | Technical team | - | Q2 2026 |
| Backup restoration test | Quarterly | Engineering | - | April 2026 |
| Plan review and update | Annual | DPO | January 2026 | January 2027 |

### 12.2 Tabletop Exercise Scenarios

1. **Scenario A: Ransomware Attack** - Production systems encrypted, ransom demanded
2. **Scenario B: Data Breach** - Customer data exfiltrated and posted online
3. **Scenario C: Insider Threat** - Employee downloads customer data before resignation
4. **Scenario D: Third-Party Breach** - Critical vendor compromised, our data exposed

### 12.3 Plan Maintenance

| Trigger | Action Required |
|---------|-----------------|
| Organizational change | Update roles and contacts |
| New system deployment | Add to scope and runbooks |
| Incident lessons learned | Incorporate improvements |
| Regulatory change | Update notification procedures |
| Annual review | Full plan review and update |

---

## 13. Document Control

### 13.1 Version History

| Version | Date | Changes | Author |
|---------|------|---------|--------|
| 1.0 | January 29, 2026 | Initial incident response plan | Compliance |

### 13.2 Approval

| Role | Name | Date |
|------|------|------|
| Data Protection Officer | Alyshia Ledlie | January 29, 2026 |
| Executive Approval | [Authorized Signatory] | [Date] |

### 13.3 Distribution

This document is distributed to:

- All Incident Response Team members
- Executive leadership
- Legal counsel (as needed)

---

## Appendix A: Quick Reference Card

### Incident Response Hotline

**Email:** security@integritystudio.ai
**DPO:** privacy@integritystudio.ai

### Severity Quick Guide

| See This? | Severity | Do This |
|-----------|----------|---------|
| Confirmed data breach | **P1 CRITICAL** | Call Incident Commander immediately |
| Production down | **P1 CRITICAL** | Call Incident Commander immediately |
| Malware/ransomware | **P1 CRITICAL** | Isolate system, call Incident Commander |
| Credential compromise | **P2 HIGH** | Disable account, notify Incident Commander |
| Suspicious activity | **P3 MEDIUM** | Log and email Incident Commander |
| Minor policy violation | **P4 LOW** | Document and report next business day |

### First 15 Minutes Checklist

- [ ] Document what you observed (time, system, symptoms)
- [ ] Do NOT power off affected systems (preserves evidence)
- [ ] Do NOT attempt to "fix" the issue alone
- [ ] Contact Incident Commander with initial report
- [ ] Secure the area if physical access involved
- [ ] Preserve any evidence (screenshots, photos)

---

## Appendix B: References

- [NIST SP 800-61 Rev 3](https://csrc.nist.gov/pubs/sp/800/61/r3/final) - Incident Response Recommendations (April 2025)
- [NIST Cybersecurity Framework 2.0](https://www.nist.gov/cyberframework) - CSF 2.0 Functions
- [GDPR Article 33](https://gdpr-info.eu/art-33-gdpr/) - Notification of personal data breach
- [GDPR Article 34](https://gdpr-info.eu/art-34-gdpr/) - Communication to data subject
- CCPA 1798.82 - Security breach notification

---

*This Incident Response Plan establishes procedures in accordance with SOC 2 CC7 (System Operations) and NIST SP 800-61 Rev 3 requirements.*
