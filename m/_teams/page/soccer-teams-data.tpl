{%extends file="common/page/layout.tpl"%}

{%block name="block_head_static"%}
    {%require name="teams:static/players/soccer-players.css"%}

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
            name="teams:widget/soccer-team-header/header.tpl"
        %}

        {%widget
            name="common:widget/inner-tab/tab.tpl"
            tabClass="soccer-team"
            selected=4
        %}

        <div class="season-content technical-content">
            <div class="table-scroll">
                <table class="table table-3">
                    <tbody>
                        <tr>
                            <td class="number-1">射门</td>
                            <td class="number-2">{%$statsInfo.total_scoring_att%}</td>
                        </tr>
                        <tr>
                            <td class="number-1">射正</td>
                            <td class="number-2">{%$statsInfo.ontarget_scoring_att%}</td>
                        </tr>
                        <tr>
                            <td class="number-1">角球</td>
                            <td class="number-2">{%$statsInfo.won_corners%}</td>
                        </tr>
                        <tr>
                            <td class="number-1">传中</td>
                            <td class="number-2">{%$statsInfo.total_cross%}</td>
                        </tr>
                        <tr>
                            <td class="number-1">控球率</td>
                            <td class="number-2">{%$statsInfo.possession_percentage%}</td>
                        </tr>
                        <tr>
                            <td class="number-1">越位</td>
                            <td class="number-2">{%$statsInfo.total_offside%}</td>
                        </tr>
                        <tr>
                            <td class="number-1">黄牌</td>
                            <td class="number-2">{%$statsInfo.total_yel_card%}</td>
                        </tr>
                        <tr>
                            <td class="number-1">红牌</td>
                            <td class="number-2">{%$statsInfo.total_red_card%}</td>
                        </tr>
                        <tr>
                            <td class="number-1">犯规</td>
                            <td class="number-2">{%$statsInfo.fk_foul_lost%}</td>
                        </tr>
                        <tr>
                            <td class="number-1">点球</td>
                            <td class="number-2">{%$statsInfo.att_pen_goal%}</td>
                        </tr>
                        <tr>
                            <td class="number-1">抢断</td>
                            <td class="number-2">{%$statsInfo.total_tackle%}</td>
                        </tr>
                        <tr>
                            <td class="number-1">传球</td>
                            <td class="number-2">{%$statsInfo.total_pass%}</td>
                        </tr>
                        <tr>
                            <td class="number-1">拦截</td>
                            <td class="number-2">{%$statsInfo.interception%}</td>
                        </tr>
                        <tr>
                            <td class="number-1">扑救</td>
                            <td class="number-2">{%$statsInfo.saves%}</td>
                        </tr>
                        <tr>
                            <td class="number-1">解围数</td>
                            <td class="number-2">{%$statsInfo.total_clearance%}</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

    </section>
{%/block%}
