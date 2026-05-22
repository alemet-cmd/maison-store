#!/bin/bash
# ============================================================
#  MAISON Demo Store — Launcher (Linux)
#  Double-click this file to start the store in your browser.
# ============================================================

# --- 1. Locate this script's own folder (works wherever it is) ---
SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
cd "$SCRIPT_DIR"

# --- 2. Find a FREE port, starting at 8080 ---
#     We never reuse a port we don't own. If 8080 is taken by
#     anything else, we move up until we find a free one. This
#     guarantees the browser always opens OUR store, never a
#     stranger's server (which is what caused the old 404).
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

# --- 3. Start OUR server on the free port ---
echo "Starting MAISON store on http://localhost:$PORT ..."
python3 -m http.server "$PORT" --directory "$SCRIPT_DIR" &
SERVER_PID=$!

# --- 4. Open the browser on the correct port ---
sleep 1
xdg-open "http://localhost:$PORT" >/dev/null 2>&1

echo ""
echo "Store is running at: http://localhost:$PORT"
echo "Close this window to stop the server."
echo ""
wait $SERVER_PID
