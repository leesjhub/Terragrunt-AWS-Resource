include "root" {
    path = find_in_parent_folders()
}

terraform {
    source = "${path_relative_from_include()}/../Terragrunt-AWS-Module/container/eks-node"
}

dependency "vpc" {
    config_path = "../../network/vpc/"
}

dependencies {
    paths = ["../eks-cluster01/"]
}

inputs = {
    sub_id                  = dependency.vpc.outputs.sub_id
    eks_node_group             = [
        {
            identifier              = "eks-node"
            name_prefix             = "eks-node"
            cluster_name            = "eks-cluster01"
            sub_identifiers         = ["dmz-web-01a", "dmz-web-01c"]
            role_arn                = "arn:aws:iam::832788968856:role/iam-role-k8s-dev-eks-node"
        }   
    ]
}

