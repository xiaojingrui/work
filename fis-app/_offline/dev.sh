#! /bin/sh
#
name="offline.zip"
output="./dist"
buildZip="./zip.js"

rm -rf $output
echo "正在编译最新版本...."
npm run build
echo "正在打包...."
#node $buildZip $output $name
cd $output
zip -q -r $name .
#mv $name $output
#echo "正在传输到测试机...."
#scp $output/$name root@192.168.9.29:/root/www/hybrid/
