echo ">>>>>>>>>>All tpl start compile<<<<<<<";
ssh root@192.168.8.52 << remotessh
rm -f /data/www-data/hupu.com/front-end/templates_c/*;
php ~/complie.php;
cd /root/frontend-tpl/;
svn up;
cp /data/www-data/hupu.com/front-end/templates_c/* /root/frontend-tpl/output/templates_c/;
cd /root/frontend-tpl/output/templates_c/;
svn add . --force;
svn commit -m "refs frontend tpl auto commit";
remotessh
echo ">>>>>>>>>>All tpl end compile<<<<<<<";
