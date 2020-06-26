一键为Proxmox VE 添加RTL 8125 2.G网卡驱动,代码还没完成。。。。   [Incomplete linux shell code]

注意[Notice]：请使用root用户编译  [Get superuser permission]

1.食用方法如下 [Usage] :  


2.检查git 是否安装 [Check git installed] 

	root@hostname# apt-get update && apt-get install git  

3.克隆我的仓库  

	root@hostname# git clone https://github.com/tubaxiaosiji/RTL8125-Driver-for-Proxmox-VE.git  

4.切换到目录[Change dir]   

	root@hostname# cd ./RTL8125-Driver-for-Proxmox-VE  

5.赋予运行权限[Chmod]   

	root@hostname# chmod a+x rtl8125_install.sh  

6.运行脚本[Run script in shell]   

	root@hostname# sh ./rtl8125_install.sh  

7.等待一会[Wait for a minutes]...  

8.检查模块是否已安装加载[Check kernel module is loaded]   

	root@hostname# lsmod | grep 'rtl8125'   

9.出现rlt 8125字样即安装成功。  [If show 'rtl8125' is OK!]
