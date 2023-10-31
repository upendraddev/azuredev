#!/usr/bin/env bash
# VERSION 1.0.0
echo -e "\n===== [$(readlink -f $0)] =====\n" 1>&2
set -euvx -o pipefail
shopt -s inherit_errexit

STAGING_FILE_PATH="./staging-data.txt"

G_STATUS=$(aws iam generate-credential-report --output text)
echo "$G_STATUS"
# G_STATUS1="COMPLETE"
# until aws iam generate-credential-report --output text | grep $G_STATUS1; do echo \"Waiting for report generation complete...\"; sleep 3; done; \
if ["$G_STATUS" != "COMPLETE" ]; then
sleep 30
G_STATUS2=$(aws iam generate-credential-report --output text)
echo "$G_STATUS2"
else
  (aws iam get-credential-report --query "Content" --output text | base64 -d) >>$STAGING_FILE_PATH
  USERS=$(cat $STAGING_FILE_PATH | awk -F "\"*,\"*" 'NR>2 {print $1"|"$7"|"$9"|"$10"|"$14"|"$15}')
  echo $USERS
  len=${#USERS[@]}
  echo $len
fi
