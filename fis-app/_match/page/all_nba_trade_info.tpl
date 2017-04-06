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
            {%if $type == "trade"%}
            <tr>
                <td width="40%" class="type" colspan="2">球员</td>
                <td width="30%" align="left" class="th3">送出</td>
                <td width="30%" align="left" class="th4">得到</td>
            </tr>
            {%else%}
            <tr>
                <td width="40%" class="type" colspan="2">球员</td>
                <td width="30%" align="center">原球队</td>
                <td width="30%" align="center">{%if $type == "free"%}备注{%else%}新球队{%/if%}</td>
            </tr>
            {%/if%}
        </thead>
    </table>
    {%if !empty($data)%}
    <section class="scroll-wrapper" id="J-scroll-wrapper">
        <table class="mod-table">
            <tbody id="J-all-rank">
                {%if $type == "trade"%}
                    {%foreach $data as $val%}
                        {%foreach $val as $subVal%}
                        <tr class="link tap" link="kanqiu://nba/nba/team/{%$val.tid%}">
                            <td width="15%" align="center" valign="top">
                                <span class="logo"><img src="{%$subVal.logo%}?t={%$val@index%}{%$subVal@index%}"/></span>
                            </td>
                            <td width="25%" class="td2" valign="top">{%$subVal.name%}</td>
                            <td width="30%" align="left" valign="top" class="td3">
                                <div>{%$subVal.cost|escape:none%}</div>
                            </td>
                            <td width="30%" align="left" valign="top" class="td4">
                                <div>{%$subVal.earn|escape:none%}</div>
                            </td>
                        </tr>
                        {%if $subVal@index+1 == count($val) && $val@index+1 != count($data)%}
                        <tr>
                            <td colspan="4" class="line"></td>
                        </tr>
                        {%/if%}
                        {%/foreach%}
                    {%/foreach%}
                {%else%}
                    {%foreach $data as $val%}
                    <tr class="link tap" link="kanqiu://nba/nba/player/{%$val.hupu_pid%}">
                        <td>
                            <table class="data-table">
                                <tr>
                                    <td width="15%" align="center" {%if $type != "free" && !empty($val.memo)%}rowspan="2" valign="top"{%/if%}>
                                        <span class="logo"><img src="{%$val.photo%}?t={%$val@index%}"/>{%if !empty($night)%}<span class="mask"></span>{%/if%}</span>
                                    </td>
                                    <td width="25%" class="td2">{%$val.alias%}</td>
                                    <td width="30%" align="center" class="td3">{%$val.from_team_name%}</td>
                                    <td width="30%" align="center" class="td4">
                                        {%if $type == "free"%}
                                        {%$val.memo%}
                                        {%else%}
                                        {%$val.to_team_name%}
                                        {%/if%}
                                    </td>
                                </tr>
                                {%if $type != "free" && !empty($val.memo)%}
                                <tr>
                                    <td colspan="3" class="contract">{%$val.memo%}</td>
                                </tr>
                                {%/if%}
                            </table>
                        </td>
                    </tr>
                    {%/foreach%}
                {%/if%}
                {%* 前端模板 *%}
                <script id="J-all-rank-tpl" type="text/template">
                    <@ $(datas).each(function(index,item){ @>
                    <tr class="link tap" link="kanqiu://nba/nba/player/<@=item.hupu_pid@>">
                        <td>
                            <table class="data-table">
                                <tr>
                                    <td width="15%" align="center"
                                        <@ if(GM.type != "free"){ @>
                                            <@ if(item.memo){ @>
                                            rowspan="2" valign="top"
                                            <@ } @>
                                        <@ } @>>
                                        <span class="logo"><img src="<@=item.photo@>?t=<@=index@>"/><@if(GM.night){ @><span class="mask"></span><@ } @></span>
                                    </td>
                                    <td width="25%" class="td2"><@=item.alias@></td>
                                    <td width="30%" align="center" class="td3"><@=item.from_team_name@></td>
                                    <td width="30%" align="center" class="td4">
                                        <@ if(GM.type == "free"){ @>
                                        <@=item.memo@>
                                        <@ }else{ @>
                                        <@=item.to_team_name@>
                                        <@ } @>
                                    </td>
                                </tr>
                                <@ if(GM.type != "free"){ @>
                                    <@ if(item.memo){ @>
                                    <tr>
                                        <td colspan="3" class="contract"><@=item.memo@></td>
                                    </tr>
                                    <@ } @>
                                <@ } @>
                            </table>
                        </td>
                    </tr>
                    <@ }); @>
                </script>
                <script id="J-all-trade-tpl" type="text/template">
                    <@ $(datas).each(function(index,item){ @>
                        <@ $(item).each(function(subIndex,subItem){ @>
                            <tr class="link tap" link="kanqiu://nba/nba/team/<@=subItem.tid@>">
                                <td width="15%" align="center" valign="top">
                                    <span class="logo"><img src="<@=subItem.logo@>?t=<@=index@>"/></span>
                                </td>
                                <td width="25%" class="td2" valign="top"><@=subItem.name@></td>
                                <td width="30%" align="center" valign="top" class="td3">
                                    <div><@=subItem.cost@></div>
                                </td>
                                <td width="30%" align="center" valign="top" class="td4">
                                    <div><@=subItem.earn@></div>
                                </td>
                            </tr>
                            <@ if(subIndex+1 == item.length && index+1 != datas.length){ @>
                            <tr>
                                <td colspan="4" class="line"></td>
                            </tr>
                            <@ } @>
                        <@ }); @>
                    <@ }); @>
                    <@ if(is_more){ @>
                    <tr class="last-tr">
                        <td colspan="4" align="center">
                            <span class="view-all link all-link" link="<@=item.allURL@>">查看全部 ></span>
                        </td>
                    </tr>
                    <@ } @>
                </script>
            </tbody>
        </table>
    </section>
    {%else%}
    <div class="mod-no-result">暂无比赛数据</div>
    {%/if%}
</section>
{%/block%}
