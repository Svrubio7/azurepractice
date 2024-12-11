param location string = resourceGroup().location
param webAppName string
param appServicePlanId string
param containerRegistryLoginServer string
param containerRegistryUsername string
@secure()
param containerRegistryPassword string

resource webApp 'Microsoft.Web/sites@2021-02-01' = {
  name: webAppName
  location: location
  properties: {
    serverFarmId: appServicePlanId
    siteConfig: {
      appSettings: [
        {
          name: 'DOCKER_REGISTRY_SERVER_URL'
          value: 'https://${containerRegistryLoginServer}'
        }
        {
          name: 'DOCKER_REGISTRY_SERVER_USERNAME'
          value: containerRegistryUsername
        }
        {
          name: 'DOCKER_REGISTRY_SERVER_PASSWORD'
          value: containerRegistryPassword
        }
      ]
      linuxFxVersion: 'DOCKER|${containerRegistryLoginServer}/${webAppName}:latest'
    }
  }
}

output webAppId string = webApp.id
output webAppDefaultHostName string = webApp.properties.defaultHostName
