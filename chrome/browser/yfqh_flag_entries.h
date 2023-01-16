// Copyright (c) 2023 Cheung_yfqh. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef CHROME_BROWSER_YFQH_FLAG_ENTRIES_H_
#define CHROME_BROWSER_YFQH_FLAG_ENTRIES_H_

    {"close-window-with-last-tab",
     "Close window with last tab",
     "Determines whether a window should close once the last tab is closed.",
     kOsDesktop, MULTI_VALUE_TYPE(kCloseWindowWithLastTab)},

    {"close-confirmation",
     "Close Confirmation",
     "Show a warning prompt when closing the browser window.",
     kOsDesktop, MULTI_VALUE_TYPE(kCloseConfirmation)},

#endif  // CHROME_BROWSER_THORIUM_FLAG_ENTRIES_H_
