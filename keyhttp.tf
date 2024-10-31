resource "alicloud_ecs_key_pair" "key" {
  key_pair_name = "keyhttp"
  key_file      = "keyhttp.pem"
}
