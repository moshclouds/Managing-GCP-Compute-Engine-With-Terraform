variable "project_id" {
  description = "The GCP Project ID"
  type        = string
}

variable "region" {
  description = "The region for the GCP resources"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "The zone for the VM instance"
  type        = string
  default     = "us-central1-a"
}

variable "credentials_file" {
  description = "Path to the service account key file"
  type        = string
}

variable "machine_type" {
  description = "Machine type for the VM instance"
  type        = string
  default     = "e2-micro"
}
