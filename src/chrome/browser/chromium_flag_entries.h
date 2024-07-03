// Copyright (c) 2024 yfqh. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef CHROMIUM_FLAG_ENTRIES_H_
#define CHROMIUM_FLAG_ENTRIES_H_

#if !BUILDFLAG(IS_ANDROID)
    {"show-component-extension-options",
     "Show Component Extension Options",
     "Shows internal Chromium component extensions on the `chrome://extensions`.",
     kOsDesktop, SINGLE_VALUE_TYPE(extensions::switches::kShowComponentExtensionOptions)},
#endif // BUILDFLAG(IS_ANDROID)

#endif  // CHROMIUM_FLAG_ENTRIES_H_
