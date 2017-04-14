#!/bin/sh
env="offline";
cd ./;
rm -rf dist;
gulp;
cp -r ./img ./dist/
if [ $env = "offline" ]; then
	scp -r ./dist/* root@192.168.9.29:/root/www/2015journey/	
fi

if [ $env = "prod" ]; then
	echo "sss";
fi

