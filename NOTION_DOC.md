# Demo Store — MAISON

**Priority:** Medium
**Status:** Ready
**Owner:** Alexandre Somet

---

## Context

### Before
- A single static HTML page was used for demos — very limited
- Required manual setup for each salesperson
- Demos frequently broke, requiring support intervention

### After
Each salesperson can set up their own local demo store with categories,
navigation, product feed, and Doofinder integration — fully managed
by the salesperson themselves.

---

## Setup Process

### Step 1 — Download the store

Download the ZIP from GitHub:
👉 https://github.com/alemet-cmd/maison-store

Click **Code → Download ZIP**

> The downloaded folder will be named **maison-store-main** — this is normal.

Unzip it on your Desktop and delete the ZIP file.

---

### Step 2 — Create a Search Engine in Doofinder Admin

Go to https://admin.doofinder.com and create a new Search Engine:

**First screen:**
- Store URL: `https://www.doofinder.com`
- Platform: Other
- Sector: Other

**Second screen:**
- Products sold in a store
- Upload a file or use a feed URL
- Upload the file **DOOFINDER_FEED.csv** from the `maison-store-main` folder

**Third screen:**
- Your Doofinder script will appear — copy the **Store ID** from it
- It looks like: `76670189-511f-4a57-b019-73834825ff75`

---

### Step 3 — Inject the Doofinder Script

1. Open the folder `maison-store-main` → `js` → open `doofinder.js` in any text editor
2. Find this line:
var DOOFINDER_STORE_ID = "";
3. Paste your Store ID between the quotes:
var DOOFINDER_STORE_ID = "76670189-511f-4a57-b019-73834825ff75";
4. Save the file

---

### Step 4 — Start the Store

**Mac:**
chmod +x /path/to/maison-store-main/START_STORE_MAC.sh
Then double-click `START_STORE_MAC.sh`

**Linux:**
Right-click `START_STORE.sh` → Properties → Permissions → tick "Allow executing as program"
Then double-click `START_STORE.sh`

Your browser will open at: **http://localhost:8080**

---

### Step 5 — Configure Doofinder Layer

1. Set the search input CSS selector:
   **Layer Settings → Configure your Layer → CSS Selector:** `input.search`

2. Add localhost to authorized domains:
   **Configuration → General Settings → Security → add** `localhost`

3. Hard refresh the browser: `Cmd+Shift+R` (Mac) or `Ctrl+Shift+R` (Linux)

✅ Doofinder is now active on every page of the store.

---

## Troubleshooting

| Problem | Solution |
|---|---|
| Browser doesn't open | Go to http://localhost:8080 manually |
| Port already in use | Mac: `kill $(lsof -t -i:8080)` / Linux: `fuser -k 8080/tcp` |
| Doofinder not loading | Check Store ID is correct, file is saved, hard refresh |
| Store doesn't load | Delete any Output subfolder, don't use VS Code terminal |

---

## Store Contents

- **798 products** across 5 categories: Women, Men, Accessories, Shoes, Sale
- **Real URLs** per category: `/category/women.html`, `/category/men.html`, etc.
- **Product detail pages** with related products and Add to Cart
- **Persistent cart** across page navigation
- **Doofinder-ready search input** (`input.search`) in every page
- **CSV product feed** with color, size, gender attributes ready to upload
