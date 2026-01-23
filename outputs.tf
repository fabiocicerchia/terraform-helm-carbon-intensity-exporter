output "namespace" {
  description = "Kubernetes namespace where Carbon Intensity Exporter is deployed"
  value       = helm_release.carbon_intensity_exporter.namespace
}

output "release_name" {
  description = "Helm release name of Carbon Intensity Exporter"
  value       = helm_release.carbon_intensity_exporter.name
}

output "chart_version" {
  description = "Chart version of Carbon Intensity Exporter deployment"
  value       = helm_release.carbon_intensity_exporter.version
}
