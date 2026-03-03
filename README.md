# Azure End-to-End Infrastructure (Manual -> Terraform)

Production-style Azure infrastructure baseline demonstrating secure cloud architecture, modular Terraform design, centralized monitoring, and RBAC-driven security controls.

This project was built using a **manual-first -> Infrastructure as Code migration model** aligned with **AZ-104 (Azure Administrator)** and **AZ-305 (Azure Solutions Architect)** principles.

---

## Project Goals

The objective of this project is to demonstrate how a secure Azure environment can be designed, deployed, monitored, and validated using real-world engineering practices.

Key goals:

- Design a production-aligned Azure baseline
- Implement modular Terraform architecture
- Enforce RBAC-based security
- Centralize logging and monitoring
- Detect unauthorized access through alerts
- Maintain zero-cost operation under free-tier constraints
- Produce architect-level documentation and evidence

---

## Architecture Overview

The environment separates shared platform infrastructure from workload resources to model enterprise landing zone patterns.

### Platform Layer (`rg-platform-dev`)

- Virtual Network & Subnets
- Network Security Groups
- Log Analytics Workspace
- Application Insights
- Azure Key Vault (RBAC enabled)
- Diagnostic Settings
- Azure Monitor Alerts & Action Groups

### Workload Layer (`rg-workload-dev`)

- App Service (deployment gated by quota)
- Managed identities
- RBAC role assignments

---

## Security Design

Security follows an **identity-first model**:

- Azure RBAC authorization (no access policies)
- Managed identities instead of credentials
- Key Vault purge protection + soft delete
- Deny-by-default network posture
- Centralized audit logging
- Alert-based threat detection

Unauthorized Key Vault access attempts trigger alerts via:
Key Vault
- Diagnostic Settings
- Log Analytics
- Scheduled Query Alert
- Action Group
- Email Notification


Alert delivery was validated through controlled unauthorized access testing.

---

## Terraform Design

Infrastructure is implemented using reusable modules:

iac/terraform/modules/
resourcegroup/
network/
monitoring/
keyvault/
rbac/
diagnostics/
alerts/
appservice/


Key practices:

- Remote state backend (Azure Storage)
- Environment isolation (`envs/devs`)
- Modular architecture
- Consistent tagging strategy
- Conditional deployments for cost control

---

## Observability

Centralized monitoring includes:

- Log Analytics workspace ingestion
- Application Insights integration
- Key Vault audit logging
- Scheduled query alerts
- Email notification action groups

Security events are queryable using KQL.

---

## Cost Governance

The environment is intentionally designed to operate at **$0 cost**:

- Free-tier compatible resources
- Minimal telemetry ingestion
- Controlled log retention
- Conditional compute deployment
- No always-on paid services

Architectural trade-offs were documented as part of design decisions.

---

## Documentation

Detailed architectural reasoning and validation evidence are included:
docs/
|-- architecture/
|-- architecture-summary.md
| |-- security-decisions.md
| |-- cost-governance.md
|
|-- evidence/
|-- terraform execution artifacts
|-- monitoring validation screenshots

---

## Validation Performed

The following scenarios were tested:

- Terraform deployment convergence
- RBAC authorization enforcement
- Unauthorized Key Vault access attempt
- Log ingestion into Log Analytics
- Alert rule triggering
- Email notification delivery

Evidence is included in `/docs/evidence`.

---

## Technologies Used

- Microsoft Azure
- Terraform (AzureRM Provider v4)
- Azure Monitor
- Log Analytics
- Application Insights
- Azure Key Vault
- Azure RBAC
- Kusto Query Language (KQL)

---

## Repository Visibility

This repository is private by design.

Sensitive infrastructure implementation details remain restricted while architecture documentation is used for portfolio demonstration.

---

## Future Enhancements

Planned improvements:

- Private endpoints
- Multi-environment promotion (dev → prod)
- CI/CD deployment pipeline
- Policy-as-Code (Azure Policy)
- Budget alerts and cost dashboards

---

## What I Learned

Building this project strengthened my ability to design and operate a production-style Azure baseline end-to-end. I learned how to break an environment into clear platform and workload layers, and how to make architecture decisions based on requirements such as security, observability, and cost constraints.

Key takeaways:

- **Architecture thinking:** translating project goals into concrete design choices (network segmentation, RBAC-first security, centralized logging).
- **Security-first implementation:** using Azure RBAC and Managed Identity with Key Vault to avoid secrets in code and reduce credential risk.
- **Operational readiness:** configuring diagnostics, Log Analytics queries, and alerting so the environment is observable and testable.
- **Infrastructure as Code maturity:** moving from manual deployment to Terraform parity using modular design and remote state.
- **Cost awareness:** designing within free-tier limitations and documenting trade-offs and governance controls.

Although this was a portfolio lab environment rather than a production system, it provided real, hands-on experience with the same patterns used in real-world Azure infrastructure delivery and operations.

---

## Author
Andrew Babes 
Cloud Infrastructure Engineer Portfolio Project  
Focused on Azure Administration, Cloud Security, and Infrastructure as Code.

---

## License

Portfolio demonstration project — not intended for production reuse without modification
