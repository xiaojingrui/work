<section class="tab">
	<ul id="J-tab">
		<li class="tab-team-rank" dace-node="{%if $type == 'nba'%}nbateamrank{%else%}cbateamrank{%/if%}">{%if $type == "nba"%}球队排行{%else%}积分榜{%/if%}</li>
		{%if $type == "nba"%}
		<li class="tab-player-data" data-type="{%$pageTab%}" dace-node="nbaplayerrank">球员数据</li>
			{%if $pageLastTab == "daily"%}
				<li class="tab-daily-data" data-type="daily" dace-node="nbadaliyrank">
				今日数据</li>
				<li class="tab-hurt-info" data-type="injury" dace-node="">伤停情况</li>
			{%else%}
				<li class="tab-trade-info" data-type="trade" dace-node="nbafreeagent">签约交易</li>
				<li class="tab-draft-result" data-type="draft" dace-node="nbadraft">选秀结果</li>
			{%/if%}
		{%else%}
		<li class="tab-player-data" data-type="pre" dace-node="cbaplayerrank">球员数据</li>
		<li class="tab-daily-data" data-type="today" dace-node="cbaweeklyrank">本轮数据</li>
		{%/if%}
	</ul>
</section>
