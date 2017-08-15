#! bin/bash
#Update Date:2016.12.23

###export LC_ALL=zh_CN.GB2312;export LANG=zh_CN.GB2312
###############配置项目名称和路径等相关参数
#projectDir="/Users/ZhaoMin/xinliji-ios-git/xinliji-build/xinliji-ios/XinLiJiMe" #项目所在目录的绝对路径
#projectName="XinLiJiMe" #项目所在目录的名称

projectDir=`pwd` #项目所在目录的绝对路径
projectName=`basename "$projectDir"` #项目名称
isWorkSpace=false  #判断是用的workspace还是直接project，workspace设置为true，否则设置为false
buildConfig="Release" #编译的方式,Debug, Release, and custom build configuration names.
if [ -d "${projectName}.xcworkspace" ]; then
    isWorkSpace=true
fi

###############配置下载的文件名称和路径等相关参数
wwwIPADir=$projectDir/WWW #html，ipa，icon，plist最后所在的目录绝对路径
mkdir -pv $wwwIPADir


##########################################################################################
##############################以下部分为自动生产部分，不需要手动修改############################
##########################################################################################

####################### FUCTION  START #######################
replaceString(){
	local inputString=$1
	result=${inputString//(/}
	result=${result//)/}
	echo $result
}

date_Y_M_D_W_T()
{
    WEEKDAYS=(星期日 星期一 星期二 星期三 星期四 星期五 星期六)
    WEEKDAY=$(date +%w)
    DT="$(date +%Y年%m月%d日) ${WEEKDAYS[$WEEKDAY]} $(date "+%H:%M:%S")"
    echo "$DT"
}
####################### FUCTION  END #######################


###Log的路径,如果发现log里又乱码请在终端执行:export LC_ALL=zh_CN.GB2312;export LANG=zh_CN.GB2312
logDir=~/xcodebuild
mkdir -pv $logDir
logPath=$logDir/$projectName-$buildConfig.log
echo "~~~~~~~~~~~~~~~~~~~开始编译~~~~~~~~~~~~~~~~~~~" >>$logPath

loginInfo=`who am i`
loginUser=`echo $loginInfo |awk '{print $1}'`
echo "登陆用户:$loginUser" >>$logPath
loginDate=`echo $loginInfo |awk '{print $3,$4,$5}'`
echo "登陆时间:$loginDate" >>$logPath
loginServer=`echo $loginInfo |awk '{print $6}'`
if [ -n "$loginServer" ]; then
	echo "登陆用户IP:$(replaceString $loginServer)" >>$logPath
else
    echo "登陆用户IP:localhost(127.0.0.1)" >>$logPath
fi

if [ -d "$logDir" ]; then
	echo "${logDir}文件目录存在"
else 
	echo "${logDir}文件目录不存在,创建${logDir}目录成功"
	echo "创建${logDir}目录成功" >>$logPath
fi

###############检查html等文件放置目录是否存在，不存在就创建
echo "开始时间:$(date_Y_M_D_W_T)" >>$logPath
echo "项目名称:$projectName" >>$logPath
echo "编译模式:$buildConfig" >>$logPath
echo "开始目录检查........" >>$logPath

if [ -d "$wwwIPADir" ]; then
	echo "文件目录存在" >>$logPath
else 
	echo "文件目录不存在" >>$logPath
    mkdir -pv $wwwIPADir
	echo "创建${wwwIPADir}目录成功" >>$logPath
fi

###############进入项目目录
cd $projectDir
echo "code update ..."
git pull
rm -rf ./build
buildAppToDir=$projectDir/build #编译打包完成后.app文件存放的目录

###############获取版本号,bundleID
infoPlist="$projectName/Info.plist"
bundleVersion=`/usr/libexec/PlistBuddy -c "Print CFBundleShortVersionString" $infoPlist`
bundleIdentifier=`/usr/libexec/PlistBuddy -c "Print CFBundleIdentifier" $infoPlist`
bundleBuildVersion=`/usr/libexec/PlistBuddy -c "Print CFBundleVersion" $infoPlist`
CFBundleDisplayName=`/usr/libexec/PlistBuddy -c "Print CFBundleDisplayName" $infoPlist`

echo "CFBundleDisplayName: ${CFBundleDisplayName}" >>$logPath
echo "bundleIdentifier: ${bundleIdentifier}" >>$logPath
echo "infoPlist: ${infoPlist}" >>$logPath
echo "bundleVersion: ${bundleVersion}" >>$logPath
echo "bundleBuildVersion: ${bundleBuildVersion}" >>$logPath


###############开始编译app
if $isWorkSpace ; then  #判断编译方式
    echo  "开始编译workspace...." >>$logPath
    xcodebuild  -workspace $projectName.xcworkspace -scheme $projectName  -configuration $buildConfig clean build SYMROOT=$buildAppToDir
else
    echo  "开始编译target...." >>$logPath
    xcodebuild  -target  $projectName  -configuration $buildConfig clean build SYMROOT=$buildAppToDir
fi
#判断编译结果
if test $? -eq 0
then
echo "~~~~~~~~~~~~~~~~~~~编译成功~~~~~~~~~~~~~~~~~~~"
else
echo "~~~~~~~~~~~~~~~~~~~编译失败~~~~~~~~~~~~~~~~~~~" >>$logPath
echo "\n" >>$logPath
exit 1
fi

###############开始打包成.ipa
ipaName=`echo $projectName | tr "[:upper:]" "[:lower:]"` #将项目名转小写
appDir=$buildAppToDir/$buildConfig-iphoneos/  #app所在路径
echo "开始打包$projectName.app成$projectName.ipa....." >>$logPath
xcrun -sdk iphoneos PackageApplication -v $appDir/$projectName.app -o $appDir/$ipaName.ipa #将app打包成ipa

###############开始拷贝到目标目录

#检查文件是否存在
if [ -f "$appDir/$ipaName.ipa" ]
then
echo "打包$ipaName.ipa成功." >>$logPath
else
echo "打包$ipaName.ipa失败." >>$logPath
exit 1
fi
cp -f -p $appDir/$ipaName.ipa $wwwIPADir/$ipaName.ipa   #拷贝ipa文件
echo "复制$ipaName.ipa到${wwwIPADir}成功" >>$logPath

###############计算文件大小和最后更新时间
fileSize=`stat $appDir/$ipaName.ipa |awk '{if($8!=4096){size=size+$8;}} END{print "文件大小:", size/1024/1024,"M"}'`
lastUpdateDate=`stat $appDir/$ipaName.ipa | awk '{print "最后更新时间:",$13,$14,$15,$16}'`
echo "$fileSize"  >>$logPath
echo "$lastUpdateDate" >>$logPath
 

echo "结束时间:$(date_Y_M_D_W_T)" >>$logPath

###############使用shenzhen ipa命令显示ipa信息
if which ipa >/dev/null; then
    ipa info $wwwIPADir/$ipaName.ipa  >>$logPath
fi

echo "~~~~~~~~~~~~~~~~~~~结束编译，处理成功~~~~~~~~~~~~~~~~~~~"

###############上传到bugly
title="${CFBundleDisplayName}V${bundleVersion} (Build NO ${bundleBuildVersion})"
echo "./upload_bugly/upload.sh ${wwwIPADir}/${ipaName}.ipa ---- $title"
sh ./upload_bugly/upload.sh "${wwwIPADir}/${ipaName}.ipa" "$title" "$logPath"
if test $? -eq 0; then
    echo "上传到bugly成功" >>$logPath
else
    echo "上传到bugly失败" >>$logPath
fi



echo "\n" >>$logPath

###############用sublime显示文件
if which subl >/dev/null; then
    subl $logPath
fi

