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
                { identifier = "dmz-eks-cluster"        , name_prefix = "eks-cluster"   , description = "EKS Cluster"         },
                { identifier = "dmz-eks-node"           , name_prefix = "eks-node"      , description = "EKS Node"         },
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
                SecurityGroup   = "dmz-eks-cluster"
                Protocol        = "tcp"
                PortRange       = 443
                Source          = "dmz-eks-node"
                Description     = "from worker node"
            }
    ]
}





