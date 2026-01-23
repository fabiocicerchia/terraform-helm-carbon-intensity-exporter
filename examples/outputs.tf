output "namespace" {
  description = "Kubernetes namespace where Carbon Intensity Exporter is deployed"
  value       = module.carbon_intensity_exporter.namespace
}

output "release_name" {
  description = "Helm release name of Carbon Intensity Exporter"
  value       = module.carbon_intensity_exporter.release_name
}

output "chart_version" {
  description = "Chart version of Carbon Intensity Exporter deployment"
  value       = module.carbon_intensity_exporter.chart_version
}
