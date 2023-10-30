#!/usr/bin/env bash
# VERSION 1.0.0
echo -e "\n===== [$(readlink -f $0)] =====\n" 1>&2
set -euvx -o pipefail
shopt -s inherit_errexit

G_STATUS=$(aws iam generate-credential-report --output text)

if [ "$G_STATUS" == "COMPLETE" ]; then
aws iam get-credential-report --output text --query Content  | base64 -d
fi  
