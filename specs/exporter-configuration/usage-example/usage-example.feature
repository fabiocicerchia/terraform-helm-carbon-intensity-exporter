@domain:exporter-configuration @area:usage-example @from:examples/examples
Feature: Trying the module with the bundled usage example
  Gives operators a ready-to-copy example of calling the exporter module with carbon-data provider credentials and reading back what was deployed.

  Background:
    Given the operator is working from the bundled usage example

  @id:exporter-configuration.usage-example.001 @rule:exporter.usage-example.chart-values-rejected-as-yaml-text @inferred @source:examples/main.tf#carbon_intensity_exporter @questionable
  Scenario: The usage example is refused because it passes chart values as YAML text instead of a map
    Given the example selects WattTime as the carbon data provider
    And the example asks for release "carbon-intensity-exporter" in namespace "kube-system" with no chart version pinned
    When the operator plans the example with credentials supplied
    Then planning stops with an error that the chart values must be a map or object
    And no exporter release is installed

  @id:exporter-configuration.usage-example.002 @rule:exporter.usage-example.requires-both-providers-credentials @inferred @source:examples/main.tf#electricity_maps_api_token @questionable
  Scenario: The usage example demands credentials for both providers even though only WattTime is selected
    Given the example selects WattTime as the carbon data provider
    When the operator runs the example without an Electricity Maps API token
    Then Terraform asks for or refuses to continue without "electricity_maps_api_token"
    And WattTime username and password are also required

  @id:exporter-configuration.usage-example.003 @rule:exporter.usage-example.secret-credentials-hidden @inferred @source:examples/main.tf#watt_time_password
  Scenario: Provider secrets in the usage example are marked sensitive, while the WattTime username is not
    Given the operator supplies an Electricity Maps token, a WattTime username and a WattTime password
    When Terraform reads the example's input variables
    Then the Electricity Maps API token is treated as sensitive
    And the WattTime password is treated as sensitive
    And the WattTime username is not marked sensitive
