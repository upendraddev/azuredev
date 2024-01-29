#!/bin/bash

# Replace with your GitHub token and repository information
REPO_OWNER="upendraddev"
REPO_NAME="azuredev"
WORKFLOW_NAME="test-certs"
RUN_ID="7695468046"

# Get workflow run details
WORKFLOW_RUN_DETAILS=$(curl -s -H "Authorization: Bearer $GITHUB_TOKEN" \
  "https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/actions/runs/$RUN_ID")

# Extract input annotations
echo "$WORKFLOW_RUN_DETAILS"
INPUT_ANNOTATIONS=$(echo "$WORKFLOW_RUN_DETAILS" | jq -r '.workflow_run.annotations')

echo "Workflow Input Annotations:"
echo "$INPUT_ANNOTATIONS"
