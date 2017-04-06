
<section class="hurt-info mod-rank swiper-slide swiper-no-swiping" id="J-hurt-info">
{%$isGoalsAllEmpty = true%}
	<script id="J-hurt-info-tpl" type="text/template">
		<div class="nav">
			<ul>
				<@ $(datas).each(function(index,item) { @>
				<li <@ if(index==0){ @> class="active" <@ } @>><a href="javascript:void(0);"><@=item.name@></a></li>
				<@ }); @>
			</ul>
		</div>
		<ul class="main">
			<@ $(datas).each(function(index,item) { @>
			<li>
				<table class="mod-title title">
					<thead>
						<tr>
							<td width="50%" class="type"><@=item.name@></td>
							<td width="20%" align="center">伤停</td>
							<td align="center">最新进展</td>
						</tr>
					</thead>
				</table>
				<table class="mod-table">
					<tbody>
						<@ if(item.data){ @>
							<@ $(item.data).each(function(subIndex,subItem){ @>
								<@ if(GM.match == "nba"){ @>
									<tr class="link" link="kanqiu://nba/nba/player/<@=subItem.hupu_pid@>">
								<@ }else{ @>
									<@ if(isH5url){ @>
										<tr class="link" link="kanqiu://nba/nba/player/<@=subItem.hupu_pid@>">
									<@ } @>
								<@ } @>
								<td width="50%" >
										<span class="logo" style="margin-left: 5px;"><img class="lazy" data-original="<@=subItem.player_photo@>?t=<@=index@><@=subIndex@>"/>
										<@if(GM.night){ @>
											<span class="mask"></span>
										<@ } @>
										</span>
									<span class="detail">
										<span class="name"><@=subItem.alias@></span>
										<span class="others">
											<@=subItem.team_name @>
										</span>
									</span>
								</td>
								<td  width="20%"  align="center">
									<@ if(subItem.injury_part_cn){ @>
										<span class="injury_returns">
											<@=subItem.injury_part_cn@>
										</span>
									<@ }else{ @>
										<span class="injury_returns">
											<@=subItem.injury_part@>
										</span>
									<@ } @>
								</td>
								<td align="center">
									<@ if(subItem.injury_returns_cn){ @>
										<span class="injury_returns_en"><@=subItem.injury_returns_cn @></span>
									<@ }else{ @>
										<span class="injury_returns_en"><@=subItem.injury_returns @></span>
									<@ } @>
								</td>
							</tr>
							<@ }); @>
							<@ if(item.is_more) { @>
								<tr class="last-tr">
									<td colspan="4" align="center">
										<span class="view-all link all-link" link="<@=item.allURL@>">查看全部 ></span>
									</td>
								</tr>
							<@ } @>
							<@if(item.data.length == 0){@>
								<tr class="last-tr">
									<td colspan="3" align="center">
										暂无伤停球员
									</td>
								</tr>
							<@ } @>
						<@ }else{ @>
								<tr>
									<td align="center" class="no-data">暂无伤停球员</td>
								</tr>
							<@ } @>
					</tbody>
				</table>
			</li>
			<@ }); @>
		</ul>
	</script>
</section>
