variable "release_name" {
  description = "Helm release name for Carbon Intensity Exporter"
  type        = string
  default     = "carbon-intensity-exporter"
}

variable "namespace" {
  description = "Kubernetes namespace for Carbon Intensity Exporter"
  type        = string
  default     = "kube-system"
}

variable "chart_version" {
  description = "Carbon Intensity Exporter Helm chart version"
  type        = string
  default     = ""
}

variable "values" {
  description = "Helm values for Carbon Intensity Exporter deployment"
  type        = any
  default     = {}
}
