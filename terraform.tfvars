kafka_topics =  {
    "one" = {
			name = "unt-test"
			partitions_count = 1
			cleanup = "compact"
			retention  = 259200000
		}
    "two" ={
 			name = "unt-test2"
			partitions_count = 1
			cleanup = "compact"
			retention  = 259200000       
    }
}
principal =  "User:sa-?????"

acls ={
    "write" ={
        resource_type = "TOPIC"
        pattern_type  = "LITERAL"
        permission    = "ALLOW"
        operation    = "WRITE"
    }
    "read" ={
        resource_type = "TOPIC"
        pattern_type  = "LITERAL"
        permission    = "ALLOW"
        operation    = "WRITE"
    }
    
}
operations =  [
        "WRITE","READ"
    ]

environment = {
    id = "env-????/"
    display_name = "???????" 
}
kafka_cluster= {
    id = "lkc-??????"
    display_name = "GooglePub"
    bootstrap_endpoint = "**BOOTSTRAP_ENDPOINT***"
    rest_endpoint = "***RESTENDPOINT****"
}

api_key = "**REDACTED****"
api_secret ="**REDACTED****"