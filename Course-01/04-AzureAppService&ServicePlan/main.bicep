// Code For App Service Plan

param name string = 'AzureBicepLearner'
param location string = resourceGroup().location
param serviceplansku string = 'F1'


resource appServicePlan 'Microsoft.Web/serverfarms@2023-01-01' = {
  name: '${name}-AppServicePlan'
  location: location
  sku: {
    name: serviceplansku
  }
  tags: {
    Name: '${name}-AppServicePlan'
    Owner: 'Divyansh Jaiswal'
    Department: 'IT Ib=nfrastructure'
  }
}




// Code For App Service


param httpsonlystatus bool = true


resource webApplication 'Microsoft.Web/sites@2023-01-01' = {
  name: '${name}-AppService'
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: httpsonlystatus
  }
  tags:{
    Name: '${name}-AppService'
    Owner: 'Divyansh Jaiswal'
    Department: 'IT Infrastructure'
  }
}





