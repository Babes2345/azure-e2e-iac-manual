# Architecture Overview (v1)
## Goals

Design and implement a production-style Azure environment that demonstrates the ability to plan, deploy, secure, monitor, and manage cloud infrastructure using both manual methods and Infrastructure as Code.

The goal of this project is to showcase:

- Clear architectural decision-making

- Proper use of Azure-native services

- Security-first and operations-aware design

- Repeatable infrastructure using Terraform and Bicep

- Practical alignment with real-world scenarios rather than overengineered solutions

- This environment is intentionally scoped to represent a single workload deployed following enterprise best practices.

## Non-Goals

- To maintain focus and avoid unnecessary complexity, the following are explicitly out of scope:

- Multi-region active/active architectures

- Kubernetes or container orchestration

- Full hub-and-spoke networking with Azure Firewall

- Large-scale Azure Policy initiatives at management group level

- Complex CI/CD pipelines (optional future enhancement)

- Advanced zero-trust networking implementations

- These may be explored in future projects but are not required to meet this project’s objectives.

## Components
### Core Platform Components

- Azure Resource Groups (platform and workload separation)

- Azure Virtual Network

- Network Security Groups (NSGs)

- Azure Key Vault

- Azure Monitor

- Log Analytics Workspace

- Azure RBAC

- Azure Cost Management (budgets and alerts)
  
- Infrastructure as Code

- Terraform (primary IaC implementation)

- Bicep (Azure-native IaC implementation for parity)

## Networking Plan

The environment will use a single Virtual Network with clearly defined subnets to support future expansion while keeping the initial design simple.

One Virtual Network with a defined address space

### Dedicated subnets for:

- Application workload

- Management or future private endpoints

- Network Security Groups applied at the subnet level

- NSG rules follow least-privilege principles

Inbound access restricted to known, trusted IP ranges where applicable

This design reflects a realistic production baseline without introducing unnecessary complexity such as full hub-and-spoke architectures.

## Security Plan

### Security is implemented using Azure-native controls, following shared responsibility and defense-in-depth principles:

- Azure Active Directory authentication with Multi-Factor Authentication

- Role-Based Access Control (RBAC) scoped at resource group level

- Managed Identities for Azure resources where applicable

- Azure Key Vault for secret management

- Secure access patterns for administrative access

- Optional use of Azure Bastion for management access (if virtual machines are introduced)

- No secrets are hard-coded or stored in source control.

## Monitoring Plan

- Monitoring and observability are treated as first-class components of the architecture.

- Azure Monitor for platform-level metrics

- Log Analytics Workspace as the central log store

- Diagnostic settings enabled on supported resources

- Application and infrastructure health monitoring

- Basic alerting for availability and critical thresholds

- This ensures the environment supports both day-1 deployment and day-2 operations.

## Cost Controls

- Cost management is incorporated from the start:

- Consistent tagging strategy for cost allocation

- Azure budget configured at the resource group or subscription level

- Cost alerts for threshold breaches

- Selection of SKUs appropriate for lab and learning purposes
  
- Resources can be safely destroyed and recreated to minimize unnecessary spend.

## Open Decisions

### The following decisions will be finalized during implementation:

- Final workload type (App Service vs virtual machine-based workload)

- Private networking enhancements (e.g., private endpoints)

- Alert thresholds and monitoring depth

- Terraform module structure vs single-stack approach

- CI/CD integration scope (if any)

- All decisions will be documented in the architecture decision log.

## Status

This document represents Architecture v1 and is considered locked for manual deployment.
Any future changes must be documented and justified to avoid scope creep.
