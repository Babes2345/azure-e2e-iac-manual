# Monitoring, Alerts, and Cost Controls - Phase 05

## Purpose

This phase enables **Day-2 operational readiness** by ensuring the environment is observable, alerting is configured, and cost protections are enforced.

By the end of this step:

- Logs and metrics are centrally collected
- Core alerts are configured
- Availability monitoring is active
- Cost safeguards prevent unexpected spend

---

## Scope

This deployment includes:

- Log Analytics Workspace validation
- Application Insights validation
- Web App diagnostic settings
- Availability monitoring
- Server error alerting
- Budget and cost alerts
- Log ingestion validation

---

## Step 1 - Validate Log Analytics Workspace

### Azure Portal

1. Navigate to **Log Analytics workspaces**
2. Open the workspace created in **Phase 01**

### Confirm

- Workspace exists in `rg-platform`
- Region matches platform deployment
- Workspace opens successfully

### Validation

- Logs (KQL editor) is accessible
- No permission errors appear

---

## Step 2 - Validate Application Insights

1. Navigate to **Application Insights**
2. Open the instance created earlier

### Confirm

- Workspace-based Application Insights is enabled
- Linked to Log Analytics workspace
- Region and resource group are correct

### Validation

- Overview dashboard loads
- Metrics panel is accessible
- Requests may initially be low or zero

---

## Step 3 - Enable Web App Diagnostic Settings

**Goal:** Forward platform logs into centralized logging.

### Azure Portal

1. Navigate to the **Web App (production slot)**
2. Select **Monitoring -> Diagnostic settings**
3. Select **Add diagnostic setting**

### Configuration

| Setting | Value |
|--------|------|
| Name | `diag-webapp-to-law` |
| Destination | Send to Log Analytics workspace |
| Workspace | Platform Log Analytics Workspace |

### Enable Log Categories (if available)

- AppServiceHTTPLogs
- AppServiceConsoleLogs
- AppServiceAppLogs
- AppServiceAuditLogs
- AllMetrics

Select **Save**.

Repeat for the **staging slot** if treated as a separate resource.

### Validation

- Diagnostic setting is visible
- Log Analytics workspace listed as destination

---

## Step 4 - Create Availability Monitoring

**Goal:** Detect application downtime.

### Application Insights

1. Navigate to **Availability**
2. Select **Create availability test**

### Configuration

| Setting | Value |
|--------|------|
| Name | `avail-webapp-prod` |
| URL | Production Web App URL |
| Frequency | 5 minutes |
| Test Locations | 1–3 locations (cost conscious) |

Enable alert creation.

### Alert Configuration

| Setting | Value |
|--------|------|
| Severity | Sev 2 |
| Action Group | Email notification |

### Validation

- Availability results appear after several minutes
- Alert rule is visible under **Monitor -> Alerts**

---

## Step 5 - Create 5xx Server Error Alert

**Goal:** Detect sustained server-side failures.

### Azure Portal

1. Navigate to **Monitor -> Alerts**
2. Select **Create -> Alert rule**

### Configuration

| Setting | Value |
|--------|------|
| Scope | Production Web App |
| Condition | Server Errors / HTTP 5xx |
| Threshold | > 5 errors within 5 minutes |
| Severity | Sev 2 or Sev 3 |
| Action Group | Existing email action group |

Create the alert.

### Validation

- Alert shows as **Enabled**
- Rule appears in Alerts list

---

## Step 6 - Apply Required Tags

Ensure all resources include standardized tags:

- `environment`
- `project`
- `owner`
- `costCenter`

### Validation

Review resources inside resource groups and confirm consistent tagging.

---

## Step 7 - Configure Budget and Cost Alerts

**Goal:** Prevent unexpected costs.

### Azure Portal

1. Navigate to **Cost Management + Billing**
2. Select **Budgets -> Create**

### Scope

- Subscription (preferred)  
  or
- `rg-workload` (acceptable)

### Configuration

| Setting | Example |
|--------|--------|
| Name | `budget-e2e-project` |
| Amount | $25–$50 |
| Reset Period | Monthly |

### Alert Thresholds

- 50% Actual Spend
- 80% Actual Spend
- 100% Actual Spend

Add your email as recipient.

### Validation

- Budget status = Active
- Alert thresholds visible

---

## Step 8 - Validate Log Ingestion

Navigate to:

**Log Analytics Workspace -> Logs**

Run a validation query.

### Example Queries

#### Broad Search

```kql
search "AppService"
AzureDiagnostics
| sort by TimeGenerated desc
| take 50
