include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../shared"
}

inputs = {
   subscription_id = "11c61beb-b32b-4166-9d6c-74cb3a2e04da" # sub-cptdx-08
    prefix          = "cptdtfprod"
    location        = "germanywestcentral"
    Environment = "prod"
}