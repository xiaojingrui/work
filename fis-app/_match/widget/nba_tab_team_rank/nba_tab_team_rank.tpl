<section class="team-rank mod-rank swiper-slide swiper-no-swiping" id="J-team-rank">
	{%$isAllEmpty = true%}
	{%foreach $data as $val%}
		{%if $val.data%}
		{%$isAllEmpty = false%}
		{%/if%}
	{%/foreach%}
	{%if !$isGoalsAllEmpty%}
	<div class="nav">
		<ul>
			{%foreach $data as $val%}
			{%if $val.data%}
			<li {%if $val@index == 0%} class="active" {%/if%}><a href="javascript:void(0);">{%$val.name%}</a></li>
			{%/if%}
			{%/foreach%}
		</ul>
	</div>
	<ul class="main">
		{%foreach $data as $val%}
			{%if $val.data%}
				{%if $val.rank_type == "east" || $val.rank_type == "west"%}
				<li>
					<table class="mod-title title">
						<thead>
							<tr>
								<td width="45%" colspan="3" class="type"><span>{%$val.name%}</span></td>
								<td width="15%" align="center">胜-负</td>
								<td width="20%" align="center">胜场差</td>
								<td width="20%" align="center">近况</td>
							</tr>
						</thead>
					</table>
					<table class="mod-table">
						<tbody>
							{%foreach $val.data as $subVal%}
							<tr class="link" link="kanqiu://nba/nba/team/{%$subVal.tid%}">
								<td>
									<span class="{%if $subVal@index+1<=8%}red{%/if%} num">{%$subVal@index+1%}</span>
								</td>
								<td>
									<span class="team-logo"><img class="lazy" data-original="//b1.hoopchina.com.cn/games/teams/nba/1_{%$subVal.tid%}_2x_alpha.png?t={%$subVal@index%}" width="28" /></span>
								</td>
								<td>
									<span class="name">{%$subVal.name%}</span>
								</td>
								<td width="15%" align="center">{%$subVal.win%}-{%$subVal.lost%}</td>
								<td width="20%" align="center">{%$subVal.gb%}</td>
								<td width="20%" align="center">{%$subVal.strk%}</td>
							</tr>
							{%/foreach%}
						</tbody>
					</table>
				</li>
				{%else%}
				<li>
					<table class="mod-title title">
						<thead>
							<tr>
								<td width="80%" colspan="3" class="type">
                                    {%if $val.name == "进攻效率" || $val.name == "防守效率" || $val.name == "回合数"%}
									    <a href="https://nba.hupu.com/wiki/%E8%BF%9B%E9%98%B6%E6%95%B0%E6%8D%AE?night=0&entrance=1">{%$val.name%}榜</a>
                                    {%else%}
                                        <span>{%$val.name%}榜</span>
									{%/if%}

									{%if $val.name == "进攻效率" || $val.name == "防守效率" || $val.name == "回合数"%}
									<a href="https://nba.hupu.com/wiki/%E8%BF%9B%E9%98%B6%E6%95%B0%E6%8D%AE?night=0&entrance=1"><i class="icon"></i></a>
									{%/if%}</td>
								<td width="20%" align="center">数据</td>
							</tr>
						</thead>
					</table>
					<table class="mod-table">
						<tbody>
							{%foreach $val.data as $subVal%}
							<tr class="link" link="kanqiu://nba/nba/team/{%$subVal.team_id%}">
								<td>
									<span class="{%if $subVal@index==0%}red{%/if%} num">{%$subVal@index+1%}</span>
								</td>
								<td>
									<span class="team-logo"><img class="lazy" data-original="//b1.hoopchina.com.cn/games/teams/nba/1_{%$subVal.team_id%}_2x_alpha.png?t={%$subVal@index%}" width="28" /></span>
								</td>
								<td>
									<span class="name">{%$subVal.team_alias%}</span>
								</td>
								<td width="20%" align="center">{%$subVal.value%}</td>
							</tr>
							{%/foreach%}
							<tr class="last-tr">
								<td colspan="5" align="center">
									<span class="view-all link all-link tap" link="/nba/getDataRank" data-isteam="1" data-type="{%$val.rank_type%}">查看全部 ></span>
								</td>
							</tr>
						</tbody>
					</table>
				</li>
				{%/if%}
			{%/if%}
		{%/foreach%}
	</ul>
	{%else%}
	<div class="mod-no-data">暂无球员榜数据</div>
	{%/if%}
</section>
