#!/bin/bash

# 仅生成

echo '请输入静态库工程目录!'
lib_project_path="${SRCROOT}"    # 静态库工程的根目录

echo '请输入静态库工程输出目录'
lib_project_output_path="${SRCROOT}"   #Users/bilibili/Desktop  比如桌面

echo '请输入静态库工程名称!'
lib_project_name=${PROJECT_NAME}    # GXUtils

lib_name="lib"$lib_project_name".a"

iphone_arch_types=("armv7" "armv7s" "arm64")
iphone_product_type="Release-iphoneos"

iphone_simulator_arch_types=("i386" "x86_64")
iphone_simulator_product_type="Release-iphonesimulator"


buildDire=$lib_project_output_path"/build/"

rm -rf $buildDire

if [ ! -d $buildDire ]; then
	mkdir $buildDire
fi

libDire=$lib_project_output_path"/Lib/"

rm -rf $libDire

if [ ! -d $libDire ]; then
	mkdir $libDire
fi

pwd
echo "**********初始化参数设置完成!!"


function build_arch()
{
    arch_type=$1    # ("armv7" "armv7s" "arm64")
	product_type=$2 # ("Release-iphoneos")

	OLD_IFS="$IFS" 
	IFS="-" 
	arr=($product_type) 
	IFS="$OLD_IFS" 
	config=${arr[0]}    # release/debug
	sdk_type=${arr[1]}  # iphonesimulator/iphoneos

	product_filename=$arch_type".a" #改名后的名字

    pwd
    echo "***********build_arch: build不同指令集的静态库包!"
    
	cd $lib_project_path
    
    pwd
	xcodebuild -workspace ${PROJECT_NAME}".xcworkspace" -scheme ${PROJECT_NAME} -sdk $sdk_type -configuration $config -arch $arch_type clean build

    echo "************编译: xcodebuild -workspace PodLinker.xcworkspace -scheme PodLinker -sdk $sdk_type -configuration $config -arch $arch_type"

    cd "${BUILD_DIR}/$product_type/"
    pwd
    echo "*******************${BUILD_DIR}/$product_type/"
    
    ls
    cp $lib_name $product_filename

	rm $lib_name
}

function merge_iphoneos_lib()
{
    product_type=$1 #("Release-iphoneos")

    path="${BUILD_DIR}/$product_type/"
	echo "*************合并三个.a包! $path"

	lipo -create $path/${iphone_arch_types[0]}".a" $path/${iphone_arch_types[1]}".a" $path/${iphone_arch_types[2]}".a" -output $lib_project_output_path/build/$product_type$lib_name
}

function merge_iphone_simulator_lib()
{
	product_type=$1 #("Release-iphoneosimulator")

    path="${BUILD_DIR}/$product_type/"
    echo "*************合并三个.a包! $path"

	lipo -create $path/${iphone_simulator_arch_types[0]}".a" $path/${iphone_simulator_arch_types[1]}".a" -output $lib_project_output_path/build/$product_type$lib_name
}




function create_iphone_lib()
{
    for iphone_arch_type in ${iphone_arch_types[*]}
    do
        build_arch $iphone_arch_type $iphone_product_type
    done
    merge_iphoneos_lib $iphone_product_type

}

function create_iphone_simulator_lib()
{

    for iphone_simulator_arch_type in ${iphone_simulator_arch_types[*]}
    do
        build_arch $iphone_simulator_arch_type $iphone_simulator_product_type
    done
    merge_iphone_simulator_lib $iphone_simulator_product_type

}

function merge_all_lib()
{
    release_product_types=("Release-iphoneos" "Release-iphonesimulator")

	release_path0=$lib_project_output_path/build/${release_product_types[0]}$lib_name
	release_path1=$lib_project_output_path/build/${release_product_types[1]}$lib_name


	echo "合并release下真机和模拟器的.a包!"
	lipo -create $release_path0 $release_path1 -output $lib_project_output_path/Lib/all_in_one_release.a

#	rm -rf $lib_project_output_path/build/*.a
}

function main()
{
	echo '生成真机的release.a包.并各自合并'
	create_iphone_lib
	echo '生成模拟器的release.a包.并各自合并'
	create_iphone_simulator_lib
	echo '合并release的真机和模拟器.a包'
	merge_all_lib
}

main










