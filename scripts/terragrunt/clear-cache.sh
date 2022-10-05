working_dir=./infrastructure/$1

find $working_dir -type d -name ".terragrunt-cache" -prune -exec rm -rf {} \;
