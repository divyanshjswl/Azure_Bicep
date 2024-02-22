@description('Azure locstion where the resources will be deployed')
param location string

@description('Name of the Storage Account')
param saName string

@description('Name of the owner Team')
param teamName string

@description('Define as many container names you want to delkoy')
param nameofContainers array = []
var containerNames = nameofContainers

module storageAccount 'Modules/StorageAccountBlobAndContainer.bicep' = {
  name: 'Deploy-multiple-containers' 
  params: {
    location: location
    storageAccountName: saName
    teamName: teamName
    containerNames: containerNames

  }
}

