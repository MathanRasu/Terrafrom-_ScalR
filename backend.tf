terraform {
  backend "remote" {
    organization = "your_scalr_org"
    workspaces {
      name = "Terraform-API-Gateway"
    }
  }
}
