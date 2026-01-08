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

variable "proxy_network_name" {
  description = "Nombre de la red del proxy"
  type        = string
  default     = "reverse-proxy"
}

variable "proxy_network_external" {
  description = "Indica si la red del proxy es externa"
  type        = bool
  default     = true
}

variable "api_volume_name" {
  description = "Nombre del volumen de la API"
  type        = string
  default     = null
}

variable "api_runtime_name" {
  description = "Nombre del contenedor de la API"
  type        = string
  default     = null
}

variable "api_runtime_image_name" {
  description = "Nombre de la imagen del contenedor del runtime de la API"
  type        = string
  default     = null
}

variable "api_runtime_build_context" {
  description = "Contexto de construcción de la imagen del runtime de la API"
  type        = string
  default     = ".."
}

variable "api_external_port" {
  description = "Puerto externo de la API"
  type        = number
  default     = 3000
}

variable "api_metrics_port" {
  description = "Puerto de métricas de la API"
  type        = number
  default     = 3001
}