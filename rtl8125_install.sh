# /bin/bash
# This script is automaticlly complie RTL8125 2.5G ethernet card driver for PVE
# date 2020/4/25 22:35 UTC +8:00
# Get Promox env version

PveVersion=`uname -r`
sed xx $PveVersion xxxx


if 6.0 == PveVersion{
	add PVE 6.0 no subcript to apt source.list
}

if 5.0 == PveVersion{
	add PVE 5.0 no subcript to apt source.list
}

if 4.0 == PveVersion{
	add PVE 5.0 no subcript to apt source.list
}




apt-update
# Install dependent packages

apt-get install ${PveVersion_kernel_Headers} dkms build-essential



tar -xvf $PWD/r8125-9.003.04.tar
cd r8125-9.003.04
chmod a+x xx.sh
./xx.sh

# check loaded kernel modules exist 'rtl8152' keyword
lsmod | grep '8152'
if [ is ture]{
	print('RTL8125 driver has been Installed!')
}
else{
	print('Please confirm your system is PVE.')
}
