# Architecture Summary - Azure E2E Infrastructure Baseline

## Purpose

This project implements a production-style Azure baseline environment deployed using Terraform to demonstrate secure infrastructure design, centralized observability, RBAC-based access control, and modular Infrastructure as Code practices.

The environment follows a manual-first → Terraform progression aligned with AZ-104 administration and AZ-305 architecture design principles.

The objective is to show how a secure Azure foundation can be deployed, monitored, and validated using cost-controlled resources within Azure free-tier constraints.

---

## Environment Structure

Infrastructure is separated into two logical resource groups to model an enterprise platform/workload boundary.

### Platform Resource Group - `rg-platform-dev`

Shared foundational services:

- Virtual Network (VNet)
- Network Security Group (NSG)
- Log Analytics Workspace
- Application Insights
- Azure Key Vault
- Diagnostic Settings
- Monitoring Alerts and Action Groups

This layer represents reusable platform infrastructure shared across workloads.

---

### Workload Resource Group - `rg-workload-dev`

Application-facing resources:

- App Service module (deployment gated due to subscription quota limits)
- Managed identity consumers
- RBAC role assignments

Separating platform and workload resources reduces operational risk and mirrors enterprise landing zone patterns.

---

## Network Architecture

A segmented virtual network provides logical isolation between components.

| Subnet | Purpose |
|-------|--------|
| snet-mgmt | Management boundary |
| snet-app | Application subnet |

Security baseline implemented:

- HTTPS inbound traffic explicitly allowed
- Explicit deny-all inbound rule
- NSG associated with application subnet

This enforces least-privilege network access.

---

## Identity and Access Strategy

Azure RBAC is used exclusively for Key Vault authorization.

Design decisions:

- Key Vault access policies disabled
- System-assigned managed identities preferred
- Role assignment: **Key Vault Secrets User**

Benefits:

- No credentials stored in Terraform or source control
- Centralized identity governance
- Production-aligned authentication model

---

## Observability Architecture

Security and operational telemetry is centralized using Log Analytics.

### Logging Flow

Key Vault  
→ Diagnostic Settings  
→ Log Analytics Workspace  
→ Scheduled Query Alert  
→ Action Group  
→ Email Notification

Unauthorized secret access attempts generate audit events which trigger monitoring alerts.

---

## Monitoring and Alerting

A scheduled query alert monitors Key Vault audit logs for authorization failures.

Configuration:

- Evaluation frequency: 5 minutes
- Window duration: 5 minutes
- Threshold-based detection
- Email notification via Action Group

Alert delivery was validated using controlled unauthorized access testing.

---

## Infrastructure as Code Design

Terraform implementation uses a modular structure:
modules/
resourcegroup/
network/
monitoring/
keyvault/
rbac/
diagnostics/
alerts/
appservice/

Key practices implemented:

- Remote Terraform state stored in Azure Storage
- Environment isolation using `envs/devs`
- Reusable and composable Terraform modules
- Consistent naming and tagging standards
- Separation of platform and workload concerns
- Conditional deployment capability for cost-controlled resources

This structure enables scalable expansion into additional environments (test, staging, production) without architectural redesign.

---

## Security Controls Implemented

The environment applies multiple layered security controls aligned with Azure Well-Architected Framework guidance.

Implemented protections include:

- RBAC-based Key Vault authorization model
- Soft delete enabled for Key Vault resources
- Purge protection enforced
- Centralized audit logging through Diagnostic Settings
- Network Security Group deny-by-default posture
- Managed identity authentication (no embedded secrets)
- Alert-driven detection of unauthorized access attempts
- Lifecycle protections preventing accidental infrastructure deletion

These controls demonstrate defense-in-depth across identity, network, and monitoring layers.

---

## Cost Governance

The solution was intentionally designed to operate within Azure free subscription constraints while maintaining architectural credibility.

Cost control measures:

- Free-tier compatible SKUs where possible
- Minimal diagnostic log categories enabled
- Controlled Log Analytics retention period
- Conditional deployment of App Service resources
- No persistent compute workloads

This reflects realistic engineering trade-offs when designing secure environments under budget constraints.

---

## Constraints and Trade-offs

Several platform limitations influenced implementation decisions:

- Linux App Service plans unavailable due to regional quota restrictions
- Windows F1 SKU used for validation scenarios
- Private endpoints excluded due to free-tier cost limitations
- Monitoring scope minimized to required security signals

All trade-offs were documented intentionally to demonstrate architectural decision-making rather than idealized design.

---

## Outcome

The deployed environment demonstrates:

- Secure Azure baseline architecture
- Centralized monitoring and alerting pipeline
- Identity-first security model using RBAC
- Modular Terraform Infrastructure as Code
- Verified operational monitoring through alert evidence
- Production-aligned documentation and validation artifacts

The project represents a complete end-to-end infrastructure deployment lifecycle suitable for portfolio demonstration and architectural review.
