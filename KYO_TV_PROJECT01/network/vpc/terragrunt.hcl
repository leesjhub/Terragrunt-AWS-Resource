include "root" {
    path = find_in_parent_folders()
}

terraform {
    source = "${path_relative_from_include()}/../Terragrunt-AWS-Module/network/vpc"
}

inputs = {
    Network                 = [
        {   
            net_env = "dmz", identifier = "dmz-01", name_prefix = "01", cidr_block = "10.10.0.0/23", igw_enable = true 
            subnets          = [                
                {   identifier = "dmz-lb-01a",  name_prefix = "lb-01a",  availability_zone  = "a", cidr_block = "10.10.0.0/27"     },
                {   identifier = "dmz-lb-01c",  name_prefix = "lb-01c",  availability_zone  = "c", cidr_block = "10.10.0.32/27"    },
                {   identifier = "dmz-app-01a", name_prefix = "app-01a", availability_zone  = "a", cidr_block = "10.10.1.0/26"     },
                {   identifier = "dmz-app-01c", name_prefix = "app-01c", availability_zone  = "c", cidr_block = "10.10.1.64/26"    },
                {   identifier = "dmz-db-01a",  name_prefix = "db-01a",  availability_zone  = "a", cidr_block = "10.10.1.128/27"   },
                {   identifier = "dmz-db-01c",  name_prefix = "db-01c",  availability_zone  = "c", cidr_block = "10.10.1.160/27"   },
            ]
            route_tables     = [
                {   identifier = "dmz-lb",      name_prefix = "lb",     association_subnet_identifier = ["dmz-lb-01a", "dmz-lb-01c"]    },
                {   identifier = "dmz-app",     name_prefix = "app",    association_subnet_identifier = ["dmz-app-01a", "dmz-app-01c"]  },
                {   identifier = "dmz-db",      name_prefix = "db",     association_subnet_identifier = ["dmz-db-01a", "dmz-db-01c"]    },
            ]
            nat_gateway     = [
                # {   identifier = "lb-01a",  sub_identifier = "dmz-lb-01a",  ngw_name_prefix = "dmz-lb-01a", eip_name_prefix = "dmz-ngw" },
            ]
        },
    ]   
}

