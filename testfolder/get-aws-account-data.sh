#!/usr/bin/env bash
# VERSION 1.0.0
echo -e "\n===== [$(readlink -f $0)] =====\n" 1>&2
set -euvx -o pipefail
shopt -s inherit_errexit

G_STATUS=$(aws iam generate-credential-report --output text)
G_STATUS1="COMPLETE"
# until aws iam generate-credential-report --output text | grep $G_STATUS1; do echo \"Waiting for report generation complete...\"; sleep 3; done; \
if [[ "$G_STATUS" != "COMPLETE" ]]
then
sleep 30
G_STATUS2=$(aws iam generate-credential-report --output text)
 if [[ "$G_STATUS2" == "COMPLETE" ]]
 then
   aws iam get-credential-report --output text --query Content  | base64 -d
  fi
fi
