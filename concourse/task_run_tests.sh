#!/bin/bash

set -e # fail fast
# set -x # print commands for debugging

# Get the cf application name from the manifest file
appname=$(grep 'name:' ci-project/manifest.yml | awk '{print $3}')

# Connect to cf
cf login -a $api -u $username -p $password -o $organization -s $space

# open SSH connection to app container and run tests
echo .
echo "SSH to application $appname ..."
echo .
cf ssh $appname -c "set -e && 
set -x && 
export PATH=$PATH:/home/vcap/deps/0/node/bin/ && 
alias npm='node /home/vcap/deps/0/node/lib/node_modules/npm/bin/npm-cli.js' && 
node --version && 
npm --version && 
cd app/ && 
npm install --only=dev && 
npm test"