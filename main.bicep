@description('Location for all resources')
param location string = resourceGroup().location

@description('Name of the Azure Container Registry')
param containerRegistryName string

@description('Name of the Azure Service Plan')
param appServicePlanName string

@description('Name of the Azure Web App')
param webAppName string

@description('Name of the Azure Key Vault')
param keyVaultName string

@description('Docker image name')
param dockerImageName string

@description('Docker image version')
param dockerImageVersion string = 'latest'

// Deploy Azure Container Registry
module containerRegistry './modules/containerRegistry.bicep' = {
  name: 'deployContainerRegistry'
  params: {
    name: containerRegistryName
    location: location
  }
}

resource containerRegistryResource 'Microsoft.ContainerRegistry/registries@2023-07-01' existing = {
  name: containerRegistryName
}

// Deploy Azure Service Plan
module servicePlan './modules/servicePlan.bicep' = {
  name: 'deployServicePlan'
  params: {
    name: appServicePlanName
    location: location
  }
}

// Deploy Azure Key Vault and store ACR credentials
module keyVault './modules/keyVault.bicep' = {
  name: 'deployKeyVault'
  params: {
    name: keyVaultName
    location: location
    acrUsername: containerRegistryResource.listCredentials().username
    acrPassword: containerRegistryResource.listCredentials().passwords[0].value
  }
}

// Deploy Azure Web App for Linux containers
module webApp './modules/webApp.bicep' = {
  name: 'deployWebApp'
  params: {
    name: webAppName
    location: location
    appServicePlanId: servicePlan.outputs.id
    dockerRegistryUrl: 'https://${containerRegistryName}.azurecr.io'
    dockerRegistryUsername: containerRegistryResource.listCredentials().username
    dockerRegistryPassword: containerRegistryResource.listCredentials().passwords[0].value
    dockerImageName: dockerImageName
    dockerImageVersion: dockerImageVersion
  }
}

// Outputs for verification
output containerRegistryId string = containerRegistry.outputs.id
output servicePlanId string = servicePlan.outputs.id
output keyVaultId string = keyVault.outputs.id
output webAppName string = webAppName
