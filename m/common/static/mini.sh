#! /bin/sh
version="1.0.3"
echo "mini start"
uglifyjs ./watch.js -m -o ./watch.m.$version.js
cp ./watch.m.$version.js ~/work/b1/js/watch
rm ./watch.m.$version.js
echo "mini end"
