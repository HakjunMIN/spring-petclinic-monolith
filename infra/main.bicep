targetScope = 'subscription'

@minLength(1)
@maxLength(64)
@description('Name of the environment that can be used as part of naming resource convention')
param environmentName string

@minLength(1)
@description('Primary location for all resources')
param location string

@description('PostgreSQL administrator username')
param postgresAdminUser string = 'pgadmin'

@secure()
@description('PostgreSQL administrator password')
param postgresAdminPassword string

@description('PostgreSQL database name')
param postgresDatabaseName string = 'petclinic'

// Generate resource group name
var resourceGroupName = 'rg-${environmentName}'

// Generate resource token for unique resource names
var resourceToken = uniqueString(subscription().id, location, environmentName)

// Resource prefixes (3 characters max, alphanumeric only)
var resourcePrefixes = {
  containerRegistry: 'acr'
  containerAppEnv: 'cae'
  containerApp: 'ca'
  logAnalytics: 'log'
  appInsights: 'ai'
  keyVault: 'kv'
  postgres: 'pg'
  managedIdentity: 'id'
}

// Resource Group
resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: location
  tags: {
    'azd-env-name': environmentName
  }
}

// Deploy resources module
module resources 'resources.bicep' = {
  name: 'resources-deployment'
  scope: rg
  params: {
    location: location
    resourceToken: resourceToken
    resourcePrefixes: resourcePrefixes
    postgresAdminUser: postgresAdminUser
    postgresAdminPassword: postgresAdminPassword
    postgresDatabaseName: postgresDatabaseName
  }
}

// Outputs
output AZURE_LOCATION string = location
output AZURE_TENANT_ID string = tenant().tenantId
output AZURE_RESOURCE_GROUP string = rg.name
output RESOURCE_GROUP_ID string = rg.id

output AZURE_CONTAINER_REGISTRY_ENDPOINT string = resources.outputs.AZURE_CONTAINER_REGISTRY_ENDPOINT
output AZURE_CONTAINER_REGISTRY_NAME string = resources.outputs.AZURE_CONTAINER_REGISTRY_NAME

output AZURE_CONTAINER_APP_NAME string = resources.outputs.AZURE_CONTAINER_APP_NAME
output AZURE_CONTAINER_APP_URL string = resources.outputs.AZURE_CONTAINER_APP_URL

output AZURE_POSTGRES_SERVER_NAME string = resources.outputs.AZURE_POSTGRES_SERVER_NAME
output AZURE_POSTGRES_DATABASE_NAME string = resources.outputs.AZURE_POSTGRES_DATABASE_NAME

output AZURE_KEY_VAULT_NAME string = resources.outputs.AZURE_KEY_VAULT_NAME
output AZURE_KEY_VAULT_ENDPOINT string = resources.outputs.AZURE_KEY_VAULT_ENDPOINT

output APPLICATIONINSIGHTS_CONNECTION_STRING string = resources.outputs.APPLICATIONINSIGHTS_CONNECTION_STRING
