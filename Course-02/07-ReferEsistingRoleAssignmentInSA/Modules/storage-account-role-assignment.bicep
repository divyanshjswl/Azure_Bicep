param roleAssignmentID string
param adgroupID string


resource role 'Microsoft.Authorization/roleDefinitions@2022-04-01' existing = {
  name: roleAssignmentID
}



//******************************** THIS IS FOR THE SINGLE STORAGE ACCOUNT*********************************************************************************
// resource storageaccount 'Microsoft.Storage/storageAccounts@2023-01-01' existing = {
//   name: storageAccountName
// }


// resource roleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
//   name: guid(storageAccountName, role.id, adgroupID)
//   scope: storageaccount
//   properties: {
//     principalId: adgroupID
//     roleDefinitionId: role.id
//   }
// }



//**********************************************TO ASSIGN ROLE TO MULTIPLE ACCOUNTS BASED ON STORGE ACCOUNT NAME********************************************************

param stoargeAccountnames array


resource storageAccounts 'Microsoft.Storage/storageAccounts@2023-01-01' existing = [for storageAccountName in stoargeAccountnames: {
  name: storageAccountName
}]


resource roleAssignments 'Microsoft.Authorization/roleAssignments@2022-04-01' = [for i in range(0, length(stoargeAccountnames)): { //Using advanced loop
  name: guid(storageAccounts[i].name, role.id, adgroupID) //For existing resources we have to use advanced loop  
  properties: {
    principalId: adgroupID
    roleDefinitionId: role.id
  }
}]
