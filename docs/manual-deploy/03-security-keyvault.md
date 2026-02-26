# Security and Key Vault Deployment - Phase 03

## Objectives

The objective of this phase is to establish a secure secrets management baseline using Azure-native services.

By the end of this deployment:

- A Key Vault is deployed using production-aligned security settings
- Access control is managed through Azure RBAC
- The vault is prepared for Managed Identity integration
- No secrets are exposed in code or configuration files

This phase intentionally occurs **before workload deployment** to enforce a security-first architecture.

---

## Step 1 - Create the Key Vault

### Azure Portal

1. Navigate to **Key Vaults**
2. Select **Create**

### Configuration

| Setting | Value |
|--------|------|
| Subscription | Target subscription |
| Resource Group | `rg-platform` |
| Key Vault Name | Project-aligned naming (e.g., `kv-e2e-prod`) |
| Region | Same region as platform resources |
| Pricing Tier | Standard |

Proceed through remaining tabs and select **Create**.

---

### Validation

Confirm:

- Key Vault exists in `rg-platform`
- Region matches Log Analytics and Application Insights resources

---

## Step 2 - Enable Security Protections

Navigate to:

**Key Vault -> Properties**

Ensure the following settings are enabled:

| Setting | Status |
|--------|--------|
| Soft Delete | Enabled |
| Purge Protection | Enabled |

These protections are mandatory in most production environments and cannot be disabled once enabled.

### Validation

- Soft delete shows as enabled
- Purge protection shows as enabled

---

## Step 3 - Select RBAC Authorization Model

Navigate to:

**Key Vault -> Access configuration**

Set **Permission model** to:
Azure role-based access control (RBAC)
Select **Save**.

### Rationale

RBAC:

- Provides centralized and auditable access control
- Aligns with modern Azure security practices
- Scales better than legacy access policies

---

## Step 4 - Assign Administrative Access

Grant administrative access only to required identities.

### Azure Portal

1. Navigate to **Access control (IAM)** on the Key Vault
2. Select **Add -> Add role assignment**

### Assignment

| Setting | Value |
|--------|------|
| Role | Key Vault Administrator |
| Scope | This resource |
| Member | Administrative user or group |

### Validation

- Role assignment appears under IAM
- Administrative user can access Key Vault settings

---

## Step 5 - Prepare for Managed Identity Access

No workload identity exists yet; however, required access is defined for future deployment.

The workload Managed Identity will receive:

| Role | Scope |
|------|------|
| Key Vault Secrets User | Key Vault resource |

This role allows secret retrieval without granting administrative permissions.

The assignment will be completed during **Phase 04 — Workload Deployment**.

---

## Step 6 - Network Access Configuration

For this phase:

| Setting | Configuration |
|--------|---------------|
| Public network access | Enabled |
| Firewall rules | Not restricted |

### Reasoning

- Simplifies initial validation
- Allows testing without networking dependencies
- Private access patterns are deferred to later phases

This design decision is documented within architecture decisions documentation.

---

## Step 7 - Optional Test Secret (Validation Only)

Create a temporary secret for validation purposes.

1. Navigate to **Secrets**
2. Select **Generate/Import**

### Configuration

| Setting | Value |
|--------|------|
| Name | `demo-secret` |
| Value | `placeholder-value` |
| Activation | Immediate |

Select **Create**.

> **Important:**  
> This secret is for validation only. No real credentials should be stored during this phase.

---

## Validation Checklist

Before proceeding, confirm:

-  Key Vault exists in `rg-platform`
-  Soft delete and purge protection are enabled
-  RBAC authorization model is active
-  Administrative access is restricted
-  At least one test secret exists
-  No access policies are configured (RBAC-only model)

---

## Outcome

At completion of this phase:

- A secure, production-aligned secrets store is deployed
- Access control is centrally managed and auditable
- The environment is prepared for Managed Identity integration
- Security-first deployment principles are enforced

Proceed to the workload deployment phase once validation is complete.
