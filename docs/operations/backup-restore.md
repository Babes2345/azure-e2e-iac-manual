# Backup and Recovery

## Infrastructure Recovery

Infrastructure is fully reproducible via Terraform.

Recovery steps:

1. Clone repository
2. Configure backend
3. Run terraform apply

## Data Protection

- Key Vault soft delete enabled
- Purge protection enabled
- Log Analytics retains logs for 30 days
