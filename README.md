# terraform-k8s-hetzner

**Launch a single-master kubernetes cluster with any number of workers in the [Hetzner Cloud](https://www.hetzner.de/cloud). 🚀**

The setup is particularly suitable for test scenarios that require a simple Kubernetes cluster without further add-ons. **Attention**: The setup is not recommended for productive use.

## Requirements

-   [Terraform](https://www.terraform.io/downloads.html) v0.11.8+
-   [Hetzner Cloud API Token](https://console.hetzner.cloud/projects)

## Usage

```
git clone https://github.com/cbrgm/terraform-k8s-hetzner.git
terraform init
terraform apply
```


Variable  |  Default | Description |  Required
--|---|---|--
`hcloud_token` | None | To create a new API token for your project, switch into the Hetzner Cloud Console choose a project, go to `Access` → `Tokens`, and create a new token.  |  True
`ẁorkers`  | 2| The number of worker nodes to join your cluster  | False

For more configuration changes please check the `variables.tf` file.

After Terraform has done the work, `kubeconfig` is located in the `creds/` folder of this project and ready for use!

## Contributing

-   **Fork** the project
-   **Patch** some code
-   **Push** your changes
-   Create a **Pull Request**
