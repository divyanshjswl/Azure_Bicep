@description('Name of the team')
param teamName string

@description('Owner of the Resources')
param ownerOfResource string

@description('name of the Department')
param Department string

// var common_tags = {
//   Team: teamName
//   Owner: ownerOfResource
//   Department: Department
// }

@description('Name of the Storage Account')
param storageAccountName string

@description('Azure location where resources needs to be deployed')
param location string

@description('Name of the Function App')
param functionAppName string

@description('Api key')
@secure()
param apikey string

// For reference resources
@description('Existing App Service Plan Name')
param appServicePlanName string

@description('Name of the Application Insight')
param appInsightName string


// resource appServicePlan 'Microsoft.Web/serverfarms@2023-01-01' existing = {
//   name: appServicePlanName
// }

// resource appInsights 'Microsoft.Insights/components@2020-02-02' existing = {
//   name: appInsightName
// }



module functionApp 'Modules/FunctionApp.bicep' = {
  name: 'deploy-${functionAppName}'
  params: {
    appServicePlanName: appServicePlanName
    appSettings: [{
      name: 'ApiKey'
      value: apikey
    }]
    Department: Department
    functionAppName: functionAppName
    location: location
    ownerOfResource: ownerOfResource
    teamName: teamName
    storageAccountName: storageAccountName 
    appInsightName: appInsightName
  }
}


output functionAppName string = functionApp.outputs.functionAppName
