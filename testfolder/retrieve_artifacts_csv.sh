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

for RUN_ID in "${RUN_IDS}"; do
    #echo "$RUN_ID"
    # Set the GitHub API URL for artifacts
    API_URL="https://api.github.com/repos/${REPO_OWNER}/${REPO_NAME}/actions/runs/${RUN_ID}/artifacts"

    # Use curl to retrieve artifact information
    response=$(curl -s -H "Authorization: Bearer $GITHUB_TOKEN" $API_URL)

    # Extract artifact ID based on the provided artifact name
    artifact_id=$(echo "$response" | jq -r ".artifacts[] | select(.name == \"$ARTIFACT_NAME\") | .id")

    if [ -z "$artifact_id" ]; then
      echo "Artifact with name '$ARTIFACT_NAME' not found."
      exit 1
    fi
done

