variable "pk_name" {
  type = string
  default = "default"  
}

variable "tags" {
  description = "Tags to set on EC2."
  type        = map(string)
  default     = {}
}