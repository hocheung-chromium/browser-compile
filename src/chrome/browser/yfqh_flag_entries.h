// Copyright (c) 2023 Cheung_yfqh. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef CHROME_BROWSER_YFQH_FLAG_ENTRIES_H_
#define CHROME_BROWSER_YFQH_FLAG_ENTRIES_H_

    {"clear-data-on-exit",
     "Clear data on exit",
     "Clears all browsing data on exit.",
     kOsDesktop, FEATURE_VALUE_TYPE(browsing_data::features::kClearDataOnExit)},

    {"close-window-with-last-tab",
     "Close window with last tab",
     "Determines whether a window should close once the last tab is closed.",
     kOsDesktop, MULTI_VALUE_TYPE(kCloseWindowWithLastTab)},

    {"close-confirmation",
     "Close Confirmation",
     "Show a warning prompt when closing the browser window.",
     kOsDesktop, MULTI_VALUE_TYPE(kCloseConfirmation)},

    {"custom-ntp",
     "Custom New Tab Page",
     "Allows setting a custom URL for the new tab page. Value can be internal (e.g. `about:blank` or `chrome://new-tab-page`), external (e.g. `example.com`), or local (e.g. `file:///tmp/startpage.html`). This applies for incognito windows as well when not set to a `chrome://` internal page.",
     kOsDesktop, ORIGIN_LIST_VALUE_TYPE("custom-ntp", "")},

    {"disable-encryption",
     "Disable encryption",
     "Disables encryption of cookies, passwords, and settings which uses a generated machine-specific encryption key. This is used to enable portable user data directories.",
     kOsWin, SINGLE_VALUE_TYPE("disable-encryption")},

    {"disable-machine-id",
     "Disable machine ID",
     "Disables use of a generated machine-specific ID to lock the user data directory to that machine. This is used to enable portable user data directories.",
     kOsWin, SINGLE_VALUE_TYPE("disable-machine-id")},
    
    {"double-click-close-tab",
     "Double Click to Close Tab",
     "Enables double clicking a tab to close it.",
     kOsDesktop, SINGLE_VALUE_TYPE("double-click-close-tab")},

     {"enable-incognito-themes",
     "Enable themes in Incognito mode",
     "Allows themes to override Google's built-in Incognito theming.",
     kOsDesktop, SINGLE_VALUE_TYPE("enable-incognito-themes")},

    {"hide-sidepanel-button",
     "Hide SidePanel Button",
     "Hides the SidePanel Button.",
     kOsDesktop, SINGLE_VALUE_TYPE("hide-sidepanel-button")},

    {"scroll-tabs",
     "Scroll switches tab",
     "Switch to the left/right tab if the wheel-scroll happens over the tabstrip, or the empty space beside the tabstrip.",
     kOsDesktop, MULTI_VALUE_TYPE(kScrollEventChangesTab)},

#endif  // CHROME_BROWSER_YFQH_FLAG_ENTRIES_H_
