#!/bin/bash

REPO_OWNER="upendraddev"
REPO_NAME="azuredev"
WORKFLOW_NAME="test-ssla-certs"
ARTIFACT_NAME="SO-Files"
FILE_TYPE=".csv"  # Specify the file type you are looking for

# Get all workflow run IDs for the specified workflow
RUN_IDS=$(curl -s -H "Authorization: Bearer $GITHUB_TOKEN" "https://api.github.com/repos/${REPO_OWNER}/${REPO_NAME}/actions/workflows/runs?workflow=${WORKFLOW_NAME}" | jq -r '.workflow_runs[].id')

# Loop through each run ID and download the artifact if it contains a CSV file
for RUN_ID in $RUN_IDS; do
  # Get the download URL for the artifact
  DOWNLOAD_URL=$(curl -s -H "Authorization: Bearer $GITHUB_TOKEN" \
    "https://api.github.com/repos/${REPO_OWNER}/${REPO_NAME}/actions/runs/$RUN_ID/artifacts/$ARTIFACT_NAME" \
    | jq -r '.archive_download_url')

  # Download the artifact as a zip file
  curl -L -o "artifact.zip" "$DOWNLOAD_URL"

  # Extract CSV files from the zip archive and store in a directory
  unzip -j "artifact.zip" "*$FILE_TYPE" -d "./$RUN_ID"

  # Optionally, you can remove the downloaded zip file
  rm "artifact.zip"
done
