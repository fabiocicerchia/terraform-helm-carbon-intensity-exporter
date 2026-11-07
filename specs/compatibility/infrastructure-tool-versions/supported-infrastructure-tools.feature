@domain:compatibility @area:infrastructure-tool-versions @from:terraform-helm-carbon-intensity-exporter/versions
Feature: Running the module on supported Terraform and OpenTofu versions
  Tells operators which Terraform and OpenTofu releases can run the exporter module, so an unsupported tool is stopped before anything is deployed.

  Background:
    Given the operator's configuration calls the carbon intensity exporter module

  @id:compatibility.infrastructure-tool-versions.001 @rule:compatibility.tooling.minimum-terraform-version @inferred @source:versions.tf#terraform
  Scenario Outline: Only Terraform 1.0 or later, or OpenTofu 1.6 or later, can run the module
    Given the operator uses <tool> version <version>
    When the operator initialises the configuration
    Then initialisation <outcome>

    Examples:
      | tool      | version | outcome                                                     |
      | Terraform | 0.15.5  | is refused with an unsupported Terraform Core version error |
      | Terraform | 1.0.0   | goes ahead                                                  |
      | Terraform | 1.9.8   | goes ahead                                                  |
      | OpenTofu  | 1.6.0   | goes ahead                                                  |
