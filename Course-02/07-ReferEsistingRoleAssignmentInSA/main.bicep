param location string = 'canadacentral'
param nameOfMultipleContainers array = [
  'audit'
  'logs'
  'error'
  'success'
]
param storageAccountName string = 'azurebiceplearnerdev'
param storageKind string = 'StorageV2'
param storageSku string = 'Premium_LRS'
param DepartmentName string = 'IT infrastructure'
param OwnerName string = 'Divyansh Jaiswal'
param NameOfTeam string = 'CloudOps'


module storageAccount 'Modules/storageAccount.bicep' = {
  name: 'Deploy-Storage-Account'
  params: {
    location: location
    nameOfContainers: nameOfMultipleContainers
    storageAccountName: storageAccountName
    storageKind: storageKind
    storageSku: storageSku
    Department: DepartmentName
    ownerOfResource: OwnerName
    teamName: NameOfTeam
  }
}


