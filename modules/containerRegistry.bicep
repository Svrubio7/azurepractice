@description('Deploys an Azure Container Registry.')
param name string
param location string = resourceGroup().location

resource containerRegistry 'Microsoft.ContainerRegistry/registries@2023-07-01' = {
  name: name
  location: location
  sku: {
    name: 'Basic'
  }
  properties: {
    adminUserEnabled: true
  }
}

// Outputs (avoid directly outputting sensitive information)
output id string = containerRegistry.id
