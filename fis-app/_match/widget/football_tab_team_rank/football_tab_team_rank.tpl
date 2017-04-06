<section class="team-rank mod-rank swiper-slide swiper-no-swiping" id="J-team-rank">
	{%$isAssistsAllEmpty = true%}
	{%foreach $rank[1].ranks_data as $val%}
		{%if $val.data%}
		{%$isAssistsAllEmpty = false%}
		{%/if%}
	{%/foreach%}
	{%if !$isAssistsAllEmpty%}
	<div class="nav">
		<ul>
			{%foreach $rank[2].ranks_data as $val%}
			<li {%if $val@index == 0%} class="active" {%/if%}><a href="javascript:void(0);">{%$val.name%}</a></li>
			{%/foreach%}
		</ul>
	</div>

	<ul class="main">
		{%foreach $rank[2].ranks_data as $val%}
		{%if $val.data%}
		<li>
			<table class="mod-title title">
				<thead>
					<tr>
						<td width="70%" colspan="2" class="type"><span>{%$val.name%}榜</span></td>
						<td width="30%" align="center">{%$val.title%}</td>
					</tr>
				</thead>
			</table>
			<table class="mod-table">
				<tbody>
					{%foreach $val.data as $subVal%}
					{%if $subVal@index < 5%}
					<tr class="link tap" link="kanqiu://soccerleagues/{%$league_name%}/team/{%$subVal.team_id%}">
						<td width="70%" align="left">
							<span {%if $subVal@index+1 == 1%} class="red num" {%else%} class="num" {%/if%}>{%$subVal@index+1%}</span>
							<span class="logo">
								<img data-original="{%$subVal.team_logo%}?t={%$val@index%}{%$subVal@index%}" width="34" class="lazy">
							</span>
							<span class="name">{%$subVal.team_name%}</span>
						</td>
						<td width="30%" align="center">
							{%if $val.rank_type == "pass_per"%}
								{%$subVal[$val.field]*100%}%
							{%else%}
								{%$subVal[$val.field]%}
							{%/if%}
						</td>
					</tr>
					{%/if%}
					{%/foreach%}
					<tr class="last-tr">
						<td colspan="3" align="center">
							<span class="view-all link all-link tap" link="/data/footballAllRank" data-type="{%$val.rank_type%}"
							>查看全部 ></span>
						</td>
					</tr>
				</tbody>
			</table>
		</li>
		{%/if%}
		{%/foreach%}
	</ul>
	{%else%}
	<div class="mod-no-data">暂无球队榜数据</div>
	{%/if%}
</section>
