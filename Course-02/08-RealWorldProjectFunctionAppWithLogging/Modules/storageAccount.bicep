//*************************************************************STORAGE ACCOUNT********************************************************************************************

@minLength(3)
@maxLength(24)
@description('Name of the Storage Account')
param storageAccountName string

@description('Azure location where resources need to be deployed')
param location string

@description('Stoarge Accoount Kind')
param storageAccountKind string

@description('SKU type of the Storage account')
@allowed([
  'Standard_LRS'
  'Standard_GRS'
])
param skuName string


@description('Describe if isSftpEnabled is true or false as per the requirement')
param isSftpEnabled bool = false

@description('Access tier of the Storage Account')
param accessTier string

//For tags 
@description('Name of the team')
param teamName string

@description('Owner of the Resources')
param ownerOfResource string

@description('name of the Department')
param Department string

var common_tags = {
  Team: teamName
  Owner: ownerOfResource
  Department: Department
}


resource storageaccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  location: location
  kind: storageAccountKind
  sku: {
    name: skuName
  }
  properties:{
    minimumTlsVersion: 'TLS1_2'
    accessTier: accessTier
    supportsHttpsTrafficOnly: true
    isSftpEnabled: isSftpEnabled
    isHnsEnabled: isSftpEnabled ? true : false
  }
  tags: common_tags
}

output storageAccountName string = storageaccount.name
output storageAccountID string = storageaccount.id


//*************************************************************BLOB SERVICE********************************************************************************************

resource blobServices 'Microsoft.Storage/storageAccounts/blobServices@2023-01-01'= {
  name: 'default'
  parent: storageaccount
}

output blobServiceID string = blobServices.id


//*************************************************************CONTAINERS********************************************************************************************

@description('Name of the Containers')
param containerNames array

resource containers 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-01-01' = [for containerName in containerNames: {
  name: containerName
  parent: blobServices
}]


output NameOfContainers array = [
  containerNames[0]
  containerNames[1]
  containerNames[2]
  containerNames[3]
]
// output NameofContainers array = [for i in range(0, length(containerNames)): {
//   containerName: containerNames[i]
// } ]
