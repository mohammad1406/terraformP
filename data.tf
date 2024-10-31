data "alicloud_zones" "default" {
  available_disk_category     = "cloud_efficiency"
  available_resource_creation = "VSwitch"
}


#data "alicloud_images" "ubuntu" {
#  name_regex = "ubuntu_24_04.*"
#  most_recent = true
#}