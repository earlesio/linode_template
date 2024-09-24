terraform {
  required_providers {
    linode = {
      source  = "linode/linode"
      version = "~> 2.28.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.42.0"
    }
  }
  backend "s3" {
    endpoints = {
      s3 = var.b2_s3_endpoint
    }
    access_key = var.b2_application_key_id
    secret_key = var.b2_application_key
    bucket     = var.b2_tfstate_bucket
    key        = var.b2_tfstate_key
    region     = var.b2_region

    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_s3_checksum            = true
  }
}

provider "linode" {
  token = var.linode_token
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}