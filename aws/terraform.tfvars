domain_name  = "femsa.nullapps.io"
organization = "femsa"
account      = "poc"
namespace    = "demo"
region       = "us-east-1"
vpc_stg = {
  cidr            = "172.30.0.0/16"
  private_subnets = ["172.30.0.0/20", "172.30.16.0/20", "172.30.32.0/20"]
  public_subnets  = ["172.30.48.0/20", "172.30.64.0/20", "172.30.80.0/20"]
  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

vpc_production = {
  cidr            = "172.31.0.0/16"
  private_subnets = ["172.31.0.0/20", "172.31.16.0/20", "172.31.32.0/20"]
  public_subnets  = ["172.31.48.0/20", "172.31.64.0/20", "172.31.80.0/20"]
  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
}
nrn = "organization=1304166607:account=996081796"
