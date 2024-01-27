#!/bin/bash

# Set the repository owner and name
REPO_OWNER="upendraddev"
REPO_NAME="azuredev"

# Set the name of the workflow you want to retrieve run IDs for
WORKFLOW_NAME="7679510334"



# Set the GitHub API URL for workflow runs
API_URL="https://api.github.com/repos/${REPO_OWNER}/${REPO_NAME}/actions/workflows/${WORKFLOW_NAME}/runs"

# Use curl to retrieve workflow runs
response=$(curl -s -H "Authorization: Bearer $GITHUB_TOKEN" $API_URL)
echo "$response"

# Extract run IDs using jq
run_ids=$(echo "$response" | jq -r '.workflow_runs[].id')

# Print the run IDs
echo "Workflow Run IDs:"
echo "$run_ids"

