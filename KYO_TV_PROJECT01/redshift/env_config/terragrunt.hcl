include "root" {
    path = find_in_parent_folders()
}

terraform {
    source = "${path_relative_from_include()}/../Terragrunt-AWS-Module//Redshift/Redshift_ENV_Config"
}

dependency "network" {
    config_path = "../../network/vpc/"
}

inputs = {
    sub_id                  = dependency.network.outputs.sub_id
    Redshift_Subnet_Groups  = [
        {
            net_env         = "dmz"
            identifier      = "temp-01"
            name_prefix     = "temp-01"
            sub_identifier  = ["dmz-db-01a", "dmz-db-01c"]
        }
    ]
    Redshift_Parameter_Groups  = [
        {
            net_env                 = "dmz"
            identifier              = "temp-01"
            name_prefix             = "temp-01"
            family                  = "redshift-1.0"
        }
    ]
}




