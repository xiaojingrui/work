<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8"/>
<title>{%$data.header.str_title%}</title>
<meta name="viewport" content="initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
<meta name="format-detection" content="telephone=no">
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />

<meta name="keywords" content="虎扑体育,虎扑,体育,运动" />
<meta name="description" content="虎扑体育" />
<link rel="apple-touch-icon" href="//b3.hoopchina.com.cn/touch/resource/events/2015journey/avatar.png"/>
<script src="//b3.hoopchina.com.cn/web/module/dace/m/m_dace.js"></script>
<script src="//res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
{%$host="//b3.hoopchina.com.cn/touch/resource/events/2015journey/"%}
{%$ver="2016011502"%}
<link rel="stylesheet" type="text/css" href="{%$host%}css/main.css?ver={%$ver%}" />
<script type="text/javascript">
	window.pager = {
		isLogin: {%intval($_islogin)%},
        userType: {%intval($data.havedata)%},
        title: '{%$share_config["title"]%}',
        ver:"{%$ver%}",
		isWeixin: (function(){
			return /MicroMessenger|kanqiu/i.test(navigator.userAgent);
		})(),
		host:"{%$host%}",
		showData: {%json_encode($data)%}
	};

  wx.config({
    debug: false,
    appId: '{%$config["appId"]%}',
    timestamp: '{%$config["timestamp"]%}',
    nonceStr: '{%$config["nonceStr"]%}',
    signature: '{%$config["signature"]%}',
    jsApiList: [
        'onMenuShareTimeline','onMenuShareAppMessage', 'onMenuShareQQ', 'onMenuShareWeibo', 'onMenuShareQZone'
    ]
  });
  wx.ready(function () {
    var shareData = {
        title: '{%$share_config["title"]%}',
        desc: '{%$share_config["desc"]%}',
        link: '{%$share_config["share_url"]%}',
        imgUrl: '{%$share_config["headimgurl"]%}',
        success:function(){

        },
        cancel:function(){
        }
    };
    wx.onMenuShareTimeline(shareData);
    wx.onMenuShareAppMessage(shareData);
    wx.onMenuShareQQ(shareData);
    wx.onMenuShareWeibo(shareData);
    wx.onMenuShareQZone(shareData);
  });
</script>
</head>
<body>
<div style="width:0px; height:0px; overflow:hidden"><img src="//b3.hoopchina.com.cn/touch/resource/events/2015journey/avatar.png" /></div>
<canvas id="background"></canvas>
<div id="loading">
    <div class="loading-main">
        <div class="loading-icon"></div>
        <p>正在载入，请稍后...<span class="load-show"></span></p>
    </div>
</div>
<div class="m-wrap" id="page-container">
    <div id="index" class="m-page" data-page="index">
        <script type="text/template" id="index-tpl">
            <@if(userType == 1 || userType == 2){@>
            <div class="center">
            <div class="head">
            <div class="inner">
            <img src="<@=avatar@>" width="42" alt="">
            </div>
            </div>
            <div class="name"><@=user.nickname@></div>
            <div class="earth">
            <a class="earth-title" href="//m.hupu.com" target="_blank">hupu.com</a>
            <canvas class="earth-pos"></canvas>
            <img src="<@=host@>img/uindex-earth.png" width="240" alt="">
            </div>
            </div>
            <ul class="text-list">
            <@=text@>
            </ul>
            <div class="index-see text-shadow2"><@=header.str_top_bt@></div>
            <@}else{@>
            <div class="avatar"><img src="<@=host@>img/index-head.png" alt="" /></div>
            <div class="earth">
            <canvas class="earth-pos"></canvas>
            <img src="<@=host@>img/uindex-earth.png" width="240" alt="">
            </div>
            <div class="index-text1 text-shadow"><em>07</em> 01月, 2004</div>
            <div class="index-text2 text-shadow">周三 美国，芝加哥</div>
            <div class="index-text3 text-shadow">hoopCHINA 诞生!</div>
            <div class="mine text-shadow" dace-node="0001_0004">查看我的2015</div>
            <div class="index-see text-shadow2"><@=header.str_top_bt@></div>
            <@}@>
        </script>
    </div>


    <script type="text/template" id="first-list-tpl">
        <ul class="ui-transform-text <@ if( typeof className !== 'undefined'  ) { @><@=className@><@ } @>">
            <@ _.each(datas, function(item,index) { @>
            <li>
                <@ if(!_.isEmpty(item.time)){ @>
                <div class="times"><@=item.time@></div>
                <@ } @>
                <div class="info">
                    <@=item.str@>
                    <@ if(!_.isEmpty(item.text)){ @>
                    <span class="color-orange"><@=item.text@></span>
                    <@ } @>
                </div>
            </li>
            <@ }); @>
        </ul>
    </script>



    <script type="text/template" id="tips-info-tpl">
        <div class="ui-tips-info">
            <@ if( typeof posts !== "undefined" && posts !== "0"  ) { @>
            <span class="list">发表了<span class="color-orange"><@=posts@></span>篇帖子</span>
            <@ } @>
            <@ if( typeof reply !== "undefined" && reply !== "0" ) { @>
            <span class="list">发了<span class="color-orange"><@=reply@></span>条回复</span>
            <@ } @>
            <@ if( typeof light !== "undefined" && light !== "0" ) { @>
            <span class="list">回帖获得<span class="color-orange"><@=light@></span>个点亮</span>
            <@ } @>
            <@ if( typeof games !== "undefined" && games !== "0" ) { @>
            <span class="list">看过<span class="color-orange"><@=games@></span>场比赛</span>
            <@ } @>
            <@ if( typeof a_aoye !== "undefined" && a_aoye !== "0" ) { @>
            <span class="list o-list">熬了<span class="color-orange"><@=a_aoye@></span>个夜晚</span>
            <@ } @>
        </div>
    </script>

    <script type="text/template" id="islogin-data-tips">
        <ul class="ui-islogin-tips">
            <@ if( typeof posts !== "undefined" && posts !== "0"  ) { @>
            <li>
                        <span class="box">
                          <span class="labe">发帖数</span><span class="color-blue"><@=posts@></span>
                        </span>
            </li>
            <@ } @>
            <@ if( typeof reply !== "undefined" && reply !== "0" ) { @>
            <li>
                      <span class="box">
                          <span class="labe">回帖数</span><span class="color-blue"><@=reply@></span>
                      </span>
            </li>
            <@ } @>
            <@ if( typeof light !== "undefined" && light !== "0" ) { @>
            <li>
                      <span class="box">
                          <span class="labe">点亮数</span><span class="color-blue"><@=light@></span>
                      </span>
            </li>
            <@ } @>
            <@ if( typeof games !== "undefined" && games !== "0" ) { @>
            <li>
                      <span class="box">
                          直播比赛数<span class="color-orange"><@=games@></span>
                      </span>
            </li>
            <@ } @>
            <@ if( typeof hot_game !== "undefined" && hot_game !== "0" ) { @>
            <li>
                      <span class="box">
                          最热门比赛<span class="color-orange"><@=hot_game@></span>
                      </span>
            </li>
            <@ } @>
            <@ if( typeof focusteam_name !== "undefined" && focusteam_name !== "0" ) { @>
            <li>
                      <span class="box">
                          最受关注的球队<span class="color-orange"><@=focusteam_name@></span>
                      </span>
            </li>
            <@ } @>
            <@ if( typeof focus_player !== "undefined" && focus_player !== "0" ) { @>
            <li>
                      <span class="box">
                          评分最多的球员<span class="color-orange"><@=focus_player@></span>
                      </span>
            </li>
            <@ } @>
        </ul>
    </script>

    <script type="text/template" id="tips-game-tpl">
        <@ if( typeof focus_player !== "undefined" ) { @>
        <div class="ui-user-tips ui-user-tips-right user-comment-tips">
            <div class="user-text">
                评分最多 <@=focus_player@>
            </div>
            <@ if( typeof focus_player_img !== "undefined" ) { @>
            <div class="user-active" style="background-image: url('<@=focus_player_img@>')">
            </div>
            <@ } @>
        </div>
        <@ } @>

        <@ if( typeof focusteam_name !== "undefined" ) { @>
        <div class="ui-user-tips user-live-player">
            <div class="user-text">
                最关注 <@=focusteam_name@>
            </div>
            <@ if( typeof focusteam_img !== "undefined" ) { @>
            <div class="user-active" style="background-image: url('<@=focusteam_img@>')">
            </div>
            <@ } @>
        </div>
        <@ } @>
    </script>

    <!-- 甘比亚 start -->
    <script type="text/template" id="africa-main-tpl">
        <div class="page-content map-content">
            <div class="ui-map" id="J_africaMap">
            </div>
        </div>
    </script>
    <!-- 甘比亚 end -->

    <!-- 装备 start -->
    <script type="text/template" id="zb-main-tpl">
        <div class="page-content map-content">
            <div class="ui-map" id="J_zbMap">

            </div>
        </div>
    </script>
    <!-- 装备 end -->

    <!-- nba start -->
    <script type="text/template" id="nba-main-tpl">
        <div class="page-content map-content">
            <div class="ui-map" id="J_nbaMap">

            </div>

        </div>
    </script>
    <!-- nba end -->

    <!-- cba start -->
    <script type="text/template" id="cba-main-tpl">
        <div class="page-content map-content">
            <div class="ui-map" id="J_cbaMap">

            </div>
        </div>
    </script>
    <!-- cba end -->

    <!-- 中国足球 start -->
    <script type="text/template" id="chinaFootball-main-tpl">
        <div class="page-content map-content">
            <div class="ui-map" id="J_chinaFootMap">

            </div>
        </div>
    </script>
    <!-- 中国足球 end -->

    <!-- 国际足球 start -->
    <script type="text/template" id="football-main-tpl">
        <div class="page-content map-content">
            <div class="ui-map" id="J_footballMap">

            </div>
        </div>
    </script>
    <!-- 国际足球 end -->

    <!-- 个人数据 start -->
    <script type="text/template" id="data-page-tpl">
        <div class="state J-dialog">
            <div class="inner">
                <div>统计</div>
                <div>说明</div>
            </div>
        </div>
        <div class="main">
            <ul class="circle-data clearfix">
                <li class="item1">
                    <div class="mod-annulus">
                        <div class="bg"></div>
                        <div class="round"></div>
                        <div class="bg2"></div>
                        <div class="round2"></div>
                        <div class="num"><div><@=d1@>%</div></div>
                    </div>
                    <div class="title">势力范围</div>
                </li>
                <li class="item2">
                    <div class="mod-annulus">
                        <div class="bg"></div>
                        <div class="round"></div>
                        <div class="bg2"></div>
                        <div class="round2"></div>
                        <div class="num"><div><@=d2@>%</div></div>
                    </div>
                    <div class="title">持久能力</div>
                </li>
                <li class="item3">
                    <div class="mod-annulus">
                        <div class="bg"></div>
                        <div class="round"></div>
                        <div class="bg2"></div>
                        <div class="round2"></div>
                        <div class="num"><div><@=d3@>%</div></div>
                    </div>
                    <div class="title">纯洁指数</div>
                </li>
            </ul>
            <ul class="line-data">
                <li class="item1 clearfix">
                    <div class="fl">生产力</div>
                    <div class="fr">
                        <div class="progress">
                            <div class="inner" style="width:0%">
                                <div class="point point<@=d4@>"><@=d4@>%<i class="triangle-down"></i></div>
                            </div>
                        </div>
                        <div class="desc">
                            <@ if( typeof a_posts !== "undefined" && a_posts !== "0" ) { @>
                            发帖 <@=a_posts@> /
                            <@ } @>
                            <@ if( typeof a_replys !== "undefined" && a_replys !== "0" ) { @>
                            回帖 <@=a_replys@>
                            <@ } @>
                        </div>
                    </div>
                </li>
                <li class="item2 clearfix">
                    <div class="fl">声望值</div>
                    <div class="fr">
                        <div class="progress">
                            <div class="inner" style="width:0%">
                                <div class="point point<@=d5@>"><@=d5@>%<i class="triangle-down"></i></div>
                            </div>
                        </div>
                        <div class="desc">
                            <@ if( typeof a_beitj !== "undefined" && a_beitj !== "0" ) { @>
                            发帖被推荐 <@=a_beitj@> /
                            <@ } @>
                            <@ if( typeof a_beidl !== "undefined" && a_beidl !== "0" ) { @>
                            回帖被点亮 <@=a_beidl@>
                            <@ } @>
                        </div>
                    </div>
                </li>
                <li class="item3 clearfix">
                    <div class="fl">神棍值</div>
                    <div class="fr">
                        <div class="progress">
                            <div class="inner" style="width:0%">
                                <div class="point point<@=d6@>"><@=d6@>%<i class="triangle-down"></i></div>
                            </div>
                        </div>
                        <div class="desc">
                            <@ if( typeof shengun_level !== "undefined" && shengun_level !== "0" ) { @>
                            竞猜胜率 <@=shengun_level@>%
                            <@ } @>
                        </div>
                    </div>
                </li>
                <li class="item4 clearfix">
                    <div class="fl">财富值</div>
                    <div class="fr">
                        <div class="progress">
                            <div class="inner" style="width:0%">
                                <div class="point point<@=d7@>"><@=d7@>%<i class="triangle-down"></i></div>
                            </div>
                        </div>
                        <div class="desc">
                            <@ if( typeof a_sonli !== "undefined" && a_sonli !== "0" ) { @>
                            送礼 <@=a_sonli@>虎扑币 /
                            <@ } @>
                            <@ if( typeof a_dashang !== "undefined" && a_dashang !== "0" ) { @>
                            打赏 <@=a_dashang@>虎扑币
                            <@ } @>
                        </div>
                    </div>
                </li>
            </ul>
        </div>
    </script>
    <script type="text/template" id="data-dialog-tpl">
        <div class="close">×</div>
        <dl>
            <dt>个人能力值定义说明</dt>
            <dd>势力范围：（疆域占领数/全部疆域数）/ %</dd>
            <dd>持久能力：登录天数在虎扑JRs中的排名情况</dd>
            <dd>纯洁指数：（100-被关小黑屋次数*10）%</dd>
            <dd>生产力：以发帖数和回帖数，按一定等级划分</dd>
            <dd>声望值：以发帖被推荐数和回帖被点亮数，按一定等级划分</dd>
            <dd>神棍值：（赢得的竞猜场数/参与的竞猜场数）/ %</dd>
            <dd>财富值：以送礼金额和打赏金额，按一定等级划分</dd>
            <dd>* 以上数据采集时间为 2015.1.1 - 2015.12.25</dd>
        </dl>
    </script>
    <!-- 个人数据 end -->

    <!-- 个人总结 start-->
    <script type="text/template" id="result-tpl">
        <div class="page-content map-content">
            <div class="ui-map" id="J_resultMap">

            </div>

            <div class="result-text">
                <@ _.each(datas, function(item,index) { @>
                <@=item@><br />
                <@ }); @>
            </div>
        </div>
    </script>

    <!-- 个人总结 end-->

    <!-- 虎扑数据 start -->
    <script type="text/template" id="count-tpl">
        <ul>
            <li class="item1">
                <div class="title">总发帖数</div>
                <div class="num">0</div>
            </li>
            <li class="item2">
                <div class="title">总回帖数</div>
                <div class="num">0</div>
            </li>
            <li class="item3">
                <div class="title">新闻总评论数</div>
                <div class="num">0</div>
            </li>
            <li class="item4">
                <div class="title">总点亮数</div>
                <div class="num">0</div>
            </li>
        </ul>
    </script>
    <!-- 虎扑数据 end -->

    <!-- 分享 start -->
    <script type="text/template" id="share-tpl">
        <div class="earth">
            <img src="<@=host@>img/share-earth.png" width="80" alt="">
        </div>
        <div class="mod-text">
            <i class="triangle-bottomright"></i>
            <p>我们的征途是星辰大海，2016未完待续......</p>
        </div>
        <@if(isWeixin){@>
        <div class="bottom weixin-bottom">
        <div class="share">分享</div>
        <div class="mine" dace-node="0003_0004"><@=text@></div>
        </div>
        <@}else{@>
        <div class="bottom others-bottom">
        <div class="mine" dace-node="0003_0004"><@=text@></div>
        <div class="title clearfix">
        <div class="line fl"></div>
        <div class="text fl">分享</div>
        <div class="line fl"></div>
        </div>
        <div class="others clearfix">
        <a class="weibo fl" href="<@=linkShareWeibo@>" target="_blank" dace-node="0003_weibo">
        <div class="img">
        <img src="<@=host@>img/weibo-share.png" width="36" alt="">
        </div>
        <div class="name">新浪微博</div>
        </a>
        <a class="QZone fr" href="<@=linkShareQzone@>" target="_blank" dace-node="0003_qzone">
        <div class="img">
        <img src="<@=host@>img/QZone-share.png" width="36" alt="">
        </div>
        <div class="name">QQ空间</div>
        </a>
        </div>
        </div>
        <@}@>
    </script>
    <!-- 分享 end -->

</div>
  <script type="text/javascript" src="{%$host%}js/start.js?ver={%$ver%}"></script>
</body>
</html>