03 – Security and Key Vault Deployment
Objectives

The objective of this step is to establish a secure secrets management baseline using Azure-native services.

By the end of this step:

A Key Vault is deployed with production security settings

Access is controlled using Azure RBAC

The vault is ready for Managed Identity integration

No secrets are exposed in code or configuration files

This step intentionally precedes workload deployment to enforce security-first design.

Key Vault Configuration
Step 1 — Create the Key Vault

Azure Portal

Navigate to Key Vaults

Select Create

Configure:

Subscription: Target subscription

Resource Group: rg-platform

Key Vault Name: Use project-aligned naming (e.g., kv-e2e-prod)

Region: Same region as platform resources

Pricing Tier: Standard

Select Next until the Review stage

Create the Key Vault

Validation

Confirm the Key Vault exists in rg-platform

Confirm the region matches Log Analytics and Application Insights

Step 2 — Enable Security Protections

In the Key Vault Settings:

Navigate to Properties

Ensure the following are enabled:

Soft Delete: Enabled

Purge Protection: Enabled

These settings are mandatory in most production environments and cannot be disabled once enabled.

Validation

Soft delete shows as enabled

Purge protection shows as enabled

Access Control Model
Step 3 — Select RBAC Authorization Model

In the Key Vault blade, navigate to Access configuration

Set Permission model to:

Azure role-based access control (RBAC)

Save changes

Rationale

RBAC provides centralized, auditable access control

Aligns with modern Azure security practices

Scales better than access policies

Role Assignments
Step 4 — Assign Administrative Access

Assign administrative access only to required identities.

Azure Portal

Navigate to Access control (IAM) on the Key Vault

Select Add role assignment

Assign:

Role: Key Vault Administrator

Scope: This resource

Member: Your administrative user or group

Validation

Confirm role assignment appears under IAM

Confirm you can view Key Vault settings

Step 5 — Prepare for Managed Identity Access

No workload identity exists yet.
However, this step documents the required role for later use.

The workload Managed Identity will be assigned:

Role: Key Vault Secrets User

Scope: Key Vault resource

This role allows secret retrieval without granting administrative permissions.

This assignment will be completed in Step 04 – Workload Deployment once the identity exists.

Security Settings
Step 6 — Network Access Configuration

For this phase:

Public network access: Enabled

Firewall rules: Not restricted

Reasoning

Simplifies initial validation

Private access patterns are intentionally deferred to Phase 2

This decision is documented in decisions.md.

Step 7 — Optional Test Secret (Validation Only)

To validate access later, create a test secret.

Navigate to Secrets

Select Generate/Import

Configure:

Name: demo-secret

Value: placeholder-value

Activation: Immediate

Save

Important

This secret is for validation only

No real credentials should be stored at this stage

Validation

Before proceeding, confirm:

Key Vault exists in rg-platform

Soft delete and purge protection are enabled

RBAC authorization model is active

Administrative access is restricted

At least one test secret exists

No access policies are configured (RBAC only)

Outcome

At this stage:

The platform has a secure, production-aligned secrets store

Access is centrally managed and auditable

The environment is ready for Managed Identity integration