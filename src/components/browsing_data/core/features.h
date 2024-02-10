// Copyright 2019 The Chromium Authors
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef COMPONENTS_BROWSING_DATA_CORE_FEATURES_H_
#define COMPONENTS_BROWSING_DATA_CORE_FEATURES_H_

#include "base/feature_list.h"

namespace browsing_data::features {

BASE_DECLARE_FEATURE(kClearDataOnExit);

// Enable BrowsingDataLifetimeManager that periodically delete browsing data as
// defined by the BrowsingDataLifetime policy.
BASE_DECLARE_FEATURE(kEnableBrowsingDataLifetimeManager);

// Deprecate CookiesTReeModel and use BrowsingDataModel as the only browsing
// data interface.
BASE_DECLARE_FEATURE(kDeprecateCookiesTreeModel);
}  // namespace browsing_data::features

#endif  // COMPONENTS_BROWSING_DATA_CORE_FEATURES_H_
