using 'main.bicep'

param name = 'myAppService'
param userAlias = 'sverdugo'
param location = 'West Europe'
param containerRegistryName = 'sverdugoContainerRegistry'
param dockerRegistryServerUsername = 'sverdugo'
@secure()
param dockerRegistryServerPassword = 'sverdugoPassword'
