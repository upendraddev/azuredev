#!/bin/bash


: $1 $2 $3 $4

REPO_OWNER=$1
REPO_NAME=$2
ARTIFACT_NAME=$3
FILE_TYPE=$4

# Get artifact information for a specific run
ARTIFACT_INFO=$(curl -s -H "Authorization: Bearer $GITHUB_TOKEN" \
  "https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/actions/runs/$RUN_ID/artifacts")

# Extract artifact ID and name from the response
ARTIFACT_ID=$(echo "$ARTIFACT_INFO" | jq -r '.artifacts[0].id')
ARTIFACT_NAME=$(echo "$ARTIFACT_INFO" | jq -r '.artifacts[0].name')

if [ "$ARTIFACT_ID" != "null" ] && [ "$ARTIFACT_NAME" != "null" ]; then
    echo "Artifact ID: $ARTIFACT_ID"
    echo "Artifact Name: $ARTIFACT_NAME"
fi
# Download the artifact as a zip file
curl -L -o "artifact.zip" -H "Authorization: Bearer $GITHUB_TOKEN" \
  "https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/actions/artifacts/$ARTIFACT_ID/zip"

# Unzip the downloaded artifact
unzip -j "artifact.zip" "*$FILE_TYPE"  -d "extracted_artifact_$artifact"

mv "extracted_artifact_$artifact" "./opsjob"
# Move or process the specific file as needed


# Optionally, remove the downloaded zip file
rm "artifact.zip"
