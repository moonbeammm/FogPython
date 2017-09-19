#!/bin/bash

echo '请输入静态库工程目录!'
# 例:/Users/bilibili/Desktop/GXPython/GXPython
read project_path

echo '请输入静态库工程输出目录'
# 例:/Users/bilibili/Desktop/GXLib
read output_path

echo '请输入静态库工程名称!'
# GXPython
read project_name

# 创建输出目录，并删除之前的文件
#rm -rf "${output_path}"
mkdir -p "${output_path}"

xcodebuild -project ${project_name}".xcodeproj" -scheme ${project_name} -configuration Release -sdk iphoneos clean build