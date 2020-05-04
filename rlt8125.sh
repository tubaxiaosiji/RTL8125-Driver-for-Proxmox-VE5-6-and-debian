# /bin/bash
# This script is automaticlly complie RLT8125 driver for PVE
# date 2020/4/25 22:35 UTC +8:00
# Check your PVE version
PveVersion=`uname -r`
sed xx $PveVersion xxxx

if PveVersion=5.0{
	add PVE 5.0 no subcript to apt source.list
}

if PveVersion=6.0{
	add PVE 6.0 no subcript to apt source.list
}

if PveVersion=4.0{
	add PVE 4.0 no subcript to apt source.list
}

apt-update

apt-get install ${PveVersion_kernel_Headers}

tar -xvf $PWD/r8125-9.003.04.tar
cd r8125-9.003.04
chmod a+x xx.sh
./xx.sh
# check loaded kernel modules exist 'rtl8152' keyword
lsmod | grep '8152'
if [ is ture]{
	print('RLT8125 driver has been Installed!')
}
else{
	print('Please tay again.')
}
