#!/bin/bash

echo "Start build"

#安装必须的软件
sudo apt-get install gcc git wget make libncurses-dev flex bison gperf python python-serial python-pip

cd ~
#切换到用户目录

#搭建工作环境，用于分类存放需要的东西
mkdir -p ~/work/tool
#创建工具目录
mkdir -p ~/work/sources
#创建源码目录
mkdir -p ~/work/project
#创建工程目录

# 安装交叉编译链
if [ $(getconf LONG_BIT)="32" ]; then
echo "你的系统是 32 位的操作系统"
wget https://dl.espressif.com/dl/xtensa-esp32-elf-linux32-1.22.0-80-g6c4433a-5.2.0.tar.gz
#获取32位的交叉编译链
sudo tar xvf xtensa-esp32-elf-linux32-1.22.0-80-g6c4433a-5.2.0.tar.gz -C /opt/
#将交叉编译链解压到opt文件夹下
else
echo "你的系统是 64 位的操作系统"
wget https://dl.espressif.com/dl/xtensa-esp32-elf-linux64-1.22.0-80-g6c4433a-5.2.0.tar.gz
#获取交叉编译链
sudo tar xvf xtensa-esp32-elf-linux64-1.22.0-80-g6c4433a-5.2.0.tar.gz -C /opt/
#将交叉编译链解压到opt文件夹下
fi

cd ~/work/sources/
#切换到源码目录下
git clone --recursive https://github.com/espressif/esp-idf.git
#获取 ESp32 的SDK

echo export IDF_PATH="~/work/sources/esp-idf" >> ~/.bashrc
echo export PATH="$PATH:/opt/xtensa-esp32-elf/bin" >> ~/.bashrc
#设置环境变量
source ~/.bashrc
#更新环境变量

pip install --user -r /home/moqi/work/sources/esp-idf/requirements.txt
#安装工具
sudo usermod -a -G dialout $USER
#修改串口权限, 便于下载
reboot
#重启电脑

