{%extends file="common/page/layout.tpl"%}

{%block name="title"%}{%$chinese%}榜{%/block%}

{%block name="head_static"%}
    {%require name="common:static/js/underscore/underscore.js"%}
    {%require name="common:static/js/zepto/zepto.js"%}
    {%require name="match:widget/rank_list/rank_list.scss"%}
    <script type="text/javascript" src="//w1.hoopchina.com.cn/hybrid/common/hpbridge_v1.0.1.js"></script>
    {%script%}
        window.GM = {
            "client": "{%$client%}" || "x",
            "islogin": !!parseInt("{%$is_login%}", 10),
            "night": !!parseInt("{%$night%}", 10),
            "type": "{%$type%}"
        };

        var allRank = require("match:widget/all_rank/all_rank.js");
        allRank.init();
    {%/script%}
{%/block%}

{%block name="content"%}
<section class="all-rank mod-rank" id="J-all-rank-wrap">
    <table class="mod-title fixed">
        <thead>
            <tr>
                {%if $type != "five_player"%}
                    <td width="60%" class="type">球员</td>
                    <td width="20%" align="center">球队</td>
                    <td width="20%" align="center">{%if $type == "salary"%}美元{%else%}数据{%/if%}</td>
                {%else%}
                    <td width="55%" colspan="2" class="type">球员</td>
                    <td width="15%" align="center">球队</td>
                    <td width="15%" align="center">时间</td>
                    <td width="15%" align="center">+/-</td>
                {%/if%}
            </tr>
        </thead>
    </table>
    {%if !empty($data)%}
    <section id="J-scroll-wrapper">
        <table class="mod-table {%if $type == "five_player"%}five_player{%/if%}">
            <tbody id="J-all-rank">
                {%foreach $data as $val%}
                <tr class="link" link="
                    {%if $type == "five_player"%}
                        kanqiu://{%$league_name%}/{%$league_name%}/team/{%$val.team_id%}
                    {%else%}
                        kanqiu://{%$league_name%}/{%$league_name%}/player/{%$val.player_id%}
                    {%/if%}
                ">
                    {%if $type != "five_player"%}
                        <td width="8%">
                            <span class="{%if $val.rank==1%}red{%/if%} num">{%$val.rank%}</span>
                        </td>
                        <td width="12%">
                            <span class="logo"><img src="{%$val.player_header%}?t={%$val@index%}" width="30" height="34" />{%if !empty($night)%}<span class="mask"></span>{%/if%}</span>
                        </td>
                        <td width="40%">
                            <span class="detail">
                                <span class="name">{%$val.player_name%}</span>
                                {%if !empty($val.pts) && !empty($val.reb) && !empty($val.asts)%}
                                <span class="others">
                                    {%$val.pts%}分&nbsp;{%$val.reb%}板&nbsp;{%$val.asts%}助
                                </span>
                                {%/if%}
                            </span>
                        </td>
                        <td width="20%" align="center">{%$val.team_name%}</td>
                        <td width="20%" align="center">{%if $type != "win_time"%}{%$val.val%}{%else%}{%$val.avg_points%}{%/if%}{%if $type == "salary"%}万{%/if%}</td>
                    {%else%}
                        <td width="8%">
                            <span class="{%if $val.rank==1%}red{%/if%} num">{%$val.rank%}</span>
                        </td>
                        <td width="47%" style="padding-left:10px;">{%$val.data_name%}</td>
                        <td width="15%" align="center">{%$val.team_name%}</td>
                        <td width="15%" align="center">{%($val.val/60)|string_format:"%0.1f"%}</td>
                        <td width="15%" align="center">{%if $val.avg_plus_minus > 0%}+{%/if%}{%$val.avg_plus_minus|string_format:"%0.1f"%}</td>
                    {%/if%}
                </tr>
                {%/foreach%}
                <script id="J-all-rank-tpl" type="text/template">
                <@ $(datas).each(function(index,item) { @>
                <tr class="link" link="
                    <@ if(GM.type == "five_player"){ @>
                        kanqiu://{%$league_name%}/{%$league_name%}/team/<@=item.team_id@>
                    <@ }else{ @>
                        kanqiu://{%$league_name%}/{%$league_name%}/player/<@=item.player_id@>
                    <@ } @>
                ">
                    <@ if(GM.type != "five_player"){ @>
                        <td width="8%">
                            <span class="<@ if(item.rank == 1){ @>red<@ } @> num"><@=item.rank@></span>
                        </td>
                        <td width="12%">
                            <span class="logo"><img src="<@=item.player_header@>?t=<@=index@>" width="30" height="34" /><@if(GM.night){ @><span class="mask"></span><@ } @></span>
                        </td>
                        <td width="40%">
                            <span class="detail">
                                <span class="name"><@=item.player_name@></span>
                                <@ if(item.pts && item.reb && item.asts){ @>
                                <span class="others">
                                    <@=item.pts@>分&nbsp;<@=item.reb@>板&nbsp;<@=item.asts@>助
                                </span>
                                <@ } @>
                            </span>
                        </td>
                        <td width="20%" align="center"><@=item.team_name@></td>
                        <td width="20%" align="center"><@ if(GM.type != "win_time"){ @><@=item.val@><@ }else{ @><@=item.avg_points@><@ } @><@ if(GM.type == "salary"){ @>万<@ } @></td>
                    <@ }else{ @>
                        <td width="8%">
                            <span class="<@ if(item.rank == 1){ @>red<@ } @> num"><@=item.rank@></span>
                        </td>
                        <td width="47%" style="padding-left:10px;"><@=item.data_name@></td>
                        <td width="15%" align="center"><@=item.team_name@></td>
                        <td width="15%" align="center"><@=parseFloat(item.val/60).toFixed(1)@></td>
                        <td width="15%" align="center">
                            <@ if(parseFloat(item.avg_plus_minus).toFixed(1)>0){ @>+<@ } @><@=parseFloat(item.avg_plus_minus).toFixed(1)@>
                        </td>
                    <@ } @>
                </tr>
                <@ }); @>
                </script>
            </tbody>
        </table>
    </section>
    {%else%}
    <div class="mod-no-result">暂无比赛数据</div>
    {%/if%}
</section>
{%/block%}
