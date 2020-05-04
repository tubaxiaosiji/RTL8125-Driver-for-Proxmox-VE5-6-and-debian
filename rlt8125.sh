# /bin/bash
# This script is auto complie RLT8125 driver for PVE
# date 2020/4/25 22:35 UTC +8:00

# author: shawen
main_version=akw 'xx'
YOUR_PVE_KERNEL_SUB_VERSION=`uname -r`
if [find $(YOUR_PVE_KERNEL_SUB_VERSION)!='PVE']
	echo 'Your system is not PVE, please check your system'
	exit 2
fi
apt-get install dkms build-essential pve-headers-$(YOUR_PVE_KERNEL_SUB_VERSION) pve-headers-$(main_version)
wget https://realtekcdn.akamaized.net/rtdrivers/cn/nic1/r8125-9.003.04.tar.bz2?__token__=exp=1587817507~acl=/rtdrivers/cn/nic1/r8125-9.003.04.tar.bz2~hmac=b1da9784dd3084c05da9c412cd6787ebcc7211d63b724e2ab897855cd12bec71
ls
tar -xzvf ./rtdrivers/cn/nic1/r8125-9.003.04.tar.bz2
cd r8125-9.003.04
chmod a+x ./autor
