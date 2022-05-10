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

# Download repo for experimental features
vcpkg_from_github(
    OUT_SOURCE_PATH REPO_PATH
    REPO microsoft/onnxruntime
    REF v1.11.1
    SHA512 319d0659f253e976c658e9b0f68e4fb260c14a6cb57c666a0c62df610fc84d009e5edb0c7273f843161db8a545e11fa519e474a2897ef0f2155480393e3f1ccd
)

file(MAKE_DIRECTORY
        ${CURRENT_PACKAGES_DIR}/include
        ${CURRENT_PACKAGES_DIR}/lib
        ${CURRENT_PACKAGES_DIR}/bin
        ${CURRENT_PACKAGES_DIR}/debug/lib
        ${CURRENT_PACKAGES_DIR}/debug/bin
    )

# Copy experimental headers
file(COPY
        ${REPO_PATH}/include/onnxruntime/core/session/experimental_onnxruntime_cxx_api.h ${REPO_PATH}/include/onnxruntime/core/session/experimental_onnxruntime_cxx_inline.h
        DESTINATION ${CURRENT_PACKAGES_DIR}/include
    )

file(COPY
        ${SOURCE_PATH}/onnxruntime-win-x64-gpu-1.11.1/include
        DESTINATION ${CURRENT_PACKAGES_DIR}
    )

# Glob and copy all libs so that different executation providers can be used
file(GLOB STATIC_LIBRARIES
    ${SOURCE_PATH}/onnxruntime-win-x64-gpu-1.11.1/lib/*.lib
)

file(GLOB DYNAMIC_LIBRARIES
    ${SOURCE_PATH}/onnxruntime-win-x64-gpu-1.11.1/lib/*.dll
)

file(COPY ${STATIC_LIBRARIES}
    DESTINATION ${CURRENT_PACKAGES_DIR}/lib)
file(COPY ${STATIC_LIBRARIES}
    DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib)
file(COPY ${DYNAMIC_LIBRARIES}
    DESTINATION ${CURRENT_PACKAGES_DIR}/bin)
file(COPY ${DYNAMIC_LIBRARIES}
    DESTINATION ${CURRENT_PACKAGES_DIR}/debug/bin)

# # Handle copyright
file(INSTALL ${SOURCE_PATH}/onnxruntime-win-x64-gpu-1.11.1/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
