//***********************************************************USE OF EXISTING APP SERVICE PLAN***************************************************************//

@description('Azure location where resources needs to be deoployed')
param location string

@description('Name of the Web App')
param appServiceName string

resource appServicePlan 'Microsoft.Web/serverfarms@2020-12-01' existing = {
  name: 'BicepLearnerAppPlan'
  scope: resourceGroup('AzureBicepLearnertest')
}


resource webApplication 'Microsoft.Web/sites@2021-01-15' = {
  name: appServiceName
  location: location
  tags: {
    'hidden-related:${resourceGroup().id}/providers/Microsoft.Web/serverfarms/appServicePlan': 'Resource'
  }
  properties: {
    serverFarmId: appServicePlan.id //used the existing app servie plan
  }
}

output webAppID string = webApplication.id
