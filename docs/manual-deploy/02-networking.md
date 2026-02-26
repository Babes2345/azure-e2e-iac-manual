# Networking Deployment - Phase 02

## Purpose

This phase establishes a clean, secure, and expandable network baseline to support the application workload.

The network design follows **least-privilege principles** and is intentionally scoped to allow future enhancements without requiring architectural redesign.

This deployment creates foundational networking components used by all subsequent infrastructure.

---

## Scope

This phase includes:

- Virtual Network (VNet) creation
- Subnet design and allocation
- Network Security Group (NSG) creation
- NSG rule configuration
- NSG association with subnets
- Validation of effective security rules

---

## Architecture Objectives

The networking layer is designed to:

- Provide logical isolation between resources
- Enforce secure inbound access
- Allow controlled outbound connectivity
- Support future expansion (private endpoints, management services)
- Maintain simplicity appropriate for a baseline environment

---

## Step 1 - Create the Virtual Network

### Azure Portal

1. Navigate to **Virtual networks**
2. Select **Create**

### Configuration

| Setting | Value |
|--------|------|
| Subscription | Target subscription |
| Resource Group | `rg-platform` |
| Name | Project-aligned name (e.g., `vnet-e2e-prod`) |
| Region | Same region as platform resources |
| Address Space | `10.10.0.0/16` |

Proceed to the **IP Addresses** tab.

---

## Step 2 - Define Subnets

Create the following subnets:

| Subnet Name | Address Range | Purpose |
|-------------|--------------|---------|
| `snet-app` | `10.10.1.0/24` | Application workload |
| `snet-mgmt` | `10.10.2.0/24` | Future management or private endpoints |

Subnets are defined even if not immediately used to demonstrate forward-looking architectural planning.

Complete Virtual Network creation.

---

## Step 3 - Create the Network Security Group (NSG)

1. Navigate to **Network security groups**
2. Select **Create**

### Configuration

| Setting | Value |
|--------|------|
| Resource Group | `rg-platform` |
| Name | e.g., `nsg-e2e-app` |
| Region | Same region as VNet |

---

## Step 4 - Configure NSG Rules

Define minimum required rules aligned with least-privilege networking.

### Inbound Rules

| Priority | Name | Source | Destination Port | Action | Purpose |
|---------|------|--------|------------------|--------|---------|
| 100 | Allow-HTTPS | Internet | 443 | Allow | Secure inbound traffic |
| 200 | Deny-All-Inbound | Any | Any | Deny | Default deny posture |

### Outbound Rules

| Priority | Name | Destination | Port | Action | Purpose |
|---------|------|-------------|------|--------|---------|
| 100 | Allow-Internet | Internet | Any | Allow | Required outbound access |

Azure default outbound rules may remain unless stricter controls are required.

---

## Step 5 - Associate NSG with Subnet

1. Open the **Network Security Group**
2. Navigate to **Subnets**
3. Select **Associate**

### Association

| Setting | Value |
|--------|------|
| Virtual Network | `vnet-e2e-prod` |
| Subnet | `snet-app` |

---

## Step 6 - Validate Effective Security Rules

1. Navigate to subnet **snet-app**
2. Select **Effective security rules**

Confirm:

- Custom NSG rules are applied
- Deny-by-default behavior is enforced
- No unintended inbound access exists

---

## Outcome

At completion of this phase:

- A production-aligned Virtual Network is deployed
- Subnets are clearly defined and documented
- Network Security Groups enforce least-privilege access
- The network is prepared to support workload resources
- The design remains simple, secure, and expandable

Proceed to the next deployment phase once validation is complete.
