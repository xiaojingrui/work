<section class="mod-rank-wrap" id="J-mod-rank-wrap">
	<ul class="tab fixed" id="J-tab">
		<li class="tab-team active">球队排行</li>
		{%if $type == "nba"%}
		<li class="tab-regular" data-type="{%$pageTab%}">球员数据</li>
		<li class="tab-daily" data-type="daily">今日数据</li>
		{%else%}
		<li class="tab-regular" data-type="pre">球员数据</li>
		<li class="tab-daily" data-type="today">本轮数据</li>
		{%/if%}
	</ul>
	<section class="swiper-container">
		<section class="swiper-wrapper">
			{%if $type == "nba"%}
			<section class="team-rank swiper-slide" id="J-team-rank" {%if !empty($rankings)%}style="padding-top: 30px;"{%/if%}>
				<!-- 季后赛对阵图 -->
				{%if !empty($rankings)%}
				{%widget
			        name="match:widget/vs_nba/vs_nba.tpl"
			    %}
			    {%/if%}
				<!-- 球队排行 -->
				<table class="mod-title">
					<thead>
						<tr {%if !empty($night)%} style="background-color: #2c2c2c;" {%else%} style="background-color: #fff;" {%/if%}>
							<td width="40%" class="type">东部排行</td>
							<td width="8%" align="center">胜</td>
							<td width="8%" align="center">负</td>
							<td width="20%" align="center">胜场差</td>
							<td width="14%" align="center">近况</td>
						</tr>
					</thead>
				</table>
				<table class="mod-table">
					<tbody>
					{%if !empty($ranking["east"])%}
						{%foreach $ranking["east"] as $val%}
						<tr class="link" link="kanqiu://nba/nba/team/{%$val.tid%}">
							<td width="40%">
								{%if $val@index+1<=8%}
								<span class="red num">{%$val@index+1%}</span>
								{%else%}
								<span class="num">{%$val@index+1%}</span>
								{%/if%}<span class="logo"><img src="//b1.hoopchina.com.cn/games/teams/nba/1_{%$val.tid%}_2x_alpha.png?t=61" width="28" /></span><span class="name">{%$val.name%}</span>
							</td>
							<td width="8%" align="center">{%$val.win%}</td>
							<td width="8%" align="center">{%$val.lost%}</td>
							<td width="20%" align="center">{%$val.gb%}</td>
							<td width="14%" align="center">{%$val.strk%}</td>
						</tr>
						{%/foreach%}
		            {%else%}
		            	暂无东部数据
					{%/if%}
					</tbody>
				</table>
				<table class="mod-title title">
					<thead>
						<tr {%if !empty($night)%} style="background-color: #2c2c2c;" {%else%} style="background-color: #fff;" {%/if%}>
							<td width="40%" class="type">西部排行</td>
							<td width="8%" align="center">胜</td>
							<td width="8%" align="center">负</td>
							<td width="20%" align="center">胜场差</td>
							<td width="14%" align="center">近况</td>
						</tr>
					</thead>
				</table>
				<table class="mod-table west-table">
					<tbody>
					{%if !empty($ranking["west"])%}
						{%foreach $ranking["west"] as $val%}
						<tr class="link" link="kanqiu://nba/nba/team/{%$val.tid%}">
							<td width="40%">
								{%if $val@index+1<=8 %}
								<span class="red num">{%$val@index+1%}</span>
								{%else%}
								<span class="num">{%$val@index+1%}</span>
								{%/if%}<span class="logo"><img src="//b1.hoopchina.com.cn/games/teams/nba/1_{%$val.tid%}_2x_alpha.png?t=62" width="28" /><span class="name">{%$val.name%}</span>
							</td>
							<td width="8%" align="center">{%$val.win%}</td>
							<td width="8%" align="center">{%$val.lost%}</td>
							<td width="20%" align="center">{%$val.gb%}</td>
							<td width="14%" align="center">{%$val.strk%}</td>
						</tr>
						{%/foreach%}
					{%else%}
		            	暂无东部数据
					{%/if%}
					</tbody>
				</table>
			</section>
			{%else%}
			<section class="team-rank swiper-slide" id="J-team-rank">
				<table class="mod-title fixed">
					<thead>
						<tr>
							<td width="40%" class="type">球队</td>
							<td width="20%" align="center">场次</td>
							<td width="10%" align="center">胜</td>
							<td width="10%" align="center">负</td>
							<td width="20%" align="center">胜率</td>
						</tr>
					</thead>
				</table>
				<table class="mod-table">
					<tbody>
						{%foreach $standings as $val%}
						<tr class="link" link="kanqiu://cba/cba/team/{%$val.id%}">
							<td width="40%">
								{%if $val@index+1<=8 %}
								<span class="red num">{%$val@index+1%}</span>
								{%else%}
								<span class="num">{%$val@index+1%}</span>
								{%/if%}<span class="logo"><img src="//b1.hoopchina.com.cn/games/teams/cba/2_{%$val.id%}{%if ($val['id'] == 14) or ($val['id'] == 21)%}_new{%/if%}{%if ($val['id'] == 12)%}_1{%/if%}.png?t=63" width="28" /></span><span class="name">{%$val.name%}</span>
							</td>
							<td width="20%" align="center">{%$val.bout%}</td>
							<td width="10%" align="center">{%$val.win%}</td>
							<td width="10%" align="center">{%$val.los%}</td>
							<td width="20%" align="center">{%$val.rate%}</td>
						</tr>
						{%/foreach%}
					</tbody>
				</table>
			</section>
			{%/if%}
			<section class="regular-rank mod-rank swiper-slide" id="J-regular-rank">
				<script id="J-regular-rank-tpl" type="text/template">
					<@ $(datas).each(function(index,item) { @>
					<@ if(index == 0){ @>
					<table class="mod-title fixed">
					<@ }else{ @>
					<table class="mod-title title">
					<@ } @>
						<thead>
							<tr>
								<td width="60%" class="type"><@=item.name@>排行榜</td>
								<td width="20%" align="center">球队</td>
								<td width="20%" align="center">数据</td>
							</tr>
						</thead>
					</table>
					<table class="mod-table">
						<tbody>
							<@ $(item.data).each(function(subIndex,subItem){ @>
							<@ if(GM.match == "nba"){ @>
							<tr class="link" link="kanqiu://nba/nba/player/<@=subItem.player_id@>">
							<@ }else{ @>
								<@ if(isH5url){ @>
								<tr class="link" link="/cba/playerPage?client=<@=GM.client@>&player_id=<@=subItem.player_id@>">
								<@ }else{ @>
								<tr class="link" link="kanqiu://cba/cba/player/<@=subItem.player_id@>">
								<@ } @>
							<@ } @>
								<td width="60%">
									<@ if(subIndex == 0){ @>
									<span class="red num"><@=subIndex+1@></span>
									<@ }else{ @>
									<span class="num"><@=subIndex+1@></span>
									<@ } @><span class="logo"><img src="<@=subItem.player_header@>?t=64" /><@if(GM.night){ @><span class="mask"></span><@ } @></span>
									<span class="detail">
										<span class="name"><@=subItem.player_name@></span>
										<span class="others">
											<@=subItem.pts@>分
											<@=subItem.reb@>板
											<@=subItem.asts@>助
										</span>
									</span>
								</td>
								<td width="20%" align="center"><@=subItem.team_name@></td>
								<td width="20%" align="center"><@=subItem.val@></td>
							</tr>
							<@ }); @>
							<@ if(GM.match == "nba"){ @>
							<tr class="last-tr">
								<td colspan="3" align="center">
									<span class="view-all link all-link" link="/nba/getDailyPlayer"
									<@ if(item.name == "得分"){ @>
									data-type="pts"
									<@ }else if(item.name == "篮板"){ @>
									data-type="reb"
									<@ }else if(item.name == "助攻"){ @>
									data-type="asts"
									<@ }else if(item.name == "抢断"){ @>
									data-type="stl"
									<@ }else if(item.name == "盖帽"){ @>
									data-type="blk"
									<@ }else if(item.name == "投篮命中率"){ @>
									data-type="fgp"
									<@ }else if(item.name == "三分命中率"){ @>
									data-type="tpp"
									<@ }else if(item.name == "罚球命中率"){ @>
									data-type="ftp"
									<@ }else if(item.name == "失误"){ @>
									data-type="to"
									<@ }else if(item.name == "上场时间"){ @>
									data-type="mins"
									<@ } @>
									>查看全部></span>
									<span class="rules"><i <@if(!GM.night){ @> class="day-icon" <@ }else{ @> class="night-icon" <@ } @>></i> 规则</span>
								</td>
							</tr>
							<@ }else{ @>
							<tr></tr>
							<@ } @>
						</tbody>
					</table>
					<@ }); @>
				</script>
			</section>
			<section class="daily-rank mod-rank swiper-slide" id="J-daily-rank">
				<script id="J-daily-rank-tpl" type="text/template">
					<@ $(datas).each(function(index,item) { @>
					<@ if(index == 0){ @>
					<table class="mod-title fixed">
					<@ }else{ @>
					<table class="mod-title title">
					<@ } @>
						<thead>
							<tr>
								<td width="60%" class="type"><@=item.name@>排行榜</td>
								<td width="20%" align="center">球队</td>
								<td width="20%" align="center">数据</td>
							</tr>
						</thead>
					</table>
					<table class="mod-table">
						<tbody>
							<@ $(item.data).each(function(subIndex,subItem){ @>
							<@ if(GM.match == "nba"){ @>
							<tr class="link" link="kanqiu://nba/nba/player/<@=subItem.player_id@>">
							<@ }else{ @>
								<@ if(isH5url){ @>
								<tr class="link" link="/cba/playerPage?client=<@=GM.client@>&player_id=<@=subItem.player_id@>">
								<@ }else{ @>
								<tr class="link" link="kanqiu://cba/cba/player/<@=subItem.player_id@>">
								<@ } @>
							<@ } @>
								<td width="60%">
									<@ if(subIndex == 0){ @>
									<span class="red num"><@=subIndex+1@></span>
									<@ }else{ @>
									<span class="num"><@=subIndex+1@></span>
									<@ } @><span class="logo"><img src="<@=subItem.player_header@>?t=65"/><@if(GM.night){ @><span class="mask"></span><@ } @></span>
									<span class="detail">
										<span class="name"><@=subItem.player_name@></span>
										<span class="others">
											<@=subItem.pts@>分
											<@=subItem.reb@>板
											<@=subItem.asts@>助
										</span>
									</span>
								</td>
								<td width="20%" align="center"><@=subItem.team_name@></td>
								<td width="20%" align="center"><@=subItem.val@></td>
							</tr>
							<@ }); @>
						</tbody>
					</table>
					<@ }); @>
				</script>
			</section>
		</section>
	</section>
</section>
{%if $type == "nba"%}
<div class="mod-show-mask" style="display: none;"></div>
<div class="mod-showBox rules-showBox m-hide" style="display: none;">
	<div class="bd">
		<p>场均得分、篮板、助攻、抢断、盖帽、上场时间：至少要打满球队已完成比赛70%的场次，对于常规赛82场比赛，至少要打58场</p>
		<p class="tips">唯一的例外是在赛季结束时，如果一名球员的上场场次未达到要求，但是以最低出场数为基数，他的场均数据仍位列联盟榜首，那么他的数据将视为有效。</p>
		<p>投篮命中率：至少投中300次</p>
		<p>罚球命中率：至少罚中125次</p>
		<p>三分命中率：至少命中82次</p>
		<p class="tips">投篮命中率、罚球命中率、三分命中率排行只和投中数有关，与出场数无关。</p>
	</div>
	<div class="ft close">关闭</div>
</div>
{%/if%}
