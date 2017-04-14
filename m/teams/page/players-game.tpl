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
            selected=2
        %}

        {%assign var="regular" value=[
            "title"=>"本赛季常规赛平均数据",
            "avg"=>$playerStats.playerStatsAvg,
            "playerStats"=>$playerStats.playerStats
        ]%}

        {%assign var="playoff" value=[
            "title"=>"本赛季季后赛平均数据",
            "avg"=>$playerStats.playerStatsAvg,
            "playerStats"=>$playerStats.playerStats
        ]%}


        {%$playerData=[]%}

        {%if $isPlayOff %}
            {%$playerData=$playoff%}
        {%else%}
            {%$playerData=$regular%}
        {%/if%}




        <div class="season-content">
            <div class="main-title">
                <h2>{%$playerData["title"]%}</h2>
            </div>
            <div class="table-scroll">
                <table class="table">
                    <thead>
                        <tr>
                            <th class="number-1">场次</th>
                            <th class="number-2">时间</th>
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
                            <td class="number-1">{%$playerData.avg.count%}</td>
                            <td class="number-2">{%$playerData.avg.mins%}</td>
                            <td class="number-3">{%$playerData.avg.pts%}</td>
                            <td class="number-4">{%$playerData.avg.reb%}</td>
                            <td class="number-5">{%$playerData.avg.asts%}</td>
                            <td class="number-6">{%$playerData.avg.stl%}</td>
                            <td class="number-7">{%$playerData.avg.blk%}</td>
                            <td class="number-8">{%$playerData.avg.to%}</td>
                            <td class="number-9">{%$playerData.avg.fgm%}-{%$playerData.avg.fga%}</td>
                            <td class="number-10">{%$playerData.avg.fgp%}</td>
                            <td class="number-11">{%$playerData.avg.tpm%}-{%$playerData.avg.tpa%}</td>
                            <td class="number-12">{%$playerData.avg.tpp%}</td>
                            <td class="number-13">{%$playerStats.playerStatsAvg.ftm%}-{%$playerData.avg.fta%}</td>
                            <td class="number-14">{%$playerData.avg.ftp%}</td>
                            <td class="number-15">{%$playerData.avg.foul%}</td>
                        </tr>
                    </tbody>
                </table>
            </div>
            {%foreach from=$playerStats.playerStats item=contact key=keys %}
                <div class="month-title">
                    <h4>{%$keys%}月</h4>
                </div>
                <div class="table-scroll">
                    <table class="table table-1">
                        <thead>
                            <tr>
                                <th class="number-1">日期</th>
                                <th class="number-2">对手</th>
                                <th class="number-3">比分</th>
                                <th class="number-4">时间</th>
                                <th class="number-5">得分</th>
                                <th class="number-6">篮板</th>
                                <th class="number-7">助攻</th>
                                <th class="number-8">抢断</th>
                                <th class="number-9">盖帽</th>
                                <th class="number-10">失误</th>
                                <th class="number-11">投篮</th>
                                <th class="number-12">投篮命中率</th>
                                <th class="number-13">三分</th>
                                <th class="number-14">三分命中率</th>
                                <th class="number-15">罚球</th>
                                <th class="number-16">罚球命中率</th>
                                <th class="number-17">犯规</th>
                            </tr>
                        </thead>
                        <tbody>
                            {%foreach from=$contact item=val key=k %}
                                <tr>
                                    <td class="number-1">{%$val.china_time_fix%}</td>
                                    <td class="number-2">{%$val.opt_team_name%}</td>
                                    <td class="number-3">{%$val.vs%}</td>
                                    <td class="number-4">{%$val.mins%}</td>
                                    <td class="number-5">{%$val.pts%}</td>
                                    <td class="number-6">{%$val.reb%}</td>
                                    <td class="number-7">{%$val.asts%}</td>
                                    <td class="number-8">{%$val.stl%}</td>
                                    <td class="number-9">{%$val.blk%}</td>
                                    <td class="number-10">{%$val.to%}</td>
                                    <td class="number-11">{%$val.fgm%}-{%$val.fga%}</td>
                                    <td class="number-12">{%$val.fgp%}%</td>
                                    <td class="number-13">{%$val.tpm%}-{%$val.tpa%}</td>
                                    <td class="number-14">{%$val.tpp%}%</td>
                                    <td class="number-15">{%$val.ftm%}-{%$val.fta%}</td>
                                    <td class="number-16">{%$val.ftp%}%</td>
                                    <td class="number-17">{%$val.foul%}</td>
                                </tr>
                            {%/foreach%}
                        </tbody>
                    </table>
                </div>
            {%/foreach%}
        </div>
    </section>
{%/block%}
