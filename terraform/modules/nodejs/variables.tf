variable "name" {
  description = "Nombre del contenedor Node.js"
  type        = string
}

variable "image_name" {
  description = "Nombre de la imagen Docker"
  type        = string
}

variable "build_context" {
  description = "Contexto de build de la imagen"
  type        = string
}

variable "dockerfile" {
  description = "Nombre del Dockerfile"
  type        = string
  default     = "Dockerfile"
}

variable "network_names" {
  description = "Nombres de las redes Docker"
  type        = list(string)
}

variable "volume_name" {
  description = "Nombre del volumen montado"
  type        = string
}

variable "restart_policy" {
  description = "Política de restart del contenedor"
  type        = string
  default     = "unless-stopped"
}
