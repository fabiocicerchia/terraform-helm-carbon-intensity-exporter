@domain:exporter-deployment @area:release-installation @from:terraform-helm-carbon-intensity-exporter/variables
Feature: Choosing where and which exporter release is deployed
  Lets an operator install the carbon intensity exporter with sensible defaults, or name the release, namespace and chart version they need.

  Background:
    Given the operator uses the carbon intensity exporter module against a Kubernetes cluster

  @id:exporter-deployment.release-installation.001 @rule:exporter.deployment.default-release-name-and-namespace @inferred @source:variables.tf#namespace @questionable
  Scenario Outline: The exporter is installed under a default release name and namespace unless the operator chooses others
    Given the operator sets release name to "<release_input>" and namespace to "<namespace_input>"
    When the operator applies the module
    Then the Helm release is named "<release_name>"
    And the exporter runs in namespace "<namespace>"
    And the namespace is created if it does not exist

    Examples:
      | release_input | namespace_input | release_name              | namespace                 |
      | (not set)     | (not set)       | carbon-intensity-exporter | carbon-intensity-exporter |
      | cie-prod      | kube-system     | cie-prod                  | kube-system               |

  @id:exporter-deployment.release-installation.002 @rule:exporter.deployment.chart-version-pinned-or-latest @inferred @source:variables.tf#chart_version
  Scenario Outline: The exporter chart is requested at the given version, or at no particular version when none is given
    Given the operator sets chart version to "<chart_version_input>"
    When the operator applies the module
    Then the Helm release is installed from the bundled upstream exporter chart
    And the Helm release asks for <requested_version>

    Examples:
      | chart_version_input | requested_version           |
      | (not set)           | no particular chart version |
      |                     | no particular chart version |
      | 0.3.0               | chart version 0.3.0         |
