#
# Copyright (C) 2026 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from chongqing device
$(call inherit-product, device/realme/chongqing/device.mk)

PRODUCT_NAME := lineage_chongqing
PRODUCT_DEVICE := chongqing
PRODUCT_MANUFACTURER := realme
PRODUCT_BRAND := realme
PRODUCT_MODEL := RMX3780

PRODUCT_GMS_CLIENTID_BASE := android-realme

PRODUCT_BUILD_PROP_OVERRIDES += \
    BuildDesc="RMX3780EEA-user 14 UKQ1.230924.001 T.R4T2.1c3c35a-7ad3-7ad4 release-keys" \
    BuildFingerprint=realme/RMX3780EEA/RE5C6CL1:14/UKQ1.230924.001/T.R4T2.1c3c35a-7ad3-7ad4:user/release-keys \
    DeviceName=RE5C6CL1 \
    DeviceProduct=RMX3780 \
    SystemDevice=RE5C6CL1 \
    SystemName=RMX3780
