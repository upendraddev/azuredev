#!/bin/bash

REPO_OWNER="upendraddev"
REPO_NAME="azuredev"
WORKFLOW_NAME="test-ssla-certs"
ARTIFACT_NAME="SO-Files"
FILE_TYPE=".csv"  # Specify the file type you are looking for

# Get all workflow run IDs for the specified workflow
# Set the GitHub API URL for workflow runs
API_URL="https://api.github.com/repos/${REPO_OWNER}/${REPO_NAME}/actions/runs?workflow=${WORKFLOW_NAME}"

# Use curl to retrieve workflow runs
response=$(curl -s -H "Authorization: Bearer $GITHUB_TOKEN" $API_URL)
# echo "$response"

# Extract run IDs using jq
RUN_IDS=$(echo "$response" | jq -r '.workflow_runs[].id')

print(RUN_IDS)

