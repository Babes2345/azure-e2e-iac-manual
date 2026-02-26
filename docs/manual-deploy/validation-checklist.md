Manual Deployment Validation Checklist
Purpose

This checklist confirms that the manually deployed environment meets all architectural, security, monitoring, and operational requirements defined for this project.

This document serves as:

Proof of correct manual deployment

The baseline for Terraform and Bicep parity

A reference for troubleshooting and audits

All items must pass before Infrastructure as Code implementation begins.

Platform Validation
Resource Groups

 rg-platform exists

 rg-workload exists

 Resource placement aligns with intended purpose

Naming and Tagging

 Resources follow naming convention

 Required tags are applied to all resources:

environment

project

owner

costCenter

Networking Validation
Virtual Network

 Virtual Network exists in rg-platform

 Address space matches documented design

 Region is consistent with platform resources

Subnets

 snet-app exists

 snet-mgmt (or reserved subnet) exists

 Address ranges do not overlap

Network Security Groups

 NSG exists in rg-platform

 NSG is associated with snet-app

 Least-privilege inbound rules are defined

 Default deny inbound behavior is enforced

Effective Security Rules

 Effective security rules reflect intended NSG configuration

 No unintended inbound access is permitted

Security & Key Vault Validation
Key Vault Configuration

 Key Vault exists in rg-platform

 Soft delete is enabled

 Purge protection is enabled

 RBAC authorization model is enabled

 No access policies are configured

Access Control

 Administrative access is restricted

 Web App Managed Identity has Key Vault Secrets User role

 Role assignments are scoped to the Key Vault resource

Secrets

 Test secret exists (demo-secret)

 No secrets are stored in application configuration or source control

Workload Validation
App Service Plan

 App Service Plan exists in rg-workload

 SKU is appropriate for lab usage

 Region matches platform resources

Web App

 Web App is running

 Default or sample page loads successfully

 Managed Identity is enabled

 Application does not store secrets locally

Deployment Slot

 Staging slot exists

 Slot URL is accessible

 Slot configuration is cloned correctly

Monitoring & Alerting Validation
Log Analytics

 Log Analytics Workspace exists

 Diagnostic logs are being ingested

 Logs show recent timestamps

Application Insights

 Application Insights is workspace-based

 Requests and availability data are visible

Diagnostic Settings

 Diagnostic settings exist for the Web App

 Logs are routed to Log Analytics

 Metrics are enabled where supported

Alerts

 Availability test is configured

 Availability alert rule is enabled

 Server error (5xx) alert exists

 Alert action group is configured

Cost Management Validation
Budget

 Budget exists at the correct scope

 Budget amount is defined

 Alert thresholds are configured

 Email notifications are set

Operational Readiness

 Environment can be safely destroyed and recreated

 No manual steps are undocumented

 All configuration decisions align with decisions.md

Final Status

Manual Deployment Status:
☐ Pass
☐ Fail

If Fail, document issues and remediate before proceeding.