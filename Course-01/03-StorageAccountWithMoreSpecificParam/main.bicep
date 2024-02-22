param location string = resourceGroup().location
param name string = uniqueString(resourceGroup().id)
param sakind string = 'StorageV2'
param sku string = 'Premium_LRS'
param accessTier string = 'Hot'



resource storageaccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: name
  location: location
  kind: sakind
  sku: {
    name: sku
  }
  properties: {
    accessTier: accessTier
  }
  tags: {
    Name: name
    Owner: 'Divyansh Jaiswal'
    Department: 'IT Infrastructure'
  }
}
