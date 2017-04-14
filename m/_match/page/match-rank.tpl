{%extends file="common/page/layout.tpl"%}

{%block name="block_head_static"%}
    {%require name="match:static/match-rank/match-rank.scss"%}
    {%script%}
        $("#J-table tr").bind("click", function(e){
            var target = $(e.currentTarget);
            var href = target.attr("data-href");
            if(href){
                location.href = href;
            }
        });
    {%/script%}
{%/block%}

{%block name="content"%}
	{%widget
        name="common:widget/new-top-nav/new-top-nav.tpl"
        hasBreadNav=true
    %}

    {%widget
    	name="common:widget/inner-tab/tab.tpl"
    	tabClass="matchafter"
    	selected=1
    %}
   <div class="table-scroll east-match">
        <table class="table" id="J-table">
            <thead>
                <tr>
                    <th class="col-header">东部排行</th>
                    <th class="number-1">胜</th>
                    <th class="number-1">负</th>
                    <th class="number-1">胜场差</th>
                    <th class="number-1">胜率</th>
                    <th class="number-1">近况</th>
                </tr>
            </thead>
            <tbody dace-node="{%$id4dace%}_team">
                {%foreach from=$standing.east item=team%}
                    <tr data-href="{%$team.team.link%}">
                        <td class="col-header">
                            <span class="rank{%if $team@index < 8%} red{%/if%}">{%$team@index+1%}</span>
                            <a href="{%$team.team.link%}">{%$team.team.name%}</a>
                        </td>
                        <td class="number-1">{%$team["win"]%}</td>
                        <td class="number-1">{%$team["lost"]%}</td>
                        <td class="number-1">{%$team["gb"]%}</td>
                        <td class="number-1">{%($team["win"]/($team["win"]+$team["lost"])*100)|string_format:'%0.1f'%}%</td>
                        <td class="number-1">{%$team["strk"]%}</td>
                    </tr>
                {%/foreach%}
            </tbody>
         </table>
    </div>

    <div class="table-scroll west-match">
        <table class="table">
            <thead>
                <tr>
                    <th class="col-header">西部排行</th>
                    <th class="number-1">胜</th>
                    <th class="number-1">负</th>
                    <th class="number-1">胜场差</th>
                    <th class="number-1">胜率</th>
                    <th class="number-1">近况</th>
                </tr>
            </thead>
            <tbody dace-node="{%$id4dace%}_team">
                {%foreach from=$standing.west item=team%}
                    <tr data-href="{%$team.team.link%}">
                        <td class="col-header">
                            <span class="rank {%if $team@index < 8%} red{%/if%}">{%$team@index+1%}</span>
                            <a href="{%$team.team.link%}">{%$team.team.name%}</a>
                        </td>
                        <td class="number-1">{%$team["win"]%}</td>
                        <td class="number-1">{%$team["lost"]%}</td>
                        <td class="number-1">{%$team["gb"]%}</td>
                        <td class="number-1">{%($team["win"]/($team["win"]+$team["lost"])*100)|string_format:'%0.1f'%}%</td>
                        <td class="number-1">{%$team["strk"]%}</td>
                    </tr>
                {%/foreach%}
            </tbody>
         </table>
    </div>
{%/block%}
