#
# Copyright (C) 2021 The PixelExperience Project
#
# SPDX-License-Identifier: Apache-2.0
#

BOARD_VENDOR := xiaomi

COMMON_PATH := device/xiaomi/sm6150-common

# Inherit from proprietary files
include vendor/xiaomi/sm6150-common/BoardConfigVendor.mk

# A/B
ifeq ($(TARGET_IS_VAB),true)
AB_OTA_UPDATER := true
BOARD_USES_RECOVERY_AS_BOOT := true
BOARD_BUILD_SYSTEM_ROOT_IMAGE := false

AB_OTA_PARTITIONS += \
    boot \
    dtbo \
    odm \
    product \
    system \
    system_ext \
    vbmeta \
    vbmeta_system \
    vendor \
    vendor_boot
endif

# APEX
DEXPREOPT_GENERATE_APEX_IMAGE := true

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := cortex-a76

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic
TARGET_2ND_CPU_VARIANT_RUNTIME := cortex-a76

# ANT+
BOARD_ANT_WIRELESS_DEVICE := "vfs-prerelease"

# Audio
AUDIO_FEATURE_ENABLED_EXTENDED_COMPRESS_FORMAT := true
AUDIO_FEATURE_ENABLED_EXTN_FORMATS := true
AUDIO_FEATURE_ENABLED_FM_POWER_OPT := true
AUDIO_FEATURE_ENABLED_HDMI_SPK := true
AUDIO_FEATURE_ENABLED_PROXY_DEVICE := true
USE_CUSTOM_AUDIO_POLICY := 1

# Bluetooth
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := $(COMMON_PATH)/bluetooth/include

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := sm6150
TARGET_NO_BOOTLOADER := true

# Broken
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true

# Camera
TARGET_USES_QTI_CAMERA_DEVICE := true
TARGET_CAMERA_BOOTTIME_TIMESTAMP := true

# Display
TARGET_USES_COLOR_METADATA := true
TARGET_USES_DISPLAY_RENDER_INTENTS := true
TARGET_USES_DRM_PP := true
TARGET_USES_HWC2 := true

# DRM
TARGET_ENABLE_MEDIADRM_64 := true

# Filesystem
TARGET_FS_CONFIG_GEN := $(COMMON_PATH)/config.fs

# FM
BOARD_HAVE_QCOM_FM := true

# HIDL
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE := \
    $(COMMON_PATH)/framework_compatibility_matrix.xml \
    vendor/aosp/config/device_framework_matrix.xml
DEVICE_MANIFEST_FILE += hardware/qcom-caf/sm8150/media/conf_files/sm6150/c2_manifest_vendor.xml
DEVICE_MATRIX_FILE := $(COMMON_PATH)/compatibility_matrix.xml
DEVICE_MANIFEST_FILE := $(COMMON_PATH)/manifest.xml
ODM_MANIFEST_SKUS += nfc
ODM_MANIFEST_NFC_FILES := $(COMMON_PATH)/manifest_nfc.xml

# Init
TARGET_INIT_VENDOR_LIB ?= //$(COMMON_PATH):init_xiaomi_sm6150
TARGET_RECOVERY_DEVICE_MODULES ?= init_xiaomi_sm6150

# Kernel
ifeq ($(PRODUCT_VIRTUAL_AB_OTA),true)
BOARD_BOOT_HEADER_VERSION := 3
else
BOARD_BOOT_HEADER_VERSION := 2
endif
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_IMAGE_NAME := Image
BOARD_KERNEL_PAGESIZE := 4096

BOARD_KERNEL_CMDLINE += androidboot.hardware=qcom
BOARD_KERNEL_CMDLINE += androidboot.memcg=1
BOARD_KERNEL_CMDLINE += androidboot.usbcontroller=a600000.dwc3
BOARD_KERNEL_CMDLINE += loop.max_part=7
BOARD_KERNEL_CMDLINE += lpm_levels.sleep_disabled=1
BOARD_KERNEL_CMDLINE += service_locator.enable=1
BOARD_KERNEL_CMDLINE += swiotlb=1
BOARD_KERNEL_CMDLINE += msm_rtb.filter=0x237
BOARD_KERNEL_CMDLINE += kpti=off

BOARD_KERNEL_SEPARATED_DTBO := true
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)

# Media
TARGET_USES_ION := true
TARGET_DISABLED_UBWC := true

# Partitions
ifeq ($(PRODUCT_USE_DYNAMIC_PARTITIONS),true)
ifeq ($(PRODUCT_VIRTUAL_AB_OTA),true)
BOARD_BOOTIMAGE_PARTITION_SIZE := 134217728
BOARD_USERDATAIMAGE_PARTITION_SIZE := 112419745792
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 100663296
BOARD_DTBOIMG_PARTITION_SIZE := 25165824
else
BOARD_BOOTIMAGE_PARTITION_SIZE := 134217728
BOARD_CACHEIMAGE_PARTITION_SIZE := 402653184
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 134217728
BOARD_USERDATAIMAGE_PARTITION_SIZE := 114898743296
BOARD_DTBOIMG_PARTITION_SIZE := 33554432
endif
ifeq ($(PRODUCT_VIRTUAL_AB_OTA),true)
FRAMEWORK_PARTITIONS_RESERVED_SIZE := 30720000
else
FRAMEWORK_PARTITIONS_RESERVED_SIZE := 1258291200
endif
BOARD_PRODUCTIMAGE_PARTITION_RESERVED_SIZE := $(FRAMEWORK_PARTITIONS_RESERVED_SIZE)
BOARD_SYSTEMIMAGE_PARTITION_RESERVED_SIZE := $(FRAMEWORK_PARTITIONS_RESERVED_SIZE)
BOARD_SYSTEM_EXTIMAGE_PARTITION_RESERVED_SIZE := $(FRAMEWORK_PARTITIONS_RESERVED_SIZE)
BOARD_ODMIMAGE_PARTITION_RESERVED_SIZE := 30720000
BOARD_VENDORIMAGE_PARTITION_RESERVED_SIZE := 30720000
ifneq ($(PRODUCT_VIRTUAL_AB_OTA),true)
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
endif
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEM_EXTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_ODMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SUPER_PARTITION_GROUPS := qti_dynamic_partitions
BOARD_SUPER_PARTITION_SIZE := 9126805504
BOARD_QTI_DYNAMIC_PARTITIONS_PARTITION_LIST := odm product system system_ext vendor
BOARD_QTI_DYNAMIC_PARTITIONS_SIZE := 9122611200 # ( BOARD_SUPER_PARTITION_SIZE - 4MB )
BOARD_FLASH_BLOCK_SIZE := 131072 # (BOARD_KERNEL_PAGESIZE * 64)
BOARD_USES_METADATA_PARTITION := true
TARGET_COPY_OUT_ODM := odm
TARGET_COPY_OUT_PRODUCT := product
TARGET_COPY_OUT_SYSTEM_EXT := system_ext
TARGET_COPY_OUT_VENDOR := vendor
else
BOARD_BOOTIMAGE_PARTITION_SIZE := 134217728
BOARD_DTBOIMG_PARTITION_SIZE := 33554432
BOARD_USERDATAIMAGE_PARTITION_SIZE := 57453555712
BOARD_VENDORIMAGE_PARTITION_SIZE := 1610612736
BOARD_CACHEIMAGE_PARTITION_SIZE := 268435456
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 67108864
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 3758096384
BOARD_FLASH_BLOCK_SIZE := 262144 # (BOARD_KERNEL_PAGESIZE * 64)

TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
BOARD_BUILD_SYSTEM_ROOT_IMAGE := true
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_VENDOR := vendor
endif

# Platform
TARGET_BOARD_PLATFORM := sm6150
BOARD_USES_QCOM_HARDWARE := true

# Power
TARGET_POWERHAL_MODE_EXT := $(COMMON_PATH)/power/power-mode.cpp

# Properties
TARGET_ODM_PROP += $(COMMON_PATH)/odm.prop
TARGET_SYSTEM_PROP += $(COMMON_PATH)/system.prop
TARGET_VENDOR_PROP += $(COMMON_PATH)/vendor.prop
TARGET_PRODUCT_PROP += $(COMMON_PATH)/product.prop
TARGET_SYSTEM_EXT_PROP += $(COMMON_PATH)/system_ext.prop

# Recovery
ifeq ($(PRODUCT_USE_DYNAMIC_PARTITIONS),true)
ifeq ($(PRODUCT_VIRTUAL_AB_OTA),true)
TARGET_RECOVERY_FSTAB := $(COMMON_PATH)/rootdir/etc/fstab_AB.qcom
else
TARGET_RECOVERY_FSTAB := $(COMMON_PATH)/rootdir/etc/fstab.qcom
endif
else
TARGET_RECOVERY_FSTAB := $(COMMON_PATH)/rootdir/etc/fstab_SAR.qcom
endif
TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_INCLUDE_RECOVERY_DTBO := true
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

# RIL
ENABLE_VENDOR_RIL_SERVICE := true

# Releasetools
TARGET_RELEASETOOLS_EXTENSIONS := $(COMMON_PATH)

# Security patch level
VENDOR_SECURITY_PATCH := 2022-02-01

# Sepolicy
TARGET_SEPOLICY_DIR := msmsteppe
include device/qcom/sepolicy_vndr/SEPolicy.mk
SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += $(COMMON_PATH)/sepolicy/private
SYSTEM_EXT_PUBLIC_SEPOLICY_DIRS += $(COMMON_PATH)/sepolicy/public
BOARD_VENDOR_SEPOLICY_DIRS += $(COMMON_PATH)/sepolicy/vendor

# Verified Boot
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3
ifeq ($(PRODUCT_USE_DYNAMIC_PARTITIONS),true)
BOARD_AVB_VBMETA_SYSTEM := system system_ext product
BOARD_AVB_VBMETA_SYSTEM_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_VBMETA_SYSTEM_ALGORITHM := SHA256_RSA2048
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX_LOCATION := 1
endif
BOARD_AVB_RECOVERY_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_RECOVERY_ALGORITHM := SHA256_RSA4096
BOARD_AVB_RECOVERY_ROLLBACK_INDEX := 1
BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION := 1

# WiFi
BOARD_WLAN_DEVICE := qcwcn
BOARD_HOSTAPD_DRIVER := NL80211
BOARD_HOSTAPD_PRIVATE_LIB := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
QC_WIFI_HIDL_FEATURE_DUAL_AP := true
WIFI_DRIVER_DEFAULT := qca_cld3
WIFI_DRIVER_STATE_CTRL_PARAM := "/dev/wlan"
WIFI_DRIVER_STATE_OFF := "OFF"
WIFI_DRIVER_STATE_ON := "ON"
WIFI_HIDL_FEATURE_AWARE := true
WIFI_HIDL_FEATURE_DUAL_INTERFACE := true
WIFI_HIDL_UNIFIED_SUPPLICANT_SERVICE_RC_ENTRY := true
WPA_SUPPLICANT_VERSION := VER_0_8_X
