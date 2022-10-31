module "name" {
  source = "github.com/s3d-club/terraform-external-name?ref=v0.1.15"

  path    = path.module
  context = join("-", [var.name_prefix, "igress-open"])
  tags    = var.tags
}

resource "aws_security_group" "this" {
  description = "Open inbound traffic"
  name_prefix = module.name.prefix
  tags        = module.name.tags
  vpc_id      = var.vpc_id

  ingress {
    cidr_blocks      = var.cidrs
    description      = "Open Access"
    from_port        = 0
    ipv6_cidr_blocks = var.cidr6s
    protocol         = "-1"
    to_port          = 0
  }
}
