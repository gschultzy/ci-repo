#!/bin/bash

set -e # fail fast
set -x # print commands

# Show resource directories
ls -al ci-repo/concourse
ls -al ci-project/

# Check node and npm versions
node --version
nodejs --version
npm --version

# Setup app dependencies
cd ci-project/
npm install

# Check node and npm versions
node --version
nodejs --version
npm --version

# Install forever tool and start web app in background
npm install forever -g
forever start app/server.js
forever list

# Pause for server to app to start
sleep 5

# Run unit and intergartion tests
npm test