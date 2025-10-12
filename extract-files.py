#!/usr/bin/env -S PYTHONPATH=../../../tools/extract-utils python3
#
# SPDX-FileCopyrightText: 2024 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

from extract_utils.fixups_blob import (
    blob_fixup,
    blob_fixups_user_type,
)

from extract_utils.fixups_lib import (
    lib_fixup_remove,
    lib_fixups,
    lib_fixups_user_type,
)

from extract_utils.main import (
    ExtractUtils,
    ExtractUtilsModule,
)

namespace_imports = [
    'device/realme/chongqing',
    'hardware/mediatek',
    'hardware/oplus',
    'hardware/mediatek/libmtkperf_client',
    'vendor/realme/chongqing',
]

def lib_fixup_vendor_suffix(lib: str, partition: str, *args, **kwargs):
    return f'{lib}_{partition}' if partition == 'vendor' else None

lib_fixups: lib_fixups_user_type = {
    **lib_fixups,
    (
        'vendor.mediatek.hardware.videotelephony@1.0',
        'libmpbase'
    ): lib_fixup_vendor_suffix,
}

blob_fixups: blob_fixups_user_type = {
    'vendor/lib64/mt6835/libcam.afhal.so': blob_fixup()
        .replace_needed('vendor.oplus.hardware.commondcs-V1-ndk_platform.so', 'vendor.oplus.hardware.commondcs-V1-ndk.so'),
    (
    'vendor/lib64/hw/vendor.oplus.hardware.cameraextension-V1-service-impl.so',
    'vendor/lib64/mt6835/libmtkcam_featurepolicy.so',
    'vendor/lib64/mt6835/libmtkcam_pipelinemodel.so'
    ): blob_fixup()
        .replace_needed('vendor.oplus.hardware.osense.client-V1-ndk_platform.so', 'vendor.oplus.hardware.osense.client-V1-ndk.so'),
    'vendor/bin/hw/mtkfusionrild': blob_fixup()
        .add_needed('libutils-v33.so'),
    'vendor/bin/hw/mt6835/camerahalserver': blob_fixup()
        .add_needed('libcamera_metadata_shim.so'),
    'vendor/bin/hw/android.hardware.graphics.composer@3.1-service': blob_fixup()
        .replace_needed('android.hardware.graphics.composer@2.1-resources.so', 'android.hardware.graphics.composer@2.1-resources-v34.so'),
    'odm/bin/hw/vendor-oplus-hardware-performance-V1-service': blob_fixup()
        .add_needed('libbase_shim.so')
        .add_needed('libprocessgroup_shim.so'),
    (
        'odm/bin/hw/vendor.oplus.hardware.charger-V3-service',
        'odm/lib/ese_spi_nxp_nq330.so',
        'odm/lib64/ese_spi_nxp_nq330.so',
        'vendor/lib/libtflite_mtk.so',
        'vendor/lib/libnvram.so',
        'vendor/lib/mt6835/libneuralnetworks_sl_driver_mtk_prebuilt.so',
        'vendor/lib64/android.hardware.power-service-mediatek.so',
        'vendor/lib64/libtflite_mtk.so',
        'vendor/lib64/libnvram.so',
        'vendor/lib64/mt6835/libneuralnetworks_sl_driver_mtk_prebuilt.so'
    ): blob_fixup()
        .add_needed('libbase_shim.so'),
    'vendor/lib64/hw/hwcomposer.mtk_common.so': blob_fixup()
        .add_needed('libprocessgroup_shim.so'),
    'vendor/lib/libvcodec_oal.so': blob_fixup()
        .clear_symbol_version('__aeabi_memcpy')
        .clear_symbol_version('__aeabi_memset')
        .clear_symbol_version('__gnu_Unwind_Find_exidx'),
    'vendor/lib64/liboplus_mtkcam_lightsensorprovider.so': blob_fixup()
        .replace_needed('libsensorndkbridge.so', 'libsensorndkbridge-v30.so'),
    (
        'vendor/lib64/hw/android.hardware.sensors@2.X-subhal-mediatek.so',
        'vendor/lib64/mt6835/libaalservice.so',
        'vendor/lib64/mt6835/libcam.utils.sensorprovider.so'
    ): blob_fixup()
        .add_needed('libshim_sensors.so'),
    'system_ext/etc/init/init.vtservice.rc': blob_fixup()
        .regex_replace('start', 'enable'),
    'vendor/bin/hw/android.hardware.security.keymint@2.0-service.trustonic': blob_fixup()
        .add_needed('android.hardware.security.rkp-V2-ndk.so'),
    'vendor/bin/hw/android.hardware.media.c2@1.2-mediatek-64b': blob_fixup()
        .add_needed('libstagefright_foundation-v33.so'),
    'vendor/etc/vintf/manifest/manifest_media_c2_V1_2_default.xml': blob_fixup()
        .regex_replace('1.1', '1.2'),
    'system_ext/lib64/libsink-mtk.so': blob_fixup()
        .add_needed('libshim_sink.so'),
    'system_ext/lib64/libimsma.so': blob_fixup()
        .replace_needed('libsink.so', 'libsink-mtk.so'),
    'system_ext/lib64/libsource.so': blob_fixup()
        .add_needed('libui_shim.so'),
    (
        'odm/lib/libCOppLceTonemapAPI.so',
        'odm/lib/libYTCommon.so',
        'odm/lib64/libcdsprpc.so',
        'odm/lib64/libCOppLceTonemapAPI.so',
        'odm/lib64/libYTCommon.so',
        'vendor/lib64/libadsprpc.so',
        'vendor/lib64/libcdsprpc.so'
    ): blob_fixup()
        .replace_needed('libstdc++.so', 'libstdc++_vendor.so'),
    (
        'odm/lib/libAlgoProcess.so',
        'odm/lib64/libAlgoProcess.so',
        'vendor/lib/vendor.mediatek.hardware.pq_aidl-V1-ndk.so',
        'vendor/lib64/libcodec2_vpp_AIMEMC_plugin.so',
        'vendor/lib64/libcodec2_vpp_AISR_plugin.so',
        'vendor/lib64/vendor.mediatek.hardware.pq_aidl-V1-ndk.so'
    ): blob_fixup()
        .replace_needed('android.hardware.graphics.common-V3-ndk', 'android.hardware.graphics.common-V6-ndk'),
}  # fmt: skip

module = ExtractUtilsModule(
    'chongqing',
    'realme',
    blob_fixups=blob_fixups,
    namespace_imports=namespace_imports,
    lib_fixups=lib_fixups,
)

if __name__ == '__main__':
    utils = ExtractUtils.device(module)
    utils.run()
