@echo off

rem Create directories
mkdir terraform
cd terraform
mkdir dev
mkdir acc
mkdir prod
mkdir modules
cd modules
mkdir eks
cd eks
mkdir templates

rem Create files
cd ..
cd ..
echo. > backend.tf
echo. > providers.tf
echo. > vars.tf
cd dev
echo. > main.tf
echo. > variables.tf
echo. > terraform.tfvars
echo. > outputs.tf
cd ..
cd acc
echo. > main.tf
echo. > variables.tf
echo. > terraform.tfvars
echo. > outputs.tf
cd ..
cd prod
echo. > main.tf
echo. > variables.tf
echo. > terraform.tfvars
echo. > outputs.tf
cd ..
cd modules\eks
echo. > alb.tf
echo. > aws-auth-cm.tpl
echo. > eks.tf
echo. > providers.tf
echo. > rds.tf
echo. > security-groups.tf
cd templates
echo. > app-deployment.tpl
echo. > app-ingress.tpl
echo. > app-service.tpl

echo File structure created successfully.
