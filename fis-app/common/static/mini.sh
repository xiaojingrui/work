#! /bin/sh
version="1.0.7"
echo "mini start"
uglifyjs ./watch.js -m -o ./watch.app.$version.js
cp ./watch.app.$version.js ~/work/b1/js/watch
rm ./watch.app.$version.js
echo "mini end"
