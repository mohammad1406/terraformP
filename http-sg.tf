resource "alicloud_security_group" "http_sg" {
  name        = "http_sg"
  description = "http_sg"
  vpc_id      = alicloud_vpc.vpc.id
}

resource "alicloud_security_group_rule" "http_sg_allow_ssh" {
  type                     = "ingress"
  ip_protocol              = "tcp"
  policy                   = "accept"
  port_range               = "22/22"
  priority                 = 1
  security_group_id        = alicloud_security_group.http_sg.id
  source_security_group_id = alicloud_security_group.bastion_sg.id
}

resource "alicloud_security_group_rule" "allow-http" {
  type                     = "ingress"
  ip_protocol              = "tcp"
  policy                   = "accept"
  port_range               = "80/80"
  priority                 = 1
  security_group_id        = alicloud_security_group.http_sg.id
  cidr_ip = "0.0.0.0/0"
}