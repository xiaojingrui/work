{%extends file="common/page/layout.tpl"%}

{%block name="block_head_static"%}
    {%require name="match:static/soccer-integral/integral.scss"%}

    {%script%}
        var dace = require("common:widget/ui/page-dace/page-dace.js");

        $(".table tr").bind("click", function(e){
            var target = $(e.currentTarget);
            var href = target.attr("data-href");
            if(href){
                location.href = href;
                dace.send(__daceDataNameOfPage + "_team");
            }
        });
    {%/script%}
{%/block%}

{%block name="content"%}
	{%widget
        name="common:widget/new-top-nav/new-top-nav.tpl"
        hasMidNav=true
        hasBreadNav=true
    %}
    {%$area=[]%}
    {%if !empty($rankInfo)%}
        <div class="table-col-1">
            <div class="team-score table-fixed">
                <table class="table">
                    <thead>
                        <tr>
                            <th>排名</th>
                            <th>球队</th>
                        </tr>
                    </thead>
                    <tbody>
                        {%foreach from=$rankInfo item=team name=infoKey%}
                            {%if !empty($team.grade)%}
                                {%$area = array_merge($area, [
                                   $team.grade.color => $team.grade.text
                                ])%}
                            {%/if%}

                            <tr data-href="{%$team.url%}">
                                <td class="text-center" {%if !empty($team.grade)%}style="color:{%$team.grade.color%}"{%/if%}>{%$team.rank_index%}</td>
                                <td>{%$team.known_name_zh%}</td>
                            </tr>
                        {%/foreach%}
                    </tbody>
                </table>
            </div>
            <div class="table-scroll team-score home">
                <table class="table">
                    <thead>
                        <tr>
                            <th class="number-1">积分</th>
                            <th class="number-1">场次</th>
                            <th class="number-1">胜/平/负</th>
                            <th class="number-1">进球</th>
                            <th class="number-1">失球</th>
                            <th class="number-1">净胜球</th>
                            <th class="number-1">场均进球</th>
                            <th class="number-1">场均失球</th>
                            <th class="number-1">场均净胜</th>
                            <th class="number-1">场均积分</th>
                        </tr>
                    </thead>
                    <tbody>
                        {%foreach from=$rankInfo item=team name=infoKey%}
                        <tr data-href="{%$team.url%}">
                            <td class="number-1">{%$team.score|default:"--"%}</td>
                            <td class="number-1">{%$team.played|default:"--"%}</td>
                            <td class="number-1">{%$team.win|default:"-"%}/{%$team.draw|default:"-"%}/{%$team.lost|default:"-"%}</td>
                            <td class="number-1">{%$team.hits|default:"--"%}</td>
                            <td class="number-1">{%$team.miss|default:"--"%}</td>
                            <td class="number-1">{%$team.difference|default:"--"%}</td>
                            <td class="number-1">{%$team.avg_goal_hit|default:"--"%}</td>
                            <td class="number-1">{%$team.avg_goal_lost|default:"--"%}</td>
                            <td class="number-1">{%$team.avg_goal_win|default:"--"%}</td>
                            <td class="number-1">{%$team.avg_score|default:"--"%}</td>
                        </tr>
                        {%/foreach%}
                    </tbody>
                 </table>
            </div>
        </div>

       {%if !empty($area)%}
       <div class="soccer-mark">
            {%foreach $area as $key => $item%}
                <div class="mark-item">
                    <span class="mark-icon" style="background-color:{%$key%}"></span>
                    {%$item%}
                </div>
            {%/foreach%}
       </div>
       {%/if%}
   {%else%}
        <div class="score-nodata">暂无数据</div>
   {%/if%}

{%/block%}
