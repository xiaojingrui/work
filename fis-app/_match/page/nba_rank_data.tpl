{%extends file="common/page/layout.tpl"%}

{%block name="title"%}NBA排行数据{%/block%}

{%block name="head_static"%}
    {%require name="common:static/js/zepto/zepto.js"%}
    {%require name="common:static/js/swiper/js/swiper.jquery.js"%}
    {%require name="common:static/js/swiper/css/swiper.css"%}
    {%require name="match:static/basketball_public/basketball_public.scss"%}
	{%script%}
		window.GM = {
            "client": "{%$client%}" || "x",
            "islogin": !!parseInt("{%$is_login%}", 10),
            "match": "nba",
            "night":!!parseInt("{%$night%}", 10),
            "season": "{%$pageTab%}" || "regular", //季后赛期间的数据开关
            "pageLastTab": "{%$pageLastTab%}" || "daily" //选秀期间的TAB开关
        };
        var rankList = require("match:widget/rank_list_data/rank_list_data.js");
        rankList.init();
    {%/script%}
{%/block%}

{%block name="content"%}
<section class="mod-rank-wrap" id="J-mod-rank-wrap">
    {%widget
        name="match:widget/basketball_tab/basketball_tab.tpl"
        type="nba"
    %}
    <section class="swiper-container">
        <section class="swiper-wrapper">
            {%if $pageLastTab == "daily"%}
                {%widget
                    name="match:widget/nba_tab_team_rank/nba_tab_team_rank.tpl"
                %}
                {%widget
                    name="match:widget/basketball_tab_player_data/basketball_tab_player_data.tpl"
                %}
                {%widget
                    name="match:widget/basketball_tab_daily_data/basketball_tab_daily_data.tpl"
                %}
                {%widget
                    name="match:widget/nba_tab_hurt_info/nba_tab_hurt_info.tpl"
                %}
            {%else%}
                {%widget
                    name="match:widget/nba_tab_trade_info/nba_tab_trade_info.tpl"
                %}
                {%widget
                    name="match:widget/nba_tab_team_rank/nba_tab_team_rank.tpl"
                %}
                {%widget
                    name="match:widget/basketball_tab_player_data/basketball_tab_player_data.tpl"
                %}
                {%widget
                    name="match:widget/nba_tab_draft_result/nba_tab_draft_result.tpl"
                %}
            {%/if%}
        </section>
    </section>
</section>
<div class="mod-show-mask" style="display: none;"></div>
<div class="mod-showBox rules-showBox m-hide" style="display: none;">
    <div class="bd">
        <p>场均得分、篮板、助攻、抢断、盖帽、上场时间：至少要打满球队已完成比赛70%的场次，对于常规赛82场比赛，至少要打58场</p>
        <p class="tips">唯一的例外是在赛季结束时，如果一名球员的上场场次未达到要求，但是以最低出场数为基数，他的场均数据仍位列联盟榜首，那么他的数据将视为有效。</p>
        <p>投篮命中率：至少投中300次</p>
        <p>罚球命中率：至少罚中125次</p>
        <p>三分命中率：至少命中82次</p>
        <p class="tips">投篮命中率、罚球命中率、三分命中率排行只和投中数有关，与出场数无关。</p>
    </div>
    <div class="ft close">关闭</div>
</div>
{%/block%}
