variable "aws_region" {
  description = "Region geográfica de AWS para el despliegue"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Nombre base para la nomenclatura de recursos"
  type        = string
  default     = "ProcesasorImagen"
}

locals {
  env = terraform.workspace
}

variable "vpc_cidr" {
  description = "IPs rango para la VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "priv_subnet_a_cidr" {
  type        = string
  default     = "10.0.11.0/24"
}

variable "priv_subnet_b_cidr" {
  type    = string
  default = "10.0.12.0/24"
}

variable "public_subnet_a_cidr" {
  type    = string
  default = "10.0.1.0/24"
}

variable "public_subnet_b_cidr" {
  type    = string
  default = "10.0.2.0/24"
}