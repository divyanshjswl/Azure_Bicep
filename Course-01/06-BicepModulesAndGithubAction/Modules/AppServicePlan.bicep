param appServicePlanName string
param location string
param appServicePlanSku string

resource appServicePlan 'Microsoft.Web/serverfarms@2023-01-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: appServicePlanSku
  }
  tags:{
    Department: 'IT Infrastructuree'
    Owner: 'Divyansh Jaiswal'
  }
}

output appServicePlanName string = appServicePlan.name
output appServiePlanId string = appServicePlan.id
