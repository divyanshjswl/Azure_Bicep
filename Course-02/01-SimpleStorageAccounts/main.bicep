

resource storageaccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: 'sabicepdevzz'
  location: 'canadacentral'
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}
