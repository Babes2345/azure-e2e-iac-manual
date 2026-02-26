Prerequisites
Azure Subscription

An active Azure subscription is required to build and validate this project.

A paid Azure subscription is recommended to ensure access to all required services and configurations.

The Azure free tier may be used; however, it includes service limits and quotas that can restrict certain features, SKUs, or deployment options.

For consistent results and to avoid interruptions during the build, a minimum one-month active subscription is recommended.

Required Permissions

The user performing the deployment must have sufficient permissions within the subscription:

Owner or Contributor access at the subscription level for manual deployment

Ability to create:

Resource groups

Networking resources

App Service resources

Monitoring and logging resources

Role assignments

Local Tooling

The following tools must be installed and configured on the local machine:

Azure CLI (latest stable version)

Terraform (latest stable version)

Bicep CLI (via Azure CLI)

Git

A code editor (e.g., VS Code)

Authentication to Azure must be verified using:

az login

Naming and Tagging Standards

Before deployment, ensure a basic naming and tagging convention is defined and consistently applied:

Resource names should reflect environment, workload, and purpose

Required tags:

environment

project

owner

costCenter

These standards will be enforced during both manual and IaC deployments.

Cost Awareness

This project provisions billable Azure resources.

Costs should remain low if resources are destroyed after use.

A budget and cost alert will be configured during deployment.

A teardown process will be documented to ensure resources can be safely removed.

Validation

Before proceeding, confirm:

Azure subscription is active

Required permissions are assigned

Local tools are installed and accessible

Azure authentication is successful

Once validated, proceed to Platform Deployment.