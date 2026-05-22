#!/bin/bash
# ============================================================
#  MAISON Demo Store — Launcher (macOS)
#  Double-click this file to start the store in your browser.
# ============================================================

# --- 1. Locate this script's own folder (absolute path) ---
#     Note: macOS does not support `readlink -f`, so we use the
#     portable `cd ... && pwd` approach instead.
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

# --- 2. Check Python 3 is available ---
if ! command -v python3 &>/dev/null; then
    echo "Python 3 is not installed. Please install it from https://www.python.org"
    read -n 1 -s -r -p "Press any key to close..."
    exit 1
fi

# --- 3. Find a FREE port, starting at 8080 ---
#     We never reuse a port we don't own. If 8080 is taken by
#     anything else, we move up until we find a free one, so the
#     browser always opens OUR store, never a stranger's server.
PORT=8080
MAX_PORT=8090
while lsof -Pi :"$PORT" -sTCP:LISTEN -t >/dev/null 2>&1; do
    echo "Port $PORT is busy — trying the next one..."
    PORT=$((PORT + 1))
    if [ "$PORT" -gt "$MAX_PORT" ]; then
        echo ""
        echo "Could not find a free port between 8080 and $MAX_PORT."
        echo "Please close other local servers, then try again."
        echo ""
        read -n 1 -s -r -p "Press any key to close..."
        exit 1
    fi
done

# --- 4. Start OUR server on the free port ---
echo "Starting MAISON store on http://localhost:$PORT ..."
python3 -m http.server "$PORT" --directory "$SCRIPT_DIR" &
SERVER_PID=$!

# --- 5. Open the browser on the correct port (macOS command) ---
sleep 1
open "http://localhost:$PORT"

echo ""
echo "Store is running at: http://localhost:$PORT"
echo "Close this window to stop the server."
echo ""
wait $SERVER_PID
