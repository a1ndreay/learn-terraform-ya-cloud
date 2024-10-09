1. Get IAM-token:
**PowerShell**:
```PowerShell
$token = $(yc iam create-token)
[System.Environment]::SetEnvironmentVariable('IAM_TOKEN', $token, [System.EnvironmentVariableTarget]::User)
[System.Environment]::SetEnvironmentVariable('TF_VAR_IAM_TOKEN', $token, [System.EnvironmentVariableTarget]::User)
```
>[!note] [Как получить IAM-токен для федеративного аккаунта | Yandex Cloud - Документация](https://yandex.cloud/ru/docs/iam/operations/iam-token/create-for-federation)
2. Apply `.tfvars` file:
```Bash
terraform apply -var-file="variables.tfvars.json"
```
>[!note] Using Terraform input variables https://developer.hashicorp.com/terraform/language/values/variables
