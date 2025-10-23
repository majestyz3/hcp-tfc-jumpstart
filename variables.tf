variable "tfe_token" {
  description = "Terraform Cloud user/team API token with appropriate permissions"
  type        = string
  sensitive   = true
}

variable "organization" {
  description = "Terraform Cloud organization slug (e.g., acme-corp)"
  type        = string
}

variable "github_api_url" {
  description = "GitHub API base URL (Public: https://api.github.com, GHES: https://github.example.com/api/v3)"
  type        = string
  default     = "https://api.github.com"
}

variable "github_http_url" {
  description = "GitHub HTTP base URL (Public: https://github.com, GHES: https://github.example.com)"
  type        = string
  default     = "https://github.com"
}

variable "github_app_installation_token" {
  description = "GitHub App installation token with access to the target repo(s)"
  type        = string
  sensitive   = true
}

variable "project_name" {
  description = "Project name in TFC"
  type        = string
  default     = "platform-network"
}

variable "workspace_name" {
  description = "Workspace name in TFC"
  type        = string
  default     = "network-prod"
}

variable "repo_identifier" {
  description = "GitHub organization/repo (e.g., acme/infrastructure)"
  type        = string
}

variable "repo_branch" {
  description = "Default VCS branch to track"
  type        = string
  default     = "main"
}

variable "working_directory" {
  description = "Relative path within repo if using a monorepo (empty for repo root)"
  type        = string
  default     = ""
}

variable "workspace_tags" {
  description = "Tags to attach to the workspace"
  type        = list(string)
  default     = ["env:prod", "owner:platform"]
}

variable "default_region" {
  description = "Default region used by modules"
  type        = string
  default     = "eastus"
}

variable "prisma_url" {
  description = "Prisma Cloud Run Task endpoint URL"
  type        = string
}

variable "prisma_hmac" {
  description = "HMAC key shared with Prisma to validate callbacks"
  type        = string
  sensitive   = true
}
