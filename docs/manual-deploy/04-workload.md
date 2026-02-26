# Workload Deployment (App Service) - Phase 04

## Purpose

This phase deploys a simple, production-aligned application workload used to validate:

- Platform readiness
- Managed Identity authentication
- Secure Key Vault access
- Monitoring and diagnostics integration

The workload is intentionally lightweight to keep focus on **architecture, security, and operational design** rather than application complexity.

---

## Scope

This deployment includes:

- App Service Plan creation
- Web App deployment
- Managed Identity enablement
- Deployment slot creation
- Key Vault RBAC configuration
- Workload validation

---

## Step 1 - Create the App Service Plan

### Azure Portal

1. Navigate to **App Service plans**
2. Select **Create**

### Configuration

| Setting | Value |
|--------|------|
| Subscription | Target subscription |
| Resource Group | `rg-workload` |
| Name | Project-aligned name (e.g., `asp-e2e-prod`) |
| Operating System | Linux |
| Region | Same region as platform resources |
| Pricing Plan | Basic or low-cost production SKU (e.g., B1) |

Select **Review + Create**, then **Create**.

### Validation

Confirm:

- App Service Plan exists in `rg-workload`
- Region matches platform resources
- SKU is correctly applied

---

## Step 2 - Create the Web App

Navigate to **App Services  -> Create**.

### Configuration

| Setting | Value |
|--------|------|
| Subscription | Target subscription |
| Resource Group | `rg-workload` |
| Name | Globally unique (e.g., `app-e2e-prod`) |
| Publish | Code |
| Runtime Stack | Any supported runtime (.NET, Node.js, etc.) |
| Region | Same as App Service Plan |
| App Service Plan | `asp-e2e-prod` |

Create the Web App.

### Validation

Confirm:

- Web App status shows **Running**
- Default landing page loads successfully via browser

---

## Step 3 - Enable Managed Identity

1. Open the Web App
2. Navigate to **Identity**
3. Enable **System assigned managed identity**
4. Select **Save**

### Validation

Confirm:

- Status = **On**
- Object (Principal) ID is generated

This identity will be used for secure service-to-service authentication.

---

## Step 4 - Create a Staging Deployment Slot

1. Navigate to **Deployment slots**
2. Select **Add Slot**

### Configuration

| Setting | Value |
|--------|------|
| Slot Name | `staging` |
| Clone Settings From | Production |

Create the slot.

### Validation

Confirm:

- Staging slot exists
- Slot has its own URL
- Slot status shows **Running**

Deployment slots enable safer release strategies and blue/green deployments.

---

## Step 5 - Grant Key Vault Access to Managed Identity

Navigate to the Key Vault created in Phase 03.

### Assign RBAC Role

1. Open **Access control (IAM)**
2. Select **Add  -> Add role assignment**

| Setting | Value |
|--------|------|
| Role | Key Vault Secrets User |
| Scope | This resource |
| Member | Web App Managed Identity |

Save the assignment.

### Validation

Confirm:

- Role assignment appears under Key Vault IAM
- No legacy access policies are configured (RBAC-only model)

---

## Step 6 - Workload Validation Checklist

Verify the following:

-   Web App is accessible
-   Managed Identity is enabled
-   Deployment slot is operational
-   Key Vault RBAC assignment exists
-   No secrets stored in application settings

### Optional Validation

If runtime supports Managed Identity:

- Retrieve a Key Vault secret using Managed Identity authentication.

---

## Outcome

At completion of this phase:

- A production-aligned workload is deployed
- Authentication is handled securely via Managed Identity
- Key Vault access follows least-privilege principles
- The application is ready for monitoring, diagnostics, and alerting

Proceed to **Phase 05 - Monitoring and Alerting**.
