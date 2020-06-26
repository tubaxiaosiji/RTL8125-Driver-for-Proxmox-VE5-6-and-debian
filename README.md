
        一键为Proxmox VE 添加RTL 8125 2.G网卡驱动,代码还没完成。。。。       [Incomplete linux shell code]          
   
注意[Notice]:           
              
Get superuser permission 【请使用root用户编译】                   
Add no subcript source 【添加非订阅用户源】     
NOT recommended for production use 【不建议生产环境中使用】                  
PVE pve-no-subscription repository provided by proxmox.com 【非订阅用户软件仓库由proxmox.com提供】   
Support Proxmox VE 3.0-6.0 (include 6.2.x) 【支持PVE 3.0-6.0 系统，包括6.2.x 】     	
r8125-9.003.04.tar provided by Realtek.com 【r8125-9.003.04.tar由Realtek官网提供】
			
1.食用方法如下 [Usage] :  
		

2.安装git和它的依赖组件  [Install git and dependent packages] 

	root@hostname# apt-get update && apt-get install git  

3.克隆我的仓库  [Clone my .git]

	root@hostname# git clone https://github.com/tubaxiaosiji/RTL8125-Driver-for-Proxmox-VE.git  

4.切换到目录	  [Change dir]   

	root@hostname# cd ./RTL8125-Driver-for-Proxmox-VE  

5.赋予运行权限   [Chmod]   

	root@hostname# chmod a+x rtl8125_install.sh  

6.运行脚本    [Run script in shell]   

	root@hostname# sh ./rtl8125_install.sh  

7.等待一会      [Wait for a minutes]...  



8.检查模块是否已安装加载[Check kernel module is exist it]   

	root@hostname# lsmod | grep 'rtl8125'   
	

9.出现 rlt 8125字样即安装成功。  [If show 'rtl8125' that is OK!]
