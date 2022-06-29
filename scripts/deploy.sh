#!/bin/bash

if [ $# -gt 2 ] || [ $# -eq 1 ];then
    echo "Usage: ./scripts/deploy.sh [stage name (default: dev)] [aws region (default: ap-northeast-1)] ";
    exit 2
fi

STAGE=dev
AWS_REGION=ap-northeast-1

if [ $# -eq 2 ];then
    STAGE=$1
    AWS_REGION=$2
fi

echo "Stage: ${STAGE}"
echo "AWS Region ${AWS_REGION}"

echo ""
echo "Current configuration, ./conf/${STAGE}.yml is as follows"
echo ""
while read line; do
    echo "$line"
done < ./conf/${STAGE}.yml
echo "If you need to change settings, please overwrite ./conf/${STAGE}.yml"
echo "Are you sure you want to start deploying? (yes or no)"
read input

if [ "$input" = "y" ] || [ "$input" = "yes" ];then
    echo "Start Deployment"

    cd /src/s3
    serverless deploy --stage ${STAGE} --region ${AWS_REGION}

else
    echo "Finish without doing anything"
fi