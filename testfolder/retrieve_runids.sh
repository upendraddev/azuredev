#!/bin/bash

REPO_OWNER="upendraddev"
REPO_NAME="azuredev"
WORKFLOW_NAME="test-ssla-certs"
ARTIFACT_NAME="SO-Files"

# Get information about workflow runs for a specific workflow
WORKFLOW_RUNS=$(curl -s -H "Authorization: Bearer $GITHUB_TOKEN" \
  "https://api.github.com/repos/${REPO_OWNER}/${REPO_NAME}/actions/runs?workflow=${WORKFLOW_NAME}")

# Iterate through each run to find the one with the specified artifact
for RUN in $(echo "$WORKFLOW_RUNS" | jq -c '.workflow_runs[]'); do
  RUN_ID=$(echo "$RUN" | jq -r '.id')
  
  # Check if the artifact exists in the run
  ARTIFACT_EXISTS=$(curl -s -H "Authorization: Bearer $GITHUB_TOKEN" \
    "https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/actions/runs/$RUN_ID/artifacts" \
    | jq -r --arg ARTIFACT_NAME "$ARTIFACT_NAME" '.artifacts | map(select(.name == $ARTIFACT_NAME)) | length')

  if [ "$ARTIFACT_EXISTS" -gt 0 ]; then
    echo "Run ID for Workflow $WORKFLOW_NAME with Artifact $ARTIFACT_NAME: $RUN_ID"
    break
  fi
done

