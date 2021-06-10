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
