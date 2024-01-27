#!/bin/bash

# Set the repository owner and name
REPO_OWNER="upendraddev"
REPO_NAME="azuredev"

# Set the workflow name
WORKFLOW_NAME="test-ssla-certs"

# Set the Personal Access Token (PAT)


# Set the GitHub API URL for workflow runs
API_URL="https://api.github.com/repos/${REPO_OWNER}/${REPO_NAME}/actions/workflows/${WORKFLOW_NAME}/runs"

# Use curl to retrieve workflow runs
response=$(curl -s -H "Authorization: Bearer $GITHUB_TOKEN" $API_URL)

# Extract workflow run IDs using jq (make sure jq is installed)
workflow_run_ids=$(echo "$response" | jq -r '.workflow_runs[].id')

# Print the workflow run IDs
echo "Workflow Run IDs:"
echo "$workflow_run_ids"
