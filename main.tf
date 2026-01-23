resource "helm_release" "carbon_intensity_exporter" {
  name       = var.release_name
  repository = "${path.module}/.upstream/charts"
  chart      = "carbon-intensity-exporter"
  version    = var.chart_version != "" ? var.chart_version : null

  dependency_update = true
  create_namespace  = true
  namespace         = var.namespace
  replace           = true

  values = [yamlencode(var.values)]
}
