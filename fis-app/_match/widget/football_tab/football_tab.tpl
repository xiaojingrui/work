<section class="tab">
	<ul id="J-tab">
		<li class="tab-standings-rank" dace-node="{%$league_name%}_standings">
			<span>
				{%$rank[0]["title"]%}
				{%if $rank[0]["title"] == "球员榜" || $rank[0]["title"] == "球队榜"%}
				<i class="new-tag {%if $rank[0]["title"] == "球员榜"%}player-tag{%else%}team-tag{%/if%}">NEW</i>
				{%/if%}
			</span>
		</li>
		<li class="tab-player-rank" dace-node="{%$league_name%}_playerrank">
			<span>
				{%$rank[1]["title"]%}
				{%if $rank[1]["title"] == "球员榜" || $rank[1]["title"] == "球队榜"%}
				<i class="new-tag {%if $rank[1]["title"] == "球员榜"%}player-tag{%else%}team-tag{%/if%}">NEW</i>
				{%/if%}
			</span>
		</li>
		{%if $league_name != "csl_zj"%}</span>
		<li class="tab-team-rank" dace-node="{%$league_name%}_teamrank">
			<span>
				{%$rank[2]["title"]%}
				{%if $rank[2]["title"] == "球员榜" || $rank[2]["title"] == "球队榜"%}
				<i class="new-tag {%if $rank[2]["title"] == "球员榜"%}player-tag{%else%}team-tag{%/if%}">NEW</i>
				{%/if%}
			</span>
		</li>
		{%/if%}
		{%if $pageLastTab == 1%}
			{%if $league_name == "csl" || $league_name == "epl" || $league_name == "bund" || $league_name == "liga" || $league_name == "seri" || $league_name == "fran"%}
			<li class="tab-transfer-player" dace-node="{%$league_name%}_transfermarket">
				<span>
					{%$rank[3]["title"]%}
					{%if $rank[3]["title"] == "球员榜" || $rank[3]["title"] == "球队榜"%}
					<i class="new-tag {%if $rank[3]["title"] == "球员榜"%}player-tag{%else%}team-tag{%/if%}">NEW</i>
					{%/if%}
				</span>
			</li>
			{%/if%}
		{%/if%}
	</ul>
</section>
