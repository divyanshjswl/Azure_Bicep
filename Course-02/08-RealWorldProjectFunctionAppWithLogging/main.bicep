//*******************************************COMMON TAGS***************************************************
@description('Azure location where resources need to be deployed')
param location string = resourceGroup().location

@description('Name of the team')
param teamName string

@description('Owner of the Resources')
param ownerOfResource string

@description('name of the Department')
param Department string

//**********************************************************************************************************************************************************
//**********************************************************************STORAGE ACCOUNTS********************************************************************
//**********************************************************************************************************************************************************
@minLength(3)
@maxLength(24)
@description('Name of the Storage Account')
param storageAccountName string

param containerNames array

@description('Stoarge Accoount Kind')
param storageAccountKind string

@description('SKU type of the Storage account')
@allowed([
  'Standard_LRS'
  'Standard_GRS'
])
param skuName string

@description('Describe if isSftpEnabled is true or false as per the requirement')
param isSftpEnabled bool

@description('Access tier of the Storage Account')
param accessTier string




module storageAccount 'Modules/storageAccount.bicep' = {
  name: 'deploy-${storageAccountName}'
  params: {
    accessTier: accessTier
    containerNames: containerNames
    Department: Department
    location: location
    ownerOfResource: ownerOfResource
    skuName: skuName
    storageAccountKind: storageAccountKind
    storageAccountName: storageAccountName
    teamName: teamName
  }
}

output storageAccountName string = storageAccount.outputs.storageAccountName
output storageAccountID string = storageAccount.outputs.storageAccountID

output storageAccountContainers array = [
  storageAccount.outputs.NameOfContainers
]

// output storageAccountContainers array = [for i in range(0, length(containerNames)): {
//   containerNames: storageAccount.outputs.NameOfContainers[i]
// }]

@description('Name of the SFTP Storage Account')
param sftpStorageAccountName string 

module sftpStorageAccount 'Modules/storageAccount.bicep' = {
  name: 'deploy-${sftpStorageAccountName}'
  params: {
    accessTier: accessTier
    containerNames: containerNames
    Department: Department
    isSftpEnabled: isSftpEnabled
    location: location
    ownerOfResource: ownerOfResource
    skuName: skuName
    storageAccountKind: storageAccountKind
    storageAccountName: sftpStorageAccountName
    teamName: teamName
  }
}


output sftpStorageAccountName string = sftpStorageAccount.outputs.storageAccountName
output sftpStorageAccountID string = sftpStorageAccount.outputs.storageAccountName


//**********************************************************************************************************************************************************
//******************************************************************APPLICATION INSIGHTS********************************************************************
//**********************************************************************************************************************************************************


@description('Name of the Application Insight')
param appInsightName string 

@description('Azure App Insight kind Web')
param appInsightKind string 


module applicationInsights 'Modules/ApplicationInsights.bicep' = {
  name: 'deploy-${appInsightName}'
  params: {
    appInsightKind: appInsightKind
    appInsightName: appInsightName
    location: location
    Department: Department
    ownerOfResource: ownerOfResource
    teamName: teamName
  }
}


output appInsightName string = applicationInsights.outputs.appInsightName


//**********************************************************************************************************************************************************
//******************************************************************APP SERVICE PLAN************************************************************************
//**********************************************************************************************************************************************************

@description('App Service Plan Name')
param appServicePlanName string

@allowed([
  'S1'
  'B1'
])
@description('App Service Plan Sku Name')
param appPlanSkuName string


module appServicePlan 'Modules/AppServicePlan.bicep'= {
  name: 'deploy-${appServicePlanName}'
  params: {
    appPlanSkuName: appPlanSkuName
    appServicePlanName: appServicePlanName
    Department: Department
    location: location
    ownerOfResource: ownerOfResource
    teamName: teamName
  }
}


output appServicePlanName string = appServicePlan.outputs.appServicePlanname



//**********************************************************************************************************************************************************
//******************************************************************FUNCTION APP****************************************************************************
//**********************************************************************************************************************************************************

@description('Name of the Function App')
param functionAppName string

@description('Name of the Function App')
param computeName string

@description('Api key')
@secure()
param apikey string

// module functionApp 'Modules/FunctionApp.bicep'= {
//   name: 'deploy-${functionAppName}'
//   params: {
//     apikey: apikey
//     appInsightName: appInsightName
//     appServicePlanName: appServicePlanName
//     Department: Department
//     functionAppName: functionAppName
//     location: location
//     ownerOfResource: ownerOfResource
//     storageAccountName: storageAccountName
//     teamName: teamName
//     appSettings: union(appse)
//   }
// }


module compute 'compute.bicep' = {
  name: 'deploy-${computeName}'
  params: {
    apikey: apikey
    appInsightName: appInsightName 
    appServicePlanName: appServicePlanName
    Department: Department
    functionAppName: functionAppName
    location: location
    ownerOfResource: ownerOfResource
    storageAccountName: storageAccountName
    teamName: teamName
  }
}
