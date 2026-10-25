resource "azurerm_resource_group" "finops" {
  name     = "rg-${var.app_name}-${var.environment}"
  location = var.location
  tags     = var.tags
}

resource "azurerm_storage_account" "finops_st" {
  name                     = "stfinops${var.environment}001"
  resource_group_name      = azurerm_resource_group.finops.name
  location                 = azurerm_resource_group.finops.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_2"
  tags                     = var.tags
}

resource "azurerm_service_plan" "asp" {
  name                = "asp-${var.app_name}-${var.environment}"
  resource_group_name = azurerm_resource_group.finops.name
  location            = azurerm_resource_group.finops.location
  os_type             = "Linux"
  sku_name            = "Y1"
  tags                = var.tags
}

resource "azurerm_linux_function_app" "function" {
  name                = "func-${var.app_name}-${var.environment}"
  resource_group_name = azurerm_resource_group.finops.name
  location            = azurerm_resource_group.finops.location

  storage_account_name       = azurerm_storage_account.finops_st.name
  storage_account_access_key = azurerm_storage_account.finops_st.primary_access_key
  service_plan_id            = azurerm_service_plan.asp.id

  site_config {
    application_stack {
      python_version = "3.11"
    }
  }

  app_settings = merge(
    var.custom_app_settings,
    {
      "FUNCTIONS_WORKER_RUNTIME" = "python"
      "ENABLE_INFRACOST_GATE"    = tostring(var.enable_budget_alert_gate)
    }
  )

  tags = var.tags
}
