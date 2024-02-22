@description('Common tag')
param teamName string
var common_tag  = {
  Team: teamName
}

@description('Azure locaion of the Virtual Machine')
@allowed(['canadacentral'])
param location string

@description('Name of the Virtual Machine')
param VmName string

@description('Size of the Virtual Machine')
@allowed([
  'Standard_DS1_v2'
  'DS1_V3'
])
param vmSize string

// osProfile properties defined
@description('Name of the Virtual Machine')
param computerName string

@description('Name of the Admin User')
param adminUsername string

@description('Password for the Admin user')
@secure()
param adminPassword string

@description('variables for Virtual Vachines OS profile')
var osProfile  = {
  computerName: computerName
  adminUsername: adminUsername
  adminPassword: adminPassword
}

// For VM OS Image reference

@description('Name of the OS Publisher MicrosoftWindowsServer')
param ospublisher string

@description('Operating system WindowsServer')
param osoffer string

@description('SKU of the Image 2022-datacenter-azure-edition')
param skuofimage string

@description('OS Version latest')
param osversion string

@description('Variables defined for the VM OS Image reference')
var imageReferenceforVM = {
  publisher: ospublisher
  offer: osoffer
  sku: skuofimage
  version: osversion
}

@description('NIC ID')
param networkinterfaceid string


resource windowsVM 'Microsoft.Compute/virtualMachines@2020-12-01' = {
  name: VmName
  location: location
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    osProfile: osProfile
    storageProfile: {
      imageReference: imageReferenceforVM
      osDisk: {
        name: 'name'
        caching: 'ReadWrite'
        createOption: 'FromImage'
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkinterfaceid
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
        storageUri:  'storageUri'
      }
    }
  }
  tags: common_tag
}


output VmName string = windowsVM.name
output VmID string = windowsVM.id



