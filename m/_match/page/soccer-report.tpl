{%extends file="common/page/layout.tpl"%}

{%block name="block_head_static"%}
    {%require name="match:static/match-report/match-report.scss"%}
    {%script%}
        require("match:widget/top-tips/top-tips.js");
    {%/script%}

{%/block%}
{%block name="content"%}
    {%widget
        name="common:widget/new-top-nav/new-top-nav.tpl"
        hasMidNav=true
        hasBreadNav=true
    %}
    {%assign var=top value=$adInfo.m_adword.nba_game_playbyplay%}
    {%widget
        name="match:widget/top-tips/top-tips.tpl"
        isOpen=$top.isopen
        content=$top.adword
        url=$top.adurl
    %}
    {%widget
        name="match:widget/soccer-header/soccer-header.tpl"
    %}
    {%widget
        name="common:widget/inner-tab/tab.tpl"
        tabClass="soccermatch"
        selected="战报"
    %}

    <section class="report-wrap">
        <!-- content start -->
        <article class="article-content">
            <!--<img src="{%$recap.img%}">-->
            {%$gameRecap|escape:none%}
        </article>
        <!-- content end -->
    </section>


{%/block%}
