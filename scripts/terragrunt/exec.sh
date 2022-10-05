working_dir=./infrastructure/$1;
shift 1;

# terraform -chdir=$working_dir $@
terragrunt $@ --terragrunt-working-dir=$working_dir
