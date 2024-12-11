@description('Deploys an Azure Web App for Linux Containers.')
param name string
param location string = resourceGroup().location
param appServicePlanId string
param dockerRegistryUrl string
@secure()
param dockerRegistryUsername string
@secure()
param dockerRegistryPassword string
param dockerImageName string
param dockerImageVersion string = 'latest'

resource webApp 'Microsoft.Web/sites@2022-03-01' = {
  name: name
  location: location
  properties: {
    serverFarmId: appServicePlanId
    siteConfig: {
      linuxFxVersion: 'DOCKER|${dockerRegistryUrl}/${dockerImageName}:${dockerImageVersion}'
      appCommandLine: ''
      appSettings: [
        {
          name: 'WEBSITES_ENABLE_APP_SERVICE_STORAGE'
          value: 'false'
        }
        {
          name: 'DOCKER_REGISTRY_SERVER_URL'
          value: dockerRegistryUrl
        }
        {
          name: 'DOCKER_REGISTRY_SERVER_USERNAME'
          value: dockerRegistryUsername
        }
        {
          name: 'DOCKER_REGISTRY_SERVER_PASSWORD'
          value: dockerRegistryPassword
        }
      ]
    }
  }
}
