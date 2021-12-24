# GitHub Actions with Terraform 

This document describes the workflow to deploy azure infrastrcture with terraform

- 1. Create service principal and assign contributor access on subscription (make sure you have access for role assignment and spn creation)

    following command can be use

```
 az ad sp create-for-rbac --name "github-action-spn" --role contributor --scopes /subscriptions/2a04288a-8136-4880-b526-c6070e59f004 --sdk-auth
```
make sure you have sdk-auth flag added to you command

- 2.  Above command will create a spn and return the result which you need store into GitHub repository secrets

the result will looks like this

```
{
  "clientId": "3640fc69-1010-4a9f-8ed6-f0a0505f4184",
  "clientSecret": "kB2XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
  "subscriptionId": "2a04288a-8136-4880-b526-c6070e59f004",
  "tenantId": "37d20c78-05e3-416d-83ab-cdbc21fed22a",
  "activeDirectoryEndpointUrl": "https://login.microsoftonline.com",
  "resourceManagerEndpointUrl": "https://management.azure.com/",
  "activeDirectoryGraphResourceId": "https://graph.windows.net/",
  "sqlManagementEndpointUrl": "https://management.core.windows.net:8443/",
  "galleryEndpointUrl": "https://gallery.azure.com/",
  "managementEndpointUrl": "https://management.core.windows.net/"
}
```



- 3. click on actions tab under github in your repository

```
 export ARM_CLIENT_ID="00000000-0000-0000-0000-000000000000"
$ export ARM_CLIENT_SECRET="00000000-0000-0000-0000-000000000000"
$ export ARM_SUBSCRIPTION_ID="00000000-0000-0000-0000-000000000000"
$ export ARM_TENANT_ID="00000000-0000-0000-0000-000000000000"
```