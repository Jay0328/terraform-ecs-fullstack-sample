source=$1
target=$2
env=$3
shift 3;

file=environment.$env.ts

if [ "$env" = "all" ]
then
  aws s3 sync $source $target --exclude "*.ts" --include "environment.*.ts" $@
else
  aws s3 cp $source/$file $target/$file $@
fi
