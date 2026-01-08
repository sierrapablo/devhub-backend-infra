variable "name" {
  description = "Nombre del volumen Docker"
  type        = string
}

variable "labels" {
  description = "Labels aplicadas al volumen"
  type        = map(string)
  default     = {}
}
