#
# Copyright (C) 2026 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/realme/chongqing

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-2a-dotprod
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := cortex-a75
TARGET_CPU_VARIANT_RUNTIME := cortex-a75

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-2a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a55
TARGET_2ND_CPU_VARIANT_RUNTIME := cortex-a55

# Assertation
TARGET_OTA_ASSERT_DEVICE := RE5C6CL1,RE5C34,chongqing

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := k6835v1_64
TARGET_NO_BOOTLOADER := true

# Display
TARGET_SCREEN_DENSITY := 480

# Vintf
ODM_MANIFEST_FILES := $(DEVICE_PATH)/vintf/manifest_odm.xml
DEVICE_MANIFEST_FILE := $(DEVICE_PATH)/vintf/manifest.xml
DEVICE_MATRIX_FILE := $(DEVICE_PATH)/vintf/compatibility_matrix.xml
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE := \
    $(DEVICE_PATH)/vintf/device_framework_matrix.xml \
    hardware/mediatek/vintf/mediatek_framework_compatibility_matrix.xml \
    hardware/oplus/vintf/device_framework_matrix.xml \
    vendor/lineage/config/device_framework_matrix.xml

ODM_MANIFEST_SKUS += nfc
ODM_MANIFEST_NFC_FILES := $(DEVICE_PATH)/vintf/manifest_nfc.xml

# Boot image
BOARD_BOOT_HEADER_VERSION := 4
BOARD_INIT_BOOT_HEADER_VERSION := 4
BOARD_USES_GENERIC_KERNEL_IMAGE := true
BOARD_KERNEL_IMAGE_NAME := Image.lz4
BOARD_RAMDISK_USE_LZ4 := true
BOARD_INCLUDE_DTB_IN_BOOTIMG := true

BOARD_KERNEL_CMDLINE += \
    bootopt=64S3,32N2,64N2 \
    androidboot.init_fatal_reboot_target=recovery

BOARD_DTB_OFFSET := 0x07c88000
BOARD_KERNEL_BASE := 0x3fff8000
BOARD_KERNEL_OFFSET := 0x00008000
BOARD_KERNEL_PAGESIZE := 4096
BOARD_KERNEL_TAGS_OFFSET := 0x07c88000
BOARD_RAMDISK_OFFSET := 0x26f08000

BOARD_MKBOOTIMG_ARGS := --dtb_offset $(BOARD_DTB_OFFSET)
BOARD_MKBOOTIMG_ARGS += --base $(BOARD_KERNEL_BASE)
BOARD_MKBOOTIMG_ARGS += --kernel_offset $(BOARD_KERNEL_OFFSET)
BOARD_MKBOOTIMG_ARGS += --pagesize $(BOARD_KERNEL_PAGESIZE)
BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)
BOARD_MKBOOTIMG_ARGS += --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)

BOARD_MKBOOTIMG_INIT_ARGS += --header_version $(BOARD_INIT_BOOT_HEADER_VERSION)

# Kernel
TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_HEADER_ARCH := arm64
TARGET_KERNEL_SOURCE := kernel/realme/kernel-5.15
TARGET_KERNEL_CLANG_VERSION := r450784e
TARGET_KERNEL_CLANG_PATH := $(abspath .)/prebuilts/clang/host/$(HOST_PREBUILT_TAG)/clang-$(TARGET_KERNEL_CLANG_VERSION)
TARGET_KERNEL_CONFIG := \
	gki_defconfig \
	vendor/mgk_64_k515.config \
    kernel/entry_level.config \
	kernel/oplus6835.config

# Kernel DTB / DTBO
TARGET_NEEDS_DTBOIMAGE := true
TARGET_KERNEL_DTBO := mediatek/dtbo.img
TARGET_KERNEL_DTBO_PREFIX := dts/
TARGET_KERNEL_DTB := \
    mediatek/mt6835.dtb

# Kernel Modules
BOARD_VENDOR_KERNEL_MODULES_LOAD := $(strip $(shell cat $(DEVICE_PATH)/modules/modules.load.vendor))
BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD := $(strip $(shell cat $(DEVICE_PATH)/modules/modules.load.recovery))
BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD := $(strip $(shell cat $(DEVICE_PATH)/modules/modules.load.vendor_ramdisk))
BOOT_KERNEL_MODULES := $(BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD) $(BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD)

TARGET_KERNEL_EXT_MODULE_ROOT := kernel/realme/vendor
TARGET_KERNEL_EXT_MODULES := \
    mediatek/kernel_modules/connectivity/bt/mt66xx/wmt \
    mediatek/kernel_modules/connectivity/common \
    mediatek/kernel_modules/connectivity/connfem \
    mediatek/kernel_modules/connectivity/fmradio \
    mediatek/kernel_modules/connectivity/gps/gps_pwr \
    mediatek/kernel_modules/connectivity/gps/gps_stp \
    mediatek/kernel_modules/connectivity/wlan/adaptor \
    mediatek/kernel_modules/connectivity/wlan/core/gen4m \
    mediatek/kernel_modules/fpsgo_cus \
    mediatek/kernel_modules/met_drv_v3 \
    mediatek/kernel_modules/gpu \
    oplus/kernel/cpu/game_opt \
    oplus/kernel/explorer \
    oplus/kernel/hans \
    oplus/kernel/mm/memleak_detect \
    oplus/kernel/network/data_module \
    oplus/kernel/network/oplus_apps_monitor \
    oplus/kernel/network/oplus_dns_hook \
    oplus/kernel/network/oplus_game_first \
    oplus/kernel/network/oplus_qr_scan \
    oplus/kernel/network/oplus_score \
    oplus/kernel/network/oplus_stats_calc \
    oplus/kernel/secureguard/gki2.0/rootguard \
    oplus/kernel/wifi/oplus_connectivity_routerboost \
    oplus/kernel/wifi/oplus_connectivity_sla \
    oplus/kernel/wifi/oplus_wificapcenter

# Partitions
AB_OTA_UPDATER := true

AB_OTA_PARTITIONS += \
    boot \
    dtbo \
    init_boot \
    odm \
    odm_dlkm \
    product \
    system \
    system_dlkm \
    system_ext \
    vbmeta \
    vbmeta_system \
    vbmeta_vendor \
    vendor \
    vendor_boot \
    vendor_dlkm

BOARD_USES_METADATA_PARTITION := true


BOARD_FLASH_BLOCK_SIZE := 262144 # BOARD_KERNEL_PAGESIZE * 64
BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_DTBOIMG_PARTITION_SIZE := 8388608
BOARD_INIT_BOOT_IMAGE_PARTITION_SIZE := 8388608
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 67108864

-include vendor/lineage/config/BoardConfigReservedSize.mk

BOARD_SUPER_PARTITION_SIZE := 9663676416
BOARD_SUPER_PARTITION_GROUPS := oplus_dynamic_partitions
BOARD_OPLUS_DYNAMIC_PARTITIONS_PARTITION_LIST := system product system_ext vendor odm system_dlkm vendor_dlkm odm_dlkm
BOARD_OPLUS_DYNAMIC_PARTITIONS_SIZE := $(shell expr $(BOARD_SUPER_PARTITION_SIZE) - 4194304)

BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEM_EXTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_ODMIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_SYSTEM_DLKMIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_ODM_DLKMIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_VENDOR_DLKMIMAGE_FILE_SYSTEM_TYPE := erofs

BOARD_EROFS_PCLUSTER_SIZE := 262144

TARGET_COPY_OUT_ODM := odm
TARGET_COPY_OUT_ODM_DLKM := odm_dlkm
TARGET_COPY_OUT_PRODUCT := product
TARGET_COPY_OUT_SYSTEM_DLKM := system_dlkm
TARGET_COPY_OUT_SYSTEM_EXT := system_ext
TARGET_COPY_OUT_VENDOR := vendor
TARGET_COPY_OUT_VENDOR_DLKM := vendor_dlkm

# Plaform
BOARD_VENDOR := realme
BOARD_HAS_MTK_HARDWARE := true
TARGET_BOARD_PLATFORM := mt6835

# Properties
TARGET_ODM_PROP += $(DEVICE_PATH)/odm.prop
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop

# Recovery
BOARD_MOVE_RECOVERY_RESOURCES_TO_VENDOR_BOOT := true
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/rootdir/etc/fstab.mt6835
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
TARGET_USERIMAGES_USE_F2FS := true

TARGET_NO_RECOVERY := true
BOARD_HAS_LARGE_FILESYSTEM := true

# RIL
ENABLE_VENDOR_RIL_SERVICE := true

# Security
BOOT_SECURITY_PATCH := 2025-02-01
INIT_BOOT_SECURITY_PATCH := $(BOOT_SECURITY_PATCH)
VENDOR_SECURITY_PATCH := 2025-02-01

# SELinux
include device/mediatek/sepolicy_vndr/SEPolicy.mk
include hardware/oplus/sepolicy/mtk/SEPolicy.mk
SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += $(DEVICE_PATH)/sepolicy/private
BOARD_VENDOR_SEPOLICY_DIRS += $(DEVICE_PATH)/sepolicy/vendor

# Verified Boot
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3
BOARD_MOVE_GSI_AVB_KEYS_TO_VENDOR_BOOT := true

BOARD_AVB_ALGORITHM := SHA256_RSA2048
BOARD_AVB_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem

BOARD_AVB_BOOT_ALGORITHM := SHA256_RSA2048
BOARD_AVB_BOOT_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_BOOT_ROLLBACK_INDEX := 0
BOARD_AVB_BOOT_ROLLBACK_INDEX_LOCATION := 3

BOARD_AVB_VBMETA_SYSTEM := product system_ext system system_dlkm
BOARD_AVB_VBMETA_SYSTEM_ALGORITHM := SHA256_RSA2048
BOARD_AVB_VBMETA_SYSTEM_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX := 0
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX_LOCATION := 2

BOARD_AVB_VBMETA_VENDOR := odm odm_dlkm vendor vendor_dlkm
BOARD_AVB_VBMETA_VENDOR_ALGORITHM := SHA256_RSA2048
BOARD_AVB_VBMETA_VENDOR_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_VBMETA_VENDOR_ROLLBACK_INDEX := 0
BOARD_AVB_VBMETA_VENDOR_ROLLBACK_INDEX_LOCATION := 4

BOARD_AVB_ODM_ADD_HASHTREE_FOOTER_ARGS += --hash_algorithm sha256
BOARD_AVB_ODM_DLKM_ADD_HASHTREE_FOOTER_ARGS += --hash_algorithm sha256
BOARD_AVB_PRODUCT_ADD_HASHTREE_FOOTER_ARGS += --hash_algorithm sha256
BOARD_AVB_SYSTEM_EXT_ADD_HASHTREE_FOOTER_ARGS += --hash_algorithm sha256
BOARD_AVB_SYSTEM_ADD_HASHTREE_FOOTER_ARGS += --hash_algorithm sha256
BOARD_AVB_SYSTEM_DLKM_ADD_HASHTREE_FOOTER_ARGS += --hash_algorithm sha256
BOARD_AVB_VENDOR_ADD_HASHTREE_FOOTER_ARGS += --hash_algorithm sha256
BOARD_AVB_VENDOR_DLKM_ADD_HASHTREE_FOOTER_ARGS += --hash_algorithm sha256

# Wifi
BOARD_WLAN_DEVICE := MediaTek
WPA_SUPPLICANT_VERSION := VER_0_8_X
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_HOSTAPD_PRIVATE_LIB := lib_driver_cmd_mt66xx
BOARD_HOSTAPD_DRIVER := $(BOARD_WPA_SUPPLICANT_DRIVER)
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := $(BOARD_HOSTAPD_PRIVATE_LIB)
WIFI_DRIVER_FW_PATH_PARAM := "/dev/wmtWifi"
WIFI_DRIVER_FW_PATH_STA := "STA"
WIFI_DRIVER_FW_PATH_AP := "AP"
WIFI_DRIVER_FW_PATH_P2P := "P2P"
WIFI_DRIVER_STATE_CTRL_PARAM := $(WIFI_DRIVER_FW_PATH_PARAM)
WIFI_DRIVER_STATE_ON := "1"
WIFI_DRIVER_STATE_OFF := "0"
WIFI_HAL_INTERFACE_COMBINATIONS := {{{STA}, 2}}
WIFI_HAL_INTERFACE_COMBINATIONS += ,{{{AP_BRIDGED}, 1},}
WIFI_HAL_INTERFACE_COMBINATIONS += ,{{{STA}, 1}, {{AP}, 1}}
WIFI_HAL_INTERFACE_COMBINATIONS += ,{{{STA}, 1}, {{P2P}, 1}}
WIFI_HAL_INTERFACE_COMBINATIONS += ,{{{STA}, 1}, {{NAN}, 1}}
WIFI_HIDL_UNIFIED_SUPPLICANT_SERVICE_RC_ENTRY := true
WIFI_FEATURE_HOSTAPD_11AX := true
WIFI_FEATURE_SUPPLICANT_11AX := true

# Inherit the proprietary files
include vendor/realme/chongqing/BoardConfigVendor.mk
