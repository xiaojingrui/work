{%extends file="common/page/layout.tpl"%}

{%block name="title"%}{%$league_chinese%}{%/block%}

{%block name="head_static"%}
    {%require name="match:static/football_zxb/football_zxb.scss"%}
{%/block%}

{%block name="content"%}
    <div class="hd">第五轮、半决赛及决赛</div>
    {%widget
        name="match:widget/vs_soccer_8/vs_soccer_8.tpl"
        leagueName={%$league_name%}
    %}
{%/block%}
