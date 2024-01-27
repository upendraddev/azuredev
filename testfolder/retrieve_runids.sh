#!/bin/bash

# Set the repository owner and name
REPO_OWNER="upendraddev"
REPO_NAME="azuredev"

# Set the workflow run ID for which you want to retrieve artifacts
WORKFLOW_RUN_ID="7677580437"

# Set the name of the artifact you want to download
ARTIFACT_NAME="SO-Files"

# Set the path to the specific file within the artifact
SPECIFIC_FILE_PATH="./*SO_Outputs.csv"

# Set the Personal Access Token (PAT)
#GITHUB_TOKEN="your-personal-access-token"

# Set the GitHub API URL for artifacts
API_URL="https://api.github.com/repos/${REPO_OWNER}/${REPO_NAME}/actions/runs/${WORKFLOW_RUN_ID}/artifacts"

# Use curl to retrieve artifact information
response=$(curl -s -H "Authorization: Bearer $GITHUB_TOKEN" $API_URL)

# Extract artifact ID based on the provided artifact name
artifact_id=$(echo "$response" | jq -r ".artifacts[] | select(.name == \"$ARTIFACT_NAME\") | .id")

if [ -z "$artifact_id" ]; then
  echo "Artifact with name '$ARTIFACT_NAME' not found."
  exit 1
fi

# Download the entire artifact as a zip file
ARTIFACT_URL="https://api.github.com/repos/${REPO_OWNER}/${REPO_NAME}/actions/artifacts/$artifact_id/zip"
curl -L -o "artifact_$artifact_id.zip" -H "Authorization: Bearer $GITHUB_TOKEN" $ARTIFACT_URL

# Unzip the downloaded artifact
unzip "artifact_$artifact_id.zip" -d "extracted_artifact_$artifact_id"

# Move or process the specific file as needed
mv "extracted_artifact_$artifact_id/$SPECIFIC_FILE_PATH" "desired-destination-directory"

# Clean up: remove downloaded zip file and extracted directory
rm "artifact_$artifact_id.zip"
rm -rf "extracted_artifact_$artifact_id"
