# Security Decisions - Azure E2E Infrastructure Baseline

## Overview

This document explains the security design decisions implemented within the Azure End-to-End Infrastructure project and the reasoning behind each choice.

The goal was not only to deploy infrastructure, but to demonstrate production-aligned security architecture using Azure-native capabilities while operating within free-tier subscription constraints.

Security controls were selected according to the principles of:

- Least privilege
- Defense in depth
- Identity-first security
- Centralized observability
- Secure-by-default configuration

---

## 1. RBAC-Based Key Vault Authorization

### Decision

Azure Key Vault was configured using RBAC authorization instead of legacy access policies.
rbac_authorization_enabled = true


### Reasoning

RBAC provides:

- Centralized identity governance
- Alignment with enterprise Azure standards
- Consistent authorization model across services
- Integration with Azure AD auditing

Access policies create fragmented permission management and are not recommended for modern deployments.

### Security Benefit

- Permissions managed via roles instead of secrets
- Easier auditing and governance
- Reduced configuration drift risk

---

## 2. Managed Identity Instead of Credentials

### Decision

System-assigned managed identities are used for resource authentication.

### Reasoning

Storing credentials or secrets inside Terraform or application configuration introduces risk.

Managed identities provide:

- Automatic credential rotation
- Azure AD-backed authentication
- No secret storage requirements

### Security Benefit

- Eliminates secret exposure in source control
- Prevents credential leakage
- Enables secure service-to-service communication

---

## 3. Key Vault Protection Controls

### Decision

Key Vault configured with:

- Soft delete enabled
- Purge protection enabled
- RBAC authorization model

soft_delete_retention_days = 7
purge_protection_enabled = true


### Reasoning

Accidental or malicious deletion is a common operational risk.

Soft delete allows recovery.  
Purge protection prevents immediate permanent deletion.

### Security Benefit

- Protection against ransomware-style deletion
- Recovery capability during incidents
- Compliance-aligned configuration

---

## 4. Centralized Logging via Diagnostic Settings

### Decision

Key Vault diagnostics are exported to Log Analytics.

### Reasoning

Security monitoring requires centralized telemetry.

Without diagnostics:

- Unauthorized access attempts are invisible
- Incident investigation becomes impossible

### Logging Flow

Key Vault → Diagnostic Settings → Log Analytics Workspace

### Security Benefit

- Central audit trail
- Queryable security events
- Foundation for automated detection

---

## 5. Detection Through Log-Based Alerts

### Decision

A scheduled query alert detects unauthorized or forbidden Key Vault access attempts.

KQL Query:
AzureDiagnostics
| where ResourceType == "VAULTS"
| where ResultSignature has "Unauthorized" or ResultSignature has "Forbidden"
| count


### Reasoning

Security monitoring must move beyond logging into detection.

Alerts convert passive logs into actionable security signals.

### Security Benefit

- Near real-time detection
- Automated notification
- Demonstrated incident response capability

---

## 6. Action Groups for Notification

### Decision

Azure Monitor Action Group configured for email notification.

### Reasoning

Alerts must reach operators to be useful.

Action Groups allow scalable notification routing without modifying alert rules.

### Security Benefit

- Decoupled alert routing
- Operational awareness
- Incident visibility

---

## 7. Network Security Baseline

### Decision

Network Security Group configured with:

- HTTPS allow rule
- Explicit deny-all inbound rule

### Reasoning

Azure default networking is permissive within VNets.

A deny-by-default posture reduces unintended exposure.

### Security Benefit

- Reduced attack surface
- Explicit traffic control
- Predictable network behavior

---

## 8. Terraform Lifecycle Protection

### Decision

Critical resources include lifecycle protections to prevent accidental deletion.

### Reasoning

Infrastructure automation increases the risk of unintended destructive changes.

Lifecycle safeguards protect foundational resources.

### Security Benefit

- Prevents accidental environment loss
- Protects shared platform components

---

## 9. Separation of Platform and Workload Resources

### Decision

Infrastructure divided into:

- Platform resource group
- Workload resource group

### Reasoning

Enterprise environments separate shared services from applications.

This limits blast radius and improves governance.

### Security Benefit

- Easier access control boundaries
- Reduced operational risk
- Cleaner RBAC scoping

---

## 10. Cost-Constrained Secure Design

### Decision

Security features prioritized while remaining within free-tier limits.

Trade-offs included:

- Minimal diagnostic categories
- Limited retention periods
- Conditional deployment of compute resources

### Reasoning

Real-world engineering requires balancing security and budget constraints.

### Security Benefit

Demonstrates practical security architecture rather than theoretical design.

---

## Summary

The environment applies layered security controls across:

- Identity
- Network
- Monitoring
- Governance
- Infrastructure lifecycle

The result is a secure Azure baseline demonstrating how modern cloud environments prioritize identity, observability, and least-privilege access over perimeter-based security models.
