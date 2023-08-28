include "root" {
    path = find_in_parent_folders()
}

terraform {
    source = "${path_relative_from_include()}/../Terragrunt-AWS-Module//Redshift/Redshift_Cluster"
}

dependency "securitygroup" {
    config_path = "../../network/securitygroup/"
}
dependency "redshift_env_config" {
    config_path = "../env_config/"
}

inputs = {
    scg_id                                  = dependency.securitygroup.outputs.scg_id
    name_prefix                             = "test01"
    net_env                                 = "dmz"
    database_name                           = "dev"
    master_username                         = "awsuser"
    master_password                         = "Star12#$"
    node_type                               = "ra3.xlplus"
    # cluster_type                            = "single-node"
    # cluster_type                            = "multi-node"
    number_of_nodes                         = 1
    port                                    = 5444
    cluster_subnet_group_name               = "subgrp-ue1-kyo-dev-dmz-temp-01"
    cluster_parameter_group_name            = "pargrp-ue1-kyo-dev-dmz-temp-01"
    vpc_security_group_identifier           = ["dmz-rs-temp01"]
    publicly_accessible                     = false
    availability_zone_relocation_enabled    = true
    ### Logging
    logs_enable                             = true
    log_destination_type                    = "cloudwatch"
    log_exports                             = ["connectionlog", "userlog", "useractivitylog"]
}




