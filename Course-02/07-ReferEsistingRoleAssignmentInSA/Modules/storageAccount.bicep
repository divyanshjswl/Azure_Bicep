@description('Common tag values')
param teamName string
param ownerOfResource string
param Department string
var tagsforresources = {
  Team: teamName
  Owner: ownerOfResource
  Department: Department
}

@description('Name of the storage Account')
param storageAccountName string 

@description('Azure location where the resources needs to be deployed')
param location string

@description('Storage Account Kind')
param storageKind string

@description('SKU of the Storage Account')
@allowed([
  'Premium_LRS'
  'Premium_GRS'
])
param storageSku string


resource storageaccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  location: location
  kind: storageKind
  sku: {
    name: storageSku
  }
  tags: tagsforresources
}




resource blobService 'Microsoft.Storage/storageAccounts/blobServices@2023-01-01' = {
  name: 'default'
  parent: storageaccount
}


param nameOfContainers array
var containerNames = nameOfContainers

resource container 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-01-01' = [for containerName in containerNames : {
  name: containerName
  parent: blobService
  properties: {
    publicAccess: 'None'
  }  
}]
