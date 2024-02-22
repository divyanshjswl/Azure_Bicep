@description('Name of the Storage Account')
param storageAccountName string

@description('Azure location to deploy the resource')
param location string

@description('name of the Owner Team')
param teamName string

var common_tags = {
  Team: teamName
}


resource storageaccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Premium_LRS'
  }
  tags: common_tags
}

output storageAccountName string = storageaccount.name
output storageAccountId string = storageaccount.id



resource blobService 'Microsoft.Storage/storageAccounts/blobServices@2022-09-01' = {
  name: 'default'
  parent: storageaccount
}

output blobName string = blobService.id

@description('Define as many container name you want to deploy')
param containerNames array = []

resource containers 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-09-01' = [for conatinerName in containerNames: {
  name: conatinerName
  parent: blobService
  properties: {
    publicAccess: 'None'
  }
}]

output containerNames array = [
  'containers.name[0]'
  'containers.name[1]'
]



