# /bin/bash
# This script is automaticlly complie RTL8125 2.5G ethernet card driver for PVE
# date 2020/4/25 22:35 UTC +8:00
# Get Proxmox VE kernel version 【获取PVE内核版本】

PVE_kernel_version=`uname -r`

kernel_headers_full_version=pve-headers-${PVE_kernel_version}

# Get PVE Full version 【获取当前PVE完整版本】
PVE_version=`pveversion`

# Get PVE Main version 【获取当前PVE主版本，添加订阅源会用到】
PVE_main_version=

# add no subcript source 【添加非订阅用户源】
# NOT recommended for production use 【不建议生产环境中使用】
# PVE pve-no-subscription repository provided by proxmox.com 【非订阅用户软件仓库由proxmox.com提供】


if [ "$PVE_version" == "6" ]; then
	# add PVE 6.0 no subcript to apt source.list
	deb http://download.proxmox.com/debian/pve buster pve-no-subscription
fi


if [ "$PVE_version" == "5" ]; then
	# add PVE 5.0 no subcript to apt source.list
	deb http://download.proxmox.com/debian stretch pve-no-subscription
fi


if [ "$PVE_version" == "4" ]; then
	# add PVE 4.0 no subcript to apt source.list
	deb http://download.proxmox.com/debian jessie pve-no-subscription
fi


if [ "$PVE_version" == "3" ]; then
	# add PVE 3.0 no subcript to apt source.list
	deb http://download.proxmox.com/debian wheezy pve-no-subscription
fi


apt-get update
# Install dependent packages 【安装依赖包】
apt-get install ${kernel_headers_full_version} dkms build-essential


tar -xvf $PWD/r8125-9.003.04.tar
cd r8125-9.003.04

chmod a+x autorun.sh
./autorun.sh

# check loaded kernel modules exist 'rtl8152' keyword

if [ lsmod | grep 'rtl8152' != "" ]; then
	print('RTL8125 driver has been Installed! [恭喜！网卡驱动已加载！]')
}
else{
	print('Please confirm your system is PVE and installed PCIE RTL8125 2.5G ethernet card on your mainboard.  [请确认您的系统是PVE，并且安装好了Rlt 8125网卡在主板PCIE卡槽上。]')
}
