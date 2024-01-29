#!/bin/bash


REPO_OWNER="upendraddev"
REPO_NAME="azuredev"
RUN_ID="7677620182"
ARTIFACT_NAME="SO-Files"
CSV_FILE_NAME="./20240127090347-SO_Outputs.csv"

# Get artifact information for a specific run
ARTIFACT_INFO=$(curl -s -H "Authorization: Bearer $GITHUB_TOKEN" \
  "https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/actions/runs/$RUN_ID/artifacts")

# Extract artifact ID and name from the response
ARTIFACT_ID=$(echo "$ARTIFACT_INFO" | jq -r '.artifacts[0].id')
ARTIFACT_NAME=$(echo "$ARTIFACT_INFO" | jq -r '.artifacts[0].name')

echo "Artifact ID: $ARTIFACT_ID"
echo "Artifact Name: $ARTIFACT_NAME"

# Download the artifact as a zip file
curl -L -o "artifact.zip" -H "Authorization: Bearer $GITHUB_TOKEN" \
  "https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/actions/artifacts/$ARTIFACT_ID/zip"



# Extract the CSV file from the zip archive
#unzip -j "artifact.zip" "$ARTIFACT_NAME/$CSV_FILE_NAME" -d "./"


# Unzip the downloaded artifact
unzip "$artifact.zip" -d "extracted_artifact_$artifact"

# Move or process the specific file as needed
mv "extracted_artifact_$artifact/$CSV_FILE_NAME" "./utils"



# Optionally, remove the downloaded zip file
rm "artifact.zip"
