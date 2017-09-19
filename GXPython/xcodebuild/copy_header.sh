#!/bin/bash

# ${SRCROOT}: 工程根目录.如./Desktop/GXThirdLib/
pods_header_directory="${SRCROOT}/PodLinker/Pods/Headers/Public/"

# ${BUILT_PRODUCTS_DIR}: 工程编译产物路径如DeriveData/PodLinker.../Build/Products/Debug-iphoneos/
copy_to_directory="${BUILT_PRODUCTS_DIR}/include/"

# 创建目标路径文件夹
mkdir -p "${copy_to_directory}"

# 将pods的头文件复制到目标路径下
cp -rpf "${pods_header_directory}"* "${copy_to_directory}"

# 打印目标路径
echo "${copy_to_directory}"
