variable "username" {
  type        = string
  description = "DB username"
}

variable "password" {
  type        = string
  description = "DB password"
}

variable "image_tag" {
  type        = string
  description = "Docker image"
  default     = "latest"
}

variable "env" {
  type        = string
  description = "Environment value"
}
