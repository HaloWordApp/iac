terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }

  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "haloword"

    workspaces {
      name = "iac"
    }
  }
}

provider "digitalocean" {}

resource "digitalocean_droplet" "halo" {
  image      = "ubuntu-20-04-x64"
  name       = "haloword"
  region     = "sfo3"
  size       = "s-1vcpu-1gb-amd"
  monitoring = true
  ipv6       = true
}

resource "digitalocean_floating_ip" "halo" {
  droplet_id = digitalocean_droplet.halo.id
  region     = digitalocean_droplet.halo.region
}

data "digitalocean_project" "halo" {
}

resource "digitalocean_project_resources" "halos" {
  project = data.digitalocean_project.halo.id
  resources = [
    digitalocean_droplet.halo.urn,
    digitalocean_floating_ip.halo.urn,
  ]
}
