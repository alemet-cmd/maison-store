#!/bin/bash
# ============================================================
# MAISON Demo Store — Launcher (Linux)
# Double-click this file to start the store in your browser.
# ============================================================

# Get the absolute path of this script's directory
SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"

# Move to that directory
cd "$SCRIPT_DIR"

PORT=8080

# Check if port is already in use
if lsof -Pi :$PORT -sTCP:LISTEN -t >/dev/null 2>&1; then
  echo "Port $PORT is already in use. Opening existing server..."
  xdg-open "http://localhost:$PORT"
  exit 0
fi

echo "Starting MAISON store on http://localhost:$PORT ..."
python3 -m http.server $PORT --directory "$SCRIPT_DIR" &
SERVER_PID=$!

sleep 1

xdg-open "http://localhost:$PORT"

echo ""
echo "Store is running at: http://localhost:$PORT"
echo "Close this window to stop the server."
echo ""

wait $SERVER_PID
