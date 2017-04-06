#! /bin/bash
qiumodules=("common" "match")

#m站同时并行多个项目, 存在多个分支，设置两个测试环境
#qa38, qatest两个节点，对应的分别是开发环境和测试环境
#local节点，为前端独立发布准备，发布代码到本地文件夹../output, 前端代码上线到固定目录
dev="qiutest"

for mod in ${qiumodules[@]}
do
echo "It's ready to release [$mod] ...";
cd $mod;
#fisp release -Dopmd $dev;
fisp release -opmd $dev;
cd ..;
done
echo ">>>>>>>>>>All modules is released!<<<<<<<<<<<";

#当前文件夹下产出的 output 文件夹就是要的东西了.
#根据服务器的部署路径，修改下路径.
