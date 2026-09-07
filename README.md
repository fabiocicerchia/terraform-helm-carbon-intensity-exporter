# Terraform Module for Carbon Intensity Exporter

Terraform module to deploy Kubernetes Carbon Intensity Exporter on Kubernetes using Helm.

## Why This Matters

Electricity grids vary dramatically in carbon intensity depending on time and location. The same workload can have radically different environmental impacts depending on when and where it runs—solar-powered compute at noon versus coal-fired electricity at night.

Carbon Intensity Exporter enables:

- ⏰ **Time-aware scheduling** based on grid cleanliness forecasts
- 🌍 **Location-aware placement** to prefer lower-carbon regions
- 🔌 **Grid-responsive workloads** that shift to cleaner electricity windows
- 📉 **Carbon-aware autoscaling** decisions
- 🐚 **Integration with Kubernetes** scheduling and placement logic

By making real-time grid carbon intensity data available to Kubernetes, workloads can automatically optimise for environmental impact—reducing emissions without sacrificing functionality.

## Overview

The Kubernetes Carbon Intensity Exporter retrieves carbon intensity data from third-party providers (WattTime or Electricity Maps) and makes it available to Kubernetes operators for carbon-aware workload scheduling. Key features include:

- **Carbon Intensity Data**: Retrieves 24-hour carbon intensity forecast data
- **ConfigMap Integration**: Stores data in a configmap for easy consumption
- **Multiple Providers**: Supports WattTime and Electricity Maps
- **Automated Updates**: Refreshes data every 12 hours

## Quick Start

```hcl
module "carbon_intensity_exporter" {
  source = "fabiocicerchia/carbon-intensity-exporter/helm"

  release_name    = "carbon-intensity-exporter"
  namespace       = "kube-system"
}
```

## Inputs

| Name            | Description                                          | Type     | Default                       | Required |
| --------------- | ---------------------------------------------------- | -------- | ----------------------------- | :------: |
| `release_name`  | Helm release name for Carbon Intensity Exporter      | `string` | `"carbon-intensity-exporter"` | no       |
| `namespace`     | Kubernetes namespace for Carbon Intensity Exporter   | `string` | `"kube-system"`               | no       |
| `chart_version` | Helm chart version (empty string for latest)         | `string` | `""`                          | no       |
| `values`        | Helm values for Carbon Intensity Exporter deployment | `any`    | See default values            | no       |

## Outputs

| Name            | Description                                                      |
| --------------- | ---------------------------------------------------------------- |
| `namespace`     | Kubernetes namespace where Carbon Intensity Exporter is deployed |
| `release_name`  | Helm release name of Carbon Intensity Exporter                   |
| `chart_version` | Chart version of Carbon Intensity Exporter deployment            |

## Requirements

- Terraform >= 1.0 or OpenTofu >= 1.6
- Helm >= 2.0
- Kubernetes v1.24+
- kubectl configured to access your cluster
- API credentials from WattTime or Electricity Maps

## Usage

### Basic Deployment with WattTime

```hcl
module "carbon_intensity_exporter" {
  source = "fabiocicerchia/carbon-intensity-exporter/helm"

  namespace = "kube-system"
  values = {
    carbonDataExporter = {
      region = "westus"
    }
    wattTime = {
      username = "your-watttime-username"
      password = "your-watttime-password"
    }
  }
}
```

### Deployment with Electricity Maps

```hcl
module "carbon_intensity_exporter" {
  source = "fabiocicerchia/carbon-intensity-exporter/helm"

  namespace = "kube-system"
  values = {
    carbonDataExporter = {
      region = "westus"
    }
    providerName = "ElectricityMaps"
    electricityMaps = {
      apiToken       = "your-api-token"
      apiTokenHeader = "auth-token"
      baseURL        = "https://api.electricitymap.org/v3/"
    }
  }
}
```

### Pin Chart Version

```hcl
module "carbon_intensity_exporter" {
  source = "fabiocicerchia/carbon-intensity-exporter/helm"

  chart_version = "0.4.0"
}
```

## Verify Deployment

```bash
# Check Carbon Intensity Exporter deployment
kubectl get pods -n kube-system | grep carbon-intensity-exporter

# View carbon intensity configmap
kubectl get configmap carbon-intensity -n kube-system

# View configmap details
kubectl describe configmap carbon-intensity -n kube-system
```

## ConfigMap Integration

The exporter creates a configmap named `carbon-intensity` in the specified namespace with the following structure:

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: carbon-intensity
  namespace: kube-system
immutable: true
data:
  lastHeartbeatTime: # Latest data update time
  message: # Additional information or error messages
  numOfRecords: # Number of forecast records (0-288)
  forecastDateTime: # Time when raw data was generated
  minForecast: # Minimum forecast value
  maxForecast: # Maximum forecast value
binarydata:
  data: # JSON marshaled EmissionsData array
```

## Resources

- [Kubernetes Carbon Intensity Exporter](https://github.com/Azure/kubernetes-carbon-intensity-exporter)
- [WattTime](https://www.watttime.org/)
- [Electricity Maps](https://www.electricitymaps.com/)

## Make targets

`make help` lists them. Every repository in this estate exposes the same eight
verbs, so you do not have to read a Makefile to find out how to build or test it
(FC-GEN-057).

| Verb      | What it does here                                    |
| --------- | ---------------------------------------------------- |
| `setup`   | Install the pre-commit hook                          |
| `install` | Download the providers this module pins              |
| `lint`    | `pre-commit run --all-files` — the whole gate        |
| `format`  | `terraform fmt -recursive`                           |
| `test`    | `terraform validate` on the module and every example |
| `analyze` | `tflint --recursive`                                 |

### Not applicable

Two verbs have no meaning for a Terraform module. They exit 0 and say so rather
than pretending to work (FC-GEN-058):

- `build` — nothing is compiled; the module is consumed from source.
- `run` — a module is instantiated by a root module, never executed directly.

## License

MIT
