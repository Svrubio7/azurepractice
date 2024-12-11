@description('Resource group location')
param location string = resourceGroup().location

@description('Name of the Azure Container Registry')
param containerRegistryName string

@description('Name of the App Service Plan')
param appServicePlanName string

@description('Name of the Web App')
param webAppName string

@description('The SKU for the App Service Plan')
param skuName string = 'B1'

@description('The full image name including tag (e.g., myregistry.azurecr.io/app:latest)')
param dockerImageName string

@description('The URL of the Azure Container Registry')
param dockerRegistryServerUrl string

@description('The username for the Azure Container Registry')
param dockerRegistryServerUserName string

@description('The password for the Azure Container Registry')
param dockerRegistryServerPassword string

// Deploy Azure Container Registry
module containerRegistry './modules/containerRegistry.bicep' = {
  name: 'deployContainerRegistry'
  params: {
    registryName: containerRegistryName
    location: location
  }
}

// Deploy App Service Plan
module servicePlan './modules/servicePlan.bicep' = {
  name: 'deployServicePlan'
  params: {
    appServicePlanName: appServicePlanName
    location: location
    skuName: skuName
  }
}

// Deploy Web App
module webApp './modules/webApp.bicep' = {
  name: 'deployWebApp'
  params: {
    webAppName: webAppName
    location: location
    appServicePlanId: servicePlan.outputs.id
    dockerRegistryServerUrl: dockerRegistryServerUrl
    dockerRegistryServerUserName: dockerRegistryServerUserName
    dockerRegistryServerPassword: dockerRegistryServerPassword
    dockerImageName: dockerImageName
  }
}
