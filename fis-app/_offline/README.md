# 说明
运行在客户端内部的离线H5单页应用，需要保证离线工作，静态资源全部离线，后期配合客户端可以离线升级

## 安装
基于vue构建的离线单页
1.需要安装配置环境 node version > 5.0.0
2.安装webpack

## 编译包脚本

    #! /bin/sh
    name="offline.zip"
    output="./dist"
    buildZip="./zip.js"

    rm -rf $output
    echo "正在编译最新版本...."
    npm run build
    echo "正在打包...."
    node $buildZip $output $name
    echo "正在传输到测试机...."
    scp $output/$name root@192.168.9.29:/root/www/hybrid/
