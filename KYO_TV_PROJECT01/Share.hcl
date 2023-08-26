locals {
    Project_code            = "kyo"
    Region                  = "ue1"
    Environment             = "dev"
    Account_alias           = "lsj-sha"
}

generate "provider" {
    path = "provider.tf"
    if_exists = "overwrite_terragrunt"
    contents = <<EOF
provider "aws" {
    region    = "us-east-1"
    profile   = "mzc-cn-lsj"
}
EOF 
}
