
name: 'terraform-Azure'

on:
  push:
    branches:
      - main
    paths:
      - "/actions/terraform-azure/*"
  pull_request:
    branches:
      - main
  workflow_dispatch: #this attribute will enable the manual run to the pipeline
  workflow_call:
    inputs:
      tf_destroy:
        description: 'tick this option if you want to destroy environment'
        default: false
        type: boolean
        required: true

# Use the Bash shell regardless whether the GitHub Actions runner is ubuntu-latest, macos-latest, or windows-latest
defaults:
  run:
    shell: bash
env: 
  ROOT_PATH: '${{github.workspace}}/actions/terraform-azure'
  ARM_CLIENT_ID: ${{secrets.AZURE_CLIENT_ID}}
  ARM_CLIENT_SECRET: ${{secrets.AZURE_CLIENT_SECRET}}
  ARM_SUBSCRIPTION_ID: ${{secrets.AZURE_SUBSCRIPTION_ID}}
  ARM_TENANT_ID: ${{secrets.AZURE_TENANT_ID}}
  STAGE_NAME: production

jobs:
  terraform_plan:
    name: 'terraform plan'
    runs-on: ubuntu-latest
    
    steps:
    - name: Checkout
      uses: actions/checkout@v2

    - name: Setup terraform
      uses: hashicorp/setup-terraform@v1
      with:
        cli_config_credentials_token: ${{ secrets.TF_API_TOKEN }}
  
    - name: terraform init
      run: terraform init
      working-directory: ${{ env.ROOT_PATH }}

    - name: terraform Plan
      run: terraform plan 
      working-directory: ${{ env.ROOT_PATH }}
      

  terraform_apply:
    name: 'terraform apply'
    needs: [terraform_plan]
    runs-on: ubuntu-latest
    environment: production
    
    defaults:
      run:
        shell: bash

    steps:
    - name: Checkout
      uses: actions/checkout@v2

    - name: Setup terraform
      uses: hashicorp/setup-terraform@v1
      with:
        cli_config_credentials_token: ${{ secrets.TF_API_TOKEN }}
 
    - name: terraform Init
      run: terraform init
      working-directory: ${{ env.ROOT_PATH }}

    - name: terraform Init
      run: echo 'var -> ${{inputs.tf_destroy}}'
      working-directory: ${{ env.ROOT_PATH }}

      #github.ref == 'refs/heads/main' && github.event_name == 'push'
    - name: terraform Apply
      run: terraform apply -auto-approve
      if: ${{inputs.tf_destroy}} == false
      working-directory: ${{ env.ROOT_PATH }}

    # - name: terraform destroy
    #   run: terraform destroy -auto-approve
    #   if: ${{inputs.tf_destroy}} == true
    #   working-directory: ${{ env.ROOT_PATH }}
