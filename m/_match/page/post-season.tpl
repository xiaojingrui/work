{%extends file="common/page/layout.tpl"%}

{%block name="block_head_static"%}
    {%require name="match:static/post-season/post-season.scss"%}

    {%script%}
        var dace = require("common:widget/ui/page-dace/page-dace.js");

        $("#J-table tr").bind("click", function(e){
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
        hasBreadNav=true
    %}
    {%widget
    	name="common:widget/inner-tab/tab.tpl"
    	tabClass="matchafter"
    	selected=2
    %}
   <div class="table-scroll post-season">
            <table class="table" id="J-table">
                <thead>
                    <tr>
	                    <th class="col-header">排行</th>
                        <th class="number-1">得分</th>
                        <th class="number-1">篮板</th>
                        <th class="number-1">助攻</th>
                        <th class="number-1">抢断</th>
                        <th class="number-1">盖帽</th>
                        <th class="number-1">失误</th>
                    </tr>
                </thead>
                <tbody dace-node="{%$id4dace%}_team">
                    {%foreach from=$stats item=team%}
                        <tr data-href="{%$team.team_link%}">
                            <td class="col-header">
                                <span class="rank">{%$team.rank%}</span>
                                <a href="{%$team.team_link%}">{%$team["team_name"]%}</a>
                            </td>
                            <td class="number-1">{%$team.pts%}</td>
                            <td class="number-1">{%$team.reb%}</td>
                            <td class="number-1">{%$team.ast%}</td>
                            <td class="number-1">{%$team.st%}</td>
                            <td class="number-1">{%$team.blk%}</td>
                            <td class="number-1">{%$team.to%}</td>
                        </tr>
                    {%/foreach%}
                </tbody>
             </table>
    </div>
{%/block%}
