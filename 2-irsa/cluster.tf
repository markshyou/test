module "cluster" {
  source  = "tedilabs/container/aws//modules/eks-cluster"
  version = "0.14.0"

  name               = "interface-test"
  kubernetes_version = "1.27"

  subnet_ids   = local.subnet_groups["public"].ids #퍼블릭 서브넷에 eks controlplane을 만듦
  service_cidr = "172.20.0.0/16"

  endpoint_public_access       = true
  endpoint_public_access_cidrs = ["0.0.0.0/0"] #테스트용
  endpoint_private_access      = true
  endpoint_private_access_cidrs = [
    local.vpc.cidr_block,
  ]

  log_types = [
    # "api", "audit", "authenticator", "controllerManager", "scheduler"
  ]
  log_retention_in_days = 90
}
