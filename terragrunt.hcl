terraform_version_constraint = ">= 1.3.0"
terragrunt_version_constraint = ">= 0.38.12"

locals {
    Share_vars              = read_terragrunt_config(find_in_parent_folders("Share.hcl"))
    Region                  = lookup(local.Share_vars.locals, "Region")
    Project_code            = lookup(local.Share_vars.locals, "Project_code")
    Environment             = lookup(local.Share_vars.locals, "Environment")

    #### backend remote state configure
    remote_state_bucket     = "s3-an2-sha-dev-terragrunt"
    s3_authorized_profile   = "mzc-cn-lsj"
    Bucket_prefix           = "${local.Project_code}-${local.Environment}"
}
 
generate   = local.Share_vars.generate
 
remote_state {
    backend = "s3"
    generate = {
        path      = "backend.tf"
        if_exists = "overwrite_terragrunt"
    }
    config = {
        bucket          = "${local.remote_state_bucket}"
        key             = "terragrunt/${local.Bucket_prefix}/${path_relative_to_include()}/terraform.tfstate"
        region          = "ap-northeast-2"
        profile         = local.s3_authorized_profile
        encrypt         = true
    }
}

inputs =  {
    Share_Middle_Name   = join("-", [local.Region, local.Project_code, local.Environment])
}