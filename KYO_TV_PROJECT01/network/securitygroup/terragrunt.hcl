include "root" {
    path = find_in_parent_folders()
}

terraform {
    source = "${path_relative_from_include()}/../Terragrunt-AWS-Module/network/securitygroup"
}

dependency "network" {
    config_path = "../vpc"
}

# locals {
#     security_group_rule     = csvdecode(file("./Security_Group_List.csv"))
# }

inputs = {
    vpc_id                  = dependency.network.outputs.vpc_id
    SecurityGroup           = [
        {
            net_env         = "dmz"
            vpc_identifier  = "dmz-01"
            securitygroup    = [
                { identifier = "dmz-vpce"               , name_prefix = "vpce"          , description = "VPCEndpoint"         },
                { identifier = "dmz-sml-domain"         , name_prefix = "sml-domain"    , description = "Sagemaker Domain"         },
                { identifier = "dmz-rs-temp01"         , name_prefix = "rs-temp01"    , description = "Redshift"         },
            ]
        }
    ]
    # Security_Group_Rule     = local.security_group_rule
        Security_Group_Rule     = [
            {
                SecurityGroup   = "dmz-vpce"
                Protocol        = "tcp"
                PortRange       = 443
                Source          = "0.0.0.0/0"
                Description     = "VPCEndpoint"
            },
            {
                SecurityGroup   = "dmz-rs-temp01"
                Protocol        = "tcp"
                PortRange       = 5444
                Source          = "125.131.155.168/32"
                Description     = "Client_Test01"
            }
    ]
}







