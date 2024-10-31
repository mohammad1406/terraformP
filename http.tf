resource "alicloud_instance" "http" {
  count                      = 2
  availability_zone          = data.alicloud_zones.default.zones.0.id
  instance_name              = "http${count.index + 1}"
  instance_type              = "ecs.g6.large"
  image_id                   = "ubuntu_24_04_x64_20G_alibase_20240812.vhd"
  security_groups            = [alicloud_security_group.http_sg.id]
  internet_charge_type       = "PayByTraffic"
  instance_charge_type       = "PostPaid"
  system_disk_category       = "cloud_essd"
  vswitch_id                 = alicloud_vswitch.private-a.id
  key_name                   = alicloud_ecs_key_pair.key.key_pair_name
  internet_max_bandwidth_out = 0
  user_data = base64encode(templatefile("http_init.tpl", {
    redis_host  = alicloud_instance.redis.private_ip,
    db_host     = alicloud_instance.mysql.private_ip,
    db_user     = var.db_user,
    db_password = var.db_password,
    db_name     = var.db_name
  }))

}

output "http_private_ips" {
  value = alicloud_instance.http.*.private_ip
}