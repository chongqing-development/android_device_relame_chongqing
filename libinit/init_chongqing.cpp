//
// Copyright (C) 2024-2025 The LineageOS Project
//
// SPDX-License-Identifier: Apache-2.0
//

#include <fcntl.h>
#include <fstream>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/stat.h>
#include <sys/types.h>

#include <android-base/file.h>
#include <android-base/logging.h>
#include <android-base/properties.h>
#include <android-base/strings.h>

#define _REALLY_INCLUDE_SYS__SYSTEM_PROPERTIES_H_
#include <sys/_system_properties.h>

#include "vendor_init.h"
#include "property_service.h"

using android::base::ReadFileToString;
using android::base::Trim;
using std::string;

std::vector<string> ro_props_default_source_order = {
    "",
    "bootimage.",
    "odm.",
    "product.",
    "system.",
    "system_ext.",
    "vendor.",
};

void property_override(const char* prop, const char* value, bool add = true) {
    prop_info* pi = (prop_info*)__system_property_find(prop);
    if (pi)
        __system_property_update(pi, value, strlen(value));
    else if (add)
        __system_property_add(prop, strlen(prop), value, strlen(value));
}

void set_ro_build_prop(const string& prop, const string& value, bool product = true) {
    string prop_name;

    for (const auto& source : ro_props_default_source_order) {
        if (product)
            prop_name = "ro.product." + source + prop;
        else
            prop_name = "ro." + source + "build." + prop;

        property_override(prop_name.c_str(), value.c_str());
    }
}

void vendor_load_properties() {
    const char* prj_file = "/proc/oplusVersion/prjName";

    string prj_name;
    string device;
    string model;
    string name;

    if (ReadFileToString(prj_file, &prj_name)) {
        prj_name = Trim(prj_name);

        if (prj_name == "23604" || prj_name == "23660" || prj_name == "23661" || prj_name == "23670" || prj_name == "23671") {
            device = "RE5C6CL1";
            if (prj_name == "23604") {
                // realme narzo 60x 5G / realme c67
                model = "RMX3782";
                name = "RMX3782";
            } else if (prj_name == "23660" || prj_name == "23661") {
                // realme 11 5g
                model = "RMX3780";
                name = "RMX3780";
            } else if (prj_name == "23670" || prj_name == "23671") {
                // realme 11x 5g
                model = "RMX3785";
                name = "RMX3785";
            }
        }

        else if (prj_name == "23605" || prj_name == "23606") {
            device = "RE5C34";
            if (prj_name == "23606") {
                // realme v50s
                model = "RMX3781";
                name = "RMX3781";
            } else {
                // realme v50
                model = "RMX3783";
                name = "RMX3783";
            }
        }

        else {
            LOG(WARNING) << "Unknown prjName: " << prj_name;
        }
    } else {
        LOG(ERROR) << "Unable to read prjName from " << prj_file;
        return;
    }

    // Product props
    set_ro_build_prop("device", device);
    set_ro_build_prop("model", model);
    set_ro_build_prop("name", name);

    // ro.build.product
    set_ro_build_prop("product", name, false);

    // Optional vendor props
    property_override("ro.vendor.device", device.c_str());
    property_override("ro.vendor.product.device", device.c_str());

}
