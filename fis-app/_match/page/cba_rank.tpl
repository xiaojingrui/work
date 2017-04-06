{%extends file="common/page/layout.tpl"%}

{%block name="title"%}CBA排行数据{%/block%}

{%block name="head_static"%}
    {%require name="common:static/js/zepto/zepto.js"%}
    {%require name="common:static/js/swiper/js/swiper.jquery.js"%}
    {%require name="common:static/js/swiper/css/swiper.css"%}
	{%script%}
		window.GM = {
            "client": "{%$client%}" || "x",
            "islogin": !!parseInt("{%$is_login%}", 10),
            "match": "cba",
            "night":!!parseInt("{%$night%}", 10),
            "version":"{%$version%}"||"7.0.7"
        };
        var rankList = require("match:widget/rank_list/rank_list.js");
        rankList.init();
    {%/script%}
{%/block%}

{%block name="content"%}
	{%widget
        name="match:widget/rank_list/rank_list.tpl"
        type="cba"
    %}
{%/block%}
