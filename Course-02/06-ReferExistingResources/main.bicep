@description('Name of the containers to be deployed')
param nameoftheContainers array

@description('Azure location where the resources needs to be deployed')
param location string

@description('Name of the owner of the resource')
param ownerOfTheResource string

@description('Name of the SKU of Storage Account')
param skuName string

@description('Storage Account Kind')
param storageKind string

@description('Storage Account Name')
param storageName string

@description('Name of the owner Team')
param teamName string


module storageAccount 'Modules/StorageAccountBlobSeviceContainers.bicep' = {
  name: 'Deploy-multiple-storages'
  params: {
    location: location
    nameoftheContainers: nameoftheContainers
    ownerOfTheResource: ownerOfTheResource
    skuName: skuName
    storageKind: storageKind
    storageName: storageName
    teamName: teamName
  }
}

output StorageAccountName string = storageAccount.outputs.storageAccountName


@description('Name of the App Service')
param appServiceName string

module webApp 'Modules/WebApp.bicep' = {
  name: 'Deploy-WebApp'
  params: {
    appServiceName: appServiceName
    location: location
  }
}


output appServiceId string = webApp.outputs.webAppID
