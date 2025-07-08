


locals {
    # Automatically load environment-level variables
    env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
    # path_to_env_hcl = path_relative_to_include("env.hcl")
#     # env_vars = read_terragrunt_config(path_relative_to_include("env.hcl"))
#     # path_to_env_hcl = "${path_relative_to_include()}"
#     # env_vars = read_terragrunt_config("${path_relative_to_include()}/env.hcl")
#     env_vars = read_terragrunt_config("env.hcl")

#     # Extract the variables we need for easy access
    env_name                        = local.env_vars.locals.env_name
    backend_type                    = local.env_vars.locals.backend_type
    subscription_id                        = local.env_vars.locals.subscription_id
    prefix                              = local.env_vars.locals.prefix
    location                          = local.env_vars.locals.location
    deployment_storage_resource_group_name = local.env_vars.locals.deployment_storage_resource_group_name
    deployment_storage_account_name        = local.env_vars.locals.deployment_storage_account_name
    tenant_id                         = local.env_vars.locals.tenant_id
}


# Generate an Azure provider block
# generate "provider" {
#   path      = "provider.tf"
#   if_exists = "overwrite_terragrunt"
#   contents  = <<EOF
# provider "azurerm" {
#   features {}
# }
# EOF
# }

# Configure Terragrunt to automatically store tfstate files in an Blob Storage container
# remote_state {
#     backend = "local"
#     generate = {
#         path      = "backend.tf"
#         if_exists = "overwrite"
#     }
#     config = {
#             path = "${path_relative_to_include()}/cpt.terraform.tfstate"
# }
# }

# # Configure Terragrunt to automatically store tfstate files in an Blob Storage container
remote_state {
    backend = local.backend_type
    generate = {
        path      = "backend.tf"
        if_exists = "overwrite"
    }
    config = (
        local.backend_type == "azurerm" ? {
            use_azuread_auth = true
            tenant_id           = local.env_vars.locals.tenant_id
            # subscription_id      = local.subscription_id
            # resource_group_name  = local.deployment_storage_resource_group_name
            storage_account_name = local.deployment_storage_account_name
            container_name       = "terraform-state-${local.env_name}"
            key                  = "${path_relative_to_include()}/terraform.tfstate"
        } : local.backend_type == "local" ? {
            path = "${path_relative_to_include()}/terraform.tfstate"
        } : {}
    )
}