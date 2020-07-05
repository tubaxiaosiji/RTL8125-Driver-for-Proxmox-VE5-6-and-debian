#!/bin/bash
# This script is automaticlly complie RTL8125 2.5G ethernet card driver for PVE
# date 2020/4/25 22:35 UTC +8:00
# Support Linux kernel version 2.4 to 5.6



# Check rtl8125 kernel module is exist it 【检查驱动是否加载】
check=`lsmod | grep r8125`
if [ "${check}" != "" ]; then
	echo 'RTL8125 driver has been Loaded!'
	echo '恭喜！当前网卡驱动已加载！'
	exit 0
fi


# Get Proxmox VE kernel version 【获取PVE内核版本】
# uname -- get name and information about current kernel

Linux_kernel_version=`uname -r`

uname -r > /tmp/kernel_version.log
check=`grep "pve" /tmp/kernel_version.log`


if [ "${check}" != "" ]; then
    	echo "Checking is pass....!"
	echo '检测通过........'
    	rm /tmp/kernel_version.log
	
	kernel_headers_latest_version=pve-headers-${Linux_kernel_version}
	kernel_image_latest_version=pve-kernel-${Linux_kernel_version}
	
	# Get PVE Full version 【获取当前PVE完整版本】
	PVE_Full_version=`pveversion`
	
	# Get PVE Main version 【获取当前PVE主版本，添加软件仓库源会用到】
	PVE_Main_version=`echo ${PVE_Full_version:12:1}`
else
        echo ''
	while true; do
	    read -p "Warning!!!!!! your system is not Proxmox VE.Maybe there is no matching kernel version in your software source repository，Continue? y/n
	    警告!!!!!您的系统不是PVE，也许您的软件源仓库里没有匹配的内核版本，继续安装？按y继续，按n退出." yn
	    case $yn in
		[Yy]* ) break;;
		[Nn]* ) exit 0;;
		* ) echo "Please answer yes or no.";;
	    esac
	done
	kernel_headers_latest_version=linux-headers-${Linux_kernel_version}
	kernel_image_latest_version=linux-image-${Linux_kernel_version}
	
	echo "Your Linux Kernel version is ${Linux_kernel_version}"
	echo "你的 Linux Kernel 版本是：${Linux_kernel_version}"
	echo '-------------------------------------------------------------------------------------'

fi


# Add no subcript source 【添加非订阅用户源】
# NOT recommended for production use 【不建议生产环境中使用】
# PVE pve-no-subscription repository provided by proxmox.com 【非订阅用户软件仓库由proxmox.com提供】

if [ "$PVE_Main_version" == 6 ]; then
	# add PVE 6.0 no subcript to apt source.list
	echo 'deb http://download.proxmox.com/debian/pve buster pve-no-subscription' > /etc/apt/sources.list.d/pve-no-subscription.list
	echo 'adding no subcript source to /etc/apt/sources.list.d/pve-no-subscription.list.....'
elif [ "$PVE_Main_version" == 5 ]; then
	# add PVE 5.0 no subcript to apt source.list
	echo 'deb http://download.proxmox.com/debian stretch pve-no-subscription' > /etc/apt/sources.list.d/pve-no-subscription.list
	echo 'adding no subcript source to /etc/apt/sources.list.d/pve-no-subscription.list.....'
else 
	echo 'Your system is not Proxmox VE that No deb source add to apt source.list.'
	echo '因为你不是PVE系统，所以没有添加任何软件源.'
	echo '-------------------------------------------------------------------------------------'
	
fi


echo 'try install dependent packages[dkms build-essential make gcc libelf-dev]....'
echo '尝试安装依赖包【dkms build-essential make gcc libelf-dev】....'	
sleep 5

apt-get update
apt-get install ${kernel_headers_latest_version} ${kernel_image_latest_version}
# Install dependent packages 【安装依赖包】
apt-get -y install dkms build-essential make gcc libelf-dev


tar vjxf $PWD/r8125-9.003.05.tar.bz2
cd r8125-9.003.05

chmod a+x autorun.sh
./autorun.sh

if [ $? == 0 ]; then
	echo ''
	echo ''
	echo 'RTL8125 driver has been compiled! please try run:[ lsmod | grep r8125 ]'
	echo '恭喜！8125网卡驱动已编译！请输入检测命令:[ lsmod | grep r8125 ]'
	echo '-------------------------------------------------------------------------------------'
	echo 'If show modprobe: ERROR: could not insert 'r8125': Invalid argument,Please reboot system, and try it again. '
	echo '如果出现 modprobe: ERROR: could not insert 'r8125': Invalid argument,请重启系统.再来一次。'
	exit 0
else 
	echo ''
	echo ''
	echo 'Please confirm your system version is latest released ，or try [sudo apt-get upgrade] ' 
	echo 'If your system is not Proxmox VE, try manually install [linux-complier-gcc-xx package]'
	echo '-------------------------------------------------------------------------------------'
	echo '请尝试更新系统版本 [sudo apt-get upgrade]'
	echo '如果你的系统不是纯PVE版本, 请尝试手动安装 [linux-complier-gcc-xx] 组件。'
	exit -1
fi
