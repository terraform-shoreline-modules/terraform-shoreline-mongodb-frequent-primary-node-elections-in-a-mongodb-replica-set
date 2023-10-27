resource "shoreline_notebook" "frequent_primary_node_elections_in_a_mongodb_replica_set" {
  name       = "frequent_primary_node_elections_in_a_mongodb_replica_set"
  data       = file("${path.module}/data/frequent_primary_node_elections_in_a_mongodb_replica_set.json")
  depends_on = [shoreline_action.invoke_update_mongo_election_timeout]
}

resource "shoreline_file" "update_mongo_election_timeout" {
  name             = "update_mongo_election_timeout"
  input_file       = "${path.module}/data/update_mongo_election_timeout.sh"
  md5              = filemd5("${path.module}/data/update_mongo_election_timeout.sh")
  description      = "Consider increasing the election timeout value to allow more time for a primary node to recover before triggering an election."
  destination_path = "/tmp/update_mongo_election_timeout.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_update_mongo_election_timeout" {
  name        = "invoke_update_mongo_election_timeout"
  description = "Consider increasing the election timeout value to allow more time for a primary node to recover before triggering an election."
  command     = "`chmod +x /tmp/update_mongo_election_timeout.sh && /tmp/update_mongo_election_timeout.sh`"
  params      = ["CONFIG_FILE_PATH","NEW_ELECTION_TIMEOUT"]
  file_deps   = ["update_mongo_election_timeout"]
  enabled     = true
  depends_on  = [shoreline_file.update_mongo_election_timeout]
}

