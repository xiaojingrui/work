{%extends file="common/page/layout.tpl"%}

{%block name="block_head_static"%}
    {%require name="teams:static/players-game/game-data.scss"%}

    {%script%}
        var toShare = require("common:widget/ui/share/share.js");

        //全局分享事件, 每个页面单独注册.
        $(document).on("page:share", function(){
            toShare();
        });
    {%/script%}
{%/block%}
{%block name="content"%}
    {%widget
        name="common:widget/new-top-nav/new-top-nav.tpl"
        hasBreadNav=false
    %}

    {%widget
        name="common:widget/inner-top-nav/nav.tpl"
    %}
    <section class="m-wrap playersGameData-wrap">
        <!-- 球队信息 -->
        {%widget
            name="teams:widget/player-header/header.tpl"
        %}

        {%widget
            name="common:widget/inner-tab/tab.tpl"
            tabClass="players"
            selected=1
        %}

        <div class="season-content technical-content">
            <div class="table-scroll">
                <table class="table table-3">
                    <thead>
                        <tr>
                            <th class="number-1">技术统计</th>
                            <th class="number-2">数值</th>
                            <th class="number-3">联盟排名</th>

                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td class="number-1">得分</td>
                            <td class="number-2">{%$playerStatsAvg["pts"]%}</td>
                            <td class="number-3">
                                {%if !empty($playerStatsAvgRank["pts"])%}
                                    {%$playerStatsAvgRank["pts"]%}
                                {%else%}
                                    -
                                {%/if%}
                            </td>
                        </tr>
                        <tr>
                            <td class="number-1">篮板</td>
                            <td class="number-2">{%$playerStatsAvg["reb"]%}</td>
                            <td class="number-3">
                                {%if !empty($playerStatsAvgRank["reb"])%}
                                    {%$playerStatsAvgRank["reb"]%}
                                {%else%}
                                    -
                                {%/if%}
                            </td>
                        </tr>
                        <tr>
                            <td class="number-1">助攻</td>
                            <td class="number-2">{%$playerStatsAvg["asts"]%}</td>
                            <td class="number-3">
                                {%if !empty($playerStatsAvgRank["asts"])%}
                                    {%$playerStatsAvgRank["asts"]%}
                                {%else%}
                                    -
                                {%/if%}
                            </td>
                        </tr>
                        <tr>
                            <td class="number-1">抢断</td>
                            <td class="number-2">{%$playerStatsAvg["st"]%}</td>
                            <td class="number-3">
                                {%if !empty($playerStatsAvgRank["stl"])%}
                                    {%$playerStatsAvgRank["stl"]%}
                                {%else%}
                                    -
                                {%/if%}
                            </td>
                        </tr>
                        <tr>
                            <td class="number-1">盖帽</td>
                            <td class="number-2">{%$playerStatsAvg["blk"]%}</td>
                            <td class="number-3">
                                {%if !empty($playerStatsAvgRank["blk"])%}
                                    {%$playerStatsAvgRank["blk"]%}
                                {%else%}
                                    -
                                {%/if%}
                            </td>
                        </tr>
                        <tr>
                            <td class="number-1">失误</td>
                            <td class="number-2">{%$playerStatsAvg["tno"]%}</td>
                            <td class="number-3">
                                {%if !empty($playerStatsAvgRank["to"])%}
                                    {%$playerStatsAvgRank["to"]%}
                                {%else%}
                                    -
                                {%/if%}
                            </td>
                        </tr>
                        <tr>
                            <td class="number-1">三分命中率</td>
                            <td class="number-2">{%$playerStatsAvg["3hitRate"]%}</td>
                            <td class="number-3">
                                {%if !empty($playerStatsAvgRank["tpp"])%}
                                    {%$playerStatsAvgRank["tpp"]%}
                                {%else%}
                                    -
                                {%/if%}
                            </td>
                        </tr>
                        <tr>
                            <td class="number-1">罚球命中率</td>
                            <td class="number-2">{%$playerStatsAvg["fhitRate"]%}</td>
                            <td class="number-3">
                                {%if !empty($playerStatsAvgRank["ftp"])%}
                                    {%$playerStatsAvgRank["ftp"]%}
                                {%else%}
                                    -
                                {%/if%}
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>

        </div>
    </section>
{%/block%}
