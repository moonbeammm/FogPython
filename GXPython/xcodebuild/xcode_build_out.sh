#!/bin/sh

###########################################
# 自动生成工程的framwork包
# 该脚本只能生成release状态下的包
# 该脚本只能放在工程根目录下.
# 并且只能用xcode来启动该脚本
# 因为该脚本需要拿xcode设置的一些参数.
###########################################


# 出错了就退出脚本
set -e

echo '请输入静态库工程根目录'
# 例:/Users/bilibili/Desktop
read SRCROOT

echo '请输入静态库工程名称!'
# GXPython
read target_Name

CONFIGURATION=("armv7" "armv7s")

echo "***********孙广鑫: target_name: $1"

# 输出目录
UNIVERSAL_OUTPUT_FOLDER="${SRCROOT}/lib"

# 创建输出目录，并删除之前的文件
rm -rf "${UNIVERSAL_OUTPUT_FOLDER}"
mkdir -p "${UNIVERSAL_OUTPUT_FOLDER}"

# 分别编译真机和模拟器版本
OLD_IFS="$IFS" 
IFS="-" 
xcodebuild -workspace ${target_Name}".xcworkspace" -scheme ${target_Name} ONLY_ACTIVE_ARCH=NO -configuration ${CONFIGURATION} -sdk iphoneos   clean build
xcodebuild -workspace "${target_Name}.xcworkspace" -scheme ${target_Name} ONLY_ACTIVE_ARCH=NO -configuration ${CONFIGURATION} -sdk iphonesimulator  clean build

echo "**********孙广鑫: xcodebuild -target "${target_Name}" ONLY_ACTIVE_ARCH=NO -configuration ${CONFIGURATION} -sdk iphonesimulator BUILD_DIR="${BUILD_DIR}" BUILD_ROOT="${BUILD_ROOT}" clean build"

# 合成模拟器和真机.a包
lipo -create "${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/lib${target_Name}.a" "${BUILD_DIR}/${CONFIGURATION}-iphoneos/lib${target_Name}.a" -output "${UNIVERSAL_OUTPUT_FOLDER}/lib${target_Name}.a"



