================================================================
  MAISON — Demo Store
  For internal use only — Doofinder integration testing
================================================================

WHAT IS THIS?
-------------
A fully functional fashion demo store you can run locally on
your laptop. Use it to test Doofinder installation, script
injection, CSS customisation, and category behaviour.

----------------------------------------------------------------
GETTING STARTED — MAC
----------------------------------------------------------------

STEP 1 — Make the launcher executable (first time only)
Open Terminal and run:
  chmod +x /path/to/maison-store/START_STORE_MAC.sh
Replace /path/to/maison-store with the actual folder location.

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
   var DOOFINDER_SCRIPT_URL = "";

3. Paste ONLY the URL from your Doofinder script between the quotes.
   Your Doofinder script looks like this:
   <script src="https://eu1-config.doofinder.com/2.x/YOUR-KEY.js" async></script>

   Copy only the URL part:
   https://eu1-config.doofinder.com/2.x/YOUR-KEY.js

   So the line should look like:
   var DOOFINDER_SCRIPT_URL = "https://eu1-config.doofinder.com/2.x/YOUR-KEY.js";

4. Save the file and refresh your browser.
   The script now loads automatically on every page.

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

maison-store/
├── START_STORE_MAC.sh      ← Mac: double-click to launch
├── START_STORE.sh          ← Linux: double-click to launch
├── DOOFINDER_FEED.csv      ← Upload to Doofinder admin
├── README.txt              ← This file
├── js/
│   ├── doofinder.js        ← Paste your Doofinder URL here
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
  → Run this in Terminal: kill $(lsof -t -i:8080)
  → Then double-click the launcher again

"Doofinder script not loading"
  → Make sure you pasted ONLY the URL (no <script> tags)
  → Make sure you saved the file after editing
  → Hard refresh the browser: Cmd+Shift+R (Mac) or Ctrl+Shift+R (Linux)

----------------------------------------------------------------
  Questions? Contact your Doofinder technical team.
================================================================
