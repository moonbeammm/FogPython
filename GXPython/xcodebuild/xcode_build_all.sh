#!/bin/bash

echo '请输入静态库工程目录!'
# 例:/Users/bilibili/Desktop/GXPython/GXPython
read lib_project_path

echo '请输入静态库工程输出目录'
# 例:/Users/bilibili/Desktop
read lib_project_output_path

echo '请输入静态库工程名称!'
# GXPython
read lib_project_name

lib_name="lib"$lib_project_name".a"

iphone_arch_types=("armv7" "armv7s" "arm64")
iphone_product_types=("Release-iphoneos" "Debug-iphoneos")

iphone_simulator_arch_types=("i386" "x86_64")
iphone_simulator_product_types=("Release-iphonesimulator" "Debug-iphonesimulator")

function build_arch()
{
	arch_type=$1
	product_type=$2 # ("Release-iphoneos" "Debug-iphoneos")

	OLD_IFS="$IFS" 
	IFS="-" 
	arr=($product_type) 
	IFS="$OLD_IFS" 
	config=${arr[0]}  # release还是debug
	sdk_type=${arr[1]}  # 真机还是模拟器

	product_filename=$arch_type".a" #改名后的名字

	echo "build不同指令集.a包!"
	cd $lib_project_path
	xcodebuild -sdk $sdk_type -configuration $config -arch $arch_type

	echo '给.a包改名!'
	cd $lib_project_path/build/$product_type
	cp $lib_name $product_filename
	rm $lib_name
	
}

function merge_iphoneos_lib()
{
	product_type=$1

	path=$lib_project_path"/build/"$product_type
	echo "合并三个.a包!"
	lipo -create $path/${iphone_arch_types[0]}".a" $path/${iphone_arch_types[1]}".a" $path/${iphone_arch_types[2]}".a" -output $path/$lib_name
}

function merge_iphone_simulator_lib()
{
	product_type=$1

	path=$lib_project_path"/build/"$product_type
	echo "合并三个.a包!"
	lipo -create $path/${iphone_simulator_arch_types[0]}".a" $path/${iphone_simulator_arch_types[1]}".a" -output $path/$lib_name
}

function merge_all_lib()
{


	debug_product_types=("Debug-iphoneos" "Debug-iphonesimulator")
	release_product_types=("Release-iphoneos" "Release-iphonesimulator")

	debug_path0=$lib_project_path"/build/"${debug_product_types[0]}/$lib_name
	debug_path1=$lib_project_path"/build/"${debug_product_types[1]}/$lib_name

	echo "合并4个.a包.输出最终极的总包.$path0"
	lipo -create $debug_path0 $debug_path1 -output $lib_project_output_path/all_in_one_debug.a

	release_path0=$lib_project_path"/build/"${release_product_types[0]}/$lib_name
	release_path1=$lib_project_path"/build/"${release_product_types[1]}/$lib_name

	echo "合并4个.a包.输出最终极的总包.$path0"
	lipo -create $release_path0 $release_path1 -output $lib_project_output_path/all_in_one_release.a
}


function create_iphone_lib()
{
	for iphone_product_type in ${iphone_product_types[*]}
	do
		for iphone_arch_type in ${iphone_arch_types[*]}
		do
    		build_arch $iphone_arch_type $iphone_product_type
		done

		merge_iphoneos_lib $iphone_product_type
	done
}

function create_iphone_simulator_lib()
{
	for iphone_simulator_product_type in ${iphone_simulator_product_types[*]}
	do
		for iphone_simulator_arch_type in ${iphone_simulator_arch_types[*]}
		do
    		build_arch $iphone_simulator_arch_type $iphone_simulator_product_type
		done

		merge_iphone_simulator_lib $iphone_simulator_product_type
	done
}

function main()
{
	echo '生成真机的debug和release的.a包.并各自合并'
	create_iphone_lib
	echo '生成模拟器的debug和release的.a包.并各自合并'
	create_iphone_simulator_lib
	echo '合并debug和release的.a包'
	merge_all_lib
}

main










