vcpkg_check_linkage(ONLY_DYNAMIC_LIBRARY)

set(VERSION 1.11.1)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/microsoft/onnxruntime/releases/download/v1.11.1/onnxruntime-win-x64-gpu-1.11.1.zip"
    FILENAME "onnxruntime-win-x64-gpu-1.11.1.zip"
    SHA512 df85345f0b471a93e6b1416e59412917322e10c51418f981b4bf1a762e6f6d5d0bfc8d4224389051f72739985ed661b17f23726387acc484af407c44b3a14011
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    NO_REMOVE_ONE_LEVEL
    REF ${VERSION}
)

file(MAKE_DIRECTORY
        ${CURRENT_PACKAGES_DIR}/include
        ${CURRENT_PACKAGES_DIR}/lib
        ${CURRENT_PACKAGES_DIR}/bin
        ${CURRENT_PACKAGES_DIR}/debug/lib
        ${CURRENT_PACKAGES_DIR}/debug/bin
    )

file(COPY
        ${SOURCE_PATH}/onnxruntime-win-x64-gpu-1.11.1/include
        DESTINATION ${CURRENT_PACKAGES_DIR}
    )

file(COPY ${SOURCE_PATH}/onnxruntime-win-x64-gpu-1.11.1/lib/onnxruntime.lib
    DESTINATION ${CURRENT_PACKAGES_DIR}/lib)
file(COPY ${SOURCE_PATH}/onnxruntime-win-x64-gpu-1.11.1/lib/onnxruntime.lib
    DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib)
file(COPY ${SOURCE_PATH}/onnxruntime-win-x64-gpu-1.11.1/lib/onnxruntime.dll
    DESTINATION ${CURRENT_PACKAGES_DIR}/bin)
file(COPY ${SOURCE_PATH}/onnxruntime-win-x64-gpu-1.11.1/lib/onnxruntime.dll
    DESTINATION ${CURRENT_PACKAGES_DIR}/debug/bin)

# # Handle copyright
file(INSTALL ${SOURCE_PATH}/onnxruntime-win-x64-gpu-1.11.1/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
