param StorageName string 
param location string
param storageKind string
param skutype string 
param accessTier string

resource storageaccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: StorageName
  location: location
  kind: storageKind
  sku: {
    name: skutype
  }
  properties:{
    accessTier: accessTier
  }
}


output StorageAccountName string = storageaccount.name
output storageAccountlocation string = storageaccount.location
output storageAccountId string = storageaccount.id
