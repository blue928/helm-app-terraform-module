variable "helm_app_name" {
  description = "The name of this application"
  type        = string
}

variable "cluster_namespace" {
  description = "The cluster namespace into which this app will be deployed."
  type        = string
}
variable "mariadb_enabled" {
  description = "False to use an existing external database. True to let Helm handle it."
  type        = string
  default     = "false"
}

variable "atomic" {
  type        = bool
  description = "If set, installation process purges chart on fail. The wait flag will be set automatically if atomic is used"
  default     = false
}

variable "timeout" {
  description = "The timeout in seconds for the helm install process to complete successfully."
  default     = 1400
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

variable "ingress_hostname" {
  description = "The hostname to use for the ingress"
  type        = string
}

# Custom image registry config
variable "image_registry" {
  description = "The url of the image registry to use for the helm chart"
  type        = string
  #default     = "testwithexternaldnsacr.azurecr.io/bluekeyvatechterraform:233"
  default = null
}

variable "image_repository" {
  description = "The repository to use for the helm chart"
  type        = string
  #default     = "bluekeyvatechterraform"
  default = null
}

variable "image_tag" {
  description = "The tag to use for the helm chart"
  type        = string
  #default     = "233"
  value = null
}
