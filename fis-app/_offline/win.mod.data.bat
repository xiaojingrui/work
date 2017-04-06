set name=data.zip
set output=./dist
set buildZip=./zip.js

rm -rf %output%
npm run data
sleep 3
node %buildZip% %output% %name%
