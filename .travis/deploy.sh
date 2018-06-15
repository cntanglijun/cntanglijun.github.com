#!/bin/bash

# see https://gist.github.com/domenic/ec8b0fc8ab45f39403dd
# Exit with nonzero exit code if anything fails
set -e

SOURCE_BRANCH="ryuu"
TARGET_BRANCH="master"

# Save some useful information
REPO=`git config remote.origin.url`
SSH_REPO=${REPO/https:\/\/github.com\//git@github.com:}
SHA=`git rev-parse --verify HEAD`

# Get the deploy key by using Travis's stored variables to decrypt deploy_key.enc
ENCRYPTED_KEY_VAR="encrypted_${ENCRYPTION_LABEL}_key"
ENCRYPTED_IV_VAR="encrypted_${ENCRYPTION_LABEL}_iv"
ENCRYPTED_KEY=${!ENCRYPTED_KEY_VAR}
ENCRYPTED_IV=${!ENCRYPTED_IV_VAR}
openssl aes-256-cbc -K $ENCRYPTED_KEY -iv $ENCRYPTED_IV -in .travis/deploy_key.enc -out ~/.ssh/deploy_key -d

# Set the permission of the key
chmod 600 ~/.ssh/deploy_key

# Start SSH agent
eval `ssh-agent -s`

# Add the private key to the system
ssh-add ~/.ssh/deploy_key

# Build site
npm run build

# Set some git options
mkdir .deploy
cd .deploy
git init
git config --global user.name $COMMIT_AUTHOR_NAME
git config --global user.email $COMMIT_AUTHOR_EMAIL
git remote add origin $SSH_REPO
git fetch -p
git checkout -q $TARGET_BRANCH || git checkout --orphan $TARGET_BRANCH

# Copy deploy files to .deploy
cd ..
cp -r public/* .deploy
cd .deploy

# Commit the "changes", i.e. the new version
git add .
git commit -q -m "Update site"

# Now that we're all set up, we can deploy
git push origin $TARGET_BRANCH

# Remove .deploy
cd ..
rm -rf .deploy
