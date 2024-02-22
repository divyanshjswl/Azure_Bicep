@description('Common tag')
param teamName string
var common_tag  = {
  Team: teamName
}

@description('Azure location where the resources will be deployed')
param location string

@description('Name of the Storage Account')
param storageAccountName string

@description('Storage account Kind StorageV2')
param storageAccountKind string

@description('Storage Account SKU')
@allowed([
  'Premium_LRS'
  'Premium_GRS'
])
param storageAccountSku string

resource storageaccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  location: location
  kind: storageAccountKind
  sku: {
    name: storageAccountSku
  }
  tags: common_tag
}

output storageAccountName string = storageaccount.name
output storageAccountid string = storageaccount.id
