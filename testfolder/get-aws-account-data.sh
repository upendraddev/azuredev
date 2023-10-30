#!/usr/bin/env bash
# VERSION 1.0.0
echo -e "\n===== [$(readlink -f $0)] =====\n" 1>&2
set -euvx -o pipefail
shopt -s inherit_errexit

STAGING_FILE_PATH="./staging-data.txt"
aws iam generate-credential-report
(aws iam get-credential-report --query "Content" --output text | base64 -d) >>$STAGING_FILE_PATH
