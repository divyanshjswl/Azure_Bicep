// ****************************************** Common parameters *********************************************
param namePrefix string = 'AzureBicepLearner'
param StorageAccountName string = uniqueString(resourceGroup().id)
param location string = 'canadacentral'
targetScope = 'resourceGroup'


// ****************************************** STORAGE ACCOUNT ************************************************

param accessTier string = 'Hot'
param skuType string = 'Premium_LRS'
param storageKind string = 'StorageV2'

module storageAccount 'Modules/StorageAccount.bicep' = {
  name: StorageAccountName
  params: {
    accessTier: accessTier
    location: location
    skutype: skuType
    storageKind: storageKind
    StorageName: StorageAccountName
  }

}

output storageAccountId string = storageAccount.outputs.storageAccountId



// ****************************************** App Service Plan ************************************************

param appServicePlanSku string = 'F1'

module AppServicePlan 'Modules/AppServicePlan.bicep' = {
  name: '${namePrefix}-AppServicePlan'
  params: {
    appServicePlanName: '${namePrefix}-AppServicePlan'
    appServicePlanSku: appServicePlanSku
    location: location
  }
}

output appServicePlanFarmId string = AppServicePlan.outputs.appServiePlanId





// ****************************************** Web Application ************************************************


module WebApplication 'Modules/WebApp.bicep' = {
  name: '${namePrefix}-WebApplication'
  params: {
    appServicePlanId: AppServicePlan.outputs.appServiePlanId
    location: location
    webAppName: '${namePrefix}-WebApplication'
  }
}

output WebApplicationUrl string = WebApplication.outputs.webAppUrl
