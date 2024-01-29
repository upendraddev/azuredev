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
    # Get the download URL for the artifact
    DOWNLOAD_URL=$(curl -s -H "Authorization: Bearer $TOKEN" \
    "https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/actions/runs/$RUN_ID/artifacts/$ARTIFACT_NAME" \
    | jq -r '.archive_download_url')

    echo "$DOWNLOAD_URL"
    # Download the artifact as a zip file
    #curl -L -o "artifact.zip" "$DOWNLOAD_URL"

    # Extract CSV files from the zip archive and store in a directory
    #unzip -j "artifact.zip" "*$FILE_TYPE" -d "./"

    # Optionally, you can remove the downloaded zip file
    #rm "artifact.zip"
done

