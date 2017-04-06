## 项目说明
项目为完整前端项目，由[fisp](http://fis.baidu.com)构建，文件夹中包含fis-conf.js为一个模块.   
主要模块有: common, news, bbs, match, user, admin, events   
output: 为前端发布目录，包含 template, config, plugin目录，为前端模板目录.   
静态资源发布到CDN http://w1.hoopchina.com.cn/hybrid/static 下，请在本地保持与CDN的svn目录的相对位置.    
dist: 生成离线包的目录，不要加入版本管理   
node_modules: 生成离线包需要的开源模块，不需要加入版本管理

## 脚本说明
devToBBSTest.sh: 发布论坛相关代码到测试环境   
devToQiuTest.sh: 发布比赛相关代码到测试环境    
build.conf.js: 生成离线包配置文件   
build.js: 生成离线包脚本   

## 命令说明
npm run bulid: 生成客户端需要离线包, 将此包交给客户端使用.

## 测试环境
192.168.9.28 有两个目录对应不同地址,用于项目并行时测试, 本地对应test, test1发布节点   
访问域名对应 http://test.mobileapi.hupu.com, http://test1.mobileapi.hupu.com

## 发布说明
kqbbs_front_end_stg  看球论坛预发布  
kqbbs_front_end  看球论坛线上正式  

kanqiu_front_end_stg   看球预发布  
kanqiu_front_end 看球线上正式  

代码通过merge request的方式合并到master，打Tag发布.

## 接口文档wiki
看球论坛Hybrid相关接口: <http://wiki.hc.dev/pages/viewpage.action?pageId=204832989>  
新闻H5接口: <http://wiki.hc.dev/pages/viewpage.action?pageId=221184106>    
其他接口: <http://wiki.hc.dev/pages/viewpage.action?pageId=250085724>


## 线上域名 & 线下域名 & 预发布
> 看球线上域名: http://games.mobileapi.hupu.com (hybrid页面) & http://kanqiu.hupu.com (分享页面)  
> 论坛线上域名: http://bbs.mobileapi.hupu.com   

> 看球线下域名: http://test.mobileapi.hupu.com & http://kanqiu-test.hupu.com
> 论坛线上域名: http://bbs-test.mobileapi.hupu.com  

> 看球线下域名: http://games-pre.mobileapi.hupu.com & http://kanqiu-pre.hupu.com
> 论坛线上域名: http://bbs-pre.mobileapi.hupu.com

## URL规则
> http(s)://${host}/${device}/${version}/${module}/${page}?${query}&${nopic}&${night}&${client}  

> host: 域名, 不同环境对应不同域名  
> device: 1为android, 2为曾经下架的ios目前已经不存在, 3为ios设备  
> version: 客户端发布的大版本号  
> module: 业务模块 news,bbs等  
> page: 页面action  
> query: 页面需要参数  
> nopic: 无图模式，客户端识别用户网络自动适配，1为无图开启，0为无图关闭  
> night: 夜间模式，客户端设置，1为夜间，0为日间  
> client: 客户端唯一识别码  

## 常用的线上Hybrid页面地址
* 新闻正文  
<http://games.mobileapi.hupu.com/3/7.0.9/news/createNewsDetailH5?nid=122737&client=867068025158311&night=0&nopic=0&leaguesEn=liga&debug>  

* 新闻评论页  
<>

* 论坛正文  
<http://bbs.mobileapi.hupu.com/1/7.0.9/threads/getThreadDetailInfoH5?tid=14763965&pid=0&page=1&fid=160&client=&night=0&nopic=0&debug>   

* 看球前瞻页
<http://games.mobileapi.hupu.com/1/7.0.9/nba/getPreview7?client=867068025158311&gid=151593&night=0>

* 看球战报页
<http://games.mobileapi.hupu.com/1/7.0.9/eurocup/getRecap7?client=867068025158311&gid=10823288&nopic=0&night=0>

* 虎扑TV  
<http://kanqiu.hupu.com/1/7.0.9/room/getHupuTVView?client=867068025158311&night=0>

* 虎扑TV全部主播  
<http://kanqiu.hupu.com/1/7.0.9/room/getAllAnchor?pagetab=all&client=867068025158311>

* 数据TAB-fifa页  
<http://games.mobileapi.hupu.com/1/7.0.9/data/fifa?client=867068025158311&night=0>


* 数据TAB-NBA页(CBA)  
<http://test.mobileapi.hupu.com/3/7.0.9/data/nba?client=2a820772bdca86678c51892d3020e7c49271a960&night=0>
