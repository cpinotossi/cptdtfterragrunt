include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../shared"
}

inputs = {
   subscription_id = "65668fbe-24d6-410e-b9b7-b9e52a499caf" # sub-cptdx-09
    prefix          = "cptdtfdev"
    location        = "germanywestcentral"
    Environment = "dev"
}