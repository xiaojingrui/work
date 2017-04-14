echo ">>>>>>>>>>All modules start release static<<<<<<<<<<<";
modules=("common" "home" "bbs" "news" "match" "teams" "my" "events")
node="local"
for mod in ${modules[@]}
do
echo "It's ready to release [$mod] ...";
cd $mod;
fisp release -Dopmd $node;
cd ..;
done
echo ">>>>>>>>>>All modules is released!<<<<<<<<<<<";
cd output;
svn add . --force;
svn commit -m "refs add local frontend tpl auto commit";
