param name string
param userAlias string = 'sverdugo'
param location string
param containerRegistryName string
param dockerRegistryServerUsername string
@secure()
param dockerRegistryServerPassword string

module containerRegistry 'modules/container-registry.bicep' = {
  name: 'containerRegistry-${userAlias}'
  params: {
    location: location
    name: containerRegistryName
  }
}

module appServicePlan 'modules/app-service-plan.bicep' = {
  name: 'appServicePlan-${userAlias}'
  params: {
    location: location
    appServicePlanName: name
  }
}

module webApp 'modules/web-app.bicep' = {
  name: 'webApp-${userAlias}'
  params: {
    location: location
    webAppName: name
    appServicePlanId: appServicePlan.outputs.appServicePlanId
    containerRegistryLoginServer: containerRegistry.outputs.containerRegistryLoginServer
    containerRegistryUsername: dockerRegistryServerUsername
    containerRegistryPassword: dockerRegistryServerPassword
  }
}
