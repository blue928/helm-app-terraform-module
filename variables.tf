variable "auto_deploy_database" {
  description = "False to use an existing external database. True to let Helm handle it."
  type = string
  default = "false"
}

variable "externaldb_fqdn" {
    description = "FQDN of the external db server to connect to."
    type = string
}

variable "externaldbprod_user" {
    description = "Username of the user that has read write permissions to the production db"
    type = string
}

variable "externaldbprod_password" {
    description = "Passwordfor the user that has read write permissions to the production db"
    type = string
}

variable "externaldbprod_database" {
    description = "Name of the production database for this app."
    type = string
}
