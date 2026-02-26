05 – Monitoring, Alerts, and Cost Controls
Purpose

Enable day-2 operational readiness by ensuring the environment is observable, alerting is configured, and cost controls are in place.

By the end of this step:

Logs and metrics are centrally collected

Core alerts are configured

A budget and cost alert exist to prevent unexpected spend

Scope

This step includes:

Log Analytics Workspace validation

Application Insights configuration validation

Diagnostic settings for the Web App

Alerts (availability + 5xx threshold)

Budget + budget alert

Validation checks (logs are arriving and alerts are active)

Monitoring Baseline
Step 1 — Validate Log Analytics Workspace

Azure Portal

Navigate to Log Analytics workspaces

Open the workspace created in Step 01

Confirm:

Workspace is in rg-platform

Region is correct

Workspace is accessible

Validation

Workspace opens successfully

You can access Logs (KQL query editor)

Step 2 — Validate Application Insights

Navigate to Application Insights

Open the instance created in Step 01

Confirm:

It is linked to the Log Analytics workspace (workspace-based)

It is in the correct region and resource group

Validation

Application Insights overview loads

You can view basic metrics (requests may be low/zero initially)

Diagnostic Settings
Step 3 — Enable Diagnostic Settings for the Web App

Goal: Send platform logs to Log Analytics.

Navigate to the Web App (production slot)

Select Diagnostic settings (under Monitoring)

Select Add diagnostic setting

Configure:

Diagnostic setting name: diag-webapp-to-law

Destination: Send to Log Analytics workspace

Select the workspace created in Step 01

Under log categories, enable the available logs (typical examples):

AppServiceHTTPLogs

AppServiceConsoleLogs

AppServiceAppLogs

AppServiceAuditLogs (if available)

AllMetrics (if available)

Save

Repeat for the staging slot if it is treated as a separate resource in the portal.

Validation

Diagnostic setting is saved and visible on the Web App

Log Analytics workspace is the destination

Alerts
Step 4 — Create Availability Monitoring (Availability Test)

Goal: Alert if the app is unreachable.

Open Application Insights

Navigate to Availability

Create a new availability test:

Name: avail-webapp-prod

URL: Production Web App URL

Test frequency: 5 minutes (or lowest acceptable)

Locations: Use 1–3 locations (keep costs low)

Create an alert rule when availability fails:

Severity: Sev 2 (or medium)

Action group: Create new (email yourself)

Validation

Availability test shows results after a few minutes

Alert rule is visible under Alerts

Step 5 — Create a 5xx Server Error Alert

Goal: Alert on sustained server-side errors.

Azure Portal

Navigate to Monitor

Select Alerts → Create → Alert rule

Configure:

Scope: Web App (production)

Condition: “Server errors” (or HTTP 5xx metric if available)

Threshold: Example: > 5 errors in 5 minutes (adjust as needed)

Severity: Sev 2 or Sev 3

Action group: Reuse the same group from availability

Create the alert

Validation

Alert appears under Monitor → Alerts

Alert shows as Enabled

Cost Controls
Step 6 — Apply Required Tags (If Not Already Applied)

Ensure all resources have required tags (minimum):

environment

project

owner

costCenter

Validation

View resources in RG and confirm tags are present and consistent

Step 7 — Create a Budget + Alert

Goal: Prevent cost overruns.

Navigate to Cost Management + Billing

Select Budgets

Create a budget scoped to:

Subscription (preferred) or rg-workload (acceptable)

Configure:

Name: budget-e2e-project

Amount: Set a low lab-safe amount (example: $25–$50)

Reset period: Monthly

Alerts:

50% actual

80% actual

100% actual

Alert recipients: Your email

Validation

Budget shows as Active

Alert thresholds are configured

Validation Queries (Log Analytics)
Step 8 — Confirm Logs Are Arriving

Go to Log Analytics Workspace → Logs

Run a simple query to confirm App Service logs are present.

Examples (tables vary by configuration; use what appears in your workspace):

Search broadly for App Service entries:

Query: search for AppService or for your Web App name

Confirm metrics/events are present:

Validate you see recent timestamps

Validation

You can see ingestion occurring (even minimal)

Outcome

At the completion of this step:

Logs and metrics are centralized

Availability monitoring is in place

Error-based alerting is configured

Cost budget and alerts exist

The environment supports basic operational requirements