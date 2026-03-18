module "small_landing_zone" {

  source              = "./modules/module-vm-vnet"
  ssh_public_key      = file("~/.ssh/id_rsa.pub")
  resource_group_name = "small-landing-zone"
  location            = "West Europe"
  vnet_address_space  = "10.0.0.0/16"

  providers = {
    azurerm = azurerm
  }


}

resource "azurerm_static_web_app" "swa-base" {

  name                = "swa-base"
  resource_group_name = module.small_landing_zone.azurerm_resource_group.name
  location            = "West Europe"

}
