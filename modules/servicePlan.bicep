@description('Deploys an Azure Service Plan for Linux.')
param name string
param location string = resourceGroup().location

resource servicePlan 'Microsoft.Web/serverfarms@2022-09-01' = {
  name: name
  location: location
  sku: {
    name: 'B1'
    tier: 'Basic'
    size: 'B1'
    family: 'B'
    capacity: 1
  }
  properties: {
    reserved: true // Indicates Linux hosting
  }
}

output id string = servicePlan.id
