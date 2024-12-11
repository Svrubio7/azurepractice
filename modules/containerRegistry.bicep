@description('Name of the Azure Container Registry')
param registryName string

@description('Resource group location')
param location string = resourceGroup().location

@description('Enable admin user for the registry')
param acrAdminUserEnabled bool = true

resource containerRegistry 'Microsoft.ContainerRegistry/registries@2023-07-01' = {
  name: registryName
  location: location
  sku: {
    name: 'Basic'
  }
  properties: {
    adminUserEnabled: acrAdminUserEnabled
  }
}

output id string = containerRegistry.id
output adminUsername string = containerRegistry.listCredentials().username
output adminPassword string = containerRegistry.listCredentials().passwords[0].value
