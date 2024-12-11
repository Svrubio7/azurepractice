param sku string = 'Basic'
param adminUserEnabled bool = true
param location string = resourceGroup().location
param name string

resource containerRegistry 'Microsoft.ContainerRegistry/registries@2023-07-01' = {
  name: name
  location: location
  sku: {
    name: sku
  }
  properties: {
    adminUserEnabled: adminUserEnabled
  }
}

// Output values for verification (optional, avoid exposing sensitive data)
output containerRegistryName string = containerRegistry.name
output containerRegistryLoginServer string = containerRegistry.properties.loginServer
