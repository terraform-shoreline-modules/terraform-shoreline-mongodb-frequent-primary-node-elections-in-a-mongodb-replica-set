terraform {
  required_version = ">= 0.13.1"

  required_providers {
    shoreline = {
      source  = "shorelinesoftware/shoreline"
      version = ">= 1.11.0"
    }
  }
}

provider "shoreline" {
  retries = 2
  debug = true
}

module "frequent_primary_node_elections_in_a_mongodb_replica_set" {
  source    = "./modules/frequent_primary_node_elections_in_a_mongodb_replica_set"

  providers = {
    shoreline = shoreline
  }
}