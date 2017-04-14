#! /bin/bash
#svn up
modules=("common" "home" "news" "bbs" "news" "my" "teams" "match")

#m站同时并行多个项目, 存在多个分支，设置两个测试环境
#qa52detach, qa52cn两个节点，对应的域名分别是 m.hupu.com, m.hupu.cn
#为了产品测试方便，m.hupu.com 域名测试主要项目，m.hupu.cn 测试分支项目
#local节点，为前端独立发布准备，发布代码到本地文件夹../output, 前端代码上线到固定目录
dev="qa52detach"

for mod in ${modules[@]}
do
echo "It's ready to release [$mod] ...";
cd $mod;
#fisp release -Dopmd $dev;
fisp release -opmd $dev;
cd ..;
sleep 1;
done
echo ">>>>>>>>>>All modules is released!<<<<<<<<<<<";

#当前文件夹下产出的 output 文件夹就是要的东西了.
#根据服务器的部署路径，修改下路径.
