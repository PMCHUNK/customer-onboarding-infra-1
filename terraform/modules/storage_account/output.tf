output "upload_url" {
  value="https://${azurerm_storage_account.my-sg.name}.blob.core.windows.ner${azurerm_storage_container.my-container.name}/cutomer-ui.zip"
}