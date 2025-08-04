resource "null_resource" "azure_csi_provider" {
  provisioner "local-exec" {
    command = <<EOT
      powershell -Command "
        Write-Output 'Sleeping for 5 minutes to ensure AKS + CSI driver is fully ready...';
        Start-Sleep -Seconds 3;

        Write-Output 'Fetching AKS credentials using az cli...';
        az aks get-credentials --name customeronboarding-aks" --resource-group customer-onboarding-rg --overwrite-existing;

        Write-Output 'Installing Azure CSI Provider...';
        kubectl apply -f https://raw.githubusercontent.com/Azure/secrets-store-csi-driver-provider-azure/master/deployment/provider-azure-installer.yaml;
      "
    EOT
  }

}
