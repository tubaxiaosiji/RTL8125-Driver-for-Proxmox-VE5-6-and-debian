一键为Promox VE 添加RTL 8125驱动  
1.食用方法如下 [Usage] :  
2.检查git 是否安装 [Check git installed] :apt-get update && apt-get install git  
3.克隆我的仓库：git clone https://github.com/tubaxiaosiji/RTL8125-Driver-for-Proxmox-VE.git  
4.切换到目录[change dir] cd ./RTL8125-Driver-for-Proxmox-VE  
5.赋予权限[chmod] chmod a+x RTL8125.sh  
6.运行脚本[shell] sh ./RLT8125.sh  
7.等待一会[wait for minutes]...  
8.检查模块是否安装加载[check kernel module loaded] lsmod | grep 'rtl8125'  
9.出现2行rlt 8125字样即安装成功。[OK！] 
