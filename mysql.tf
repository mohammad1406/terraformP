resource "alicloud_instance" "mysql" {
  availability_zone          = data.alicloud_zones.default.zones.0.id
  instance_name              = "mysql"
  instance_type              = "ecs.g6.large"
  image_id                   = "ubuntu_24_04_x64_20G_alibase_20240812.vhd"
  security_groups            = [alicloud_security_group.mysql_sg.id]
  instance_charge_type       = "PostPaid"
  system_disk_category       = "cloud_essd"
  vswitch_id                 = alicloud_vswitch.private-a.id
  key_name                   = alicloud_ecs_key_pair.key.key_pair_name
  internet_max_bandwidth_out = 0
  internet_charge_type       = "PayByTraffic"
  user_data = base64encode(templatefile("mysql_init.tpl", {
    mysql_root_password = var.mysql_root_password
    mysql_database      = var.mysql_database
  }))

}
output "mysql_private_ip" {
  value = alicloud_instance.mysql.private_ip
}