application     = "westendfinancial"
environment     = "prod"
container_image = "docker.io/armck/west-end-financial:app-latest"
dns_zone = {
  name        = "armckinney.dev"
  application = "armckinney"
  environment = "prod"
}
