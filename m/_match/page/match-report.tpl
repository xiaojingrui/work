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
        name="match:widget/match-info/match-info.tpl"
    %}
    {%widget
        name="common:widget/inner-tab/tab.tpl"
        tabClass="match"
        selected="战报"
    %}

    <section class="report-wrap">
        <!-- title start -->
        <header class="artical-title">
            <h1 class="headline">{%$recap.title|escape:none%}</h1>
        </header>
        <!-- title end -->

        <!-- content start -->
        <article class="article-content">
            <img src="{%$recap.img%}">
            {%$recap.content|escape:none%}
        </article>
        <!-- content end -->
    </section>


{%/block%}
