@description('Deployment location for the resource group')
param location string = resourceGroup().location

@description('The name of the App Service Plan for hosting the application')
param appServicePlanName string

@description('The SKU for the App Service Plan (Basic Linux SKU)')
param skuName string = 'B1'

resource appServicePlan 'Microsoft.Web/serverFarms@2022-03-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: skuName
    tier: 'Basic'
    capacity: 1
  }
  kind: 'linux'
  properties: {
    reserved: true
  }
}

output id string = appServicePlan.id
