// ============================================================
// DOOFINDER CONFIGURATION
// ============================================================
// 1. Copy your Doofinder script src URL
//    It looks like: https://eu1-config.doofinder.com/2.x/YOUR-KEY.js
//
// 2. Paste ONLY the URL between the quotes below (replace the empty string)
//
// 3. Save the file and refresh your browser. Done!
// ============================================================

var DOOFINDER_SCRIPT_URL = "https://eu1-config.doofinder.com/2.x/xxxx-xxx-xxxx-xxxx-xxxxxxxx.js"; // <- PASTE YOUR URL HERE

// Do not edit below this line
if (DOOFINDER_SCRIPT_URL) {
  var df = document.createElement('script');
  df.src = DOOFINDER_SCRIPT_URL;
  df.async = true;
  document.head.appendChild(df);
}
