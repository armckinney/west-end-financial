locals {
  application                  = "westendfinancial"
  workspace_root               = "/workspaces/west-end-financial"
  app_dockerfile_relative_path = "./app/Dockerfile"
  app_checksum                 = sha1(join("", [for f in fileset(path.module, "../../app/*") : filesha1(f)]))
  tags = {
    application = local.application
    environment = var.environment
  }
}
