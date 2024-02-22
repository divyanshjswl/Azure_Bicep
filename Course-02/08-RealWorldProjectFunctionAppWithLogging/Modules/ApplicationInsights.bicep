
@description('Name of the Application Insight')
param appInsightName string

@description('Azure location where resources needs to be deployed')
param location string

@description('Azure App Insight kind Web')
param appInsightKind string

// For Tags
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

resource appInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: appInsightName
  location: location
  kind: appInsightKind
  properties: {
    Application_Type: 'web'
    Request_Source: 'rest'
  }
  tags: common_tags
}


output appInsightName string = appInsights.name
