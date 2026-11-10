@domain:exporter-configuration @area:custom-values @from:terraform-helm-carbon-intensity-exporter/variables
Feature: Customising the exporter's chart values
  Lets an operator adjust the exporter's Helm settings while the module keeps the chart aware of its namespace.

  Background:
    Given the operator uses the carbon intensity exporter module against a Kubernetes cluster

  @id:exporter-configuration.custom-values.001 @rule:exporter.values.caller-values-merged-with-namespace @inferred @source:variables.tf#values
  Scenario: The operator's chart values are applied alongside the chosen namespace
    Given the operator sets namespace to "kube-system"
    And the operator supplies chart values setting carbonDataExporter region to "westus"
    When the operator applies the module
    Then the chart receives namespace "kube-system"
    And the chart receives carbonDataExporter region "westus"

  @id:exporter-configuration.custom-values.002 @rule:exporter.values.caller-namespace-value-overrides-module @inferred @source:variables.tf#values @questionable
  Scenario: A namespace given in the chart values overrides the one the module passes to the chart
    Given the operator sets namespace to "kube-system"
    And the operator supplies chart values with namespace "monitoring"
    When the operator applies the module
    Then the chart receives namespace "monitoring"
    And the Helm release is still installed in namespace "kube-system"
