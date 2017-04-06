{%extends file="common/page/layout.tpl"%}

{%block name="title"%}{%$chinese%}{%/block%}

{%block name="head_static"%}
    {%require name="common:static/js/zepto/zepto.js"%}
    {%require name="match:static/all_public/all_public.scss"%}
    {%require name="match:static/all_nba_trade_info/all_nba_trade_info.scss"%}
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
<section class="mod-all trade-info {%if $type == "trade"%}trade{%/if%}" id="J-all-rank-wrap">
    <table class="mod-title fixed">
        <thead>
            <tr>
                <td width="35%" class="type" colspan="2">球员</td>
                <td width="43%" align="center" style="padding-left: 1px;">伤停</td>
                <td align="center" style="padding-right: 15px;">最新进展</td>
            </tr>
        </thead>
    </table>
    {%if !empty($data)%}
    <section class="scroll-wrapper" id="J-scroll-wrapper">
        <table class="mod-table">
            <tbody id="J-all-rank">
                {%foreach $data as $val%}
                    <tr class="link tap" link="kanqiu://nba/nba/player/{%$val.hupu_pid%}">
                        <td>
                            <table class="data-table">
                                <tr>
                                    <td width="15%" align="center" rowspan="2" valign="top">
                                        <span class="logo">
                                            <img src="{%$val.player_photo%}?t={%$val@index%}"/>
                                            {%if !empty($night)%}
                                                <span class="mask"></span>
                                            {%/if%}
                                        </span>
                                    </td>
                                    <td width="27%" class="td2">{%$val.alias%}</td>
                                    <td width="30%" rowspan="2" align="center">{%$val.injury_part_cn%}</td>
                                    <td align="center" rowspan="2">
                                        {%if !empty($val.injury_returns_cn)%}
                                            <span class="injury_returns_en">{%$val.injury_returns_cn%}</span>
                                        {%else%}
                                            <span class="injury_returns_en">{%$val.injury_returns%}</span>
                                        {%/if%}
                                    </td>
                                </tr>
                                {%if !empty($val.team_name)%}
                                <tr>
                                    <td colspan="3" class="contract">{%$val.team_name%}</td>
                                </tr>
                                {%/if%}
                            </table>
                        </td>
                    </tr>
                {%/foreach%}
                {%* 前端模板 *%}
                <script id="J-all-rank-tpl" type="text/template">
                    <@ $(datas).each(function(index,item){ @>
                    <tr class="link tap" link="kanqiu://nba/nba/player/<@=item.hupu_pid@>">
                        <td>
                            <table class="data-table">
                                <tr>
                                     <td width="15%" align="center" rowspan="2" valign="top">
                                        <span class="logo">
                                            <img src="<@=item.player_photo@>?t=<@=index@>"/>
                                                <@if(GM.night){ @>
                                                    <span class="mask"></span>
                                                <@ } @>
                                        </span>
                                    </td>
                                    <td width="27%" class="td2"><@=item.alias@></td>
                                    <td width="30%" align="center" rowspan="2"><@=item.injury_part_cn@></td>
                                    <td align="center" rowspan="2">
                                        <@ if(item.injury_returns_cn){ @>
                                            <span class="injury_returns_en"><@=item.injury_returns_cn@></span>
                                        <@ }else{ @>
                                            <span class="injury_returns_en"><@=item.injury_returns@></span>
                                        <@ } @>
                                    </td>
                                </tr>
                                <@ if(item.team_name){ @>
                                    <tr>
                                        <td colspan="3" class="contract"><@=item.team_name@></td>
                                    </tr>
                                <@ } @>
                            </table>
                        </td>
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
