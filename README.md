# HCP Terraform Jumpstart (Automated)

This repo automates baseline setup for HCP Terraform:
1. Read SSO (SAML) settings (manual trust setup in console)
2. Create a Team (and optional member example)
3. Configure GitHub (GitHub App) VCS connection
4. Create an org-level Variable Set (+ example variables)
5. Create a Project
6. Create a Workspace (VCS-driven, monorepo-friendly)
7. Configure a Prisma Cloud Run Task and attach it to the workspace

> NOTE: SSO trust with Azure Entra ID is a manual, out-of-band step. This module reads SSO state for visibility.

## Usage

```bash
terraform init
terraform plan -var-file=terraform.tfvars
terraform apply -var-file=terraform.tfvars
```

### Required Inputs
- `tfe_token` – Terraform Cloud token
- `organization` – Terraform Cloud org slug
- `github_app_installation_token` – GitHub App installation token
- `repo_identifier` – e.g., `your-org/your-repo`
- `prisma_url`, `prisma_hmac` – Prisma Cloud Run Task details

### Optional
- `github_api_url`, `github_http_url` for GitHub Enterprise Server
- `working_directory` for monorepo layout
- `workspace_tags`, `default_region`

## Security
- Keep tokens out of VCS.
- Use least privilege for the GitHub App installation.
- Prefer SCIM for user/group lifecycle rather than managing `tfe_team_member` in code.
