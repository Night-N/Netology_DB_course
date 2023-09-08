terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  token = "${var.yc_token}"
  cloud_id  = "b1ggel59310trksk1fu4"
  folder_id = "b1g9oing6niujio3j61t"
  zone      = "ru-central1-a"
}

resource "yandex_mdb_postgresql_cluster" "pg" {
  name                = "pg"
  environment         = "PRODUCTION"
  network_id          = yandex_vpc_network.network.id
  deletion_protection = false

  config {
    version = "15"
    resources {
      resource_preset_id = "s2.micro"
      disk_type_id       = "network-ssd"
      disk_size          = 10
    }
  }

  host {
    zone      = "ru-central1-a"
    name      = "pg-host-a"
    subnet_id = yandex_vpc_subnet.subnet-a.id
    assign_public_ip = true
  }
  host {
    zone      = "ru-central1-b"
    name      = "pg-host-b"
    subnet_id = yandex_vpc_subnet.subnet-b.id
    assign_public_ip = true
  }
}

resource "yandex_mdb_postgresql_database" "db1" {
  cluster_id = yandex_mdb_postgresql_cluster.pg.id
  name       = "db1"
  owner      = "night"
  depends_on = [
    yandex_mdb_postgresql_user.night
  ]
}

resource "yandex_mdb_postgresql_user" "night" {
  cluster_id = yandex_mdb_postgresql_cluster.pg.id
  name       = "night"
  password   = "${var.db_pass}"
}


resource "yandex_vpc_network" "network" {
  name = "default"
}

resource "yandex_vpc_subnet" "subnet-a" {
  name           = "pb-a"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = ["10.128.0.0/24"]
}
resource "yandex_vpc_subnet" "subnet-b" {
  name           = "pg-b"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = ["10.128.2.0/24"]
}

output "external_address_pg-a" {
  value = yandex_mdb_postgresql_cluster.pg.host[0].fqdn
}

output "external_address_pg-b" {
  value = yandex_mdb_postgresql_cluster.pg.host[1].fqdn
}