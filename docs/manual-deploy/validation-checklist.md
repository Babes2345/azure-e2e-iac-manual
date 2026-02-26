# Manual Deployment Validation Checklist

## Purpose

This checklist confirms that the manually deployed environment meets all architectural, security, monitoring, and operational requirements defined for this project.

This document serves as:

- Proof of successful manual deployment
- The baseline for Terraform Infrastructure as Code parity
- A reference for troubleshooting and audits

All items must pass before Infrastructure as Code implementation begins.

---

## Platform Validation

### Resource Groups

- [ ] `rg-platform` exists
- [ ] `rg-workload` exists
- [ ] Resources are deployed into the correct resource groups
- [ ] Resource placement aligns with architectural intent

### Naming and Tagging

- [ ] Resources follow defined naming conventions
- [ ] Required tags are applied consistently:

  - `environment`
  - `project`
  - `owner`
  - `costCenter`

---

## Networking Validation

### Virtual Network

- [ ] Virtual Network exists in `rg-platform`
- [ ] Address space matches documented architecture
- [ ] Region matches platform resources

### Subnets

- [ ] `snet-app` exists
- [ ] `snet-mgmt` (or reserved subnet) exists
- [ ] Address ranges do not overlap

### Network Security Groups

- [ ] NSG exists in `rg-platform`
- [ ] NSG is associated with `snet-app`
- [ ] Least-privilege inbound rules are configured
- [ ] Default deny inbound behavior is enforced

### Effective Security Rules

- [ ] Effective rules reflect intended NSG configuration
- [ ] No unintended inbound access is permitted

---

## Security & Key Vault Validation

### Key Vault Configuration

- [ ] Key Vault exists in `rg-platform`
- [ ] Soft delete is enabled
- [ ] Purge protection is enabled
- [ ] RBAC authorization model is enabled
- [ ] No access policies are configured (RBAC only)

### Access Control

- [ ] Administrative access is restricted
- [ ] Web App Managed Identity has **Key Vault Secrets User** role
- [ ] Role assignments are scoped to the Key Vault resource

### Secrets

- [ ] Test secret exists (`demo-secret`)
- [ ] No secrets stored in application configuration
- [ ] No secrets committed to source control

---

## Workload Validation

### App Service Plan

- [ ] App Service Plan exists in `rg-workload`
- [ ] SKU is appropriate for lab usage
- [ ] Region matches platform resources

### Web App

- [ ] Web App is running
- [ ] Default/sample page loads successfully
- [ ] Managed Identity is enabled
- [ ] Application does not store secrets locally

### Deployment Slot

- [ ] Staging slot exists
- [ ] Slot URL is accessible
- [ ] Slot configuration cloned correctly

---

## Monitoring & Alerting Validation

### Log Analytics

- [ ] Log Analytics Workspace exists
- [ ] Diagnostic logs are being ingested
- [ ] Logs contain recent timestamps

### Application Insights

- [ ] Workspace-based configuration enabled
- [ ] Requests and availability data visible

### Diagnostic Settings

- [ ] Diagnostic settings configured for Web App
- [ ] Logs routed to Log Analytics
- [ ] Metrics enabled where supported

### Alerts

- [ ] Availability test configured
- [ ] Availability alert rule enabled
- [ ] Server error (5xx) alert exists
- [ ] Alert action group configured

---

## Cost Management Validation

### Budget

- [ ] Budget created at correct scope
- [ ] Budget amount defined
- [ ] Alert thresholds configured
- [ ] Email notifications enabled

---

## Operational Readiness

- [ ] Environment can be safely destroyed and recreated
- [ ] No manual steps remain undocumented
- [ ] Configuration decisions align with `decisions.md`

---

## Final Status

Manual Deployment Status:

- [ ] **Pass**
- [ ] **Fail**

If **Fail**, document issues and remediate before proceeding to Infrastructure as Code implementation.
