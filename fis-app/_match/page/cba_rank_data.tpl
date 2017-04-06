{%extends file="common/page/layout.tpl"%}

{%block name="title"%}CBA排行数据{%/block%}

{%block name="head_static"%}
    {%require name="common:static/js/zepto/zepto.js"%}
    {%require name="common:static/js/swiper/js/swiper.jquery.js"%}
    {%require name="common:static/js/swiper/css/swiper.css"%}
    {%require name="match:static/basketball_public/basketball_public.scss"%}
	{%script%}
		window.GM = {
            "client": "{%$client%}" || "x",
            "islogin": !!parseInt("{%$is_login%}", 10),
            "match": "cba",
            "night":!!parseInt("{%$night%}", 10),
            "version":"{%$version%}"||"7.0.7"
        };
        var rankList = require("match:widget/rank_list_data/rank_list_data.js");
        rankList.init();
    {%/script%}
{%/block%}

{%block name="content"%}
<section class="mod-rank-wrap" id="J-mod-rank-wrap">
    {%widget
        name="match:widget/basketball_tab/basketball_tab.tpl"
        type="cba"
    %}
    <section class="swiper-container">
        <section class="swiper-wrapper">
            {%widget
                name="match:widget/cba_tab_team_rank/cba_tab_team_rank.tpl"
            %}
            {%widget
                name="match:widget/basketball_tab_player_data/basketball_tab_player_data.tpl"
            %}
            {%widget
                name="match:widget/basketball_tab_daily_data/basketball_tab_daily_data.tpl"
            %}
        </section>
    </section>
</section>
{%/block%}
