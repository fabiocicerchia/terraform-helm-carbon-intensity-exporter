@domain:compatibility @area:helm-provider-requirement @from:terraform-helm-carbon-intensity-exporter/versions
Feature: Requiring a supported Helm provider
  Tells operators which Helm provider the module installs the exporter with, so init stops an incompatible provider before any release is touched.

  Background:
    Given the operator's configuration calls the carbon intensity exporter module

  @id:compatibility.helm-provider-requirement.001 @rule:compatibility.helm-provider.minimum-version @inferred @source:versions.tf#terraform
  Scenario Outline: The HashiCorp Helm provider must be version 2.0 or later
    Given the operator pins the hashicorp/helm provider to <version>
    When the operator initialises the configuration
    Then initialisation <outcome>

    Examples:
      | version | outcome                                                           |
      | 1.3.2   | is refused because no provider version satisfies both constraints |
      | 2.0.0   | goes ahead                                                        |
      | 2.17.0  | goes ahead                                                        |
      | 3.0.2   | goes ahead                                                        |
