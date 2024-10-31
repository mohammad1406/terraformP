resource "alicloud_security_group" "redis_sg" {
  name        = "redis_sg"
  description = "redis_sg"
  vpc_id      = alicloud_vpc.vpc.id
}


resource "alicloud_security_group_rule" "redis_sg_allow_ssh" {
  type                     = "ingress"
  ip_protocol              = "tcp"
  policy                   = "accept"
  port_range               = "22/22"
  priority                 = 1
  security_group_id        = alicloud_security_group.redis_sg.id
  source_security_group_id = alicloud_security_group.bastion_sg.id
}


resource "alicloud_security_group_rule" "redis_sg_allow_redis" {
  type                     = "ingress"
  ip_protocol              = "tcp"
  policy                   = "accept"
  port_range               = "6379/6379"
  priority                 = 1
  security_group_id        = alicloud_security_group.redis_sg.id
  source_security_group_id = alicloud_security_group.http_sg.id
}