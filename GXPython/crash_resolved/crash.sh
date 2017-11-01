#!/bin/bash

export DEVELOPER_DIR="/Applications/XCode.app/Contents/Developer"

echo '1.请确保crash文件夹里包含crash.crash文件!'
echo '2.请确保crash文件夹里包含.dsym文件!'
echo '3.最后生成的log日志将输出至crash文件夹内!'

echo '请输入crash文件夹路径!'
read crash_dir

echo '请输入.dsym文件名'
read dsym_name

/Applications/Xcode.app/Contents/SharedFrameworks/DVTFoundation.framework/Versions/A/Resources/symbolicatecrash $crash_dir/crash.crash $crash_dir/$dsym_name ->~/Desktop/crash/crash.log


