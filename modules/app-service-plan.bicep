param location string = resourceGroup().location
param appServicePlanName string
param skuName string = 'B1'

resource appServicePlan 'Microsoft.Web/serverfarms@2021-02-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: skuName
    capacity: 1
    family: 'B'
    size: 'B1'
    tier: 'Basic'
  }
  properties: {
    reserved: true
  }
}

output appServicePlanId string = appServicePlan.id
