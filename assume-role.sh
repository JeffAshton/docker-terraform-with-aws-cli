#!/bin/bash
set -eu

if [ "${1:-}" == "" ]; then
	echo "Usage: aws-assume-role <roleArn>"
	exit 1
fi

roleArn="$1"

echo "Assuming $roleArn"
json="$( aws sts assume-role --role-arn "$roleArn" --role-session-name "circleci" )"

export AWS_ACCESS_KEY_ID=$(echo $json | jq -r '.Credentials.AccessKeyId')
export AWS_SECRET_ACCESS_KEY=$(echo $json | jq -r '.Credentials.SecretAccessKey')
export AWS_SESSION_TOKEN=$(echo $json | jq -r '.Credentials.SessionToken')
export AWS_SECURITY_TOKEN="$AWS_SESSION_TOKEN"