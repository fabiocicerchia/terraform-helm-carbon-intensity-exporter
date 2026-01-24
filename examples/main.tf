terraform {
  required_version = ">= 1.0"
}

module "carbon_intensity_exporter" {
  source = "../"

  release_name  = var.release_name
  namespace     = var.namespace
  chart_version = var.chart_version
  values        = var.values
}
