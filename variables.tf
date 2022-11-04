variable "principal" {
    description = "principal"
    type        = string
}
variable "acls" {
    description = "resource acl"
    type        = map(object({
        resource_type = string
        pattern_type  = string
        permission    = string
        operation    = string
    }))
}

variable "operations" {
    description = "operations data"
    type        = set(string)
}
##
##variable "kafka_topics" {
####    description = "topics creation"
##    type        = 
##}

variable "kafka_topics" {
    description = "operations data"
    type        = map(object({
        	name = string
			partitions_count = number
			cleanup = string
			retention  = number
    }))
}


variable "environment" {
    description = "environment ID"
    type        =map
}

variable "kafka_cluster" {
    type = object({ 
        id = string
    display_name =  string
    bootstrap_endpoint = string
    rest_endpoint = string
})
}

variable "account_key" {
    description = "account_key"
    type        = string
}
variable "account_secret" {
    description = "account_secret"
    type        = string
}

variable "api_key" {
    description = "api_key"
    type        = string
}
variable "api_secret" {
    description = "api_secret"
    type        = string
}