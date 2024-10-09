#bash       terraform apply -var-file="variables.tfvars.json"
#PowerShell terraform apply -var-file='variables.tfvars.json'
#bash       terraform apply -var="IAM_TOKEN=$()"
#PowerShell terraform plan -var "name=value"


variable "IAM_TOKEN" {
  description = "IAM Token for Yandex Cloud: $(export YC_TOKEN)"
  type        = string
  default     = ""
  sensitive   = true
  nullable    = false
}

variable "folder_id" {
  type    = string
  default = ""
}

variable "cloud_id" {
  type    = string
  default = ""
}

variable "zone" {
  type    = string
  default = ""
}

variable "network_id" {
  type    = string
  default = ""
}

variable "subnet_id" {
  type = string
  default = ""
}

variable "bucket" {
  type    = string
  default = ""
}