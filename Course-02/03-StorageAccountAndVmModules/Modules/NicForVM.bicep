@description('Common tag')
param teamName string
var common_tag  = {
  Team: teamName
}

@description('Azure Location where resources will be deployed')
param location string

@description('Name of the NIC card')
param NicName string = 'testbicepnic'

@description('Name of the Private IP address')
param NicIpname string = 'testbicepipname'

resource networkInterface 'Microsoft.Network/networkInterfaces@2023-09-01' = {
  name: NicName
  location: location
  properties: {
    ipConfigurations: [
      {
        name: NicIpname
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            name: 'snet-system'
          }
        }
      }
    ]
  }
  tags: common_tag
}

output NicId string = networkInterface.id
