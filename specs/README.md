# Specifications of terraform-helm-carbon-intensity-exporter

What this code does, one atomic Gherkin scenario per behaviour, read from the code by code-atlas.
Tags: `@verified` a test asserts it · `@inferred` read from the code only · `@gap` an entry point no test covers · `@human` written or amended by a person, never rewritten.

## Compatibility

The tool and provider versions the module works with.

- **Helm provider requirement**: [Requiring a supported Helm provider](compatibility/helm-provider-requirement/helm-provider-requirement.feature) (1)
- **Infrastructure tool versions**: [Running the module on supported Terraform and OpenTofu versions](compatibility/infrastructure-tool-versions/supported-infrastructure-tools.feature) (1)

## Exporter Configuration

Tailoring how the deployed exporter behaves and where it gets carbon-intensity data.

- **Custom chart values**: [Customising the exporter's chart values](exporter-configuration/custom-values/exporter-custom-values.feature) (2)
- **Usage example**: [Trying the module with the bundled usage example](exporter-configuration/usage-example/usage-example.feature) (3)

## Exporter Deployment

Installing the Carbon Intensity Exporter into a Kubernetes cluster as a Helm release.

- **Release installation**: [Choosing where and which exporter release is deployed](exporter-deployment/release-installation/exporter-deployment-settings.feature) (2)
