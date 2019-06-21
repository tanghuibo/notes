#!/bin/bash
#创建文件
gitbook build
#添加所有文件到暂存区
git add .
#提交注释
git commit -m "$1"
#推到远端
git push
#进入发布目录
cd publish
#删除所有非隐藏文件
sudo rm -rf *
#拷贝_book下的文件
cp -r ../_book/. ./
#提示用户提交文件
echo "请手动运行: ./.push.sh \"$1\" (命令已被复制到剪切板)" 
echo "./.push.sh \"$1\"" | xclip -selection clipboard 