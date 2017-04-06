<section class="transfer-player mod-rank swiper-slide swiper-no-swiping" id="J-transfer-player">
	{%$isGoalsAllEmpty = true%}
	{%foreach $rank[3].ranks_data as $val%}
		{%if $val.data%}
		{%$isGoalsAllEmpty = false%}
		{%/if%}
	{%/foreach%}
	{%if !$isGoalsAllEmpty%}
	<div class="nav">
		<ul>
			{%foreach $rank[3].ranks_data as $val%}
			<li {%if $val@index == 0%} class="active" {%/if%}><a href="javascript:void(0);">{%$val.name%}</a></li>
			{%/foreach%}
		</ul>
	</div>
	<ul class="main">
		{%foreach $rank[3].ranks_data as $val%}
		{%if $val.name != "最近" && $val.name != "TOP20"%}
		<li class="item-team">
			<table class="mod-title title">
				<thead>
					<tr>
						<td width="40%" colspan="2" class="type">
							<span class="team-logo">
								<img data-original="{%$val.logo%}?t={%$val@index%}" width="30" class="lazy">
							</span>
							<span class="team-name">{%$val.name%}</span>
						</td>
						{%* <td width="60%" colspan="2" align="right" class="cost">转会净支出：2亿欧元</td> *%}
					</tr>
				</thead>
			</table>
			{%if !empty($val.data.join) || !empty($val.data.leave)%}
				{%if !empty($val.data.join)%}
				<table class="mod-table">
					<thead>
						<tr>
							<td width="50%" colspan="2" class="type"><span class="join">加入</span></td>
							<td width="20%" align="center">原球队</td>
							<td width="30%" align="center">转会费(欧元)</td>
						</tr>
					</thead>
					<tbody>
						{%foreach $val.data.join as $subVal%}
						<tr {%if $league_name != "afccl"%}class="link tap" link="kanqiu://soccerleagues/{%$league_name%}/player/{%$subVal.player_id%}"{%/if%}>
							<td width="14%">
								<span class="logo">
									<img data-original="{%$subVal.photo%}?t={%$val@index%}{%$subVal@index%}" class="lazy">
									{%if !empty($night)%}
									<span class="mask"></span>
									{%/if%}
								</span>
							</td>
							<td width="36%" class="td2">
								<div class="name">{%$subVal.name%}</div>
							</td>
							<td width="20%" align="center" class="td3">
								<div class="old-team">{%$subVal.from_team_name%}</div>
								<div class="league">{%if !empty($subVal.from_league_name)%}({%$subVal.from_league_name%}){%/if%}</div>
							</td>
							<td width="30%" align="center" class="td4">{%$subVal.fee%}{%if !empty($subVal.memo)%}<i class="icon" data-memo="{%$subVal.memo%}"></i>{%/if%}</td>
						</tr>
						{%/foreach%}
					</tbody>
				</table>
				{%/if%}
				{%if !empty($val.data.leave)%}
				<table class="mod-table">
					<thead>
						<tr>
							<td width="50%" colspan="2" class="type"><span class="leave">离开</span></td>
							<td width="20%" align="center">新球队</td>
							<td width="30%" align="center">转会费(欧元)</td>
						</tr>
					</thead>
					<tbody>
						{%foreach $val.data.leave as $subVal%}
						<tr {%if $league_name != "afccl"%}class="link tap" link="kanqiu://soccerleagues/{%$league_name%}/player/{%$subVal.player_id%}"{%/if%}>
							<td width="14%">
								<span class="logo">
									<img data-original="{%$subVal.photo%}?t={%$val@index%}{%$subVal@index%}" class="lazy">
									{%if !empty($night)%}
									<span class="mask"></span>
									{%/if%}
								</span>
							</td>
							<td width="36%" class="td2">
								<div class="name">{%$subVal.name%}</div>
							</td>
							<td width="20%" align="center" class="td3">
								<div class="old-team">{%$subVal.to_team_name%}</div>
								<div class="league">{%if !empty($subVal.from_league_name)%}({%$subVal.from_league_name%}){%/if%}</div>
							</td>
							<td width="30%" align="center" class="td4">{%$subVal.fee%}{%if !empty($subVal.memo)%}<i class="icon" data-memo="{%$subVal.memo%}"></i>{%/if%}</td>
						</tr>
						{%/foreach%}
					</tbody>
				</table>
				{%/if%}
			{%else%}
				<table class="mod-table">
					<td colspan="4" align="center" class="no-result">暂无球员变动</td>
				</table>
			{%/if%}
		</li>
		{%else%}
		<li>
			<table class="mod-title title">
				<thead>
					<tr>
						<td width="50%" colspan="2" class="type"><span>{%$val.name%}</span></td>
						<td width="20%" align="center">转会至</td>
						<td width="30%" align="center">转会费(欧元)</td>
					</tr>
				</thead>
			</table>
			<table class="mod-table">
				<tbody>
					{%if !empty($val.data)%}
						{%foreach $val.data as $subVal%}
						<tr {%if $league_name != "afccl"%}class="link tap" link="kanqiu://soccerleagues/{%$league_name%}/player/{%$subVal.player_id%}"{%/if%}>
							<td width="14%">
								<span class="logo">
									<img data-original="{%$subVal.photo%}?t={%$val@index%}{%$subVal@index%}" class="lazy">
									{%if !empty($night)%}
									<span class="mask"></span>
									{%/if%}
								</span>
							</td>
							<td width="36%" class="td2">
								<div class="name">{%$subVal.name%}</div>
								<div class="old-team">{%$subVal.from_team_name%}(原)</div>
							</td>
							<td width="20%" align="center" class="td3">{%$subVal.to_team_name%}</td>
							<td width="30%" align="center" class="td4">{%$subVal.fee%}{%if !empty($subVal.memo)%}<i class="icon" data-memo="{%$subVal.memo%}"></i>{%/if%}</td>
						</tr>
						{%/foreach%}
						{%if $val.is_more%}
						<tr class="last-tr">
							<td colspan="4" align="center">
								<span class="view-all link all-link tap" link="/data/footballAllTransfer" data-type="{%$val.rank_type%}">查看全部 ></span>
							</td>
						</tr>
						{%/if%}
					{%else%}
						<tr>
							<td colspan="4" align="center" class="no-result">暂无球员变动</td>
						</tr>
					{%/if%}
				</tbody>
			</table>
		</li>
		{%/if%}
		{%/foreach%}
	</ul>
	{%else%}
	<div class="mod-no-data">暂无转会球员数据</div>
	{%/if%}
</section>
