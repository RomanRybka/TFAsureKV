# Create keyvault

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "KV" {
  name                        = "${var.prefix}TFKV"
  location                   = var.location
  resource_group_name         = var.rgname
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "backup", "create", "decrypt", "delete", "encrypt", "get", "import", "list", "purge",
      "recover", "restore", "sign", "unwrapKey","update", "verify", "wrapKey"
    ]

    secret_permissions = [
      "backup", "delete", "get", "list", "purge", "recover", "restore", "set"
    ]

    certificate_permissions = [
     "create", "delete", "deleteissuers", "get", "getissuers", "import", "list", "listissuers",
     "managecontacts", "manageissuers", "purge", "recover", "setissuers", "update", "backup", "restore"
    ]

    storage_permissions = [
     "backup", "delete", "deletesas", "get", "getsas", "list", "listsas",
     "purge", "recover", "regeneratekey", "restore", "set", "setsas", "update"
    ]
  }
}