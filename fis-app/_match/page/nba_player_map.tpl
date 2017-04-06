{%extends file="common/page/layout.tpl"%}

{%block name="title"%}{%/block%}

{%block name="head_static"%}
	<script type="text/javascript" src="//w1.hoopchina.com.cn/hybrid/common/hpbridge_v1.0.1.js"></script>
	{%require name="common:static/js/zepto/zepto.js"%}
	{%require name="match:static/nba_player_map/nba_player_map.scss"%}
	{%require name="match:static/nba_player_map/nba_player_map.js"%}
	{%script%}
		window.GM = {
            "client": "{%$client%}" || "x",
            "islogin": !!parseInt("{%$is_login%}", 10),
            "night": !!parseInt("{%$night%}", 10),
            "gid": "{%$smarty.get.gid%}" || 1,
            "player_id": "{%$smarty.get.player_id%}" || 1
        };
    {%/script%}
{%/block%}

{%block name="content"%}
	<section class="iwidth"></section>
	<section class="map-wrap" id="J-map-wrap">
		<i class="close" id="J-close"></i>
		<a href="javascript:void(0);" class="header link" link="kanqiu://nba/nba/player/{%$player_info.player_id%}">
			<div class="head">
				<img src="{%$player_info.player_header%}" alt="">
				{%if !empty($night)%}
				<span class="mask"></span>
				{%/if%}
			</div>
			<div class="info">
				<div class="name">
					{%if !empty($player_info.player_name)%}{%$player_info.player_name%}{%else%}{%$player_info.player_enname%}{%/if%}
					<span class="line"></span>
				</div>
				<div class="num">{%$player_info.number%}{%if $player_info.number != ""%}号{%/if%}</div>
			</div>
			<div class="mask"></div>
		</a>
		<section class="tabs" id="J-tabs">
			{%$loop=$sections%}
			{%section name=loop loop=$loop%}
			<span>
				<a href="javascript:void(0);" {%if $section_status[$smarty.section.loop.index] == 0%} class="absent" {%/if%} data-section="{%$smarty.section.loop.index+1%}">
				{%if $smarty.section.loop.index+1 > 4%}
				加{%$smarty.section.loop.index-3%}
				{%else%}
				{%$smarty.section.loop.index+1%}
				{%/if%}
				</a>
			</span>
			{%/section%}
			<span class="active"><a href="javascript:void(0);" data-section="0">全场</a></span>
		</section>
		<section id="J-datas-wrap">
			<section class="all-data">
				<section class="datas datas-top">
					<ul>
						<li>
							<div class="value">{%$player_score.playerStats.ti%}</div>
							<div class="key">时间</div>
						</li>
						<li>
							<div class="value">{%$player_score.playerStats.pts%}</div>
							<div class="key">得分</div>
						</li>
						<li>
							<div class="value">{%$player_score.playerStats.oreb+$player_score.playerStats.dreb%}</div>
							<div class="key">篮板</div>
						</li>
						<li>
							<div class="value">{%$player_score.playerStats.asts%}</div>
							<div class="key">助攻</div>
						</li>
						<li>
							<div class="value">{%$player_score.playerStats.stl%}</div>
							<div class="key">抢断</div>
						</li>
						<li>
							<div class="value">{%$player_score.playerStats.blk%}</div>
							<div class="key">盖帽</div>
						</li>
						<li>
							<div class="value">{%$player_score.playerStats.net_points%}</div>
							<div class="key">+/-</div>
						</li>
					</ul>
				</section>
				<section class="datas-map">
					{%if !empty($night)%}
					<img src="../static/nba_player_map/img/map_bg_night.jpg" alt="">
					{%else%}
					<img src="../static/nba_player_map/img/map_bg.jpg" alt="">
					{%/if%}
					{%if !empty($player_score.fgStats)%}
					{%foreach $player_score.fgStats as $val%}
					<span {%if $val.is_get == 1%} class="dot get" {%else%} class="dot notget" {%/if%} style="left: {%$val.shot_coord_x%}px; top: {%$val.shot_coord_y%}px;"></span>
					{%/foreach%}
					{%/if%}
				</section>
				<section class="datas datas-bottom">
					<ul>
						<li>
							<div class="value">{%$player_score.playerStats.fg_made%}/{%$player_score.playerStats.fg_made+$player_score.playerStats.fg_missed%}</div>
							<div class="key">投篮</div>
						</li>
						<li>
							<div class="value">
							{%if $player_score.playerStats.fg_missed == 0 && $player_score.playerStats.fg_made != 0%}100{%else if $player_score.playerStats.fg_made == 0%}0{%else%}{%($player_score.playerStats.fg_made/($player_score.playerStats.fg_made+$player_score.playerStats.fg_missed)*100)|string_format:"%0.1f"%}{%/if%}%
							</div>
							<div class="key">命中</div>
						</li>
						<li>
							<div class="value">{%$player_score.playerStats.2pm%}/{%$player_score.playerStats.2pa%}</div>
							<div class="key">两分球</div>
						</li>
						<li>
							<div class="value">{%$player_score.playerStats.tpm%}/{%$player_score.playerStats.tpa%}</div>
							<div class="key">三分球</div>
						</li>
						<li>
							<div class="value">{%$player_score.playerStats.ftm%}/{%$player_score.playerStats.fta%}</div>
							<div class="key">罚球</div>
						</li>
						<li>
							<!-- <div class="value">{%$player_score.playerStats.blkr%}</div>
							<div class="key">被盖</div> -->
						</li>
					</ul>
					<ul>
						<li>
							<div class="value">{%$player_score.playerStats.jumpshot_made%}/{%$player_score.playerStats.jumpshot_made+$player_score.playerStats.jumpshot_missed%}</div>
							<div class="key">跳投</div>
						</li>
						<li>
							<div class="value">{%$player_score.playerStats.dunk_made%}/{%$player_score.playerStats.dunk_made+$player_score.playerStats.dunk_missed%}</div>
							<div class="key">扣篮</div>
						</li>
						<li>
							<div class="value">{%$player_score.playerStats.layup_made%}/{%$player_score.playerStats.layup_made+$player_score.playerStats.layup_missed%}</div>
							<div class="key">上篮</div>
						</li>
						<li>
							<div class="value">{%$player_score.playerStats.tipin_made%}/{%$player_score.playerStats.tipin_made+$player_score.playerStats.tipin_missed%}</div>
							<div class="key">补篮</div>
						</li>
						<li>
							<div class="value">{%$player_score.playerStats.hook_made%}/{%$player_score.playerStats.hook_made+$player_score.playerStats.hook_missed%}</div>
							<div class="key">勾手</div>
						</li>
						<li>
							<div class="value">{%$player_score.playerStats.other_made%}/{%$player_score.playerStats.other_made+$player_score.playerStats.other_missed%}</div>
							<div class="key">其他</div>
						</li>
					</ul>
				</section>
			</section>
		</section>
		<script type="text/template" id="J-datas-tpl">
			<section class="datas datas-top">
				<ul>
					<li>
						<div class="value"><@=player_score.playerStats.ti@></div>
						<div class="key">时间</div>
					</li>
					<li>
						<div class="value"><@=player_score.playerStats.pts@></div>
						<div class="key">得分</div>
					</li>
					<li>
						<div class="value"><@=player_score.playerStats.oreb + player_score.playerStats.dreb@></div>
						<div class="key">篮板</div>
					</li>
					<li>
						<div class="value"><@=player_score.playerStats.asts@></div>
						<div class="key">助攻</div>
					</li>
					<li>
						<div class="value"><@=player_score.playerStats.stl@></div>
						<div class="key">抢断</div>
					</li>
					<li>
						<div class="value"><@=player_score.playerStats.blk@></div>
						<div class="key">盖帽</div>
					</li>
					<li>
						<div class="value"><@=player_score.playerStats.net_points@></div>
						<div class="key">+/-</div>
					</li>
				</ul>
			</section>
			<section class="datas-map">
				<@if(GM.night){@>
				<img src="../static/nba_player_map/img/map_bg_night.jpg" alt="">
				<@}else{@>
				<img src="../static/nba_player_map/img/map_bg.jpg" alt="">
				<@}@>
				<@$(datas).each(function(index, item){@>
				<span <@if(item.is_get == 1){@> class="dot get" <@}else{@> class="dot notget" <@}@> style="left: <@=item.shot_coord_x@>px; top: <@=item.shot_coord_y@>px;"></span>
				<@})@>
			</section>
			<section class="datas datas-bottom">
				<ul>
					<li>
						<div class="value"><@=player_score.playerStats.fg_made@>/<@=player_score.playerStats.fg_made+player_score.playerStats.fg_missed@></div>
						<div class="key">投篮</div>
					</li>
					<li>
						<div class="value">
						<@if(player_score.playerStats.fg_missed == 0 && player_score.playerStats.fg_made != 0 ){@>100<@}else if(player_score.playerStats.fg_made == 0){@>0<@}else{@><@=parseFloat(player_score.playerStats.fg_made/(player_score.playerStats.fg_made+player_score.playerStats.fg_missed)*100).toFixed(1)@><@}@>%
						</div>
						<div class="key">命中</div>
					</li>
					<li>
						<div class="value"><@=player_score.playerStats['2pm']@>/<@=player_score.playerStats['2pa']@></div>
						<div class="key">两分球</div>
					</li>
					<li>
						<div class="value"><@=player_score.playerStats.tpm@>/<@=player_score.playerStats.tpa@></div>
						<div class="key">三分球</div>
					</li>
					<li>
						<div class="value"><@=player_score.playerStats.ftm@>/<@=player_score.playerStats.fta@></div>
						<div class="key">罚球</div>
					</li>
					<li>
						<div class="value"><@=player_score.playerStats.blkr@></div>
						<div class="key">被盖</div>
					</li>
				</ul>
				<ul>
					<li>
						<div class="value"><@=player_score.playerStats.jumpshot_made@>/<@=player_score.playerStats.jumpshot_made+player_score.playerStats.jumpshot_missed@></div>
						<div class="key">跳投</div>
					</li>
					<li>
						<div class="value"><@=player_score.playerStats.dunk_made@>/<@=player_score.playerStats.dunk_made+player_score.playerStats.dunk_missed@></div>
						<div class="key">扣篮</div>
					</li>
					<li>
						<div class="value"><@=player_score.playerStats.layup_made@>/<@=player_score.playerStats.layup_made+player_score.playerStats.layup_missed@></div>
						<div class="key">上篮</div>
					</li>
					<li>
						<div class="value"><@=player_score.playerStats.tipin_made@>/<@=player_score.playerStats.tipin_made+player_score.playerStats.tipin_missed@></div>
						<div class="key">补篮</div>
					</li>
					<li>
						<div class="value"><@=player_score.playerStats.hook_made@>/<@=player_score.playerStats.hook_made+player_score.playerStats.hook_missed@></div>
						<div class="key">勾手</div>
					</li>
					<li>
						<div class="value"><@=player_score.playerStats.other_made@>/<@=player_score.playerStats.other_made+player_score.playerStats.other_missed@></div>
						<div class="key">其他</div>
					</li>
				</ul>
			</section>
		</script>
	</section>
{%/block%}
