@description('Deployment location for the resource group')
param location string = resourceGroup().location

@description('The name of the Web App')
param webAppName string

@description('The name of the App Service Plan')
param appServicePlanId string

@description('The URL of the Azure Container Registry')
param dockerRegistryServerUrl string

@description('The username for the Azure Container Registry')
param dockerRegistryServerUserName string

@description('The password for the Azure Container Registry')
param dockerRegistryServerPassword string

@description('The full image name including tag (e.g., myregistry.azurecr.io/app:latest)')
param dockerImageName string

resource webApp 'Microsoft.Web/sites@2022-03-01' = {
  name: webAppName
  location: location
  kind: 'app'
  properties: {
    serverFarmId: appServicePlanId
    siteConfig: {
      linuxFxVersion: 'DOCKER|${dockerImageName}'
      appCommandLine: ''
      appSettings: [
        {
          name: 'WEBSITES_ENABLE_APP_SERVICE_STORAGE'
          value: 'false'
        }
        {
          name: 'DOCKER_REGISTRY_SERVER_URL'
          value: dockerRegistryServerUrl
        }
        {
          name: 'DOCKER_REGISTRY_SERVER_USERNAME'
          value: dockerRegistryServerUserName
        }
        {
          name: 'DOCKER_REGISTRY_SERVER_PASSWORD'
          value: dockerRegistryServerPassword
        }
      ]
    }
  }
}

output id string = webApp.id
