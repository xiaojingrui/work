<section class="player-data mod-rank swiper-slide swiper-no-swiping" id="J-player-data">
	<script id="J-player-data-tpl" type="text/template">
		<@ if(!_.isEmpty($(datas))){ @>
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
								<@ if(item.en != "five_player"){ @>
									<td width="66%" class="type">
                                        <@ if(GM.match == "nba"){ @>
											<@ if(item.name == "eFG%" || item.name == "TS%" || item.name == "失误率" || item.name == "PER" || item.name == "WS" || item.name == "OWS" || item.name == "DWS" || item.name == "USG%" || item.name == "罚球率" || item.name == "进攻效率" || item.name == "防守效率"){ @>
												<a href="https://nba.hupu.com/wiki/%E8%BF%9B%E9%98%B6%E6%95%B0%E6%8D%AE?night=0&entrance=1"><@=item.name@>榜</a>
                                            <@ }else{ @>
                                                <@=item.name@>榜
                                            <@ } @>
										<@ }else{ @>
											<@ if(item.name == "真实命中率" || item.name == "防守效率" || item.name == "回合数"){ @>
												<a href="https://nba.hupu.com/wiki/%E8%BF%9B%E9%98%B6%E6%95%B0%E6%8D%AE?night=0&entrance=1"><@=item.name@>榜</a>
                                            <@ }else{ @>
                                                <@=item.name@>榜
                                            <@ } @>
										<@ } @>

										<@ if(GM.match == "nba"){ @>
											<@ if(item.name == "eFG%" || item.name == "TS%" || item.name == "失误率" || item.name == "PER" || item.name == "WS" || item.name == "OWS" || item.name == "DWS" || item.name == "USG%" || item.name == "罚球率" || item.name == "进攻效率" || item.name == "防守效率"){ @>
												<a href="https://nba.hupu.com/wiki/%E8%BF%9B%E9%98%B6%E6%95%B0%E6%8D%AE?night=0&entrance=1"><i class="icon"></i></a>
											<@ } @>
										<@ }else{ @>
											<@ if(item.name == "真实命中率" || item.name == "防守效率" || item.name == "回合数"){ @>
												<a href="https://nba.hupu.com/wiki/%E8%BF%9B%E9%98%B6%E6%95%B0%E6%8D%AE?night=0&entrance=1"><i class="icon"></i></a>
											<@ } @>
										<@ } @>
									</td>
									<td width="20%" align="center">球队</td>
									<td width="14%" align="center"><@ if(item.en == "salary"){ @>美元<@ }else{ @>数据<@ } @></td>
								<@ }else{ @>
									<td width="55%" colspan="2" class="type"><@=item.name@>排行榜</td>
									<td width="15%" align="center">球队</td>
									<td width="15%" align="center">时间</td>
									<td width="15%" align="center">+/-</td>
								<@ } @>
							</tr>
						</thead>
					</table>
					<table class="mod-table">
						<tbody>
							<@ $(item.data).each(function(subIndex,subItem){ @>
							<@ if(GM.match == "nba"){ @>
								<@ if(item.en != "five_player"){ @>
									<tr class="link" link="kanqiu://nba/nba/player/<@=subItem.player_id@>">
								<@ }else{ @>
									<tr class="link" link="kanqiu://nba/nba/team/<@=subItem.team_id@>">
								<@ } @>
							<@ }else{ @>
								<@ if(isH5url){ @>
								<tr class="link" link="/cba/playerPage?client=<@=GM.client@>&player_id=<@=subItem.player_id@>">
								<@ }else{ @>
								<tr class="link" link="kanqiu://cba/cba/player/<@=subItem.player_id@>">
								<@ } @>
							<@ } @>
								<@ if(item.en != "five_player"){ @>
									<td width="66%">
										<span class="<@ if(subItem.rank == 1){ @>red<@ } @> num"><@=subItem.rank@></span>
										<span class="logo"><img class="lazy" data-original="<@=subItem.player_header@>?t=<@=index@><@=subIndex@>" /><@if(GM.night){ @><span class="mask"></span><@ } @></span>
										<span class="detail">
											<span class="name"><@=subItem.player_name@></span>
											<@ if(subItem.pts && subItem.reb && subItem.asts){ @>
											<span class="others">
												<@=subItem.pts@>分
												<@=subItem.reb@>板
												<@=subItem.asts@>助
											</span>
											<@ } @>
										</span>
									</td>
									<td width="20%" align="center"><@=subItem.team_name@></td>
									<td width="14%" align="center"><@ if(item.en != "win_time"){ @><@=subItem.val@><@ }else{ @><@=subItem.avg_points@><@ } @><@ if(item.en == "salary"){ @>万<@ } @></td>
								<@ }else{ @>
									<td>
										<span class="<@ if(subItem.rank == 1){ @>red<@ } @> num"><@=subItem.rank@></span>
									</td>
									<td><@=subItem.data_name@></td>
									<td width="15%" align="center"><@=subItem.team_name@></td>
									<td width="15%" align="center"><@=parseFloat(subItem.val/60).toFixed(1)@></td>
									<td width="15%" align="center">
										<@ if(parseFloat(subItem.avg_plus_minus).toFixed(1)>0){ @>+<@ } @><@=parseFloat(subItem.avg_plus_minus).toFixed(1)@>
									</td>
								<@ } @>
							</tr>
							<@ }); @>
							<@if(item.is_more){@>
							<tr class="last-tr">
								<td <@ if(item.en != "five_player"){ @>colspan="3"<@ }else{ @>colspan="5"<@ } @> align="center">
									<span class="view-all link all-link" link="<@ if(GM.match == "nba"){ @>/nba/getDailyPlayer<@ }else{ @>/cba/getPlayerAllPreRank<@ } @>" data-type="<@=item.en@>">查看全部 ></span>
									<!-- <span class="rules"><i <@if(!GM.night){ @> class="day-icon" <@ }else{ @> class="night-icon" <@ } @>></i> 规则</span> -->
								</td>
							</tr>
							<@ } @>
							<@if(item.data.length == 0){@>
								<tr class="last-tr">
									<td colspan="3" align="center">
										暂无数据
									</td>
								</tr>
							<@ } @>
						</tbody>
					</table>
				</li>
			<@ }); @>
		</ul>
		<@ }else{ @>
			<div class="main">
				<div class="no-data">暂无球员数据</div>
			</div>
		<@ } @>
	</script>
</section>
