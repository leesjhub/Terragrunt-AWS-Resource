include "root" {
    path = find_in_parent_folders()
}

terraform {
    source = "${path_relative_from_include()}/../Terragrunt-AWS-Module/container/eks-cluster"
}

dependency "vpc" {
    config_path = "../../network/vpc/"
}

dependency "scg" {
    config_path = "../../network/securitygroup/"
}

inputs = {
    sub_id                      = dependency.vpc.outputs.sub_id
    scg_id                      = dependency.scg.outputs.scg_id
    identifier                  = "eks-cluster01"     
    name                        = "eks-cluster01"     
    sub_identifiers             = ["dmz-web-01a", "dmz-web-01c"]
    scg_identifiers             = ["dmz-eks-cluster"]
    eks_version                 = "1.23"
    role_arn                    = "arn:aws:iam::832788968856:role/iam-role-k8s-dev-eks-cluster"
    endpoint_public_access      = true
    endpoint_private_access     = true

}

