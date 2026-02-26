# Prerequisites

This document outlines the requirements needed to successfully build and validate the Azure End-to-End Infrastructure environment using the manual deployment phase.

The manual deployment establishes foundational understanding before transitioning to Infrastructure as Code (Terraform).

---

## Azure Subscription

An active Azure subscription is required.

A **paid Azure subscription is recommended** to ensure full access to services, SKUs, and configurations used throughout the project.

The Azure Free Tier may be used; however, it includes quota and service limitations that may restrict certain deployments.

> **Recommendation:**  
> Maintain an active subscription for at least one month to avoid interruptions during the build process.

---

## Required Permissions

The deploying user must have sufficient privileges within the Azure subscription.

### Minimum Required Access

- **Owner** or **Contributor** role at the subscription level

### Required Capabilities

The user must be able to create and manage:

- Resource Groups
- Virtual Networks and Networking Resources
- App Service Resources
- Monitoring and Logging Services
- Role Assignments (RBAC)

---

## Local Tooling

The following tools must be installed and configured locally:

| Tool | Purpose |
|------|---------|
| Azure CLI | Azure authentication and management |
| Terraform | Infrastructure as Code deployment |
| Bicep CLI | ARM/Bicep resource deployments |
| Git | Version control |
| Code Editor (VS Code recommended) | Development environment |

---

### Verify Azure Authentication

Authenticate using:

```bash
az login
