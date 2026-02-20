// ============================================================
// DOOFINDER CONFIGURATION
// ============================================================
// 1. Go to your Doofinder Admin Panel
// 2. Copy your Store ID (looks like: 76670189-511f-4a57-b019-73834825ff75)
// 3. Paste it between the quotes below
// 4. Save the file and refresh your browser. Done!
// ============================================================

var DOOFINDER_STORE_ID = ""; // <- PASTE YOUR STORE ID HERE

// Do not edit below this line
if (DOOFINDER_STORE_ID) {
  var df = document.createElement('script');
  df.src = "https://eu1-config.doofinder.com/2.x/" + DOOFINDER_STORE_ID + ".js";
  df.async = true;
  document.head.appendChild(df);
}
