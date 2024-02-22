@description('Name of the Storage Account')
param storageName string

@description('Azure location to deploy the resources')
param location string

@description('Define the kind of the storage StorageV2')
param storageKind string

@description('Define Storage Account SKU Premium_LRS')
@allowed([
  'Premium_LRS'
  'Premium_GRS'
])
param skuName string

@description('Cpommon tags to use to tag the resources')
param teamName string
param ownerOfTheResource string
var common_tags =  {
  Team: teamName
  Owner: ownerOfTheResource
}

resource storageaccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageName
  location: location
  kind: storageKind
  sku: {
    name: skuName
  }
  tags: common_tags
}

output storageAccountName string = storageaccount.name
output storageAccountID string = storageaccount.id


resource blobService 'Microsoft.Storage/storageAccounts/blobServices@2023-01-01' = {
  name: 'default'
  parent: storageaccount
}

output blobServiceName string = blobService.name 


@description('Put as many container names you want to deploy')
param nameoftheContainers array
var multipleConatinerNames = nameoftheContainers

resource containers 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-01-01' = [for containerName in multipleConatinerNames: {
  name: containerName
  parent: blobService
}]



