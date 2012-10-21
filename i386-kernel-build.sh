#!/bin/bash

BUILD_PATH=/home/koneca/systemx86/builds/kernel
SRC_DIR=linux-3.4.11
ARCH=i386
CMD=defconfig

export CMD=$CMD
export ARCH=$ARCH
export SRC_DIR=$SRC_DIR
export BUILD_PATH=$BUILD_PATH

check_src() {
	echo "### checking if Kernel Sources exists"
	if [ -d "$SRC_DIR" ]; then
		echo ""
	else
		echo "### Kernel sources not found"
		if [ -e "$SRC_DIR.tar.bz2" ]; then
			echo "### found local sources archive"
		else
			echo "### downloading Kernel sources archives from kernel.org"
			wget -nv "http://www.kernel.org/pub/linux/kernel/v3.0/$SRC_DIR.tar.bz2"
		fi
		echo "### extracting Kernel sources" 
		tar -xjf "$SRC_DIR.tar.bz2"
	fi
	if [ -d "$BUILD_PATH/$ARCH" ]; then
		echo ""
	else
		echo "### creating Build-path in $BUILD_PATH/$ARCH"
		mkdir -p "$BUILD_PATH/$ARCH"
	fi
}

make_cmd() {
	check_src
	echo "### make -C $SRC_DIR O=$BUILD_PATH ARCH=$ARCH $CMD"
	make -C $SRC_DIR O=$BUILD_PATH/$ARCH ARCH=$ARCH $CMD
}

build_kernel () {
	check_src
	echo "Using $BUILD_PATH/$ARCH/.config"
	if [ -e "$BUILD_PATH/$ARCH/.config" ]; then
		echo ""
	else 
		echo "### .config not found"
		echo "### creating defconfig"
		CMD=defconfig
		make_cmd
	fi
	CMD=
	echo "### ready to build Kernel!"
	echo "### Hit Enter to proceed."
	echo "------------------------------------------------------"
	read inp
	time make_cmd
}
startmenu() {
	echo "enter your choice:"
	read inp	
	case "$inp" in
		"config")
			CMD=menuconfig
			make_cmd
			echo "### done configuration!"
		;;
		"arch")
			echo ""
			echo "### Please type in your targeted architecture:"
			read inp
			ARCH=$inp
			echo "### Target architecture is now $ARCH!"
		;;
		"path")
			echo ""
			echo "### please type in abs buildpath"
			read inp
			BUILD_PATH=$inp
			echo "### Target build-path is now $BUILD_PATH!"
		;;
		"distclean")
			CMD=distclean
			make_cmd
			echo "### done distclean!"
		;;
		"mrpropper")
			CMD=mrpropper
			make_cmd
			echo "### done mrpropper!"
		;;
		"exit")
			echo "### exit program"
			exit 0
		;;
		*)
			build_kernel
			echo "### done build kernel $ARCH in $BUILD_PATH!"
		;;
	esac
}

clear
while true
do
	echo ""
	echo ""
	echo "======================================================"
	echo "    Building kernel for i386 arch"
	echo ""
	echo ""
	echo "Options:"
	echo "    config                         execute menuconfig"
	echo "    clean, distclean, mrpropper    src cleanup"
	echo "    path                           choose buildpath"
	echo "    arch                           choose target arch"
	echo "    exit                           exit kernel build"
	echo ""
	echo " or leave blank for default build procedure"
	echo "------------------------------------------------------"
	startmenu
done
