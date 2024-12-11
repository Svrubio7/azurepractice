using 'main.bicep'

param name = 'sverdugo'
param userAlias = 'sverdugo'
param location = 'West Europe'
param containerRegistryName = 'sverdugoContainerRegistry'
param dockerRegistryServerUsername = 'sverdugo'
@secure()
param dockerRegistryServerPassword = 'sverdugoPassword'
