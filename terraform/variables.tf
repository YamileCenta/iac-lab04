variable "region_aws" {
    description = "Region geográfica de AWS para el despliegue"
    type        = string
    default     = "us-east-1"
}
variable "environment" {
    description = "Entorno (dev, qa, prod)"
    type        = string
}

variable "project_name" {
    description = "Nombre base para la nomenclatura de recursos"
    type        = string
    default     = "image-processor"
}

variable "vpc_cidr" {
    description = "CIDR asignado a la red virtual (VPC)"
    type        = string
    default     = "10.0.0.0/16"
}