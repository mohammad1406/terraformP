resource "alicloud_ecs_key_pair" "key" {
  key_pair_name = "keyhttp12"
  key_file      = "keyhttp12.pem"
}
