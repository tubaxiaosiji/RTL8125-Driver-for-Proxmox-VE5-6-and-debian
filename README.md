一键为Proxmox VE 添加RTL 8125 2.G网卡驱动  [暂时未完成。。。]incomplete linux shell code  
注意[Notice]：请使用root用户编译  [get superuser permission]

1.食用方法如下 [Usage] :  


2.检查git 是否安装 [Check git installed] 

	root@hostname#apt-get update && apt-get install git  

3.克隆我的仓库  

	root@hostname#git clone https://github.com/tubaxiaosiji/RTL8125-Driver-for-Proxmox-VE.git  

4.切换到目录[change dir]   

	root@hostname#cd ./RTL8125-Driver-for-Proxmox-VE  

5.赋予权限[chmod]   

	root@hostname#chmod a+x rtl8125_install.sh  

6.运行脚本[run script in shell]   

	root@hostname#sh ./rtl8125_install.sh  

7.等待一会[wait for a minutes]...  

8.检查模块是否已安装加载[check kernel module is loaded]   

	root@hostname# lsmod | grep 'rtl8125'   

9.出现2行rlt 8125字样即安装成功。  [show 2 lines 'rtl8125' is OK！]
