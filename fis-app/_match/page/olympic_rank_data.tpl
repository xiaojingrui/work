{%extends file="common/page/layout.tpl"%}

{%block name="title"%}奥运会数据排行榜{%/block%}

{%block name="head_static"%}
    {%require name="common:static/js/zepto/zepto.js"%}
    {%require name="common:static/js/swiper/js/swiper.jquery.js"%}
    {%require name="common:static/js/swiper/css/swiper.css"%}
    {%require name="match:static/olympic_public/olympic_public.scss"%}
	{%script%}
		window.GM = {
            "client": "{%$client%}" || "x",
            "islogin": !!parseInt("{%$is_login%}", 10),
            "night":!!parseInt("{%$night%}", 10)
        };

        var olympicRankData = require("match:widget/olympic_rank_data/olympic_rank_data.js");
        olympicRankData.init();
    {%/script%}
{%/block%}

{%block name="content"%}
<section class="mod-rank-wrap" id="J-mod-rank-wrap">
    {%widget
        name="match:widget/olympic_tab/olympic_tab.tpl"
    %}
    <section class="swiper-container">
        <section class="swiper-wrapper">
            {%widget
                name="match:widget/olympic_gold_rank/olympic_gold_rank.tpl"
            %}
            {%widget
                name="match:widget/olympic_basketball_rank/olympic_basketball_rank.tpl"
                type="men"
                index=1
            %}
            {%widget
                name="match:widget/olympic_basketball_rank/olympic_basketball_rank.tpl"
                type="women"
                index=2
            %}
            {%widget
                name="match:widget/olympic_football_rank/olympic_football_rank.tpl"
                type="men"
                index=3
            %}
            {%widget
                name="match:widget/olympic_football_rank/olympic_football_rank.tpl"
                type="women"
                index=4
            %}
        </section>
    </section>
</section>
{%/block%}
