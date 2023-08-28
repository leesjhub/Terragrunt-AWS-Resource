include "root" {
    path = find_in_parent_folders()
}

terraform {
    source = "${path_relative_from_include()}/../Terragrunt-AWS-Module/network/vpcendpoint"
}

dependency "vpc" {
    config_path = "../vpc"
}

dependency "securitygroup" {
    config_path = "../securitygroup"
}

inputs = {
    vpc_id              = dependency.vpc.outputs.vpc_id
    sub_id              = dependency.vpc.outputs.sub_id
    rtb_id              = dependency.vpc.outputs.rtb_id
    scg_id              = dependency.securitygroup.outputs.scg_id

    VPC_Endpoint_Gateway    = [
        {
            net_env     = "dmz",            vpc_identifier  = "dmz-01",     rtb_identifiers      = ["dmz-web"]
            identifier  = "dmz-s3-gateway", name_prefix     = "s3-gateway", service_name        = "com.amazonaws.ap-northeast-2.s3"
        },
    ]
    VPC_Endpoint_Interface  = [
        {
            net_env             = "dmz",    vpc_identifier = "dmz-01", sub_identifiers = ["dmz-web-01a", "dmz-web-01c"], scg_identifiers = ["dmz-vpce"]
            service             = [
                {   identifier = "dmz-ssm",                   name_prefix = "ssm",              service_name = "com.amazonaws.ap-northeast-2.ssm"                },
                {   identifier = "dmz-ssmmessages",           name_prefix = "dmz-ssmmessages",        service_name = "com.amazonaws.ap-northeast-2.ssmmessages"        },
                {   identifier = "dmz-ec2",                   name_prefix = "dmz-ec2",                service_name = "com.amazonaws.ap-northeast-2.ec2"                },
                {   identifier = "dmz-ec2messages",           name_prefix = "dmz-ec2messages",        service_name = "com.amazonaws.ap-northeast-2.ec2messages"        },
                {   identifier = "dmz-monitoring",            name_prefix = "dmz-monitoring",         service_name = "com.amazonaws.ap-northeast-2.monitoring"         },
                # {   identifier = "dmz-kinesis-firehose",      name_prefix = "dmz-kinesis-firehose",     service_name = "com.amazonaws.ap-northeast-2.kinesis-firehose"   },
            ]
        }
    ]
}






