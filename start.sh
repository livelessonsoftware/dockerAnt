#!/bin/bash
set -e

echo "Starting Ant Media Server..."
exec /usr/local/antmedia/start.sh
stat /usr/local/antmedia/start.sh

