#!/bin/bash
# ============================================================
# MAISON Demo Store — Launcher (macOS)
# Double-click this file to start the store in your browser.
# ============================================================

# Move to the folder where this script lives
cd "$(dirname "$0")"

PORT=8080

# Check if port is already in use
if lsof -Pi :$PORT -sTCP:LISTEN -t >/dev/null 2>&1; then
  echo "Port $PORT is already in use. Opening existing server..."
  open "http://localhost:$PORT"
  exit 0
fi

# Check Python 3 is available
if ! command -v python3 &>/dev/null; then
  echo "Python 3 is not installed. Please install it from https://www.python.org"
  exit 1
fi

# Start Python's built-in HTTP server in the background
echo "Starting MAISON store on http://localhost:$PORT ..."
python3 -m http.server $PORT &
SERVER_PID=$!

# Wait a moment for the server to start
sleep 1

# Open the browser (macOS command)
open "http://localhost:$PORT"

echo ""
echo "Store is running at: http://localhost:$PORT"
echo "Close this window to stop the server."
echo ""

# Keep terminal open until server is stopped
wait $SERVER_PID
