using 'main.bicep'

param name = 'myAppService'
param userAlias = 'sverdugo'
param location = 'West Europe'
param containerRegistryName = 'myContainerRegistry'
param dockerRegistryServerUsername = 'myRegistryUsername'
@secure()
param dockerRegistryServerPassword = 'myRegistryPassword'
