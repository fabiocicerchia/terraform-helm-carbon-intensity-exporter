terraform {
  required_version = ">= 1.0"
}

module "carbon_intensity_exporter" {
  source = "../"

  release_name  = "carbon-intensity-exporter"
  namespace     = "kube-system"
  chart_version = ""

  values = yamlencode({
    providerName = "WattTime"
    electricityMaps = {
      apiToken = var.electricity_maps_api_token
    }
    wattTime = {
      username = var.watt_time_username
      password = var.watt_time_password
    }
  })
}

variable "electricity_maps_api_token" {
  type        = string
  description = "Electricity Maps API token."
  sensitive   = true
}

variable "watt_time_username" {
  type        = string
  description = "WattTime API username."
}

variable "watt_time_password" {
  type        = string
  description = "WattTime API password."
  sensitive   = true
}
