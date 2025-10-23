terraform {
  required_version = ">= 1.6.0"
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.56"
    }
  }
}

provider "tfe" {
  hostname = "app.terraform.io"
  token    = var.tfe_token
}

data "tfe_saml_settings" "org_sso" {
  organization = var.organization
}

resource "tfe_team" "admins" {
  name         = "tfc-admins"
  organization = var.organization
}

resource "tfe_oauth_client" "github" {
  organization     = var.organization
  api_url          = var.github_api_url
  http_url         = var.github_http_url
  service_provider = "github"
  oauth_token      = var.github_app_installation_token
}

resource "tfe_variable_set" "common" {
  name         = "common-vars"
  description  = "Shared variables for workspaces or projects"
  organization = var.organization
}

resource "tfe_variable_set_variable" "region" {
  key             = "region"
  value           = var.default_region
  variable_set_id = tfe_variable_set.common.id
  category        = "terraform"
  description     = "Default region for modules"
  sensitive       = false
}

resource "tfe_project" "platform_network" {
  name         = var.project_name
  organization = var.organization
}

resource "tfe_project_variable_set" "common_to_project" {
  project_id      = tfe_project.platform_network.id
  variable_set_id = tfe_variable_set.common.id
}

resource "tfe_workspace" "network" {
  name              = var.workspace_name
  organization      = var.organization
  project_id        = tfe_project.platform_network.id
  execution_mode    = "remote"
  working_directory = var.working_directory
  tag_names         = var.workspace_tags
  auto_apply        = false

  vcs_repo {
    identifier     = var.repo_identifier
    oauth_token_id = tfe_oauth_client.github.oauth_token_id
    branch         = var.repo_branch
  }
}

resource "tfe_run_task" "prisma" {
  name              = "Prisma Cloud"
  description       = "Validate Terraform plans with Prisma Cloud"
  url               = var.prisma_url
  organization      = var.organization
  hmac_key          = var.prisma_hmac
  enforcement_level = "mandatory"
}

resource "tfe_workspace_run_task" "attach_prisma" {
  workspace_id = tfe_workspace.network.id
  run_task_id  = tfe_run_task.prisma.id
  stage        = "post_plan"
}
