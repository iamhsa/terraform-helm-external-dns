### Terraform, Provider, Kubernetes and Helm Versions
<!--Run `terraform -v` to show the version. If you are not running the latest version of Terraform, please upgrade because your issue may have already been fixed.
Please note that this provider only supports Helm 3.-->

```
Terraform version: 1.11.2
Provider version: v3.0.0-pre2 or 2.17.0
Kubernetes version: v1.31.6
```

### Affected Resource(s)
<!--Please list the resources as a list, for example:-->
- helm_release

<!--If this issue appears to affect multiple resources, it may be an issue with Terraform's core, so please mention this.-->

### Terraform Configuration Files
```hcl
terraform {
  required_version = "1.11.2"
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "3.0.0-pre2"
    }
  }
}

provider "helm" {
  kubernetes = {
    config_path = "~/.kube/config"
  }
}

variable "external-dns-chart-version" {
  description = "External-dns chart version"
  type        = string
}

resource "helm_release" "external-dns" {
  name       = "external-dns"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "external-dns"
  version    = var.external-dns-chart-version
}
```

### Debug Output
<!--Please provider a link to a GitHub Gist containing the complete debug output: https://www.terraform.io/docs/internals/debugging.html. Please do NOT paste the debug output in the issue; just paste a link to the Gist. -->

See : https://github.com/iamhsa/terraform-helm-external-dns/blob/main/helm-provider-3.0.0.pre2/helm-provider-3.0.0.pre2.log

### Steps to Reproduce
<!--Please list the steps required to reproduce the issue, for example:-->
1. `terraform init`
2. `terraform plan -var "external-dns-chart-version=8.7.7"`

### Expected Behavior
<!--What should have happened?-->
terraform should have display the execution plan

### Actual Behavior
<!--What actually happened?-->
```
Planning failed. Terraform encountered an error while generating this plan.


Error: Error locating chart

  with helm_release.external-dns,
  on main.tf line 22, in resource "helm_release" "external-dns":
  22: resource "helm_release" "external-dns" {

Unable to locate chart external-dns: invalid_reference: invalid tag
```
```
```

### Other informations

Terraform plan work like a charm with external-dns-chart-version <= 8.5.1 but failed with external-dns-chart-version >= 8.6.0.

I am able to install any version of this chart whith `helm install external-dns bitnami/external-dns --version x.y.z`

I note a similar behavior with provider version: v2.17.0 except that the plan works but apply failed.


### References
<!--Are there any other GitHub issues (open or closed) or Pull Requests that should be linked here? For example:-->
- Maybe related to #1596, as the error output say `invalid_reference: invalid tag`

### Community Note
<!--- Please keep this note for the community --->
* Please vote on this issue by adding a 👍 [reaction](https://blog.github.com/2016-03-10-add-reactions-to-pull-requests-issues-and-comments/) to the original issue to help the community and maintainers prioritize this request
* If you are interested in working on this issue or have submitted a pull request, please leave a comment

