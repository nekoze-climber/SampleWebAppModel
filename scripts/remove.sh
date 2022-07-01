#!/bin/bash

if [ $# -gt 3 ] || [ $# -eq 1 ];then
    echo "Usage: ./remove-s3.sh [stage name (default: dev)] [aws region (default: ap-northeast-1)] [bucket name (default: sample-web-app-model-ui-{stage})]";
    exit 2
fi

STAGE=dev
AWS_REGION=ap-northeast-1
BUCKET_NAME=sample-web-app-model-ui-${STAGE}

if [ $# -eq 3 ];then
    STAGE=$1
    AWS_REGION=$2
    BUCKET_NAME=$3
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
echo "Are you sure you want to start removing? (yes or no)"
read input

if [ "$input" = "y" ] || [ "$input" = "yes" ];then
    echo "Start Remove"
    aws s3 rm s3://${BUCKET_NAME} --recursive    
    cd ../src/s3
    serverless remove --stage ${STAGE} --region ${AWS_REGION} --config serverless-s3-ui.yml

else
    echo "Finish without doing anything"
fi