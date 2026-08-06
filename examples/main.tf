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
      apiToken = "token" # Replace with your actual API token
    }
    wattTime = {
      username = "username" # Replace with your actual username
      password = "password" # Replace with your actual password
    }
  })
}
