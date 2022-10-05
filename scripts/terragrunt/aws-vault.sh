profile=$1
shift 1;

aws-vault exec $profile --no-session -- sh ./scripts/terragrunt/exec.sh $@
