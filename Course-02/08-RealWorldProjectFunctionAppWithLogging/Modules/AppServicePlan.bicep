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

@description('Name of the App Service Plan')
param appServicePlanName string

@description('Azure Location where the application needs to be deployed')
param location string

@allowed([
  'S1'
  'B1'
])
@description('App Service Plan Sku Name')
param appPlanSkuName string


resource appServicePlan 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: appPlanSkuName
  }
  tags: common_tags
}


output appServicePlanname string = appServicePlan.name
