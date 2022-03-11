variable "create_namespace" {
  description = "True to allow Helm to create the name space. Otherwise, it should already exist (false)."
  type = bool
  default = false
}

variable "cluster_namespace" {
  description = "The cluster namespace into which this app will be deployed."
  type = string
}
variable "mariadb_enabled" {
  description = "False to use an existing external database. True to let Helm handle it."
  type        = string
  default     = "false"
}

variable "atomic" {
  type        = bool
  description = "If set, installation process purges chart on fail. The wait flag will be set automatically if atomic is used"
  default     = true
}


variable "externalDatabase_host" {
  description = "FQDN of the external db server to connect to."
  type        = string
}

variable "externalDatabase_user" {
  description = "Username of the user that has read write permissions to the production db"
  type        = string
}

variable "externalDatabase_password" {
  description = "Password for the user that has read write permissions to the production db"
  type        = string
}

variable "externalDatabase_database" {
  description = "Name of the production database for this app."
  type        = string
}
