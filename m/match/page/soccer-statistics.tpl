{%extends file="common/page/layout.tpl"%}

{%block name="block_head_static"%}
    {%require name="match:static/soccer-statistics/soccer-statistics.scss"%}
    {%script%}
        require("match:widget/top-tips/top-tips.js");
    {%/script%}

{%/block%}

{%block name="content"%}
    {%widget
        name="common:widget/new-top-nav/new-top-nav.tpl"
        hasMidNav=true
        hasBreadNav=true
    %}
    {%assign var=top value=$adInfo.m_adword.nba_game_playbyplay%}
    {%widget
        name="match:widget/top-tips/top-tips.tpl"
        isOpen=$top.isopen
        content=$top.adword
        url=$top.adurl
    %}
    {%widget
        name="match:widget/soccer-header/soccer-header.tpl"
    %}
    {%widget
        name="common:widget/inner-tab/tab.tpl"
        tabClass="soccermatch"
        selected="统计"
    %}

    <section class="match-soccer-statistics">
        <table class="table">
            <tbody>
                {%$home=$gameStats[0]%}
                {%$away=$gameStats[1]%}
                <tr>
                    <td class="ball-number ball-number-left">
                        {%$home["total_scoring_att"]%}
                    </td>
                    <td class="td-ball td-ball-left">
                        <div class="ball-progress-bar {%if $home["total_scoring_att"] < $away["total_scoring_att"]%}lose-ball{%/if%}" style="width: {%percentage first=$home["total_scoring_att"] second=$away["total_scoring_att"]%}%">
                        </div>
                    </td>
                    <td class="type">
                        射门
                    </td>
                    <td class="td-ball">
                        <div class="ball-progress-bar {%if $home["total_scoring_att"] > $away["total_scoring_att"]%}lose-ball{%/if%}" style="width: {%percentage first=$away["total_scoring_att"] second=$home["total_scoring_att"]%}%">
                        </div>
                    </td>
                    <td class="ball-number ball-number-right">
                        {%$away["total_scoring_att"]%}
                    </td>
                </tr>
                <tr>
                    <td class="ball-number ball-number-left">
                        {%$home["ontarget_scoring_att"]%}
                    </td>
                    <td class="td-ball td-ball-left">
                        <div class="ball-progress-bar {%if $home["ontarget_scoring_att"] < $away["ontarget_scoring_att"]%}lose-ball{%/if%}" style="width: {%percentage first=$home["ontarget_scoring_att"] second=$away["ontarget_scoring_att"]%}%">
                        </div>
                    </td>
                    <td class="type">
                        射正
                    </td>
                    <td class="td-ball">
                        <div class="ball-progress-bar {%if $home["ontarget_scoring_att"] > $away["ontarget_scoring_att"]%}lose-ball{%/if%}" style="width: {%percentage first=$away["ontarget_scoring_att"] second=$home["ontarget_scoring_att"]%}%">
                        </div>
                    </td>
                    <td class="ball-number ball-number-right">
                        {%$away["ontarget_scoring_att"]%}
                    </td>
                </tr>
                <tr>
                    <td class="ball-number ball-number-left">
                        {%$home["won_corners"]%}
                    </td>
                    <td class="td-ball td-ball-left">
                        <div class="ball-progress-bar {%if $home["won_corners"] < $away["won_corners"]%}lose-ball{%/if%}" style="width: {%percentage first=$home["won_corners"] second=$away["won_corners"]%}%">
                        </div>
                    </td>
                    <td class="type">
                        角球
                    </td>
                    <td class="td-ball">
                        <div class="ball-progress-bar {%if $home["won_corners"] > $away["won_corners"]%}lose-ball{%/if%}" style="width: {%percentage first=$away["won_corners"] second=$home["won_corners"]%}%">
                        </div>
                    </td>
                    <td class="ball-number ball-number-right">
                        {%$away["won_corners"]%}
                    </td>
                </tr>
                <tr>
                    <td class="ball-number ball-number-left">
                        {%$home["possession_percentage"]%}%
                    </td>
                    <td class="td-ball td-ball-left">
                        <div class="ball-progress-bar {%if $home["possession_percentage"] < $away["possession_percentage"]%}lose-ball{%/if%}" style="width: {%$home["possession_percentage"]%}%">
                        </div>
                    </td>
                    <td class="type">
                        控球率
                    </td>
                    <td class="td-ball">
                        <div class="ball-progress-bar {%if $home["possession_percentage"] > $away["possession_percentage"]%}lose-ball{%/if%}" style="width: {%$away["possession_percentage"]%}%">
                        </div>
                    </td>
                    <td class="ball-number ball-number-right">
                        {%$away["possession_percentage"]%}%
                    </td>
                </tr>
                <tr>
                    <td class="ball-number ball-number-left">
                        {%$home["total_offside"]%}
                    </td>
                    <td class="td-ball td-ball-left">
                        <div class="ball-progress-bar {%if $home["total_offside"] < $away["total_offside"]%}lose-ball{%/if%}" style="width: {%percentage first=$home["total_offside"] second=$away["total_offside"]%}%">
                        </div>
                    </td>
                    <td class="type">
                        越位
                    </td>
                    <td class="td-ball">
                        <div class="ball-progress-bar {%if $home["total_offside"] > $away["total_offside"]%}lose-ball{%/if%}" style="width: {%percentage first=$away["total_offside"] second=$home["total_offside"]%}%">
                        </div>
                    </td>
                    <td class="ball-number ball-number-right">
                        {%$away["total_offside"]%}
                    </td>
                </tr>
                <tr>
                    <td class="ball-number ball-number-left">
                        {%$home["total_yel_card"]%}
                    </td>
                    <td class="td-ball td-ball-left">
                        <div class="ball-progress-bar {%if $home["total_yel_card"] < $away["total_yel_card"]%}lose-ball{%/if%}" style="width: {%percentage first=$home["total_yel_card"] second=$away["total_yel_card"]%}%">
                        </div>
                    </td>
                    <td class="type">
                        黄牌
                    </td>
                    <td class="td-ball">
                        <div class="ball-progress-bar {%if $home["total_yel_card"] > $away["total_yel_card"]%}lose-ball{%/if%}" style="width: {%percentage first=$away["total_yel_card"] second=$home["total_yel_card"]%}%">
                        </div>
                    </td>
                    <td class="ball-number ball-number-right">
                        {%$away["total_yel_card"]%}
                    </td>
                </tr>
                <tr>
                    <td class="ball-number ball-number-left">
                        {%$home["total_red_card"]%}
                    </td>
                    <td class="td-ball td-ball-left">
                        <div class="ball-progress-bar {%if $home["total_red_card"] < $away["total_red_card"]%}lose-ball{%/if%}" style="width: {%percentage first=$home["total_red_card"] second=$away["total_red_card"]%}%">
                        </div>
                    </td>
                    <td class="type">
                        红牌
                    </td>
                    <td class="td-ball">
                        <div class="ball-progress-bar {%if $home["total_red_card"] > $away["total_red_card"]%}lose-ball{%/if%}" style="width: {%percentage first=$away["total_red_card"] second=$home["total_red_card"]%}%">
                        </div>
                    </td>
                    <td class="ball-number ball-number-right">
                        {%$away["total_red_card"]%}
                    </td>
                </tr>
                <tr>
                    <td class="ball-number ball-number-left">
                        {%$home["total_cross"]%}
                    </td>
                    <td class="td-ball td-ball-left">
                        <div class="ball-progress-bar {%if $home["total_cross"] < $away["total_cross"]%}lose-ball{%/if%}" style="width: {%percentage first=$home["total_cross"] second=$away["total_cross"]%}%">
                        </div>
                    </td>
                    <td class="type">
                        传中
                    </td>
                    <td class="td-ball">
                        <div class="ball-progress-bar {%if $home["total_cross"] > $away["total_cross"]%}lose-ball{%/if%}" style="width: {%percentage first=$away["total_cross"] second=$home["total_cross"]%}%">
                        </div>
                    </td>
                    <td class="ball-number ball-number-right">
                        {%$away["total_cross"]%}
                    </td>
                </tr>
                <tr>
                    <td class="ball-number ball-number-left">
                        {%$home["fk_foul_lost"]%}
                    </td>
                    <td class="td-ball td-ball-left">
                        <div class="ball-progress-bar {%if $home["fk_foul_lost"] < $away["fk_foul_lost"]%}lose-ball{%/if%}" style="width: {%percentage first=$home["fk_foul_lost"] second=$away["fk_foul_lost"]%}%">
                        </div>
                    </td>
                    <td class="type">
                        犯规
                    </td>
                    <td class="td-ball">
                        <div class="ball-progress-bar {%if $home["fk_foul_lost"] > $away["fk_foul_lost"]%}lose-ball{%/if%}" style="width: {%percentage first=$away["fk_foul_lost"] second=$home["fk_foul_lost"]%}%">
                        </div>
                    </td>
                    <td class="ball-number ball-number-right">
                        {%$away["fk_foul_lost"]%}
                    </td>
                </tr>
                <tr>
                    <td class="ball-number ball-number-left">
                        {%$home["att_pen_goal"]%}
                    </td>
                    <td class="td-ball td-ball-left">
                        <div class="ball-progress-bar {%if $home["att_pen_goal"] < $away["att_pen_goal"]%}lose-ball{%/if%}" style="width: {%percentage first=$home["att_pen_goal"] second=$away["att_pen_goal"]%}%">
                        </div>
                    </td>
                    <td class="type">
                        点球
                    </td>
                    <td class="td-ball">
                        <div class="ball-progress-bar {%if $home["att_pen_goal"] > $away["att_pen_goal"]%}lose-ball{%/if%}" style="width: {%percentage first=$away["att_pen_goal"] second=$home["att_pen_goal"]%}%">
                        </div>
                    </td>
                    <td class="ball-number ball-number-right">
                        {%$away["att_pen_goal"]%}
                    </td>
                </tr>
                <tr>
                    <td class="ball-number ball-number-left">
                        {%$home["total_tackle"]%}
                    </td>
                    <td class="td-ball td-ball-left">
                        <div class="ball-progress-bar {%if $home["total_tackle"] < $away["total_tackle"]%}lose-ball{%/if%}" style="width: {%percentage first=$home["total_tackle"] second=$away["total_tackle"]%}%">
                        </div>
                    </td>
                    <td class="type">
                        抢断
                    </td>
                    <td class="td-ball">
                        <div class="ball-progress-bar {%if $home["total_tackle"] > $away["total_tackle"]%}lose-ball{%/if%}" style="width: {%percentage first=$away["total_tackle"] second=$home["total_tackle"]%}%">
                        </div>
                    </td>
                    <td class="ball-number ball-number-right">
                        {%$away["total_tackle"]%}
                    </td>
                </tr>
                <tr>
                    <td class="ball-number ball-number-left">
                        {%$home["interception"]%}
                    </td>
                    <td class="td-ball td-ball-left">
                        <div class="ball-progress-bar {%if $home["interception"] < $away["interception"]%}lose-ball{%/if%}" style="width: {%percentage first=$home["interception"] second=$away["interception"]%}%">
                        </div>
                    </td>
                    <td class="type">
                        拦截
                    </td>
                    <td class="td-ball">
                        <div class="ball-progress-bar {%if $home["interception"] > $away["interception"]%}lose-ball{%/if%}" style="width: {%percentage first=$away["interception"] second=$home["interception"]%}%">
                        </div>
                    </td>
                    <td class="ball-number ball-number-right">
                        {%$away["interception"]%}
                    </td>
                </tr>
                <tr>
                    <td class="ball-number ball-number-left">
                        {%$home["total_pass"]%}
                    </td>
                    <td class="td-ball td-ball-left">
                        <div class="ball-progress-bar {%if $home["total_pass"] < $away["total_pass"]%}lose-ball{%/if%}" style="width: {%percentage first=$home["total_pass"] second=$away["total_pass"]%}%">
                        </div>
                    </td>
                    <td class="type">
                        传球
                    </td>
                    <td class="td-ball">
                        <div class="ball-progress-bar {%if $home["total_pass"] > $away["total_pass"]%}lose-ball{%/if%}" style="width: {%percentage first=$away["total_pass"] second=$home["total_pass"]%}%">
                        </div>
                    </td>
                    <td class="ball-number ball-number-right">
                        {%$away["total_pass"]%}
                    </td>
                </tr>
            </tbody>
        </table>
    </section>

{%/block%}
