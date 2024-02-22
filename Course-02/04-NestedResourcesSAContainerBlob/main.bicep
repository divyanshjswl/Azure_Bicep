

param storageAccountName string
param location string 
param teamName string

var common_tag = {
  Team: teamName
}

resource storageaccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: storageAccountName
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Premium_LRS'
  }
  tags: common_tag
}


param blobServiceName string

resource blobServices 'Microsoft.Storage/storageAccounts/blobServices@2023-01-01' = {
  parent: storageaccount //DEFINED THE PARENT RESOURCE, HENCE THIS RESOURCE WILL BE CREATED UNDER THE STORAGE ACCOUNT AND WILL CREATED AFTER SA WILL BE CREATED
  name: blobServiceName
}


param conatinerName string

resource StorageContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-01-01' = {
  parent: blobServices //DEFINED THE PARENT RESOURCE, HENCE THIS RESOURCE WILL BE CREATED UNDER THE BLOB SERVICES AND WILL CREATED AFTER BLOB SERVICES WILL BE CREATED
  name: conatinerName
}
