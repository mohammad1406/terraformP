resource "alicloud_ecs_key_pair" "key" {
  key_pair_name = "keyhttp9"
  key_file      = "keyhttp9.pem"
}
