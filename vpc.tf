resource "alicloud_vpc" "vpc" {
  vpc_name   = "vpc"
  cidr_block = "10.0.0.0/8"
}

resource "alicloud_vswitch" "public-a" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "10.0.1.0/24"
  zone_id      = data.alicloud_zones.default.zones.0.id
  vswitch_name = "public-a"
}
resource "alicloud_vswitch" "public-b" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "10.0.3.0/24"
  zone_id      = data.alicloud_zones.default.zones.1.id
  vswitch_name = "public-b"
}

resource "alicloud_vswitch" "private-a" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "10.0.2.0/24"
  zone_id      = data.alicloud_zones.default.zones.0.id
  vswitch_name = "private-b"
}


resource "alicloud_nat_gateway" "nat" {
  vpc_id           = alicloud_vpc.vpc.id
  nat_type         = "Enhanced"
  nat_gateway_name = "nat"
  vswitch_id       = alicloud_vswitch.public-a.id
  payment_type     = "PayAsYouGo"
}

resource "alicloud_eip_address" "eip_nat" {
  netmode              = "public"
  bandwidth            = "100"
  internet_charge_type = "PayByTraffic"
  payment_type         = "PayAsYouGo"
}

resource "alicloud_eip_association" "link_eip_nat" {
  allocation_id = alicloud_eip_address.eip_nat.id
  instance_id   = alicloud_nat_gateway.nat.id
  instance_type = "Nat"
}

resource "alicloud_snat_entry" "http_private_nat" {
  snat_table_id     = alicloud_nat_gateway.nat.snat_table_ids
  source_vswitch_id = alicloud_vswitch.private-a.id
  snat_ip           = alicloud_eip_address.eip_nat.ip_address
}

resource "alicloud_route_table" "private-a_rt" {
  description      = "private-a_rt"
  vpc_id           = alicloud_vpc.vpc.id
  route_table_name = "private-a_rt"
  associate_type   = "VSwitch"
}
resource "alicloud_route_entry" "private-a_route_entry" {
  route_table_id        = alicloud_route_table.private-a_rt.id
  destination_cidrblock = "0.0.0.0/0"
  nexthop_type          = "NatGateway"
  nexthop_id            = alicloud_nat_gateway.nat.id
}


resource "alicloud_route_table_attachment" "link_rt_private-a" {
  vswitch_id     = alicloud_vswitch.private-a.id
  route_table_id = alicloud_route_table.private-a_rt.id
}