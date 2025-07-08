locals {
  env_name        = "prod"
  backend_type = "azurerm"
  subscription_id = "11c61beb-b32b-4166-9d6c-74cb3a2e04da" # sub-cptdx-08
  prefix       = "cptdtfprod"
  location       = "germanywestcentral"
  deployment_storage_resource_group_name = "test"
  deployment_storage_account_name       = "cptdtfgrunt"
  tenant_id = "ade68923-b72b-4190-8508-a19a58692001" # cptdx.net
}