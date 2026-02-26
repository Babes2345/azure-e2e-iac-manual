# Cost Governance — Azure E2E Infrastructure Baseline

## Overview

This document describes the cost governance strategy applied to the Azure End-to-End Infrastructure project.

The objective of this environment was to demonstrate production-aligned cloud architecture while operating under Azure free subscription constraints. Cost control was treated as an architectural requirement rather than an afterthought.

Design decisions prioritize:

- Predictable spending
- Minimal operational cost
- Secure configuration within free-tier limits
- Scalable design without future re-architecture

---

## Cost Governance Principles

The environment was designed according to the following principles:

1. **Use Platform Services Over Compute**
2. **Prefer Free or Consumption-Based SKUs**
3. **Minimize Always-On Resources**
4. **Control Log Ingestion**
5. **Enable Observability Without Excess Cost**
6. **Design for Scale Without Paying for Scale**

---

## Resource Cost Strategy

### Resource Groups

Infrastructure is separated into:

- `rg-platform-dev`
- `rg-workload-dev`

This enables future cost tracking, budgeting, and chargeback models.

---

### Log Analytics Workspace

Configuration:

- SKU: PerGB2018
- Retention: 30 days
- Minimal diagnostic categories enabled

#### Cost Decision

Log Analytics is required for centralized monitoring but can become expensive if unrestricted logs are collected.

Only security-relevant diagnostics were enabled.

#### Benefit

- Maintains observability
- Controls ingestion volume
- Prevents unexpected billing spikes

---

### Application Insights

Application Insights is workspace-based and linked to Log Analytics.

#### Cost Control Measures

- No synthetic tests enabled
- No continuous load generation
- Minimal telemetry ingestion

#### Result

Monitoring capability demonstrated without sustained cost generation.

---

### Azure Key Vault

Key Vault operates under a consumption model.

#### Cost Optimization

- Limited secret operations
- Demo secret used only for validation
- RBAC model avoids credential sprawl

Key Vault incurs negligible cost under low usage.

---

### Virtual Network and NSG

Networking components incur no baseline cost unless advanced features are enabled.

#### Design Choice

- No NAT Gateway
- No Private Endpoints (cost trade-off)
- No VPN Gateway

#### Reasoning

Network segmentation demonstrated without introducing paid networking services.

---

### App Service Strategy

App Service deployment was constrained by subscription quota limitations.

#### Architectural Response

- Windows F1 (Free) SKU used
- Deployment gated using Terraform variable
- Infrastructure remains deployable without compute

enable_appservice = false


#### Benefit

- Infrastructure validation preserved
- Zero ongoing compute cost
- Demonstrates conditional infrastructure deployment

---

## Monitoring Cost Controls

Alerting designed to minimize execution overhead:

- Evaluation frequency: 5 minutes
- Narrow KQL query scope
- Security-focused detection only

Alerts monitor only Key Vault authorization failures instead of broad telemetry scanning.

---

## Terraform Cost Governance

Infrastructure as Code contributes to cost control through:

- Reproducible deployments
- Controlled resource creation
- Versioned infrastructure changes
- Prevention of orphaned resources

Lifecycle protections reduce accidental destruction and recreation cycles that could increase costs.

---

## Trade-Off Decisions

Certain enterprise features were intentionally excluded due to cost constraints:

| Feature | Reason |
|--------|--------|
| Private Endpoints | Not free-tier compatible |
| Azure Firewall | High baseline cost |
| DDoS Protection Plan | Monthly charge |
| Premium Key Vault | Unnecessary for demo scope |

These exclusions were documented as conscious architectural trade-offs.

---

## Operational Cost Model

Estimated steady-state monthly cost:

| Component | Expected Cost |
|-----------|--------------|
| Resource Groups | $0 |
| VNet / NSG | $0 |
| Key Vault (low usage) | ~$0 |
| Log Analytics (minimal ingestion) | Free-tier usage |
| Alerts | Minimal |
| App Service F1 | $0 |

Total expected cost: **$0 under normal usage**.

---

## Governance Outcomes

The environment demonstrates:

- Secure infrastructure within strict budget limits
- Observability without unnecessary spend
- Cost-aware architectural decision making
- Free-tier compatible enterprise patterns

Cost governance was integrated into design decisions rather than applied after deployment.

---

## Future Cost Scaling Strategy

If expanded to production environments:

- Introduce budgets and cost alerts
- Enable tagging-based cost allocation
- Use environment-based subscriptions
- Implement reserved capacity where appropriate
- Expand monitoring retention strategically

The current architecture supports these enhancements without redesign.

---

## Summary

This project demonstrates that secure, observable, and well-architected Azure environments can be built responsibly within financial constraints.

Cost governance was treated as a first-class architectural concern alongside security, reliability, and operational visibility.