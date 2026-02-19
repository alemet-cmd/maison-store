#!/bin/bash
# ============================================================
# MAISON Demo Store — Launcher
# Double-click this file to start the store in your browser.
# ============================================================

# Move to the folder where this script lives
cd "$(dirname "$0")"

PORT=8080

# Check if port is already in use
if lsof -Pi :$PORT -sTCP:LISTEN -t >/dev/null 2>&1; then
  echo "Port $PORT is already in use. Opening existing server..."
  xdg-open "http://localhost:$PORT"
  exit 0
fi

# Start Python's built-in HTTP server in the background
echo "Starting MAISON store on http://localhost:$PORT ..."
python3 -m http.server $PORT &
SERVER_PID=$!

# Wait a moment for the server to start
sleep 1

# Open the browser
xdg-open "http://localhost:$PORT"

echo ""
echo "Store is running at: http://localhost:$PORT"
echo "Close this window to stop the server."
echo ""

# Wait for the server process (keep this terminal open)
wait $SERVER_PID
