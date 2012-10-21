#!/bin/bash

BUILD_PATH=/home/koneca/systemx86/builds/kernel
SRC_DIR=linux-3.4.11
ARCH=i386
CMD=defconfig

make_cmd() {
		echo "make -C $SRC_DIR O=$BUILD_PATH ARCH=$ARCH $CMD"
		make -C $SRC_DIR O=$BUILD_PATH/$ARCH ARCH=$ARCH $CMD
}

build_kernel () {
	if [ -d "$BUILD_PATH/$ARCH" ]; then
		echo ""
	else
		echo "$BUILD_PATH/$ARCH"
		mkdir -p "$BUILD_PATH/$ARCH"
	fi
	if [ -e "$BUILD_PATH/$ARCH.config" ]; then
		echo "Building Kernel"
		make_cmd
	else 
		echo ".config not found"
		echo "creating defconfig"
		read inp
		CMD=defconfig
		make_cmd
		CMD=
		make_cmd
		echo "done kernel build!"
	fi
}
startmenu() {
	read inp	
	case "$inp" in
		"help")
			echo "Options:"
			echo "    config                         execute menuconfig"
			echo "    clean, distclean, mrpropper    src cleanup"
			echo "    path                           choose buildpath"
			echo "    arch                           choose target arch"
			echo "    blank                          for default build"
			echo "    exit                           exit kernel build"
		;;
		"config")
			CMD=menuconfig
			make_cmd
			echo "done configuration!"
		;;
		"arch")
			read inp
			ARCH=$inp
			echo "Target architecture is now $ARCH!"
		;;
		"path")
			echo "please type in abs buildpath"
			read inp
			BUILD_PATH=$inp
			echo "Target build-path is now $BUILD_PATH!"
		;;
		"distclean")
			CMD=distclean
			make_cmd
			echo "done distclean!"
		;;
		"mrpropper")
			CMD=mrpropper
			make_cmd
			echo "done mrpropper!"
		;;
		"exit")
			echo "exit program"
			exit 0
		;;
		*)
			time
			build_kernel
			echo "done build kernel $ARCH in $BUILD_PATH!"
		;;
	esac
}

clear
echo ""
echo "======================================================"
echo "    Building kernel for i386 arch"
echo ""
	echo "    type \"help\"  for information"
	echo "    or leave blank for continue default build"
	echo "------------------------------------------------------"
while true
do
	startmenu
done



