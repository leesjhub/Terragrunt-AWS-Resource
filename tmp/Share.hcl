locals {
    Project_code            = "sha"
    Region                  = "an2"
    Environment             = "dev"
    Account_alias           = "lsj-sha"
}

generate "provider" {
    path = "provider.tf"
    if_exists = "overwrite_terragrunt"
    contents = <<EOF
provider "aws" {
    region    = "ap-northeast-2"
    profile   = "mzc-cn-lsj"
}
EOF 
}
