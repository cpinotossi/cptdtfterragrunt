# Generated by Terragrunt. Sig: nIlQXj57tbuaRZEa
terraform {
  backend "azurerm" {
    container_name       = "terraform-state-prod"
    key                  = "prod/alz/terraform.tfstate"
    storage_account_name = "cptdtfgrunt"
    tenant_id            = "ade68923-b72b-4190-8508-a19a58692001"
    use_azuread_auth     = "true"
  }
}
