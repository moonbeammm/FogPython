#!/bin/sh

###########################################
# README
# 自动生成工程的framwork包
# 该脚本只能生成release状态下的包
###########################################


# 出错了就退出脚本
set -e

echo '请输入project根目录'
# 例:/Users/bilibili/Desktop/ijkplayer/IJKMediaPlayer
read pro_root_dir

echo '请输入project名称!'
# 如: IJKMediaPlayer
read pro_name

echo '请输入scheme名称!(即你要打包的framwork名称.他可能和project名称相同)'
# 如: IJKMediaFramework
read scheme_name

# 输出目录
UNIVERSAL_OUTPUT_FOLDER="${pro_root_dir}/framework"

# 创建输出目录，并删除之前的文件
rm -rf "${UNIVERSAL_OUTPUT_FOLDER}"
mkdir -p "${UNIVERSAL_OUTPUT_FOLDER}"

# 分别编译真机和模拟器版本
xcodebuild -project ${pro_name}.xcodeproj -configuration Release -sdk iphoneos ONLY_ACTIVE_ARCH=NO clean build
xcodebuild -project ${pro_name}.xcodeproj -configuration Release -sdk iphonesimulator ONLY_ACTIVE_ARCH=NO clean build

echo "**********孙广鑫: xcodebuild -project ${pro_name}.xcodeproj -configuration Release -sdk iphoneos ONLY_ACTIVE_ARCH=NO clean build"

# 合成模拟器和真机.framework包
iphoneosDir="${pro_root_dir}/build/Release-iphoneos/${scheme_name}.framework"
simulatorDir="${pro_root_dir}/build/Release-iphonesimulator/${scheme_name}.framework"

echo "*********孙广鑫${iphoneosDir}"


lipo -create "${simulatorDir}/${scheme_name}" "${iphoneosDir}/${scheme_name}" -output "${iphoneosDir}/${scheme_name}"
#将最终包赋值到framework文件夹下
cp -rp $iphoneosDir "${UNIVERSAL_OUTPUT_FOLDER}/${scheme_name}.framework"



