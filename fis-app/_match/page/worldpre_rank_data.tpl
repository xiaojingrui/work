{%extends file="common/page/layout.tpl"%}

{%block name="title"%}{%$league_chinese%}{%/block%}

{%block name="head_static"%}
    {%require name="common:static/js/zepto/zepto.js"%}
    {%require name="common:static/js/swiper/js/swiper.jquery.js"%}
    {%require name="common:static/js/swiper/css/swiper.css"%}
    {%require name="match:static/worldpre_public/worldpre_public.scss"%}
	{%script%}
		window.GM = {
            "client": "{%$client%}" || "x",
            "islogin": !!parseInt("{%$is_login%}", 10),
            "night":!!parseInt("{%$night%}", 10)
        };

		var worldpreRankData = require("match:widget/worldpre_rank_data/worldpre_rank_data.js");
		worldpreRankData.init();
    {%/script%}
{%/block%}

{%block name="content"%}
	<section class="mod-rank-wrap" id="J-mod-rank-wrap">
		{%widget
	        name="match:widget/worldpre_tab/worldpre_tab.tpl"
	    %}
		<section class="swiper-container">
			<section class="swiper-wrapper">
                {%*
                *    世预赛赛区：亚洲 欧洲 南美 中北美 非洲 大洋洲
                *    code分别对应：w173 w172 w174 w175 w176 w177
                *    注意坑：亚洲和欧洲code值
                *%}
                {%widget
        	        name="match:widget/worldpre_tab_standings_rank/worldpre_tab_standings_rank.tpl"
                    code="w173"
        	    %}
                {%widget
        	        name="match:widget/worldpre_tab_standings_rank/worldpre_tab_standings_rank.tpl"
                    code="w172"
        	    %}
                {%widget
        	        name="match:widget/worldpre_tab_standings_rank/worldpre_tab_standings_rank.tpl"
                    code="w174"
        	    %}
                {%widget
        	        name="match:widget/worldpre_tab_standings_rank/worldpre_tab_standings_rank.tpl"
                    code="w175"
        	    %}
                {%widget
        	        name="match:widget/worldpre_tab_standings_rank/worldpre_tab_standings_rank.tpl"
                    code="w176"
        	    %}
                {%widget
        	        name="match:widget/worldpre_tab_standings_rank/worldpre_tab_standings_rank.tpl"
                    code="w177"
        	    %}
			</section>
		</section>
	</section>
{%/block%}
