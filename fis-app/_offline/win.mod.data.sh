name="data.zip"
output="./dist"
buildZip="./zip.js"

rm -rf $output
npm run data
sleep 3
node $buildZip $output $name
