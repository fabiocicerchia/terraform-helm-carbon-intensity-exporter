terraform {
  required_version = ">= 1.0"
}

module "carbon_intensity_exporter" {
  source = "../"

  release_name  = "carbon-intensity-exporter"
  namespace     = "kube-system"
  chart_version = ""
  
  # values = yamlencode({
  #   # Add your custom values here
  # })
}
