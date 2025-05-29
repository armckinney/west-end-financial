variable "application" {
  description = "Name of the application to deploy"
  type        = string
}

variable "environment" {
  description = "Deployment Environment Name"
  type        = string
}

variable "container_registry" {
  description = "Optional: Container registry to push the application image to; default creates a new ACR"
  type        = string
  default     = "docker.io"
}

variable "container_name" {
  description = "Name of the container to deploy"
  type        = string
  default     = "armck/hello-world"
}

variable "image_tag" {
  description = "Tag of the container image to deploy"
  type        = string
  default     = "latest"
}
