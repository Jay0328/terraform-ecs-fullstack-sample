app=$1
env=$2
shift 2;

source=./apps/$app/src/environments
target=s3://just-test-$app-env

./scripts/env/_sync.sh $source $target $env $@
