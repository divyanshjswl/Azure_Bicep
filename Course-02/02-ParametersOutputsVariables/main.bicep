@description('This is the location of the resources to be deployed in Azure')
param location string

@minLength(3)
@maxLength(24)
@description('This is the name of simple Storage Account')
param storageAccountName string

@minLength(3)
@maxLength(24)
@description('This is the name of Logging Storage Account')
param loggingstorageAccountName string

@allowed([
  'Standard_LRS'
  'Standard_GRS'
])
@description('This is the Storage Account SKU type')
param storageAccountSku string

// USING PARAMETERS AND VARIABLE TOGETHER

@description('This is a property of Storage Account')
param minimumTlsVersion string

@description('This is a property of Storage Account')
param supportsHttpsTrafficOnly bool

var storageAccountProperties = {
  minimumTlsVersion: minimumTlsVersion
  supportsHttpsTrafficOnly: supportsHttpsTrafficOnly
}

@description('The common tags used for all resources created in Azure')
param commontags object = {}


resource storageaccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  location: location
  kind: 'StorageV2'
  sku: {
    name: storageAccountSku
  }
  properties: storageAccountProperties
  tags: commontags
}



resource loggingstorageaccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: loggingstorageAccountName
  location: location
  kind: 'StorageV2'
  sku: {
    name: storageAccountSku
  }
  properties: storageAccountProperties
  tags: commontags
}

