#!/bin/bash

REPO_OWNER="upendraddev"
REPO_NAME="azuredev"
WORKFLOW_NAME="test-ssla-certs"
ARTIFACT_NAME="SO-Files"
FILE_TYPE=".csv"  # Specify the file type you are looking for



# Get all workflow run IDs for the specified workflow

# Set the GitHub API URL for workflow runs
RUN_ID=$(curl -s -H "Authorization: Bearer $TOKEN" \
  "https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/actions/workflows/$WORKFLOW_NAME/runs" \
  | jq -r '.workflow_runs[0].id')

echo "Latest Run ID for Workflow $WORKFLOW_NAME: $RUN_ID"

#echo "$RUN_IDS"
# RUN_IDS ="7677620182,7691725319,7677580437"
# 
for RUN_ID in "${RUN_IDS}"; do
  echo "$RUN_ID"
  # Get artifact information for a specific run
  API_URL="https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/actions/runs/$RUN_ID/artifacts"

  # Use curl to retrieve workflow runs
  response2=$(curl -s -H "Authorization: Bearer $GITHUB_TOKEN" $API_URL)
  #echo "$response2"

  # Extract artifact ID and name from the response
  ARTIFACT_ID=$(echo "$response2" | jq -r '.artifacts[0].id')
  ARTIFACT_NAME=$(echo "$response2" | jq -r '.artifacts[0].name')
  
  if [ "$ARTIFACT_ID" != "null" ] && [ "$ARTIFACT_NAME" != "null" ]; then
      echo "Artifact ID: $ARTIFACT_ID"
      echo "Artifact Name: $ARTIFACT_NAME"
  fi
    # Download the artifact as a zip file
    # curl -L -o "artifact.zip" -H "Authorization: Bearer $GITHUB_TOKEN" \
    # "https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/actions/artifacts/$ARTIFACT_ID/zip"
    # sudo apt-get install unzip
    
    # Unzip the downloaded artifact
    # unzip -j "artifact.zip" "*$FILE_TYPE"  -d "extracted_artifact_$artifact"

    # mv "extracted_artifact_$artifact" "./testssl"
    # Move or process the specific file as needed


    # Optionally, remove the downloaded zip file
    # rm "artifact.zip"
done

