#!/bin/bash

# Use this script to import an image to run an EC2 instance

export SCRIPT_NAME="$0"

if [ -z "$AWS_PROFILE" ]
then
	echo "Missing AWS_PROFILE: Set AWS_PROFILE to the user credential profile to use with aws-cli"
	echo "Usage: $SCRIPT_NAME"
	exit 1
fi

if [ $# -ne 3 ]
then
  echo "Error: missing argument(s)"
  echo "Usage: ${SCRIPT_NAME} s3-bucket image job-name"
  exit 1
fi

BUCKET="$1"
IMAGE="$2"
JOB="$3"

# cp role-policy.json.template role-policy.json
# sed -i '' "s/MY-BUCKET/${BUCKET}/" role-policy.json
#
# aws iam put-role-policy \
#   --role-name vmimport \
#   --policy-name vmimport \
#   --policy-document file://role-policy.json

cp containers.json.template containers.json
sed -i '' "s/BUCKET/${BUCKET}/" containers.json
sed -i '' "s/IMAGE/${IMAGE}/" containers.json
sed -i '' "s/JOB/${JOB}/" containers.json

aws ec2 import-image \
  --description ${JOB} \
  --disk-containers file://containers.json
