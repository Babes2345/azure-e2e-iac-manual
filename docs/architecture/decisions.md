# Architecture Decisions (ADR-lite)

---

## ADR-001 - Workload Type: App Service (PaaS) over VMs

- ### Status:
  Accepted
- ### Decision:
  Use Azure App Service (Web App) as the primary workload for this project.
- ### Rationale:
  Demonstrates production-relevant PaaS patterns (identity, monitoring, deployment slots).
  Reduces operational overhead (patching, OS hardening) so focus stays on architecture, security, and governance.
  Strong alignment with AZ-104 operational tasks (monitoring, RBAC, diagnostics) and AZ-305 design priorities (managed services, resilience, cost).
- ### Consequences:
  Some “admin access” patterns (Bastion/SSH/RDP) are not required initially.
  Network hardening will be staged (public endpoint initially, optional private networking later).

---

## ADR-002 - Resource Organization: Two Resource Groups

- ### Status:
  Accepted
- ### Decision:
  Separate resources into:

   rg-platform (shared services: monitoring, key vault, state storage)
   
   rg-workload (application resources)
- ### Rationale:

  Clear separation of concerns and access boundaries.
  Supports least-privilege RBAC and easier cost tracking.
  
- ### Consequences:
  Requires consistent tagging and naming to keep resources discoverable.

---

## ADR-003 - Networking Baseline: Single VNet (Simple, Expandable)

- ### Status: Accepted
- ### Decision:
  Use a single Virtual Network with subnets reserved for future growth.
- ### Rationale:
  Avoids hub/spoke overbuild while still showing strong networking fundamentals.
  Keeps design clear and repeatable for manual → IaC progression.
- ### Consequences:
  Private endpoint integration is deferred (explicitly Phase 2 if needed).
  
  Notes:
  - App Service does not “live inside” the VNet by default; VNet integration is optional and scenario-driven.
    
---

## ADR-004 - Access Control: Azure RBAC + Least Privilege

- ### Status:
  Accepted
- ### Decision:
  Use Azure RBAC for access management and scope assignments at the RG level.
- ### Rationale:

  Realistic enterprise pattern and directly tests AZ-104 skills.

  Enables clean separation between platform administration and workload deployment.
  
- ### Consequences:

    Requires careful role selection (avoid Owner where not necessary).
  
---

## ADR-005 — Secrets: Key Vault + Managed Identity

- ### Status:
   Accepted
- ### Decision:
  Store secrets in Azure Key Vault and access them using Managed Identity for the Web App where applicable.
- ### Rationale:

  Demonstrates secure secret handling (no secrets in code).

  Aligns with Azure best practice.
- ### Consequences:

  Requires Key Vault access configuration (RBAC or access policies, documented during build).

---

## ADR-006 - Monitoring: Log Analytics + Application Insights + Alerts

- ### Status:
  Accepted
- ### Decision: 
  Centralize logs in Log Analytics, enable Application Insights, and configure a minimum alert set.
- ### Rationale:

  Day-2 operations readiness is required for production-style builds.

  Strong AZ-104 alignment (diagnostics, queries, alerting).
  
- ### Consequences:

  Must ensure diagnostic settings are enabled consistently (manual and IaC parity).

  Minimum Alerts:

    - Availability/health check

    - Server error threshold (5xx)

    - Budget threshold alert (cost control)
 
---

## ADR-007 - Cost Controls: Tags + Budget + Teardown Process

- ### Status: 
  Accepted
- ### Decision:
  Enforce tagging and configure a budget with alerts; maintain a documented teardown.
- ### Rationale:

  Demonstrates financial governance and practical lab safety.
- ### Consequences:

  Tagging must be consistent across manual and IaC deployments.

---

## ADR-008 - IaC Strategy: Manual First → Terraform → Bicep (Parity)

- ### Status:
  Accepted
- ### Decision:
  Implement the same architecture in three phases:

    - Manual deployment

    - Terraform (primary)

    - Bicep (parity)
- ### Rationale:

  Manual build validates decisions and produces a “known-good” baseline.

  Terraform demonstrates industry-standard IaC practice.

  Bicep shows Azure-native proficiency and comparison ability.
- ### Consequences:

  Must document all config choices during manual deployment to ensure parity.

---

## ADR-009 - Explicit Non-Goals (Scope Lock)

- ### Status: 
  Accepted
- ### Decision:
  The following are out of scope for Project 1:

  Hub/spoke + Azure Firewall baseline

  Multi-region DR

  Kubernetes

  Private Link everywhere

  Management group-level governance
  
- ### Rationale:

  Keeps the project focused, finishable, and resume-ready.
- ### Consequences:

Advanced features may be added as Phase 2 only if they support learning outcomes without redesigning the baseline.
