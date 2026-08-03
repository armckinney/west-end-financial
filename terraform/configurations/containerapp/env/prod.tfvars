application     = "westendfinancial"
environment     = "prod"
container_image = "ghcr.io/armckinney/west-end-financial:app-latest"
dns_zone = {
  name        = "armckinney.dev"
  application = "armckinney"
  environment = "prod"
}
