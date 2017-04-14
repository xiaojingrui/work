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
            selected=3
        %}

        <div class="season-content career-content">
            <div class="main-title">
                <h2>职业生涯常规赛平均数据</h2>
            </div>
            <div class="table-scroll general-table">
                <table class="table">
                    <thead>
                        <tr>
                            <th class="number-1">场次</th>
                            <th class="number-2">上场时间</th>
                            <th class="number-3">得分</th>
                            <th class="number-4">篮板</th>
                            <th class="number-5">助攻</th>
                            <th class="number-6">抢断</th>
                            <th class="number-7">盖帽</th>
                            <th class="number-8">失误</th>
                            <th class="number-9">投篮</th>
                            <th class="number-10">投篮命中率</th>
                            <th class="number-11">三分</th>
                            <th class="number-12">三分命中率</th>
                            <th class="number-13">罚球</th>
                            <th class="number-14">罚球命中率</th>
                            <th class="number-15">犯规</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td class="number-1">{%$playerStats.REGULAR_AVG.count%}</td>
                            <td class="number-2">{%$playerStats.REGULAR_AVG.mins%}</td>
                            <td class="number-3">{%$playerStats.REGULAR_AVG.pts%}</td>
                            <td class="number-4">{%$playerStats.REGULAR_AVG.reb%}</td>
                            <td class="number-5">{%$playerStats.REGULAR_AVG.asts%}</td>
                            <td class="number-6">{%$playerStats.REGULAR_AVG.stl%}</td>
                            <td class="number-7">{%$playerStats.REGULAR_AVG.blk%}</td>
                            <td class="number-8">{%$playerStats.REGULAR_AVG.to%}</td>
                            <td class="number-9">{%$playerStats.REGULAR_AVG.fgm%}-{%$playerStats.REGULAR_AVG.fga%}</td>
                            <td class="number-10">{%$playerStats.REGULAR_AVG.fgp%}</td>
                            <td class="number-11">{%$playerStats.REGULAR_AVG.tpm%}-{%$playerStats.REGULAR_AVG.tpa%}</td>
                            <td class="number-12">{%$playerStats.REGULAR_AVG.tpp%}</td>
                            <td class="number-13">{%$playerStats.REGULAR_AVG.ftm%}-{%$playerStats.REGULAR_AVG.fta%}</td>
                            <td class="number-14">{%$playerStats.REGULAR_AVG.ftp%}</td>
                            <td class="number-15">{%$playerStats.REGULAR_AVG.foul%}</td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="table-scroll">
                <table class="table table-2">
                    <thead>
                        <tr>
                            <th class="number-1">赛季</th>
                            <th class="number-2">球队</th>
                            <th class="number-3">场次</th>
                            <th class="number-4">首发</th>
                            <th class="number-5">时间</th>
                            <th class="number-6">得分</th>
                            <th class="number-7">篮板</th>
                            <th class="number-8">助攻</th>
                            <th class="number-9">抢断</th>
                            <th class="number-10">盖帽</th>
                            <th class="number-11">失误</th>
                            <th class="number-12">投篮</th>
                            <th class="number-13">投篮命中率</th>
                            <th class="number-14">三分</th>
                            <th class="number-15">三分命中率</th>
                            <th class="number-16">罚球</th>
                            <th class="number-17">罚球命中率</th>
                            <th class="number-18">犯规</th>
                        </tr>
                    </thead>
                    <tbody>
                        {%foreach from=$playerStats.REGULAR item=val key=keys %}
                            <tr>
                                <td class="number-1">{%$val.season%}</td>
                                <td class="number-2">{%$val.team_name%}</td>
                                <td class="number-3">{%$val.games%}</td>
                                <td class="number-4">{%$val.games_started%}</td>
                                <td class="number-5">{%$val.mins%}</td>
                                <td class="number-6">{%$val.pts%}</td>
                                <td class="number-7">{%$val.reb%}</td>
                                <td class="number-8">{%$val.asts%}</td>
                                <td class="number-9">{%$val.stl%}</td>
                                <td class="number-10">{%$val.blk%}</td>
                                <td class="number-11">{%$val.to%}</td>
                                <td class="number-12">{%$val.fgm%}-{%$val.fga%}</td>
                                <td class="number-13">{%$val.fgp%}%</td>
                                <td class="number-14">{%$val.tpm%}-{%$val.tpa%}</td>
                                <td class="number-15">{%$val.tpp%}%</td>
                                <td class="number-16">{%$val.ftm%}-{%$val.fta%}</td>
                                <td class="number-17">{%$val.ftp%}%</td>
                                <td class="number-18">{%$val.foul%}</td>
                            </tr>
                        {%/foreach%}
                    </tbody>
                </table>
            </div>
            {%if isset($playerStats["PLAYOFF_AVG"]) && !empty($playerStats["PLAYOFF_AVG"])%}
                <div class="main-title">
                    <h2>职业生涯季后赛平均数据</h2>
                </div>
                <div class="table-scroll general-table">
                    <table class="table">
                        <thead>
                        <tr>
                            <th class="number-1">场次</th>
                            <th class="number-2">上场时间</th>
                            <th class="number-3">得分</th>
                            <th class="number-4">篮板</th>
                            <th class="number-5">助攻</th>
                            <th class="number-6">抢断</th>
                            <th class="number-7">盖帽</th>
                            <th class="number-8">失误</th>
                            <th class="number-9">投篮</th>
                            <th class="number-10">投篮命中率</th>
                            <th class="number-11">三分</th>
                            <th class="number-12">三分命中率</th>
                            <th class="number-13">罚球</th>
                            <th class="number-14">罚球命中率</th>
                            <th class="number-15">犯规</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td class="number-1">{%$playerStats.PLAYOFF_AVG.count%}</td>
                            <td class="number-2">{%$playerStats.PLAYOFF_AVG.mins%}</td>
                            <td class="number-3">{%$playerStats.PLAYOFF_AVG.pts%}</td>
                            <td class="number-4">{%$playerStats.PLAYOFF_AVG.reb%}</td>
                            <td class="number-5">{%$playerStats.PLAYOFF_AVG.asts%}</td>
                            <td class="number-6">{%$playerStats.PLAYOFF_AVG.stl%}</td>
                            <td class="number-7">{%$playerStats.PLAYOFF_AVG.blk%}</td>
                            <td class="number-8">{%$playerStats.PLAYOFF_AVG.to%}</td>
                            <td class="number-9">{%$playerStats.PLAYOFF_AVG.fgm%}-{%$playerStats.PLAYOFF_AVG.fga%}</td>
                            <td class="number-10">{%$playerStats.PLAYOFF_AVG.fgp%}</td>
                            <td class="number-11">{%$playerStats.PLAYOFF_AVG.tpm%}-{%$playerStats.PLAYOFF_AVG.tpa%}</td>
                            <td class="number-12">{%$playerStats.PLAYOFF_AVG.tpp%}</td>
                            <td class="number-13">{%$playerStats.PLAYOFF_AVG.ftm%}-{%$playerStats.PLAYOFF_AVG.fta%}</td>
                            <td class="number-14">{%$playerStats.PLAYOFF_AVG.ftp%}</td>
                            <td class="number-15">{%$playerStats.PLAYOFF_AVG.foul%}</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <div class="table-scroll">
                    <table class="table table-2">
                        <thead>
                        <tr>
                            <th class="number-1">赛季</th>
                            <th class="number-2">球队</th>
                            <th class="number-3">场次</th>
                            <th class="number-4">首发</th>
                            <th class="number-5">时间</th>
                            <th class="number-6">得分</th>
                            <th class="number-7">篮板</th>
                            <th class="number-8">助攻</th>
                            <th class="number-9">抢断</th>
                            <th class="number-10">盖帽</th>
                            <th class="number-11">失误</th>
                            <th class="number-12">投篮</th>
                            <th class="number-13">投篮命中率</th>
                            <th class="number-14">三分</th>
                            <th class="number-15">三分命中率</th>
                            <th class="number-16">罚球</th>
                            <th class="number-17">罚球命中率</th>
                            <th class="number-18">犯规</th>
                        </tr>
                        </thead>
                        <tbody>
                        {%foreach from=$playerStats.PLAYOFF item=val key=keys %}
                        <tr>
                            <td class="number-1">{%$val.season%}</td>
                            <td class="number-2">{%$val.team_name%}</td>
                            <td class="number-3">{%$val.games%}</td>
                            <td class="number-4">{%$val.games_started%}</td>
                            <td class="number-5">{%$val.mins%}</td>
                            <td class="number-6">{%$val.pts%}</td>
                            <td class="number-7">{%$val.reb%}</td>
                            <td class="number-8">{%$val.asts%}</td>
                            <td class="number-9">{%$val.stl%}</td>
                            <td class="number-10">{%$val.blk%}</td>
                            <td class="number-11">{%$val.to%}</td>
                            <td class="number-12">{%$val.fgm%}-{%$val.fga%}</td>
                            <td class="number-13">{%$val.fgp%}%</td>
                            <td class="number-14">{%$val.tpm%}-{%$val.tpa%}</td>
                            <td class="number-15">{%$val.tpp%}%</td>
                            <td class="number-16">{%$val.ftm%}-{%$val.fta%}</td>
                            <td class="number-17">{%$val.ftp%}%</td>
                            <td class="number-18">{%$val.foul%}</td>
                        </tr>
                        {%/foreach%}
                        </tbody>
                    </table>
                </div>
            {%/if%}
        </div>
    </section>
{%/block%}
