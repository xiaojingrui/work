{%extends file="common/page/layout.tpl"%}

{%block name="title"%}{%$config['mysharetext']|default:"2015足球最佳阵型"%}{%/block%}

{%block name="head_static"%}
	{%require name="events:static/footballbest2015/footballbest2015.scss"%}
	{%require name="common:static/js/underscore/underscore.js"%}
	{%require name="common:static/js/fastclick/fastclick.js"%}
    {%script%}
    	window.GM = {
    		person_fd : "{%$smarty.get.fd%}",
    		ffdtmyfd: {%json_encode($ffdtmyfd)%},
    		t : "{%$t%}",
    		fd : "{%$fd%}",
	        kanqiu: window.navigator.userAgent.indexOf("kanqiu"),
	        config: {
	        	debug: false,
	        	appId: '{%$config["appId"]%}',
	        	timestamp: '{%$config["timestamp"]%}',
	        	nonceStr: '{%$config["nonceStr"]%}',
		        signature: '{%$config["signature"]%}',
		        jsApiList: [
		            'onMenuShareTimeline','onMenuShareAppMessage', 'onMenuShareQQ', 'onMenuShareWeibo', 'onMenuShareQZone'
		        ]
	        },
	        shareData: {
	        	title: '2015虎扑足球年度最佳阵容评选_虎扑体育App',
	            desc: '2015虎扑足球年度最佳阵容评选',
	            link: '{%$config["url"]%}',
	            imgUrl: '//b3.hoopchina.com.cn/games/events_img/football_logo.png',
	            success: function(){
				
	            }
	        }
    	};
    	var page = require("events:widget/footballbest2015/footballbest2015.js");
    	page.init();
    {%/script%}
  
	<script src="//res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
	{%script%}
	window.bindWx = function(shareData){
    	wx.onMenuShareTimeline(shareData);
        wx.onMenuShareAppMessage(shareData);
        wx.onMenuShareQQ(shareData);
        wx.onMenuShareWeibo(shareData);
        wx.onMenuShareQZone(shareData);
    }
	if(location.href.indexOf("fd")!=-1){
	
	}else{
		wx.config(GM.config);
	    wx.ready(function () {
			bindWx(GM.shareData);
	    });
	}
    {%/script%}
    <script> var _hmt = _hmt || []; (function() { var hm = document.createElement("script"); hm.src = "//hm.baidu.com/hm.js?55c95320c1fa35719e6d3fbb24b94234"; var s = document.getElementsByTagName("script")[0]; s.parentNode.insertBefore(hm, s); })(); </script>
{%/block%}

{%block name="content"%}
<section class="content" id="container">
 	<script type="text/template" id="J-index-tpl">
 	 	<div class="index">
 	 		<span data-href="step1" class="btn"></span>
 	 	</div>
 	</script>
 	<script type="text/template" id="J-member-tpl">
 		<div <@if(GM.kanqiu!=-1){@> style="padding-bottom:75px;"<@}@>>
 	 	<@$.each(data, function(key, item){@>
 	 		<li>
 	 			<div class="head" data-id="<@=key@>">
 	 				<img src="//w1.hoopchina.com.cn/hybrid/resource/events/footballbest2015/<@=key@>.png" width="80" alt="">
 	 			</div>
 	 			<div class="name"><@=item.name@></div>
 	 			<div class="icon unchecked" data-position="<@=postion@>" data-id="<@=key@>"></div>
 	 		</li>
	 	<@})@>
	 	</div>
 	</script>
 	<script type="text/template" id="J-step1-tpl">
 		<div <@if(GM.kanqiu!=-1){@> style="padding-bottom:75px;"<@}@>>
	 	 	<div class="mod-title">
	 	 		<span class="big">最佳前锋 <span class="choose"><span class="num">0</span>/3</span></span>
	 	 		<span class="small">请选出3名2015年最佳前锋</span>
	 	 	</div>
	 	 	<ul class="mod-list clearfix"><@=member@></ul>
	 	 	<div class="bottom-bg" <@if(GM.kanqiu!=-1){@> style="height:150px;"<@}@>>
	 	 		<span data-href="step2" class="mod-btn next">下一步</span>
	 	 	</div>
 	 	</div>
 	</script>
 	<script type="text/template" id="J-step2-tpl">
 		<div <@if(GM.kanqiu!=-1){@> style="padding-bottom:75px;"<@}@>>
	 	 	<div class="mod-title">
	 	 		<span class="big">最佳中场 <span class="choose"><span class="num">0</span>/3</span></span>
	 	 		<span class="small">请选出3名2015年最佳中场</span>
	 	 	</div>
	 	 	<ul class="mod-list clearfix"><@=member@></ul>
	 	 	<div class="bottom-bg" <@if(GM.kanqiu!=-1){@> style="height:150px;"<@}@>>
	 	 		<span data-href="step1" class="mod-btn prev">上一步</span>&nbsp;&nbsp;&nbsp;
	 	 		<span data-href="step3" class="mod-btn next">下一步</span>
	 	 	</div>
 	 	</div>
 	</script>
 	<script type="text/template" id="J-step3-tpl">
 		<div <@if(GM.kanqiu!=-1){@> style="padding-bottom:75px;"<@}@>>
	 	 	<div class="mod-title">
	 	 		<span class="big">最佳中后卫 <span class="choose"><span class="num">0</span>/2</span></span>
	 	 		<span class="small">请选出2名2015年最佳中后卫</span>
	 	 	</div>
	 	 	<ul class="mod-list clearfix"><@=member@></ul>
	 	 	<div class="bottom-bg" <@if(GM.kanqiu!=-1){@> style="height:150px;"<@}@>>
	 	 		<span data-href="step2" class="mod-btn prev">上一步</span>&nbsp;&nbsp;&nbsp;
	 	 		<span data-href="step4" class="mod-btn next">下一步</span>
	 	 	</div>
 	 	</div>
 	</script>
 	<script type="text/template" id="J-step4-tpl">
 		<div <@if(GM.kanqiu!=-1){@> style="padding-bottom:75px;"<@}@>>
 	 		<div class="mod-title">
	 	 		<span class="big">最佳左后卫 <span class="choose"><span class="num leftwingback">0</span>/1</span></span>
	 	 		<span class="small">请选出1名2015年最佳左后卫</span>
	 	 	</div>
	 	 	<ul class="mod-list clearfix"><@=member1@></ul>
	 	 	<div class="mod-title">
	 	 		<span class="big">最佳右后卫 <span class="choose"><span class="num rightwingback">0</span>/1</span></span>
	 	 		<span class="small">请选出1名2015年最佳右后卫</span>
	 	 	</div>
	 	 	<ul class="mod-list clearfix"><@=member2@></ul>
	 	 	<div class="bottom-bg" <@if(GM.kanqiu!=-1){@> style="height:150px;"<@}@>>
	 	 		<span data-href="step3" class="mod-btn prev">上一步</span>&nbsp;&nbsp;&nbsp;
	 	 		<span data-href="step5" class="mod-btn next">下一步</span>
	 	 	</div>
 	 	</div>
 	</script>
 	<script type="text/template" id="J-step5-tpl">
 		<div <@if(GM.kanqiu!=-1){@> style="padding-bottom:75px;"<@}@>>
	 	 	<div class="mod-title">
	 	 		<span class="big">最佳门将 <span class="choose"><span class="num goalkeeper">0</span>/1</span></span>
	 	 		<span class="small">请选出1名2015年最佳门将</span>
	 	 	</div>
	 	 	<ul class="mod-list clearfix"><@=member1@></ul>
	 	 	<div class="mod-title">
	 	 		<span class="big">最佳教练 <span class="choose"><span class="num coach">0</span>/1</span></span>
	 	 		<span class="small">请选出1名2015年最佳教练</span>
	 	 	</div>
	 	 	<ul class="mod-list clearfix"><@=member2@></ul>
	 	 	<div class="bottom-bg" <@if(GM.kanqiu!=-1){@> style="height:150px;"<@}@>>
	 	 		<span data-href="step4" class="mod-btn prev">上一步</span>&nbsp;&nbsp;&nbsp;
	 	 		<span data-href="result" class="mod-btn build">生成最佳阵容</span>
	 	 	</div>
 	 	</div>
 	</script>
 	<script type="text/template" id="J-result-tpl">
 		<div <@if(GM.kanqiu!=-1){@> style="padding-bottom:75px;"<@}@>>
 			<@if(GM.kanqiu==-1){@>
			<div class="top-down-app">
		        <a href="//mobile.hupu.com/download/games?r=201601soccerdreamteam">
		            <div class="hupu-logo">
		                <img src="../static/footballbest2015/img/logo.png" alt=""/>
		            </div>
		            <div class="app-info">
		                <h4 class="name">
		                    虎扑体育
		                </h4>
		                <div class="text">
		                    下载客户端，晒阵容赢大奖！
		                </div>
		                <div class="score">
		                    <img src="../static/footballbest2015/img/star.png" alt=""/>
		                </div>
		            </div>
		            <div class="button-down">
		                免费下载
		            </div>
		        </a>
		    </div>
		    <@}@>
			<div class="team">
				<img src="../static/footballbest2015/img/result-bg.jpg" alt="">
				<@$.each(data, function(idx, member){@>
					<div class="item item<@=idx+1@>">
						<div class="head">
							<img src="//w1.hoopchina.com.cn/hybrid/resource/events/footballbest2015/<@=member.id@>.png" width="65" alt="">
						</div>
						<div class="name"><@=member.name@></div>
					</div>
				<@})@>
			</div>
			<div class="notice">
				百万球迷评选结果将于1月8日在虎扑体育客户端公布。 
			</div>
			<div class="bottom-bg" <@if(GM.kanqiu!=-1){@> style="height:150px;"<@}@>>
				<@if(!isSelf){@>
					<span data-href="index" class="mod-btn join-btn">参与投票</span>
				<@}else{@>
					<span data-href="rank" class="mod-btn gotorank">查看票数排行榜</span>&nbsp;&nbsp;&nbsp;
					<span class="mod-btn share-btn">晒晒我的最佳阵容</span>
				<@}@>
			</div>
		</div>
	</script>
	<script type="text/template" id="J-rank-tpl">
		<@$.each(data, function(idx, item){@>
			<dl>
				<dt><@=item.name@></dt>
				<@$.each(item.members, function(sidx, member){@>
					<dd class="<@if(sidx === 0){@>first<@}@>">
						<div class="num"><@=sidx+1@></div>
						<div class="head">
							<img src="//w1.hoopchina.com.cn/hybrid/resource/events/footballbest2015/<@=member.id@>.png" width="80" alt="">
						</div>
						<div class="main">
							<div class="info clearfix">
								<div class="name fl"><@=member.name@></div>
								<div class="votes fr"><@=member.score@></div>	
							</div>
							<div class="progress">
								<div class="inner" <@if(idx > 2){@>style="width:<@=member.percent@>%"<@}else{@>data-percent="<@=member.percent@>%"<@}@>></div>
							</div>
						</div>
					</dd>
				<@})@>
			</dl>
		<@})@>
	</script>
 	<script type="text/template" id="J-dialog-tpl">
 	 	<div class="close"><div class="close-inner"></div></div>
 	 	<div class="hd">
 	 		<div class="head">
 	 			<img src="//w1.hoopchina.com.cn/hybrid/resource/events/footballbest2015/<@=id@>.png" width="80" alt="">
 	 		</div>
 	 		<div class="name"><@=name@></div>
 	 	</div>
 	 	<div class="bd">
 	 		<ul>
 	 			<li>俱乐部：<span><@=club@></span></li>
 	 			<li>国籍：<span><@=nationality@></span></li>
 	 			<li>生日：<span><@=both@></li>
 	 			<@if(Honor){@>
 	 			<li>荣誉：<span><@=Honor@></span></li>
 	 			<@}@>
 	 			<li class="intro">简介：<span><@=info@></span></li>
 	 		</ul>
 	 	</div>
 	</script>
	<script type="text/template" id="J-share-tpl">
		<div class="mod-mask">
			<div class="share-img"></div>
		</div>
	</script>
</section>
{%/block%}