{%extends file="common/page/layout.tpl"%}

{%block name="block_head_static"%}
    {%require name="teams:static/teams-data/teams.scss"%}

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
    <section class="m-wrap teams-data-wrap">
        <!-- 球队信息 -->
        {%widget
            name="teams:widget/team-header/header.tpl"
            currentMatch="off"
        %}

        {%widget
            name="common:widget/inner-tab/tab.tpl"
            tabClass="team"
            selected=4
        %}

        <div class="main-content">
            <div class="table-col-1">
                <table class="table table-2">
                    <thead>
                        <tr>
                            <th class="number-1">球员</th>
                        </tr>
                    </thead>
                    <tbody>
                    {%foreach from=$playerStats item=val key=keys %}
                        <tr>
                            <td class="number-1"><a href="{%$val.player_link%}">{%$val.alias|cut:7%}</a></td>
                        </tr>
                    {%/foreach%}

                    </tbody>
                </table>
                <div class="table-scroll">
                    <table class="table table-1">
                        <thead>
                            <tr>
                                <th class="number-13">位置</th>
                                <th class="number-2">场数</th>
                                <th class="number-3">首发数</th>
                                <th class="number-4">时间</th>
                                <th class="number-5">得分</th>
                                <th class="number-6">篮板</th>
                                <th class="number-7">助攻</th>
                                <th class="number-8">抢断</th>
                                <th class="number-9">盖帽</th>
                                <th class="number-10">失误</th>
                                <th class="number-11">三分</th>
                                <th class="number-12">罚球</th>
                            </tr>
                        </thead>
                        <tbody>
                            {%foreach from=$playerStats item=val key=keys %}
                                <tr>
                                    <td class="number-13">{%$val["position"]%}</td>
                                    <td class="number-2">{%$val["games"]%}</td>
                                    <td class="number-3">{%$val["games_started"]%}</td>
                                    <td class="number-4">{%$val["mins"]%}</td>
                                    <td class="number-5">{%$val["pts"]%}</td>
                                    <td class="number-6">{%$val["reb"]%}</td>
                                    <td class="number-7">{%$val["asts"]%}</td>
                                    <td class="number-8">{%$val["stl"]%}</td>
                                    <td class="number-9">{%$val["blk"]%}</td>
                                    <td class="number-10">{%$val["to"]%}</td>
                                    <td class="number-11">{%$val["tpt"]%}</td>
                                    <td class="number-12">{%$val["fpt"]%}</td>
                                </tr>
                            {%/foreach%}

                        </tbody>
                    </table>
                </div>
            </div>
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
                        <td class="number-1">场均得分</td>
                        <td class="number-2">{%$teamsStats["pts_score"]%}</td>
                        <td class="number-3">{%$teamsStats["pts"]%}</td>
                    </tr>
                    <tr>
                        <td class="number-1">场均篮板</td>
                        <td class="number-2">{%$teamsStats["reb_score"]%}</td>
                        <td class="number-3">{%$teamsStats["reb"]%}</td>
                    </tr>
                    <tr>
                        <td class="number-1">场均助攻</td>
                        <td class="number-2">{%$teamsStats["ast_score"]%}</td>
                        <td class="number-3">{%$teamsStats["ast"]%}</td>
                    </tr>
                    <tr>
                        <td class="number-1">场均失误</td>
                        <td class="number-2">{%$teamsStats["tno_score"]%}</td>
                        <td class="number-3">{%$teamsStats["tno"]%}</td>
                    </tr>
                    <tr>
                        <td class="number-1">场均失分</td>
                        <td class="number-2">{%$teamsStats["lts_score"]%}</td>
                        <td class="number-3">{%$teamsStats["lts"]%}</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </section>
{%/block%}
