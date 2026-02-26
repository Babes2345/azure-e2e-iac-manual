# Evidence — Azure End-to-End IaC Baseline

This folder contains operational proof that the Azure infrastructure was successfully deployed using Terraform and that security monitoring and alerting function as designed.

The goal of this evidence set is to demonstrate production-aligned deployment validation, observability, and RBAC security enforcement.

---

## Infrastructure Validation

| File | Description |
|------|-------------|
| 01-terraform-plan.txt | Terraform execution plan showing infrastructure state alignment (no configuration drift). |
| 02-terraform-state-list.txt | List of Azure resources managed by Terraform state. |

These files confirm:

- Remote state backend functioning
- Terraform successfully managing Azure resources
- Environment fully converged with configuration

---

## Security Validation Evidence

The following screenshots demonstrate security controls and monitoring:

| Screenshot | Purpose |
|------------|---------|
| 02-keyvault-rbac.png | RBAC authorization model applied to Key Vault |
| 03-keyvault-diagnostics.png | Diagnostic logs exported to Log Analytics |
| 04-log-analytics-unauthorized.png | Unauthorized access events recorded |
| 05-alert-rule-config.png | Alert rule configuration |
| 06-alert-fired.png | Alert triggered successfully |
| 07-alert-email.png | Email notification delivery |

---

## Validation Scenario Performed

1. Infrastructure deployed using Terraform modules.
2. Key Vault configured with RBAC authorization.
3. Unauthorized access attempt executed.
4. Audit logs ingested into Log Analytics.
5. Scheduled query alert detected failure events.
6. Action Group delivered email notification.

This confirms end-to-end observability:

Key Vault → Diagnostic Settings → Log Analytics → Alert Rule → Action Group → Email Notification

---

## Notes

- Sensitive values were redacted where applicable.
- Demo secrets are not stored in source control.
- Environment deployed under free-tier cost constraints.