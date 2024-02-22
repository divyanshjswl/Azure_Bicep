param location string = 'canadacentral'
param teamName string = 'CloudOps'

module StorageAccount 'Modules/StorageAccount.bicep' = {
  name: 'Deploy-SA'
  params: {
    location: location
    storageAccountKind: 'StorageV2'
    storageAccountName: 'biceplearnerdevv'
    storageAccountSku: 'Premium_LRS'
    teamName: teamName
  }
}

module NetworkInterface 'Modules/NicForVM.bicep' = {
  name: 'Deploy-NIC'
  params: {
    location: location
    teamName: teamName
  }
}

module VirtualMachine 'Modules/VirtualMachine.bicep' = {
  name: 'Deploy-VM'
  params: {
    adminPassword: 'Divyansh@eq'
    adminUsername: 'azurevmadmin'
    computerName: 'TestBicepVm'
    location: location
    networkinterfaceid: NetworkInterface.outputs.NicId
    osoffer: 'WindowsServer'
    ospublisher: 'MicrosoftWindowsServer'
    osversion: 'latest'
    skuofimage: '2022-datacenter-azure-edition'
    teamName: teamName
    VmName: 'TestBicepVm'
    vmSize: 'Standard_DS1_v2'
  }
}
