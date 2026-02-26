04 – Workload Deployment (App Service)
Purpose

Deploy a simple, production-aligned application workload that validates:

Platform readiness

Managed Identity usage

Secure access to Key Vault

Monitoring and diagnostics integration

The workload is intentionally lightweight to keep focus on architecture, security, and operations.

Scope

This step includes:

App Service Plan creation

Web App deployment

Managed Identity enablement

Deployment slot creation

Key Vault access configuration

Basic validation

App Service Plan
Step 1 — Create the App Service Plan

Azure Portal

Navigate to App Service plans

Select Create

Configure:

Subscription: Target subscription

Resource Group: rg-workload

Name: e.g., asp-e2e-prod

Operating System: Linux

Region: Same region as platform resources

Pricing plan: Basic or lower-cost production-appropriate SKU (e.g., B1)

Review and create

Validation

App Service Plan exists in rg-workload

Region and SKU are correct

Web App
Step 2 — Create the Web App

Navigate to App Services

Select Create

Configure:

Subscription: Target subscription

Resource Group: rg-workload

Name: Globally unique name (e.g., app-e2e-prod)

Publish: Code

Runtime stack: Any supported runtime (e.g., .NET, Node.js)

Region: Same as App Service Plan

App Service Plan: asp-e2e-prod

Create the Web App

Validation

Web App is running

Default landing page loads successfully

Managed Identity
Step 3 — Enable Managed Identity

Open the Web App

Navigate to Identity

Enable System assigned managed identity

Save changes

Validation

Status shows On

Object (principal) ID is generated

Deployment Slot
Step 4 — Create a Staging Deployment Slot

In the Web App, navigate to Deployment slots

Select Add Slot

Configure:

Name: staging

Clone settings from: Production

Create slot

Validation

Staging slot exists

Slot has its own URL

Slot is running

Key Vault Access
Step 5 — Grant Key Vault Access to Managed Identity

Navigate to the Key Vault created in Step 03

Open Access control (IAM)

Select Add role assignment

Assign:

Role: Key Vault Secrets User

Scope: This resource

Member: Web App managed identity

Save assignment

Validation

Role assignment appears in Key Vault IAM

No access policies are used (RBAC only)

Validation
Step 6 — Workload Validation Checklist

Confirm:

Web App is accessible

Managed Identity is enabled

Deployment slot is functional

Key Vault role assignment exists

No secrets are stored in application settings

Optional (if runtime supports it):

Test secret retrieval via Managed Identity

Outcome

At the completion of this step:

A production-aligned workload is deployed

Identity is handled securely via Managed Identity

Key Vault access is configured correctly

The application is ready for monitoring and alerting