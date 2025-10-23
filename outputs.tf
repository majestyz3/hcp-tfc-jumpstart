output "sso_enabled" {
  description = "Whether SAML SSO is enabled on the organization"
  value       = try(data.tfe_saml_settings.org_sso.enabled, null)
}

output "vcs_oauth_client_id" {
  description = "OAuth client ID created for VCS provider"
  value       = tfe_oauth_client.github.oauth_token_id
}

output "project_id" {
  value = tfe_project.platform_network.id
}

output "workspace_id" {
  value = tfe_workspace.network.id
}

output "prisma_run_task_id" {
  value = tfe_run_task.prisma.id
}
