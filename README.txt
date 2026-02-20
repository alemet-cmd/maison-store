================================================================
  MAISON — Demo Store
  For internal use only — Doofinder integration testing
================================================================

WHAT IS THIS?
-------------
A fully functional fashion demo store you can run locally on
your laptop. Use it to test Doofinder installation, script
injection, CSS customisation, and category behaviour.

NOTE: When you download the ZIP from GitHub, the folder will be
named "maison-store-main". This is normal. Just unzip and use it
as described below.

----------------------------------------------------------------
GETTING STARTED — MAC
----------------------------------------------------------------

STEP 1 — Make the launcher executable (first time only)
Open Terminal and run:
  chmod +x /path/to/maison-store-main/START_STORE_MAC.sh
Replace /path/to/maison-store-main with the actual folder path.

STEP 2 — Start the store
Double-click START_STORE_MAC.sh
Your browser will open automatically at: http://localhost:8080

To stop the store: close the Terminal window that opened.

----------------------------------------------------------------
GETTING STARTED — LINUX
----------------------------------------------------------------

STEP 1 — Make the launcher executable (first time only)
Right-click START_STORE.sh → Properties → Permissions tab
→ tick "Allow executing file as program"

STEP 2 — Start the store
Double-click START_STORE.sh
Your browser will open automatically at: http://localhost:8080

To stop the store: close the Terminal window that opened.

----------------------------------------------------------------
HOW TO INJECT YOUR DOOFINDER SCRIPT
----------------------------------------------------------------

1. Open js/doofinder.js in any text editor

2. Find this line:
   var DOOFINDER_STORE_ID = "";

3. Go to your Doofinder Admin Panel and copy your Store ID.
   It looks like: 76670189-511f-4a57-b019-73834825ff75

4. Paste it between the quotes:
   var DOOFINDER_STORE_ID = "76670189-511f-4a57-b019-73834825ff75";

5. Save the file.

6. In your Doofinder Admin Panel, configure the search input selector:
   Go to your Search Engine → Layer Settings → Configure your Layer
   Set the CSS Selector to: input.search

7. Add localhost to your authorized domains:
   Go to Configuration → General Settings → Security
   Add "localhost" to the allowed domains list and save.

8. Hard refresh your browser: Cmd+Shift+R (Mac) or Ctrl+Shift+R (Linux)
   Doofinder is now active on every page of the store.

----------------------------------------------------------------
HOW TO UPLOAD THE PRODUCT FEED TO DOOFINDER
----------------------------------------------------------------

1. Log in to your Doofinder Admin Panel at https://admin.doofinder.com
2. Go to your Search Engine → Data Sources
3. Upload the file: DOOFINDER_FEED.csv (located in the root folder)
4. Start indexing

The feed contains 798 products with id, title, description,
price, category, image, availability, color, size and gender.

----------------------------------------------------------------
STORE STRUCTURE
----------------------------------------------------------------

maison-store-main/
├── START_STORE_MAC.sh      ← Mac: double-click to launch
├── START_STORE.sh          ← Linux: double-click to launch
├── DOOFINDER_FEED.csv      ← Upload to Doofinder admin
├── README.txt              ← This file
├── js/
│   ├── doofinder.js        ← Paste your Doofinder Store ID here
│   └── store.js            ← All 798 products
├── index.html              ← Homepage
├── category/
│   ├── women.html          → http://localhost:8080/category/women.html
│   ├── men.html            → http://localhost:8080/category/men.html
│   ├── accessories.html    → http://localhost:8080/category/accessories.html
│   ├── shoes.html          → http://localhost:8080/category/shoes.html
│   └── sale.html           → http://localhost:8080/category/sale.html
└── product/
    └── detail.html         → http://localhost:8080/product/detail.html?id=w1

----------------------------------------------------------------
TROUBLESHOOTING
----------------------------------------------------------------

"Browser doesn't open automatically"
  → Open your browser manually and go to http://localhost:8080

"Port already in use" error
  → Mac: run this in Terminal: kill $(lsof -t -i:8080)
  → Linux: run this in Terminal: fuser -k 8080/tcp
  → Then double-click the launcher again

"Doofinder script not loading"
  → Make sure you pasted ONLY the Store ID (not the full URL)
  → Make sure you saved doofinder.js after editing
  → Hard refresh: Cmd+Shift+R (Mac) or Ctrl+Shift+R (Linux)

"Store doesn't load / localhost not working"
  → Check the folder for an Output subfolder and delete it
  → Do NOT launch the store from a VS Code terminal
  → Close VS Code completely and double-click the launcher directly

----------------------------------------------------------------
  Questions? Contact your Doofinder technical team.
================================================================
