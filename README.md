# Terragrunt

I do not see the real benefit of using Terragrunt. It is just a wrapper around Terraform. But it is useful for managing multiple environments but I believe tfvars will do the same at least for my case.

## use different backends

~~~powershell
code terragrunt.hcl
mkdir shared

mkdir dev
mkdir dev/alz
code dev/alz/terragrunt.hcl
code dev/env.hcl

mkdir prod
mkdir prod/alz
code prod/alz/terragrunt.hcl
code prod/env.hcl

tree /f

cd dev
terragrunt destroy --auto-approve
cd ..
cd prod
terragrunt destroy --auto-approve
cd ..

terragrunt run --all apply


terragrunt run-all validate
terragrunt run-all fmt

terragrunt run-all apply --auto-approve

terragrunt validate --log-level debug --inputs-debug

~~~

## Lesson learned

- In case you make use of Azure Storage Account as backend, you need to make sure that the container already exists. This is strange because the documentation says that it will be created automatically. But it does not work for me. So I created the container manually.


# Misc

~~~powershell
# create pub github repo
git init
gh repo create cptdtfterragrunt --public --source . --remote origin
git status
git add .
git commit -m "Initial commit"
git push origin main