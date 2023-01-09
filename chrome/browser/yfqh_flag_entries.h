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

    {"hide-sidepanel-button",
     "Hide Side Panel Button",
     "Hides the Side Panel Button.",
     kOsDesktop, SINGLE_VALUE_TYPE("hide-sidepanel-button")},

#endif  // CHROME_BROWSER_THORIUM_FLAG_ENTRIES_H_