variable "project_name" {
  description = "Nombre del proyecto"
  type        = string
  default     = "devhub-backend"
}

variable "environment" {
  description = "Entorno de despliegue"
  type        = string
  default     = "dev"
}

variable "database_network_name" {
  description = "Nombre de la red de la base de datos"
  type        = string
  default     = null
}

variable "database_network_external" {
  description = "Indica si la red de la base de datos es externa"
  type        = bool
  default     = true
}

variable "api_network_name" {
  description = "Nombre de la red de la API"
  type        = string
  default     = null
}

variable "api_network_external" {
  description = "Indica si la red de la API es externa"
  type        = bool
  default     = false
}

variable "api_volume_name" {
  description = "Nombre del volumen de la API"
  type        = string
  default     = null
}