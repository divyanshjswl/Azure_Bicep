param webAppName string
param location string
param appServicePlanId string

resource webApplication 'Microsoft.Web/sites@2023-01-01' = {
  name: webAppName
  location: location
  properties: {
    serverFarmId: appServicePlanId
    httpsOnly: true
  }
}


output webAppName string = webApplication.name
output webAppUrl string = webApplication.properties.hostNames[0]
