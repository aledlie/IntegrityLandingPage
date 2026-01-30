# Access Review Policy and Procedures

**Organization:** Integrity Studio LLC
**Effective Date:** January 29, 2026
**Document Version:** 1.0
**Document Owner:** Data Protection Officer
**Review Frequency:** Annual
**Framework Reference:** SOC 2 CC6.1, CC6.2, CC6.3

---

## 1. Purpose and Scope

### 1.1 Purpose

This policy establishes requirements and procedures for conducting regular user access reviews to ensure:

- Access rights remain appropriate and aligned with job responsibilities
- Terminated or transferred users have access promptly revoked or modified
- Privileged access is justified and monitored
- Compliance with SOC 2, GDPR, and CCPA requirements

### 1.2 Scope

This policy applies to:

- All systems processing customer or business data
- All user accounts (employees, contractors, service accounts)
- All access types (standard, privileged, administrative)
- Third-party and vendor access

### 1.3 SOC 2 Control Alignment

| Control | Requirement | This Policy Addresses |
|---------|-------------|----------------------|
| **CC6.1** | Logical access security | Access appropriateness verification |
| **CC6.2** | User system credentials | User registration, modification, removal |
| **CC6.3** | Role-based access | Role assignment validation |

---

## 2. Roles and Responsibilities

| Role | Responsibilities |
|------|------------------|
| **Data Protection Officer** | Policy ownership, review oversight, compliance monitoring, escalation handling |
| **System Owners** | Conduct reviews for owned systems, approve/revoke access, document decisions |
| **IT/Engineering** | Provide access reports, execute access changes, maintain audit logs |
| **People Operations** | Communicate personnel changes, verify employment status |
| **Users** | Report access issues, comply with access policies |

---

## 3. Access Review Requirements

### 3.1 Review Frequency

| Access Type | Review Frequency | Rationale |
|-------------|------------------|-----------|
| **Privileged/Admin** | Quarterly | High-risk access requires frequent validation |
| **Standard User** | Semi-annually | Moderate risk, balanced with operational burden |
| **Service Accounts** | Quarterly | Automated access requires regular validation |
| **Vendor/Third-Party** | Quarterly | External access requires strict oversight |
| **Terminated Users** | Within 24 hours | Immediate risk mitigation |

### 3.2 Review Schedule

| Quarter | Review Type | Due Date | Systems Covered |
|---------|------------|----------|-----------------|
| Q1 | Privileged + Vendor + Service | March 31 | All systems |
| Q2 | All Users (comprehensive) | June 30 | All systems |
| Q3 | Privileged + Vendor + Service | September 30 | All systems |
| Q4 | All Users (comprehensive) | December 31 | All systems |

### 3.3 Systems in Scope

| System | Owner | Access Type | Review Priority |
|--------|-------|-------------|-----------------|
| **Production Infrastructure** | Engineering | Admin | Critical |
| **Cloud Provider (Vercel/AWS)** | Engineering | Admin | Critical |
| **Cloudflare** | Engineering | Admin | Critical |
| **SigNoz** | Engineering | Standard | High |
| **Sentry** | Engineering | Standard | High |
| **GitHub** | Engineering | Standard/Admin | High |
| **Google Workspace** | DPO | Standard/Admin | High |
| **Calendly** | DPO | Standard | Medium |
| **Resend** | Engineering | API Keys | Medium |
| **Analytics (GA4)** | DPO | Standard | Medium |

---

## 4. Access Review Procedures

### 4.1 Pre-Review Preparation

**Timeline:** 1 week before scheduled review

| Step | Action | Owner |
|------|--------|-------|
| 1 | Generate current access reports from all systems | IT/Engineering |
| 2 | Obtain current employee roster from People Operations | People Ops |
| 3 | Identify any personnel changes since last review | People Ops |
| 4 | Distribute access reports to System Owners | DPO |
| 5 | Schedule review sessions with System Owners | DPO |

### 4.2 Review Execution

**For each user account, verify:**

| Checkpoint | Question | Action if No |
|------------|----------|--------------|
| **Employment Status** | Is user still employed/contracted? | Immediate revocation |
| **Role Alignment** | Does access match current job function? | Modify access |
| **Least Privilege** | Is access level appropriate (not excessive)? | Reduce access |
| **Activity** | Has account been used in last 90 days? | Investigate/disable |
| **MFA Status** | Is MFA enabled where required? | Enable MFA |

### 4.3 Review Workflow

```
┌─────────────────┐
│ Generate Access │
│ Reports         │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ Compare to      │
│ Employee Roster │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ System Owner    │
│ Review          │
└────────┬────────┘
         │
    ┌────┴────┐
    ▼         ▼
┌───────┐  ┌───────────┐
│ Valid │  │ Invalid/  │
│       │  │ Excessive │
└───┬───┘  └─────┬─────┘
    │            │
    │            ▼
    │      ┌───────────┐
    │      │ Modify/   │
    │      │ Revoke    │
    │      └─────┬─────┘
    │            │
    └──────┬─────┘
           ▼
    ┌─────────────┐
    │ Document    │
    │ Decision    │
    └─────────────┘
```

### 4.4 Documentation Requirements

**For each review, document:**

1. **Review date and reviewer name**
2. **System reviewed**
3. **Total accounts reviewed**
4. **Accounts validated (no changes)**
5. **Accounts modified (with reason)**
6. **Accounts revoked (with reason)**
7. **Exceptions approved (with justification)**
8. **Sign-off from System Owner**

---

## 5. Access Review Template

### 5.1 Access Review Log

```
ACCESS REVIEW LOG

Review ID: AR-YYYY-QN-NNN
System: [System Name]
Review Date: [Date]
Reviewer: [Name]
Review Type: [Quarterly Privileged | Semi-Annual All Users]

SUMMARY:
- Total accounts reviewed: [Count]
- Accounts validated: [Count]
- Accounts modified: [Count]
- Accounts revoked: [Count]
- Exceptions: [Count]

PERSONNEL CHANGES SINCE LAST REVIEW:
- New hires: [Count]
- Terminations: [Count]
- Role changes: [Count]

REVIEW DETAILS:
[See attached spreadsheet or table below]

SIGN-OFF:
System Owner: _________________ Date: _________
DPO Approval: _________________ Date: _________
```

### 5.2 User Access Review Worksheet

| User | Email | Role | Access Level | Last Activity | Employment Status | Decision | Reason | Reviewer |
|------|-------|------|--------------|---------------|-------------------|----------|--------|----------|
| [Name] | [Email] | [Job Title] | [Admin/User] | [Date] | [Active/Term] | [Valid/Modify/Revoke] | [Reason] | [Initials] |

### 5.3 Privileged Access Review Worksheet

| User | System | Privilege Type | Business Justification | Last Used | Decision | Approver |
|------|--------|----------------|----------------------|-----------|----------|----------|
| [Name] | [System] | [Root/Admin/etc] | [Justification] | [Date] | [Valid/Revoke] | [Name] |

---

## 6. Access Lifecycle Management

### 6.1 Joiner Process (New Access)

| Step | Action | Timeline | Owner |
|------|--------|----------|-------|
| 1 | Manager submits access request | Before start date | Hiring Manager |
| 2 | Request approved by System Owner | Within 2 business days | System Owner |
| 3 | Access provisioned | Before start date | IT/Engineering |
| 4 | Access verified by user | First day | New User |
| 5 | Access documented in inventory | Within 1 week | IT/Engineering |

### 6.2 Mover Process (Role Change)

| Step | Action | Timeline | Owner |
|------|--------|----------|-------|
| 1 | Manager notifies of role change | Before effective date | Manager |
| 2 | Current access reviewed | Within 2 business days | System Owner |
| 3 | Unnecessary access revoked | Before new role starts | IT/Engineering |
| 4 | New access provisioned if needed | Before new role starts | IT/Engineering |
| 5 | Changes documented | Within 1 week | IT/Engineering |

### 6.3 Leaver Process (Termination)

| Step | Action | Timeline | Owner |
|------|--------|----------|-------|
| 1 | Termination notification received | Immediately | People Ops |
| 2 | All access revoked | Within 24 hours (same day if involuntary) | IT/Engineering |
| 3 | Sessions terminated | Immediately | IT/Engineering |
| 4 | Shared credentials rotated | Within 24 hours | IT/Engineering |
| 5 | Access removal verified | Within 48 hours | DPO |
| 6 | Revocation documented | Within 1 week | IT/Engineering |

---

## 7. Privileged Access Management

### 7.1 Privileged Access Requirements

| Requirement | Implementation |
|-------------|----------------|
| **Justification** | Business need documented and approved |
| **Approval** | System Owner + DPO approval required |
| **Time-bound** | Privileged access reviewed quarterly |
| **MFA Required** | All privileged accounts require MFA |
| **Separate Accounts** | Admins use separate accounts for privileged tasks |
| **Logging** | All privileged actions logged |

### 7.2 Privileged Access Inventory

| User | System | Privilege | Justification | Granted | Last Review | Next Review |
|------|--------|-----------|---------------|---------|-------------|-------------|
| [Name] | [System] | [Level] | [Reason] | [Date] | [Date] | [Date] |

### 7.3 Service Account Management

| Account | System | Purpose | Owner | Credential Storage | Last Rotation | Next Rotation |
|---------|--------|---------|-------|-------------------|---------------|---------------|
| [Name] | [System] | [Purpose] | [Owner] | [Vault/Env Var] | [Date] | [Date] |

---

## 8. Exception Handling

### 8.1 Exception Criteria

Exceptions may be granted when:

- Business need cannot be met through standard access
- Technical constraints prevent standard implementation
- Temporary access needed for specific project

### 8.2 Exception Approval Process

| Step | Action | Owner |
|------|--------|-------|
| 1 | Requestor documents exception justification | Requestor |
| 2 | System Owner reviews and recommends | System Owner |
| 3 | DPO reviews and approves/denies | DPO |
| 4 | Exception logged with expiration date | DPO |
| 5 | Exception reviewed at next scheduled review | DPO |

### 8.3 Exception Log

| Exception ID | User | System | Justification | Approved By | Expiration | Status |
|--------------|------|--------|---------------|-------------|------------|--------|
| EXC-YYYY-NNN | [Name] | [System] | [Reason] | [Approver] | [Date] | [Active/Expired] |

---

## 9. Audit and Compliance

### 9.1 Evidence Retention

| Evidence Type | Retention Period | Storage Location |
|---------------|------------------|------------------|
| Access review logs | 3 years | Secure document repository |
| Access change records | 3 years | System audit logs |
| Exception approvals | 3 years | Secure document repository |
| Termination checklists | 3 years | HR records |

### 9.2 Audit Trail Requirements

All access changes must be logged with:

- Timestamp
- User affected
- Change made (grant/modify/revoke)
- Requestor
- Approver
- Business justification

### 9.3 Compliance Metrics

| Metric | Target | Measurement |
|--------|--------|-------------|
| Review completion rate | 100% | Reviews completed on schedule |
| Termination access revocation | < 24 hours | Time from notification to revocation |
| Privileged access with justification | 100% | Documented business need |
| Inactive accounts | 0 | Accounts unused > 90 days |
| Unauthorized access findings | 0 | Access without proper approval |

### 9.4 Quarterly Review Checklist

- [ ] All systems reviewed per schedule
- [ ] All privileged accounts validated
- [ ] All vendor/third-party access validated
- [ ] All service accounts validated
- [ ] Terminated user access confirmed revoked
- [ ] Role changes processed correctly
- [ ] Exceptions reviewed and renewed/expired
- [ ] Review documentation complete
- [ ] Metrics calculated and reported
- [ ] Findings remediated

---

## 10. Reporting

### 10.1 Quarterly Access Review Report

| Section | Content |
|---------|---------|
| **Executive Summary** | Review completion status, key findings, metrics |
| **Review Coverage** | Systems reviewed, accounts reviewed by type |
| **Findings** | Access changes made, exceptions granted |
| **Metrics** | KPIs vs. targets |
| **Recommendations** | Process improvements, risk observations |

### 10.2 Report Distribution

| Recipient | Frequency | Report Type |
|-----------|-----------|-------------|
| Executive Leadership | Quarterly | Summary report |
| System Owners | Quarterly | System-specific details |
| External Auditors | Annual/On request | Full documentation package |

---

## 11. Current Access Inventory

### 11.1 System Access Summary

| System | Total Users | Privileged | Standard | Service Accounts | Last Review |
|--------|-------------|------------|----------|------------------|-------------|
| Production Infrastructure | [Count] | [Count] | [Count] | [Count] | - |
| Cloudflare | [Count] | [Count] | [Count] | [Count] | - |
| GitHub | [Count] | [Count] | [Count] | [Count] | - |
| SigNoz | [Count] | [Count] | [Count] | [Count] | - |
| Sentry | [Count] | [Count] | [Count] | [Count] | - |
| Google Workspace | [Count] | [Count] | [Count] | [Count] | - |

### 11.2 Initial Review Schedule

| Review | Systems | Due Date | Status |
|--------|---------|----------|--------|
| Q1 2026 Privileged Review | All | March 31, 2026 | Scheduled |
| Q2 2026 Comprehensive Review | All | June 30, 2026 | Scheduled |

---

## 12. Document Control

### 12.1 Version History

| Version | Date | Changes | Author |
|---------|------|---------|--------|
| 1.0 | January 29, 2026 | Initial access review policy | Compliance |

### 12.2 Approval

| Role | Name | Date |
|------|------|------|
| Data Protection Officer | Alyshia Ledlie | January 29, 2026 |
| Executive Approval | [Authorized Signatory] | [Date] |

### 12.3 Next Review

- **Annual Policy Review:** January 2027
- **Next Quarterly Access Review:** Q1 2026 (March 31, 2026)

---

## Appendix A: Quick Reference

### Access Review Calendar

| Month | Activity |
|-------|----------|
| January | Annual policy review |
| March | Q1 Privileged/Vendor/Service review |
| June | Q2 Comprehensive review |
| September | Q3 Privileged/Vendor/Service review |
| December | Q4 Comprehensive review |

### Termination Checklist

- [ ] All application access revoked
- [ ] Email account disabled
- [ ] Cloud provider access removed
- [ ] GitHub access removed
- [ ] Active sessions terminated
- [ ] Shared credentials rotated
- [ ] Physical access revoked (if applicable)
- [ ] Documentation completed

---

## Appendix B: References

- [SOC 2 CC6 - Logical and Physical Access](https://www.aicpa-cima.com/topic/audit-assurance/audit-and-assurance-greater-than-soc-2) - AICPA Trust Service Criteria
- [User Access Review Best Practices](https://secureframe.com/blog/user-access-reviews) - Secureframe Guide
- [SOC 2 User Access Reviews](https://ssae-16.com/resources/user-access-reviews-2/) - SSAE-16 Resources
- [Access Review Policy Template](https://www.zluri.com/blog/user-access-review-policy) - Zluri Compliance Guide

---

*This Access Review Policy establishes procedures in accordance with SOC 2 CC6.1, CC6.2, and CC6.3 requirements for logical access security.*
