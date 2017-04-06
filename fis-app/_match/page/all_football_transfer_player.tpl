{%extends file="common/page/layout.tpl"%}

{%block name="title"%}{%$title%}{%/block%}

{%block name="head_static"%}
    {%require name="common:static/js/zepto/zepto.js"%}
    {%require name="match:static/all_public/all_public.scss"%}
    {%require name="match:static/all_football_transfer_player/all_football_transfer_player.scss"%}
    {%script%}
        window.GM = {
            "client": "{%$client%}" || "x",
            "islogin": !!parseInt("{%$is_login%}", 10),
            "night": !!parseInt("{%$night%}", 10),
            "league_name": "{%$league_name%}",
            "rank_type": "{%$rank_type%}"
        };

        var allRank = require("match:widget/all_rank/all_rank.js");
        allRank.init();

    {%/script%}
{%/block%}

{%block name="content"%}
<section class="mod-all transfer-player" id="J-all-rank-wrap">
    <table class="mod-title fixed">
        <thead>
            <tr>
                <td width="15%" align="center">{%$title%}</td>
                <td width="40%" align="left" colspan="2">球员</td>
                <td width="20%" align="center">转会至</td>
                <td width="25%" align="center">转会费(欧元)</td>
            </tr>
        </thead>
    </table>
    {%if !empty($data)%}
    <section class="scroll-wrapper" id="J-scroll-wrapper">
        <table class="mod-table">
            <tbody id="J-all-rank">
                {%foreach $data as $val%}
                <tr class="link tap" link="kanqiu://soccerleagues/{%$league_name%}/player/{%$val.player_id%}">
                    <td width="15%" align="center">{%if $rank_type == "TOP20"%}<span class="top20">{%$val@index+1%}</span>{%else%}{%$val.occur_time%}{%/if%}</td>
                    <td width="11%" align="left">
                        <span class="logo"><img src="{%$val.photo%}?t={%$val@index%}" width="30" />{%if !empty($night)%}<span class="mask"></span>{%/if%}</span>
                    </td>
                    <td width="29%" align="left">
                        <div class="player-name">{%$val.name%}</div>
                        <div class="old-team">{%$val.from_team_name%}(原)</div>
                    </td>
                    <td width="20%" align="center">{%$val.to_team_name%}</td>
                    <td width="25%" align="center" {%if !empty($val.memo)%}class="td-icon"{%/if%}>{%$val.fee%}{%if !empty($val.memo)%}<i class="icon" data-memo="{%$val.memo%}"></i>{%/if%}</td>
                </tr>
                {%/foreach%}

                {%* 前端模板 *%}
                <script id="J-all-rank-tpl" type="text/template">
                <@ $(datas).each(function(index,item) { @>
                <tr class="link tap" link="kanqiu://soccerleagues/<@=GM.league_name@>/player/<@=item.player_id@>">
                    <td width="15%" align="center"><@=item.occur_time@></td>
                    <td width="11%" align="left">
                        <span class="logo"><img src="<@=item.photo@>?t=<@=index@>" width="30" /><@if(GM.night){ @><span class="mask"></span><@ } @></span>
                    </td>
                    <td width="29%" align="left">
                        <div class="player-name"><@=item.name@></div>
                        <div class="old-team"><@=item.from_team_name@>(原)</div>
                    </td>
                    <td width="20%" align="center"><@=item.to_team_name@></td>
                    <td width="25%" align="center"<@ if(item.memo){ @>class="td-icon"<@ } @>><@=item.fee@><@ if(item.memo){ @><i class="icon" data-memo="<@=item.memo@>"></i><@ } @></td>
                </tr>
                <@ }); @>
                </script>
            </tbody>
        </table>
    </section>
    {%else%}
    <div class="mod-no-result">暂无转会球员数据或数据出错</div>
    {%/if%}
</section>
<div class="cover"></div>
<div class="formation m-hide">
    <div class="bd"></div>
    <div class="ft"><a href="javascript:void(0);" class="close">关闭</a></div>
</div>
{%/block%}
