#! /bin/sh
offline=("data" "news" "bbs" "exam")

rm -rf ./offlinepkg/*

for mod in ${offline[@]}
do
echo "It's ready to release [$mod] ...";
sh module.sh $mod
cp ./dist/$mod.zip ./offlinepkg/
echo "[$mod] was released!";
echo "=========================== 华丽丽的分割线 =======================";
done
