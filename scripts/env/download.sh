app=$1
env=$2
shift 2;

source=s3://just-test-$app-env
target=./apps/$app/src/environments

./scripts/env/_sync.sh $source $target $env $@
