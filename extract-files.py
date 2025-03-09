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

}

blob_fixups: blob_fixups_user_type = {
    'vendor/lib64/hw/hwcomposer.mtk_common.so': blob_fixup()
        .add_needed('libprocessgroup_shim.so'),
    (
        'vendor/lib/mt6835/libneuralnetworks_sl_driver_mtk_prebuilt.so',
        'vendor/lib64/mt6835/libneuralnetworks_sl_driver_mtk_prebuilt.so'
    ): blob_fixup()
        .add_needed('libbase_shim.so'),
    (
        'vendor/lib/libnvram.so',
        'vendor/lib64/libnvram.so'
    ): blob_fixup()
        .add_needed('libbase_shim.so'),
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
