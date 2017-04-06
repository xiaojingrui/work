{%extends file="common/page/layout-empty.tpl"%}

{%block name="title"%}战报{%/block%}

{%block name="head_static"%}
	{%require name="match:static/page/preview.scss"%}
	<style type="text/css">
	.video-play{position:relative;width:240px;min-height:100px;display:block;margin:14px auto 20px;text-indent:0;}
    .video-blackMack{position:absolute;left:0;top:0;display:block;width:100%;height:100%;background:rgba(0,0,0,.2);}
    .btn-video-play{display:block;position:absolute;top:50%;left:50%;width:50px;height:50px;margin:-25px 0 0 -25px;overflow:hidden;background:url(//w1.hoopchina.com.cn/games/images/play_btn_new.png) no-repeat 0 0;background-size:cover;-webkit-tap-highlight-color:rgba(0,0,0,0);}
    .btn-video-play-hover,
    .btn-video-play:hover{display:block;position:absolute;top:50%;left:50%;width:50px;height:50px;margin:-25px 0 0 -25px;overflow:hidden;background:url(//w1.hoopchina.com.cn/games/images/play_btn_new_hover.png) no-repeat 0 0;background-size:cover;-webkit-tap-highlight-color:rgba(0,0,0,0);}
    .view-link{text-indent:2em;padding:23px 0;}
    .view-link.first{padding:10px 0 13px 0;}
    .statics tr{background-color:#d1d1d1;text-align:center;}
    .statics tr:nth-child(even){background-color:#dedede;}
    .statics td{padding:13px 0;width:33%;}
	</style>
{%/block%}

{%block name="content"%}
	<div class="video-info">
		
	</div>
	{%if !empty($recap)%}
		<div class="recap">{%$recap|escape:none%}</div>
	{%else%}
		{%if !empty($recap_tips)%}
			<div class="recap_tips"><p>{%$recap_tips|escape:none%}</p></div>
		{%/if%}
	{%/if%}
	<script>
		var winHeight = window.innerHeight;
		var docHeight = document.body.offsetHeight;
		if(docHeight < winHeight){
			var style = document.createElement("style");
			style.innerHTML = "html,body{height:100%;}";
			document.body.appendChild(style);
		}
	</script>
{%/block%}
