# /bin/bash
# This script is automaticlly complie RTL8125 2.5G ethernet card driver for PVE
# date 2020/4/25 22:35 UTC +8:00

# Check rtl8125 kernel modules exist it 【检查驱动是否加载】
check=`lsmod | grep rtl8152`
if [ "$check" != "" ]; then
	echo 'RTL8125 driver has been Installed! [恭喜！当前网卡驱动已加载！]'
	exit 0
fi
# Get Proxmox VE kernel version 【获取PVE内核版本】

Linux_kernel_version=`uname -r`

# Get Proxmox VE kernel version 【获取PVE内核版本】

uname -r > /tmp/PVE_kernel_version.log
check=`grep "pve" /tmp/PVE_kernel_version.log`
pve_kernel_headers_version=''
if [ "${check}" != "" ]; then
        echo "Check is OK! [检测通过........]"
        rm /tmp/PVE_kernel_version.log
	pve_kernel_headers_version=pve-headers-${Linux_kernel_version}
	# Get PVE Full version 【获取当前PVE完整版本】
	PVE_Full_version=`pveversion`
	# Get PVE Main version 【获取当前PVE主版本，添加软件仓库源会用到】
	PVE_Main_version=`echo ${PVE_Full_version:12:1}`
else
        echo ''
	while true; do
	    read -p "Warning, your system is not Proxmox VE.Maybe there is no matching kernel version in your software source repository，Continue? y/n
	    [警告，您的系统不是PVE，也许您的软件源仓库里没有匹配的内核版本，继续安装？按y继续，按n退出.]" yn
	    case $yn in
		[Yy]* ) break;;
		[Nn]* ) exit 0;;
		* ) echo "Please answer yes or no.";;
	    esac
	done
	pve_kernel_headers_version=linux-headers-${Linux_kernel_version}
	echo "Your Linux Kernel version is ${Linux_kernel_version}"
	echo "你的 Linux Kernel 版本是：${Linux_kernel_version}"

fi



# Add no subcript source 【添加非订阅用户源】
# NOT recommended for production use 【不建议生产环境中使用】
# PVE pve-no-subscription repository provided by proxmox.com 【非订阅用户软件仓库由proxmox.com提供】


if [ "$PVE_Main_version" == 6 ]; then
	# add PVE 6.0 no subcript to apt source.list
	deb http://download.proxmox.com/debian/pve buster pve-no-subscription
elif [ "$PVE_Main_version" == 5 ]; then
	# add PVE 5.0 no subcript to apt source.list
	deb http://download.proxmox.com/debian stretch pve-no-subscription
elif [ "$PVE_Main_version" == 4 ]; then
	# add PVE 4.0 no subcript to apt source.list
	deb http://download.proxmox.com/debian jessie pve-no-subscription
elif [ "$PVE_Main_version" == 3 ]; then
	# add PVE 3.0 no subcript to apt source.list
	deb http://download.proxmox.com/debian wheezy pve-no-subscription
else 
	echo 'Your system is not Proxmox VE that No deb source add to apt source.list. [因为你不是PVE系统，所以没有添加任何软件源.]'
fi


apt-get update
# Install dependent packages 【安装依赖包】
apt-get install ${pve_kernel_headers_version} dkms build-essential 


tar -xvf $PWD/r8125-9.003.04.tar
cd r8125-9.003.04

chmod a+x autorun.sh
./autorun.sh

if [ $? == 0 ]; then
	echo 'RTL8125 driver has been Installed! [恭喜！网卡驱动已加载！]'
	exit 0
else 
	echo 'Please confirm has installed RTL8125 2.5G PCIE　ethernet card on your mainboard.  [请确认安装好了Rlt 8125网卡在主板PCIE卡槽上。]'
	exit -1
fi
