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
STEP 1 — MAKE THE LAUNCHER EXECUTABLE (first time only)
----------------------------------------------------------------

1. Right-click on START_STORE.sh
2. Select "Properties"
3. Go to the "Permissions" tab
4. Check the box: "Allow executing file as program"
5. Close the window

Alternatively, open a terminal and run:
   chmod +x START_STORE.sh

You only need to do this ONCE.

----------------------------------------------------------------
STEP 2 — START THE STORE
----------------------------------------------------------------

Double-click START_STORE.sh

Your browser will open automatically at:
   http://localhost:8080

That's it. The store is running.

To stop it: close the terminal window that opened.

----------------------------------------------------------------
STEP 3 — INJECT YOUR DOOFINDER SCRIPT
----------------------------------------------------------------

Each page has a clearly marked placeholder where you paste
your Doofinder script. Open the file in any text editor
(Mousepad, Gedit, VS Code, etc.) and look for:

  <!-- DOOFINDER SCRIPT — PASTE YOUR DOOFINDER SCRIPT BELOW -->

Paste your script there, save the file, and refresh your browser.

Files to edit (one per page):
  • index.html               → Homepage
  • category/women.html      → /category/women
  • category/men.html        → /category/men
  • category/accessories.html→ /category/accessories
  • category/shoes.html      → /category/shoes
  • category/sale.html       → /category/sale
  • product/detail.html      → Any product detail page

TIP: To inject on ALL pages at once, use Find & Replace in
     your text editor across the whole folder.

----------------------------------------------------------------
STORE STRUCTURE
----------------------------------------------------------------

maison-store/
├── START_STORE.sh          ← Start here
├── README.txt              ← This file
├── index.html              ← Homepage
├── js/
│   └── store.js            ← Product data + cart logic
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
  → Manually open your browser and go to http://localhost:8080

"Port already in use" error
  → Another server is running. Either close it, or change the
    PORT=8080 line in START_STORE.sh to another number (e.g. 8081)
    and visit http://localhost:8081 instead.

"Store doesn't load"
  → Make sure START_STORE.sh is still running in the terminal.

----------------------------------------------------------------
  Questions? Contact your Doofinder technical team.
================================================================
