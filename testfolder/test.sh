#!/usr/bin/env bash
# VERSION 1.0.0
echo -e "\n===== [$(readlink -f $0)] =====\n" 1>&2
set -euvx -o pipefail
shopt -s inherit_errexit


# Env="tessghc2456"
# TitleMessage="teysav4556"
# DDAPPKEY="svjgcjmd3564"
# ACIC="2345678"
# GSAQ="67896767"

# echo "acic=${ACIC}" >> $GITHUB_OUTPUT
# echo "gsaq=${GSAQ}" >> $GITHUB_OUTPUT
FILE_CONTENT=$(cat samplefile.txt)
echo "FILE_CONTENT=${FILE_CONTENT}" >> $GITHUB_ENV
