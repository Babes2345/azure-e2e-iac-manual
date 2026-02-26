# Platform Deployment - Phase 01

## Purpose

This document describes the manual deployment of the **shared platform baseline** that all workload resources depend on.

The platform layer establishes foundational services required for monitoring, security, and centralized management before application resources are introduced.

This phase is intentionally performed **manually** to build operational understanding prior to migrating the environment to Terraform Infrastructure as Code.

---

## Components Deployed

The following resources are created during this phase:

- Resource Group creation
- Naming and tagging standard application
- Log Analytics Workspace
- Application Insights
- Azure Key Vault
- (Optional) Storage Account for Terraform remote state

These resources form the core platform services shared across environments and workloads.

---

## Deployment Objectives

The platform deployment aims to:

- Establish a centralized monitoring foundation
- Enable secure secret storage
- Apply consistent governance through tagging
- Prepare infrastructure for Terraform state management
- Validate Azure configuration prior to automation

---

## Architecture Role

The platform layer represents shared infrastructure commonly found in enterprise landing zone architectures.

It provides:

- Observability services
- Security boundaries
- Centralized logging
- Identity-integrated secret management

All future workload deployments depend on this layer.

---

## Deployment Steps (High-Level)

1. Create platform resource group
2. Apply required naming and tagging standards
3. Deploy Log Analytics Workspace
4. Deploy Application Insights linked to Log Analytics
5. Deploy Azure Key Vault with RBAC authorization enabled
6. (Optional) Create storage account for Terraform remote state

Detailed portal steps are documented in subsequent sections.

---

## Validation

After deployment, verify:

- Platform resource group exists
- Tags are applied consistently
- Log Analytics Workspace is operational
- Application Insights is connected to workspace
- Key Vault is accessible and RBAC-enabled
- Resources appear correctly within Azure Portal

---

## Outcome

At completion of this phase, the environment will contain a fully deployed **platform layer**, manually provisioned and validated.

This platform baseline will serve as the foundation for:

- Network deployment
- Workload resources
- Terraform migration
- Monitoring and alert configuration

Proceed to the next deployment phase once validation is complete.
