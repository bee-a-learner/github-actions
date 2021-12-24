# GitHub Actions with Terraform 

This document describes the workflow to deploy azure infrastrcture with terraform

- 1. Create service principal and assign contributor access on subscription (make sure you have access for role assignment and spn creation)

    following command can be use

```az ad sp create-for-rbac -n github-action-spn --role="Contributor" --scopes="/subscriptions/SUBSCRIPTION_ID"```



- 2.  Above command will create a spn and return the result which you need store into GitHub repository secrets

the result will looks like this

```
{
  "appId": "7cdc973d-7e99-xxxxxxxxxxxxxxxxxxxxx",
  "displayName": "github-action-spn",
  "name": "7cdc973d-7e99-xxxxxxxxxxxxxxxxxxxxx",
  "password": "KjkMmnnIhz_xxxxxxxxxxxxxxxxxxxxx",
  "tenant": "xxxxxxxxxxxxxxxxxxxxx-fed22a"
}
```

- 3. click on actions tab under github in your repository