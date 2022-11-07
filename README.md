## Purpose: 
It will use [setproduct](https://developer.hashicorp.com/terraform/language/functions/setproduct) feature of terraform to create a cartesian join from multiple topics with multiple acl.
For example this repo will create:
* 2 topics: unit-test, and unit-test2 
* 2 acl (READ and WRITE) per topics.
