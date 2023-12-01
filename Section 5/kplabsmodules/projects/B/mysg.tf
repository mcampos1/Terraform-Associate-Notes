module "sgmodule" {
    source = "../../modules/sg"
    app_port = "22" #overrides port 8443 in the variables file
}