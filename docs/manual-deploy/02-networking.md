02 – Networking Deployment
Purpose

Establish a clean, secure, and expandable network baseline that supports the application workload while avoiding unnecessary architectural complexity.

This network design follows least-privilege principles and is intentionally scoped to allow future enhancements without redesign.

Scope

This step includes:

Virtual Network creation

Subnet design and allocation

Network Security Group (NSG) creation

NSG rule definition

NSG association to subnets

Validation of effective security rules

Virtual Network Creation
Step 1 — Create the Virtual Network

Azure Portal

Navigate to Virtual networks

Select Create

Configure:

Subscription: Target subscription

Resource Group: rg-platform

Name: Use project-aligned naming (e.g., vnet-e2e-prod)

Region: Same region as platform resources

Address space: e.g., 10.10.0.0/16

Proceed to IP Addresses

Subnet Design
Step 2 — Define Subnets

Create the following subnets:

Subnet Name	Address Range	Purpose
snet-app	10.10.1.0/24	Application workload
snet-mgmt	10.10.2.0/24	Future management or private endpoints

Subnets are intentionally defined even if not immediately used to demonstrate forward-looking design.

Complete the VNet creation.

Network Security Group (NSG)
Step 3 — Create the Network Security Group

Navigate to Network security groups

Select Create

Configure:

Resource Group: rg-platform

Name: e.g., nsg-e2e-app

Region: Same as VNet

Step 4 — Configure NSG Rules

Define minimum required rules following least-privilege principles.

Inbound Rules
Priority	Name	Source	Destination	Port	Action	Purpose
100	Allow-HTTPS	Internet	Any	443	Allow	Secure inbound traffic
200	Deny-All-Inbound	Any	Any	Any	Deny	Default deny
Outbound Rules
Priority	Name	Destination	Port	Action	Purpose
100	Allow-Internet	Internet	Any	Allow	Required outbound access

Default Azure outbound rules may be used unless restrictions are required.

NSG Association
Step 5 — Associate NSG to Subnet

Open the Network Security Group

Navigate to Subnets

Select Associate

Associate with:

Virtual Network: vnet-e2e-prod

Subnet: snet-app

Validation
Step 6 — Validate Effective Security Rules

Navigate to the subnet (snet-app)

Select Effective security rules

Confirm:

Custom NSG rules are applied

Deny-by-default behavior is enforced

No unintended inbound access exists

Outcome

At the completion of this step:

A production-aligned Virtual Network is deployed

Subnets are clearly defined and documented

Network Security Groups enforce least-privilege access

The network is ready to support the workload

The design remains simple and expandable