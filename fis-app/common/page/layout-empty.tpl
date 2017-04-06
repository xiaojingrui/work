<!DOCTYPE html>
{%html framework="common:static/mod.js" class="expanded"%}
	{%head%}
	    <meta charset="utf-8"/>
        <title>{%block name="title"%}虎扑体育{%/block%}</title>
        <meta name="viewport" content="initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
        <meta name="format-detection" content="telephone=no">
        <meta name="apple-mobile-web-app-capable" content="yes" />
        <meta name="apple-mobile-web-app-status-bar-style" content="black" />
        {%block name="meta"%}{%/block%}
        <script id="watch_script" data-mid="4" src="//w10.hoopchina.com.cn/hybrid/common/watch.app.1.0.6.js"></script>
        <script type="text/javascript" src="//w10.hoopchina.com.cn/hybrid/common//m_dace.js?v=20160121"></script>
    	{%block name="head_static"%}{%/block%}
	{%/head%}
	{%body class="{%if !empty($night)%}night{%/if%}"%}
		{%block name="content"%}{%/block%}

        {%block name="footer"%}{%/block%}
        <script>
            var winHeight = window.innerHeight;
            var docHeight = document.body.offsetHeight;
            if(docHeight < winHeight){
                var style = document.createElement("style");
                style.innerHTML = "html,body{height:100%;}";
                document.body.appendChild(style);
            }
        </script>
	{%/body%}
{%/html%}
