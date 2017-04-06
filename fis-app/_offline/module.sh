#! /bin/sh
#
name=$1".zip"
output="./dist"
buildZip="./zip.js"

rm -rf $output
echo "正在编译最新版本...."
npm run $1
echo "正在打包...."
sleep 1
cd $output
zip -q -r $name .
#echo "正在传输到测试机...."
#scp $output/$name root@192.168.9.29:/root/www/hybrid/
