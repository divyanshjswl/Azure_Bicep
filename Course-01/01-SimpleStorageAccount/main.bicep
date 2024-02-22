resource storageaccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: 'testbiceplearner'
  location: 'canadacentral'
  kind: 'StorageV2'
  sku: {
    name: 'Premium_LRS'
  }
  properties: {
    accessTier: 'Cool'
  }
  tags: {
    Name: 'testbiceplearner'
    Owner: 'Divyansh Jaiswal'
    Department: 'IT Infrastructure'
  }
}
