@description('Deploys an Azure Key Vault and stores secrets.')
param name string
param location string = resourceGroup().location
@secure()
param acrUsername string
@secure()
param acrPassword string

resource keyVault 'Microsoft.KeyVault/vaults@2021-10-01' = {
  name: name
  location: location
  properties: {
    tenantId: subscription().tenantId
    sku: {
      family: 'A'
      name: 'standard'
    }
    accessPolicies: []
  }
}

resource secretUsername 'Microsoft.KeyVault/vaults/secrets@2021-10-01' = {
  name: 'acr-username'
  parent: keyVault
  properties: {
    value: acrUsername
  }
}

resource secretPassword 'Microsoft.KeyVault/vaults/secrets@2021-10-01' = {
  name: 'acr-password'
  parent: keyVault
  properties: {
    value: acrPassword
  }
}

output id string = keyVault.id
