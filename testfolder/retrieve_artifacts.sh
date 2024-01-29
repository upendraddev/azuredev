#!/bin/bash

# Set the repository owner and name
REPO_OWNER="upendraddev"
REPO_NAME="azuredev"

# Set the workflow run ID for which you want to retrieve artifacts
#WORKFLOW_RUN_ID="7677580437"
# Set the name of the workflow you want to retrieve run IDs for
WORKFLOW_NAME="test-ssla-certs"
# Set the name of the artifact you want to download
ARTIFACT_NAME="SO-Files"


MAX_RUNS=5

# Get the workflow run IDs using the GitHub API
run_ids=$(curl -s -H "Authorization: Bearer $GITHUB_TOKEN" "https://api.github.com/repos/${REPO_OWNER}/${REPO_NAME}/actions/workflows/runs?workflow=${WORKFLOW_NAME}" | jq -r '.workflow_runs[].id')

for run_id in $run_ids; do
    # Set the GitHub API URL for artifacts
    API_URL="https://api.github.com/repos/${REPO_OWNER}/${REPO_NAME}/actions/runs/${run_id}/artifacts"

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

    # Find all CSV files in the extracted directory
    csv_files=$(find "extracted_artifact_$artifact_id" -type f -name '*.csv')

    if [ -z "$csv_files" ]; then
      echo "No CSV files found in the artifact."
      exit 1
    fi

    # Move or process each CSV file as needed
    for csv_file in $csv_files; do
      mv "$csv_file" "./utils"
    done

    # Clean up: remove downloaded zip file and extracted directory
    rm "artifact_$artifact_id.zip"
    rm -rf "extracted_artifact_$artifact_id"
done

