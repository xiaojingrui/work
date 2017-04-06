{%extends file="common/page/layout.tpl"%}

{%block name="title"%}{%$title%}{%/block%}

{%block name="head_static"%}
    {%require name="common:static/js/zepto/zepto.js"%}
    {%require name="common:widget/tap-link/tap-link.js"%}
    {%require name="match:widget/rank_list/rank_list.scss"%}
    {%script%}
        window.GM = {
            "client": "{%$client%}" || "x",
            "islogin": !!parseInt("{%$is_login%}", 10),
            "night": !!parseInt("{%$night%}", 10)
        };
        var allRankWrapContainer = $("#J-all-rank-wrap");
        var current = null;

        allRankWrapContainer.delegate(".link", "click", function(e){
            current = $(e.currentTarget);
            window.location.href = current.attr("link");
        });

    {%/script%}
    {%style%}
    .detail span {
        width: 95px;
        display: inline-block;
        line-height: normal;
        word-wrap: break-word;
        vertical-align: middle;
    }
    {%/style%}
{%/block%}

{%block name="content"%}
<section class="all-rank mod-rank" id="J-all-rank-wrap">
    <table class="mod-title fixed" style="position: fixed;">
        <thead>
            <tr>
                <td width="70%" class="type">球队</td>
                <td width="20%" align="center">数据</td>
            </tr>
        </thead>
    </table>
    {%if !empty($rankData)%}
        <section id="J-scroll-wrapper">
            <table class="mod-table">
                <tbody id="J-all-rank">
                    {%foreach $rankData as $val%}
                    <tr class="link" link="kanqiu://nba/nba/team/{%$val.team_id%}">
                        <td width="8%">
                            <span class="{%if $val@index==0%}red{%/if%} num">{%$val@index+1%}</span>
                        </td>
                        <td width="12%" align="center">
                            <img src="{%$val.team_logo%}?t={%$val@index%}" width="22" />
                        </td>
                        <td width="50%">
                            <span class="detail">
                                {%if !empty($val.team_alias)%}
                                    <span class="name">{%$val.team_alias%}</span>
                                {%else%}
                                    {%$val.team_alias_en%}
                                {%/if%}
                            </span>
                        </td>
                        <td width="20%" align="center">
                            {%if strstr($title,"率") && $title != "进攻效率" && $title != "防守效率"%}
                                {%($val.value*100)|round:1%}%
                            {%else%}
                                {%$val.value|round:1%}
                             {%/if%}
                        </td>
                    </tr>
                    {%/foreach%}
                </tbody>
            </table>
        </section>
    {%else%}
        <div class="mod-no-result">暂无比赛数据</div>
    {%/if%}
</section>
{%/block%}
