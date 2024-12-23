resource "alicloud_security_group" "mysql_sg" {
  name        = "mysql_sg"
  description = "mysql_sg"
  vpc_id      = alicloud_vpc.vpc.id
}
resource "alicloud_security_group_rule" "mysql_sg_allow_ssh" {
  type                     = "ingress"
  ip_protocol              = "tcp"
  policy                   = "accept"
  port_range               = "22/22"
  priority                 = 1
  security_group_id        = alicloud_security_group.mysql_sg.id
  source_security_group_id = alicloud_security_group.bastion_sg.id
}


resource "alicloud_security_group_rule" "mysql_sg_allow_mysql" {
  type                     = "ingress"
  ip_protocol              = "tcp"
  policy                   = "accept"
  port_range               = "3306/3306"
  priority                 = 1
  security_group_id        = alicloud_security_group.mysql_sg.id
  source_security_group_id = alicloud_security_group.http_sg.id
}