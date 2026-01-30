# Change Management Policy

**Organization:** Integrity Studio LLC
**Effective Date:** January 29, 2026
**Document Version:** 1.0
**Document Owner:** Engineering Lead
**Review Frequency:** Annual
**Framework Reference:** SOC 2 CC8.1, ITIL Change Management

---

## 1. Purpose and Scope

### 1.1 Purpose

This Change Management Policy establishes requirements for authorizing, designing, developing, configuring, documenting, testing, approving, and implementing changes to:

- Minimize disruption to services
- Maintain system integrity and security
- Ensure traceability and accountability
- Meet SOC 2 compliance requirements

### 1.2 Scope

This policy applies to all changes to:

- Production infrastructure and environments
- Application code and configurations
- Database schemas and data
- Network configurations
- Security controls and policies
- Third-party integrations
- Documentation (where operationally significant)

### 1.3 SOC 2 Alignment

| Criteria | Requirement | This Policy Addresses |
|----------|-------------|----------------------|
| **CC8.1** | Changes are authorized, designed, developed, configured, documented, tested, approved, and implemented | Full change lifecycle management |

---

## 2. Roles and Responsibilities

| Role | Responsibilities |
|------|------------------|
| **Change Requester** | Initiates change request, provides business justification |
| **Change Owner** | Responsible for change implementation, testing, documentation |
| **Technical Reviewer** | Reviews technical design, security implications |
| **Change Approver** | Authorizes change for implementation |
| **Change Manager** | Oversees change process, maintains change log, reports metrics |
| **Release Manager** | Coordinates deployments, manages release schedule |

### 2.1 Current Assignments

| Role | Assignment |
|------|------------|
| Change Manager | Engineering Lead |
| Default Change Approver | Engineering Lead |
| Emergency Change Approver | DPO or Engineering Lead |
| Release Manager | Engineering Lead |

---

## 3. Change Classification

### 3.1 Change Types

| Type | Description | Examples | Approval |
|------|-------------|----------|----------|
| **Standard** | Pre-approved, low-risk, routine changes | Dependency updates, minor config changes | Pre-approved |
| **Normal** | Planned changes requiring review | New features, infrastructure changes | Change Approver |
| **Emergency** | Urgent changes to restore service or fix critical issues | Security patches, outage resolution | Emergency Approver |

### 3.2 Risk Classification

| Risk Level | Criteria | Review Requirements |
|------------|----------|---------------------|
| **Low** | No customer impact; easily reversible; tested pattern | Peer review |
| **Medium** | Limited customer impact; reversible; some complexity | Peer review + Approver |
| **High** | Significant customer impact; complex; limited reversibility | Full CAB review |
| **Critical** | Major customer impact; high complexity; irreversible | CAB + Executive |

### 3.3 Risk Assessment Criteria

| Factor | Low (1) | Medium (2) | High (3) |
|--------|---------|------------|----------|
| **Customer Impact** | None | Limited/degraded | Significant/outage |
| **Data Risk** | No data changes | Config changes | Schema/data changes |
| **Reversibility** | Instant rollback | Minutes to rollback | Complex/impossible |
| **Complexity** | Simple, tested | Moderate | Complex, untested |
| **Dependencies** | None | Few | Many systems |

**Risk Score = Sum of factors**
- 5-7: Low Risk
- 8-11: Medium Risk
- 12-14: High Risk
- 15: Critical Risk

---

## 4. Change Management Process

### 4.1 Process Overview

```
┌─────────────────┐
│ 1. REQUEST      │
│   • Initiate    │
│   • Classify    │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ 2. ASSESS       │
│   • Risk        │
│   • Impact      │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ 3. REVIEW       │
│   • Technical   │
│   • Security    │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ 4. APPROVE      │
│   • Authorize   │
│   • Schedule    │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ 5. IMPLEMENT    │
│   • Deploy      │
│   • Test        │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ 6. CLOSE        │
│   • Verify      │
│   • Document    │
└─────────────────┘
```

### 4.2 Phase 1: Request

**Required Information:**

| Field | Description | Required |
|-------|-------------|----------|
| Change Title | Brief description | Yes |
| Change Description | Detailed explanation of what and why | Yes |
| Business Justification | Why is this change needed? | Yes |
| Change Type | Standard / Normal / Emergency | Yes |
| Requested By | Change requester | Yes |
| Change Owner | Person responsible for implementation | Yes |
| Affected Systems | Systems impacted | Yes |
| Proposed Date/Time | When to implement | Yes |

### 4.3 Phase 2: Assess

**Risk Assessment:**

- [ ] Customer impact evaluated
- [ ] Data risk assessed
- [ ] Reversibility determined
- [ ] Complexity evaluated
- [ ] Dependencies identified
- [ ] Risk score calculated

**Impact Assessment:**

- [ ] Affected users/customers identified
- [ ] Downtime requirements documented
- [ ] Communication needs identified
- [ ] Resource requirements confirmed

### 4.4 Phase 3: Review

**Technical Review Requirements:**

| Risk Level | Review Requirement |
|------------|-------------------|
| Low | Peer review (1 reviewer) |
| Medium | Peer review + Tech Lead |
| High | Peer review + Tech Lead + Security |
| Critical | Full team review + Security + DPO |

**Review Checklist:**

- [ ] Technical design is sound
- [ ] Security implications addressed
- [ ] Testing plan adequate
- [ ] Rollback plan documented
- [ ] Documentation updated
- [ ] Dependencies coordinated

**Segregation of Duties:**

- Developer cannot approve their own changes
- Reviewer must be different from implementer
- Production access requires approval

### 4.5 Phase 4: Approve

**Approval Authority:**

| Change Type | Risk Level | Approver |
|-------------|------------|----------|
| Standard | Any | Pre-approved |
| Normal | Low | Tech Lead |
| Normal | Medium | Change Approver |
| Normal | High/Critical | CAB (Change Advisory Board) |
| Emergency | Any | Emergency Approver |

**Approval Criteria:**

- [ ] All review comments addressed
- [ ] Testing completed successfully
- [ ] Rollback plan verified
- [ ] Communication plan confirmed
- [ ] Scheduled during approved window

### 4.6 Phase 5: Implement

**Pre-Implementation:**

- [ ] Change approved and documented
- [ ] Stakeholders notified
- [ ] Backups/snapshots taken
- [ ] Rollback plan ready
- [ ] Monitoring in place

**Implementation:**

- [ ] Follow documented procedure
- [ ] Log all actions taken
- [ ] Verify each step before proceeding
- [ ] Communicate status updates

**Post-Implementation:**

- [ ] Verify change successful
- [ ] Run validation tests
- [ ] Monitor for anomalies
- [ ] Confirm rollback plan still viable

### 4.7 Phase 6: Close

**Closure Requirements:**

- [ ] Change verified successful
- [ ] Documentation updated
- [ ] Stakeholders notified
- [ ] Change record completed
- [ ] Lessons learned captured (if applicable)

---

## 5. Standard Changes

### 5.1 Pre-Approved Standard Changes

Standard changes are low-risk, routine changes that follow documented procedures and are pre-approved.

| Standard Change | Procedure | Approval | Documentation |
|-----------------|-----------|----------|---------------|
| Dependency version updates (patch) | Update, test, deploy | Pre-approved | Commit message |
| SSL certificate renewal | Auto-renewal or manual | Pre-approved | Log entry |
| DNS record updates (non-critical) | Cloudflare dashboard | Pre-approved | Change log |
| User access provisioning | Per access policy | Pre-approved | Access log |
| Content/copy updates | CMS or code | Pre-approved | Commit message |
| Monitoring threshold adjustments | Config change | Pre-approved | Change log |

### 5.2 Standard Change Requirements

- Follow documented procedure
- No deviation from approved scope
- Log the change
- Can be elevated to Normal if issues arise

---

## 6. Emergency Changes

### 6.1 Emergency Change Criteria

Emergency changes are justified only when:

- Service is down or critically degraded
- Security vulnerability is actively exploited
- Data loss is occurring or imminent
- Regulatory or legal requirement with immediate deadline

### 6.2 Emergency Change Process

| Step | Action | Timeline |
|------|--------|----------|
| 1 | Identify emergency and notify Emergency Approver | Immediate |
| 2 | Obtain verbal approval | < 15 minutes |
| 3 | Implement change with available resources | ASAP |
| 4 | Document actions taken | During/immediately after |
| 5 | Verify resolution | After implementation |
| 6 | Complete formal change record | Within 24 hours |
| 7 | Post-incident review | Within 5 business days |

### 6.3 Emergency Change Documentation

Emergency changes require retrospective documentation within 24 hours:

- [ ] Change request created/updated
- [ ] Justification for emergency classification
- [ ] Actions taken documented
- [ ] Approval documented (verbal → written)
- [ ] Impact assessment completed
- [ ] Lessons learned captured

---

## 7. Change Windows

### 7.1 Deployment Windows

| Window Type | Time (UTC) | Suitable For |
|-------------|------------|--------------|
| **Standard** | Weekdays 10:00-16:00 | Low-risk changes, standard changes |
| **Extended** | Weekdays 08:00-20:00 | Medium-risk changes |
| **Maintenance** | Saturday 02:00-06:00 | High-risk changes, maintenance |
| **Emergency** | Any time | Emergency changes only |

### 7.2 Change Freeze Periods

| Period | Dates | Allowed Changes |
|--------|-------|-----------------|
| End of Quarter | Last 3 business days | Emergency only |
| Major Holidays | Per calendar | Emergency only |
| Product Launches | As designated | Emergency only |

---

## 8. Testing Requirements

### 8.1 Testing by Risk Level

| Risk Level | Required Testing |
|------------|-----------------|
| Low | Unit tests, basic smoke test |
| Medium | Unit tests, integration tests, staging validation |
| High | Full test suite, staging validation, UAT |
| Critical | Full test suite, staging, UAT, performance testing |

### 8.2 Test Documentation

| Test Type | Documentation Required |
|-----------|----------------------|
| Unit Tests | Test results (automated) |
| Integration Tests | Test results (automated) |
| Staging Validation | Validation checklist |
| UAT | Sign-off from stakeholder |
| Performance Tests | Performance metrics comparison |

### 8.3 Testing Environments

| Environment | Purpose | Access |
|-------------|---------|--------|
| Development | Developer testing | Developers |
| Staging | Pre-production validation | Team |
| Production | Live environment | Restricted |

---

## 9. Rollback Procedures

### 9.1 Rollback Plan Requirements

Every change must have a documented rollback plan including:

- [ ] Rollback trigger criteria
- [ ] Rollback steps
- [ ] Estimated rollback time
- [ ] Data recovery steps (if applicable)
- [ ] Verification steps

### 9.2 Rollback Decision Criteria

| Condition | Action |
|-----------|--------|
| Change fails validation tests | Rollback |
| Critical errors detected | Rollback |
| Performance degradation > 20% | Assess, likely rollback |
| Customer-impacting issues | Rollback |
| Security vulnerability introduced | Immediate rollback |

### 9.3 Rollback Methods

| Change Type | Rollback Method |
|-------------|-----------------|
| Application code | Redeploy previous version (Vercel) |
| Configuration | Revert config, redeploy |
| Database schema | Run rollback migration |
| Database data | Restore from backup |
| Infrastructure | Revert IaC, redeploy |

---

## 10. Documentation Requirements

### 10.1 Change Record

Every change must be documented with:

| Field | Required | Description |
|-------|----------|-------------|
| Change ID | Yes | Unique identifier |
| Title | Yes | Brief description |
| Description | Yes | What was changed and why |
| Type | Yes | Standard/Normal/Emergency |
| Risk Level | Yes | Low/Medium/High/Critical |
| Requester | Yes | Who requested |
| Owner | Yes | Who implemented |
| Approver | Yes | Who approved |
| Requested Date | Yes | When requested |
| Implemented Date | Yes | When implemented |
| Status | Yes | Open/Approved/Implemented/Closed/Rejected |
| Affected Systems | Yes | What was impacted |
| Test Results | Yes | Pass/Fail, evidence |
| Rollback Plan | Yes | How to reverse |
| Outcome | Yes | Success/Failed/Rolled back |

### 10.2 Evidence Retention

| Evidence Type | Retention Period |
|---------------|------------------|
| Change records | 3 years |
| Approval documentation | 3 years |
| Test results | 1 year |
| Deployment logs | 1 year |
| Rollback documentation | 1 year |

---

## 11. Tools and Systems

### 11.1 Change Management Tools

| Tool | Purpose | Usage |
|------|---------|-------|
| **GitHub** | Code changes, PRs, reviews | All code changes |
| **GitHub Issues/Projects** | Change tracking | Normal/Emergency changes |
| **Vercel** | Deployment management | Production deployments |
| **Slack** | Communication | Change notifications |

### 11.2 GitHub Workflow

```
┌─────────────────┐
│ Feature Branch  │
│ (Development)   │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ Pull Request    │
│ (Review)        │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ Approval        │
│ (1+ Reviewers)  │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ Merge to Main   │
│ (Auto-deploy)   │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ Production      │
│ (Vercel)        │
└─────────────────┘
```

### 11.3 Branch Protection Rules

| Rule | Setting |
|------|---------|
| Require pull request | Yes |
| Required reviewers | 1 minimum |
| Require status checks | Yes (tests) |
| Require branches up to date | Yes |
| Restrict who can push to main | Admin only |

---

## 12. Metrics and Reporting

### 12.1 Key Metrics

| Metric | Target | Measurement |
|--------|--------|-------------|
| Change success rate | > 95% | Successful / Total |
| Emergency change rate | < 10% | Emergency / Total |
| Mean time to implement | < 24 hours (Normal) | Request to close |
| Failed changes | < 5% | Rolled back / Total |
| Changes with incidents | 0% | Changes causing incidents |

### 12.2 Monthly Change Report

| Section | Content |
|---------|---------|
| Summary | Total changes, by type, by risk |
| Success Rate | Successful vs. failed/rolled back |
| Trends | Month-over-month comparison |
| Incidents | Changes that caused issues |
| Exceptions | Emergency changes, policy deviations |
| Improvements | Process improvement recommendations |

---

## 13. Compliance and Audit

### 13.1 Audit Evidence

For SOC 2 audits, maintain evidence of:

- [ ] Approved change management policy
- [ ] Sample of change records with approvals
- [ ] Evidence of testing before implementation
- [ ] Segregation of duties enforcement
- [ ] Emergency change documentation
- [ ] Change success/failure metrics

### 13.2 Control Points

| Control | Evidence |
|---------|----------|
| Changes are authorized | Approval in PR/ticket |
| Changes are tested | Test results, CI/CD logs |
| Changes are documented | Change records, commit messages |
| Segregation of duties | Different requester/approver/implementer |
| Rollback capability | Rollback plan, deployment history |

---

## 14. Document Control

### 14.1 Version History

| Version | Date | Changes | Author |
|---------|------|---------|--------|
| 1.0 | January 29, 2026 | Initial change management policy | Compliance |

### 14.2 Approval

| Role | Name | Date |
|------|------|------|
| Engineering Lead | [Name] | January 29, 2026 |
| DPO | Alyshia Ledlie | January 29, 2026 |

### 14.3 Related Documents

- `reports/incident-response-plan.md` - For changes related to incidents
- `reports/access-review-policy.md` - For access-related changes
- `reports/business-continuity-plan.md` - For DR-related changes

---

## Appendix A: Change Request Template

```
CHANGE REQUEST

Change ID: CHG-YYYY-NNN
Status: [Draft | Pending Review | Approved | Implementing | Closed | Rejected]

BASIC INFORMATION:
- Title: [Brief description]
- Description: [Detailed explanation]
- Business Justification: [Why is this needed?]
- Change Type: [ ] Standard  [ ] Normal  [ ] Emergency
- Risk Level: [ ] Low  [ ] Medium  [ ] High  [ ] Critical

REQUESTOR INFORMATION:
- Requested By: [Name]
- Request Date: [Date]
- Change Owner: [Name]

AFFECTED SYSTEMS:
- Systems: [List]
- Environments: [Dev | Staging | Production]
- Dependencies: [List]

SCHEDULE:
- Proposed Date/Time: [Date, Time UTC]
- Change Window: [Standard | Extended | Maintenance | Emergency]
- Estimated Duration: [Time]
- Downtime Required: [ ] Yes (Duration: ___) [ ] No

IMPLEMENTATION PLAN:
1. [Step 1]
2. [Step 2]
3. [Step 3]

TESTING PLAN:
- Tests to run: [List]
- Expected results: [Description]
- Test environment: [Environment]

ROLLBACK PLAN:
- Trigger criteria: [When to rollback]
- Rollback steps:
  1. [Step 1]
  2. [Step 2]
- Estimated rollback time: [Time]

COMMUNICATION PLAN:
- Stakeholders to notify: [List]
- Notification timing: [Before/During/After]

APPROVALS:
- Technical Reviewer: _____________ Date: _______
- Change Approver: _____________ Date: _______

IMPLEMENTATION:
- Implemented By: [Name]
- Implementation Date: [Date]
- Outcome: [ ] Success  [ ] Failed  [ ] Rolled Back
- Notes: [Any issues or observations]

CLOSURE:
- Verified By: [Name]
- Closure Date: [Date]
- Lessons Learned: [If applicable]
```

---

## Appendix B: Quick Reference

### Change Type Decision Tree

```
Is there a service outage or critical security issue?
├── Yes → EMERGENCY CHANGE
└── No → Is this a routine, pre-approved change?
    ├── Yes → STANDARD CHANGE
    └── No → NORMAL CHANGE
```

### Risk Level Quick Guide

| If... | Risk Level |
|-------|------------|
| No customer impact, easily reversible | Low |
| Limited impact, can rollback in minutes | Medium |
| Customer-facing, complex rollback | High |
| Major impact, irreversible | Critical |

### Approval Quick Reference

| Change Type | Low Risk | Medium+ Risk |
|-------------|----------|--------------|
| Standard | Pre-approved | N/A |
| Normal | Tech Lead | Change Approver/CAB |
| Emergency | Emergency Approver | Emergency Approver |

---

## Appendix C: References

- [SOC 2 CC8.1 Explained](https://www.isms.online/soc-2/controls/change-management-cc8-1-explained/) - ISMS.online
- [SOC 2 Change Management](https://sprinto.com/blog/soc-2-change-management/) - Sprinto
- [Change Management Best Practices](https://kirkpatrickprice.com/video/soc-2-academy-change-management-best-practices/) - KirkpatrickPrice
- [CC8 Common Criteria](https://www.designcs.net/soc-2-cc8-common-criteria-related-to-change-management/) - Design Compliance
- ITIL Change Management Framework

---

*This Change Management Policy establishes procedures in accordance with SOC 2 CC8.1 requirements for change authorization, design, development, configuration, documentation, testing, approval, and implementation.*
