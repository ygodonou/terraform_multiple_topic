terraform {
  required_providers {
    confluent = {
      source  = "confluentinc/confluent"
      version = "1.0.0"
    }
  }
}

provider "confluent" {
  cloud_api_key    = var.confluent_cloud_api_key
  cloud_api_secret = var.confluent_cloud_api_secret
}

### list the environment 

data "confluent_environment" "my_env" {
  id = var.environment.id
} 
output "my_env" {
  value = data.confluent_environment.my_env
}


# Value about the cluster


resource "confluent_kafka_topic" "topics" {
  kafka_cluster {
    id = var.kafka_cluster.id
  }
  for_each = var.kafka_topics
  topic_name    = each.value.name
  partitions_count = each.value.partitions_count
  config = {
    "cleanup.policy"    = each.value.cleanup
    "retention.ms"      = each.value.retention
  }
  rest_endpoint = var.kafka_cluster.rest_endpoint
  credentials {
    key    = var.api_key
    secret = var.api_secret
  }
}

locals {
  # setproduct works with sets and lists, but the variables are both maps
  # so convert them first.
  topics = [
    for key, topic in var.kafka_topics : {
      key        = key
      topic_name = topic.name
    }
  ]
  acl = [
    for key, acl in var.acls : {
      key    = key
      resource_type = acl.resource_type
      pattern_type = acl.pattern_type
      permission = acl.permission
      operation = acl.operation
    }
  ]
    topic_acl = [
    # in pair, element zero is a topic and element one is a acl,
    # in all unique combinations.
    for pair in setproduct(local.topics, local.acl) : {
      topic_key  = pair[0].key
      acl_key    = pair[1].key
      topic_name = pair[0].topic_name
      resource_type  = pair[1].resource_type
      pattern_type  = pair[1].pattern_type
      operation    = pair[1].operation
      permission   = pair[1].permission
    }
  ]
}

resource "confluent_kafka_acl" "acl_on_topic" {
  kafka_cluster {
    id = var.kafka_cluster.id
  }
  for_each      = {
    for acl in local.topic_acl : "${acl.topic_key}.${acl.acl_key}" => acl
  }
  resource_type = each.value.resource_type
  resource_name = each.value.topic_name
  pattern_type  = each.value.pattern_type
  principal     = var.principal
  host          = "*"
  operation     = each.value.operation
  permission    =  each.value.permission
  rest_endpoint = var.kafka_cluster.rest_endpoint
  credentials {
    key    = var.api_key
    secret = var.api_secret
  }
}
