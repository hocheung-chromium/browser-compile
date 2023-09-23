// Copyright (c) 2023 Cheung_yfqh. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef CHROME_BROWSER_YFQH_FLAG_CHOICES_H_
#define CHROME_BROWSER_YFQH_FLAG_CHOICES_H_

const FeatureEntry::Choice kCloseConfirmation[] = {
    {flags_ui::kGenericExperimentChoiceDefault, "", ""},
    {"Show confirmation with last window",
     "close-confirmation",
     "last"},
    {"Show confirmation with multiple windows",
     "close-confirmation",
     "multiple"},
};

const FeatureEntry::Choice kCloseWindowWithLastTab[] = {
    {flags_ui::kGenericExperimentChoiceDefault, "", ""},
    {"Never",
     "close-window-with-last-tab",
     "never"},
};

const FeatureEntry::Choice kScrollEventChangesTab[] = {
    {flags_ui::kGenericExperimentChoiceDefault, "", ""},
    {"Always",
     "scroll-tabs",
     "always"},
    {"Never",
     "scroll-tabs",
     "never"}
};

#endif  // CHROME_BROWSER_YFQH_FLAG_CHOICES_H_