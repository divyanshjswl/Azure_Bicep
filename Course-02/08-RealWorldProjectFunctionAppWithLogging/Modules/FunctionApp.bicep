@description('Name of the team')
param teamName string

@description('Owner of the Resources')
param ownerOfResource string

@description('name of the Department')
param Department string

var common_tags = {
  Team: teamName
  Owner: ownerOfResource
  Department: Department
}

@description('Azure location where resources needs to be deployed')
param location string

@description('Name of the Function App')
param functionAppName string

@description('Function App AppSettings')
param appSettings array


@description('Existing App Service Plan Name')
param appServicePlanName string

resource appServicePlan 'Microsoft.Web/serverfarms@2023-01-01' existing = {
  name: appServicePlanName
}

@minLength(3)
@maxLength(24)
@description('Name of the Storage Account')
param storageAccountName string

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' existing = {
  name: storageAccountName
}

@description('Name of the Application Insight')
param appInsightName string

resource appInsights 'Microsoft.Insights/components@2020-02-02' existing = {
  name: appInsightName
}



var requiredAppSettings = [
  {
    name: 'AzureWebJobsStorage'
    value: storageAccountConnectionString
  }
  {
    name: 'APPINSIGHTS_INSTRUMENTATIONKEYT'
    value: appInsights.properties.InstrumentationKey
  }
  {
    name: 'APPINSIGHTS_CONNECTION_STRING'
    value: appInsights.properties.ConnectionString
  }
  {
    name: 'FUNCTIONS_EXTENSION_VERSION'
    value: '~4'
  }
  {
    name: 'FUNCTIONS_WORKER_RUNTIME'
    value: 'dotnet'
  }
]

var storageAccountConnectionString = 'DefaultEndpointsProtocol=https;AccountName=${storageAccountName};EndpointSuffix=${environment().suffixes.storage};AccountKey=${storageAccount.listKeys().keys[0].value}'

resource functionApp 'Microsoft.Web/sites@2023-01-01' = {
  name: functionAppName
  location: location
  tags: common_tags
  kind: 'functionapp'
  identity: {
    type:'SystemAssigned'
  }
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
    siteConfig: {
      windowsFxVersion: 'DOTNETCORE|LTS'
      alwaysOn: true
      appSettings: union(appSettings, requiredAppSettings)
    }
  }
}


output functionAppName string = functionApp.name
