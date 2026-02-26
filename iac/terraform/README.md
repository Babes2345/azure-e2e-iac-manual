# Terraform Environment - dev

## Overview

This directory contains the Terraform configuration used to deploy the **development environment** for the Azure E2E Infrastructure project.

Infrastructure is deployed using modular Terraform design aligned with production cloud engineering practices.

---

## Architecture

This environment deploys:

- Resource Groups
- Virtual Network and Subnets
- Network Security Groups
- Log Analytics Workspace
- Application Insights
- Azure Key Vault (RBAC-enabled)
- Role Assignments
- Diagnostic Settings
- Alerts and Action Groups
- (Optional) App Service workload

---

## Prerequisites

Install:

- Azure CLI
- Terraform (>= 1.5)
- Git

Authenticate:

```bash
az login
