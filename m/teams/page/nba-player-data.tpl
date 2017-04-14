{%extends file="common/page/layout.tpl"%}

{%block name="block_head_static"%}
    {%require name="teams:static/nba-player-data/nba-player-data.scss"%}
    {%require name="teams:static/nba-player-data/echarts.js"%}
    {%require name="teams:static/nba-player-data/nba-player-data.js"%}

    {%script%}
        var toShare = require("common:widget/ui/share/share.js");
		var url = window.location.href.replace("/2", "");

        //全局分享事件, 每个页面单独注册.
        $(document).on("page:share", function(){
        	toShare();
        });
    {%/script%}
   	<script type='text/javascript'>
   		//使用{%script%}fis会自动封装在ready事件中，可能使用GM的时候还未赋值，故分离出来
		window.GM = {
			"data_regular": {%json_encode($playerStats.REGULAR)%},
			"data_playoff": {%json_encode($playerStats.PLAYOFF)%}
		}
    </script>
{%/block%}
{%block name="content"%}
    {%widget
        name="common:widget/new-top-nav/new-top-nav.tpl"
        hasBreadNav=false
    %}
    
    {%widget
        name="common:widget/inner-top-nav/nav.tpl"
    %}

	<section class="m-wrap nbaPlayerData-wrap">
		{%widget
            name="teams:widget/player-header/player-header.tpl"
            type="nba"
        %}
		<nav>
			<a href="{%$basicurl%}" class="info">基本信息</a><a href="javascript:void(0);" class="active">生涯数据</a>
		</nav>
		<section class="mod-data regular-data">
			<h2 class="mod-title-h2"><span class="icon"></span>常规赛</h2>
			<div class="bd">
				<div class="subnav" id="J-regular-subNav">
					<a href="javascript:void(0);"><span>得分</span></a>
					<a href="javascript:void(0);" class="active"><span>常规数据</span></a>
					<a href="javascript:void(0);"><span>命中率</span></a>
				</div>
				<div class="chart">
					<div class="tips" id="J-regular-tips">
						<div class="tip1" style="display: none;">
							<span><i class="blue"></i>上场时间</span>
							<span><i class="red"></i>得分</span>
						</div>
						<div class="tip1">
							<span><i class="blue"></i>篮板</span>
							<span><i class="red"></i>助攻</span>
							<span><i class="orange"></i>抢断</span>
							<span><i class="green"></i>盖帽</span>
						</div>
						<div class="tip3" style="display: none;">
							<span><i class="blue"></i>投篮命中率</span>
							<span><i class="red"></i>三分命中率</span>
							<span><i class="orange"></i>罚球命中率</span>
						</div>
					</div>
					<div class="main-wrap">
						<div class="regular-chart" style="overflow:visible;-webkit-transform: translateZ(0);"></div>
					</div>
					<input type="hidden" id="J-regular-input" value="">
				</div>
				<div class="detail-wrap" id="J-regular-wrap">
					<dl class="detail">
						{%$REGULAR_length = {%$playerStats.REGULAR|count%} - 1%}
						<dt>
							<span class="title-col col1">
								<span class="key">赛季</span>
								{%if !empty($playerStats.REGULAR[$REGULAR_length].season)%}
								<span class="value">{%$playerStats.REGULAR[$REGULAR_length].season%}</span>
								{%else%}
								<span class="none">--</span>
								{%/if%}
								</span>
							<span class="title-col col2">
								<span class="line">|</span><span class="key">球队</span>
								{%if !empty($playerStats.REGULAR[$REGULAR_length].team_name)%}
								<span class="value">{%$playerStats.REGULAR[$REGULAR_length].team_name%}</span>
							    {%else%}
							    <span class="none">--</span>
							    {%/if%}
							</span>
						</dt>
						<dd>
							<span class="col">
								<span class="key">出场</span>
								{%if !empty($playerStats.REGULAR[$REGULAR_length].games)%}
								<span class="value">{%$playerStats.REGULAR[$REGULAR_length].games%}</span>
							    {%else%}
							    <span class="none">--</span>
							    {%/if%}
							</span>
							<span class="col">
								<span class="key">首发</span>
								{%if !empty($playerStats.REGULAR[$REGULAR_length].games_started)%}
								<span class="value">{%$playerStats.REGULAR[$REGULAR_length].games_started%}</span>
							    {%else%}
							    <span class="none">--</span>
							    {%/if%}
							</span>
							<span class="col">
								<span class="key">上场时间</span>
								{%if !empty($playerStats.REGULAR[$REGULAR_length].mins)%}
								<span class="value">{%$playerStats.REGULAR[$REGULAR_length].mins%}'</span>
							    {%else%}
							    <span class="none">--</span>
							    {%/if%}
							</span>
						</dd>
						<dd>
							<span class="col">
								<span class="key">得分</span>
								{%if !empty($playerStats.REGULAR[$REGULAR_length].pts)%}
								<span class="value">{%$playerStats.REGULAR[$REGULAR_length].pts%}</span>
							    {%else%}
							    <span class="none">--</span>
							    {%/if%}
							</span>
							<span class="col">
								<span class="key">篮板</span>
								{%if !empty($playerStats.REGULAR[$REGULAR_length].reb)%}
								<span class="value">{%$playerStats.REGULAR[$REGULAR_length].reb%}</span>
							    {%else%}
							    <span class="none">--</span>
							    {%/if%}
							</span>
							<span class="col">
								<span class="key">助攻</span>
								{%if !empty($playerStats.REGULAR[$REGULAR_length].asts)%}
								<span class="value">{%$playerStats.REGULAR[$REGULAR_length].asts%}</span>
							    {%else%}
							    <span class="none">--</span>
							    {%/if%}
							</span>
						</dd>
						<dd>
							<span class="col">
								<span class="key">抢断</span>
								{%if !empty($playerStats.REGULAR[$REGULAR_length].stl)%}
								<span class="value">{%$playerStats.REGULAR[$REGULAR_length].stl%}</span>
							    {%else%}
							    <span class="none">--</span>
							    {%/if%}
							</span>
							<span class="col">
								<span class="key">盖帽</span>
								{%if !empty($playerStats.REGULAR[$REGULAR_length].blk)%}
								<span class="value">{%$playerStats.REGULAR[$REGULAR_length].blk%}</span>
							    {%else%}
							    <span class="none">--</span>
							    {%/if%}
							</span>
							<span class="col">
								<span class="key">失误</span>
								{%if !empty($playerStats.REGULAR[$REGULAR_length].to)%}
								<span class="value">{%$playerStats.REGULAR[$REGULAR_length].to%}</span>
							    {%else%}
							    <span class="none">--</span>
							    {%/if%}
							</span>
						</dd>
						<dd>
							<span class="col">
								<span class="key">投篮</span>
								{%if !empty($playerStats.REGULAR[$REGULAR_length].fga)%}
								<span class="value">{%$playerStats.REGULAR[$REGULAR_length].fga%}</span>
							    {%else%}
							    <span class="none">--</span>
							    {%/if%}
							</span>
							<span class="col">
								<span class="key">投篮命中率</span>
								{%if !empty($playerStats.REGULAR[$REGULAR_length].fgp)%}
								<span class="value">{%$playerStats.REGULAR[$REGULAR_length].fgp%}%</span>
							    {%else%}
							    <span class="none">--</span>
							    {%/if%}
							</span>
							<span class="col">
								<span class="key">犯规</span>
								{%if !empty($playerStats.REGULAR[$REGULAR_length].foul)%}
								<span class="value">{%$playerStats.REGULAR[$REGULAR_length].foul%}</span>
							    {%else%}
							    <span class="none">--</span>
							    {%/if%}
							</span>
						</dd>
						<dd class="widthdd">
							<span class="col">
								<span class="key">三分球</span>
								{%if !empty($playerStats.REGULAR[$REGULAR_length].tpa)%}
								<span class="value">{%$playerStats.REGULAR[$REGULAR_length].tpa%}</span>
							    {%else%}
							    <span class="none">--</span>
							    {%/if%}
							</span>
							<span class="col">
								<span class="key">三分命中率</span>
								{%if !empty($playerStats.REGULAR[$REGULAR_length].tpp)%}
								<span class="value">{%$playerStats.REGULAR[$REGULAR_length].tpp%}%</span>
							    {%else%}
							    <span class="none">--</span>
							    {%/if%}
							</span>
							<span class="col">
								<span class="key">&nbsp;</span>
								<span class="value">&nbsp;</span>
							</span>
						</dd>
						<dd class="widthdd">
							<span class="col">
								<span class="key">罚球</span>
								{%if !empty($playerStats.REGULAR[$REGULAR_length].fta)%}
								<span class="value">{%$playerStats.REGULAR[$REGULAR_length].fta%}</span>
							    {%else%}
							    <span class="none">--</span>
							    {%/if%}
							</span>
							<span class="col">
								<span class="key">罚球命中率</span>
								{%if !empty($playerStats.REGULAR[$REGULAR_length].ftp)%}
								<span class="value">{%$playerStats.REGULAR[$REGULAR_length].ftp%}%</span>
							    {%else%}
							    <span class="none">--</span>
							    {%/if%}
							</span>
							<span class="col">
								<span class="key">&nbsp;</span>
								<span class="value">&nbsp;</span>
							</span>
						</dd>
					</dl>
					<script type="text/template" id="J-regular-data-tpl">
						<dl class="detail">
							<dt>
								<span class="title-col col1">
									<span class="key">赛季</span>
									<@if(GM.data_regular[regularIndex].season!=""){@>
									<span class="value"><@=GM.data_regular[regularIndex].season@></span>
									<@}else{@>
									<span class="none">--</span>
									<@}@>
								</span>
								<span class="title-col col2">
									<span class="line">|</span><span class="key">球队</span>
									<@if(GM.data_regular[regularIndex].team_name!=""){@>
									<span class="value"><@=GM.data_regular[regularIndex].team_name@></span>
									<@}else{@>
									<span class="none">--</span>
									<@}@>
								</span>
							</dt>
							<dd>
								<span class="col">
									<span class="key">出场</span>
									<@if(GM.data_regular[regularIndex].games!=""){@>
									<span class="value"><@=GM.data_regular[regularIndex].games@></span>
									<@}else{@>
									<span class="none">--</span>
									<@}@>
								</span>
								<span class="col">
									<span class="key">首发</span>
									<@if(GM.data_regular[regularIndex].games_started!=""){@>
									<span class="value"><@=GM.data_regular[regularIndex].games_started@></span>
									<@}else{@>
									<span class="none">--</span>
									<@}@>
								</span>
								<span class="col">
									<span class="key">上场时间</span>
									<@if(GM.data_regular[regularIndex].mins!=""){@>
									<span class="value"><@=GM.data_regular[regularIndex].mins@>'</span>
									<@}else{@>
									<span class="none">--</span>
									<@}@>
								</span>
							</dd>
							<dd>
								<span class="col">
									<span class="key">得分</span>
									<@if(GM.data_regular[regularIndex].pts!=""){@>
									<span class="value"><@=GM.data_regular[regularIndex].pts@></span>
									<@}else{@>
									<span class="none">--</span>
									<@}@>
								</span>
								<span class="col">
									<span class="key">篮板</span>
									<@if(GM.data_regular[regularIndex].reb!=""){@>
									<span class="value"><@=GM.data_regular[regularIndex].reb@></span>
									<@}else{@>
									<span class="none">--</span>
									<@}@>
								</span>
								<span class="col">
									<span class="key">助攻</span>
									<@if(GM.data_regular[regularIndex].asts!=""){@>
									<span class="value"><@=GM.data_regular[regularIndex].asts@></span>
									<@}else{@>
									<span class="none">--</span>
									<@}@>
								</span>
							</dd>
							<dd>
								<span class="col">
									<span class="key">抢断</span>
									<@if(GM.data_regular[regularIndex].stl!=""){@>
									<span class="value"><@=GM.data_regular[regularIndex].stl@></span>
									<@}else{@>
									<span class="none">--</span>
									<@}@>
								</span>
								<span class="col">
									<span class="key">盖帽</span>
									<@if(GM.data_regular[regularIndex].blk!=""){@>
									<span class="value"><@=GM.data_regular[regularIndex].blk@></span>
									<@}else{@>
									<span class="none">--</span>
									<@}@>
								</span>
								<span class="col">
									<span class="key">失误</span>
									<@if(GM.data_regular[regularIndex].to!=""){@>
									<span class="value"><@=GM.data_regular[regularIndex].to@></span>
									<@}else{@>
									<span class="none">--</span>
									<@}@>
								</span>
							</dd>
							<dd>
								<span class="col">
									<span class="key">投篮</span>
									<@if(GM.data_regular[regularIndex].fga!=""){@>
									<span class="value"><@=GM.data_regular[regularIndex].fga@></span>
									<@}else{@>
									<span class="none">--</span>
									<@}@>
								</span>
								<span class="col">
									<span class="key">投篮命中率</span>
									<@if(GM.data_regular[regularIndex].fgp!=""){@>
									<span class="value"><@=GM.data_regular[regularIndex].fgp@>%</span>
									<@}else{@>
									<span class="none">--</span>
									<@}@>
								</span>
								<span class="col">
									<span class="key">犯规</span>
									<@if(GM.data_regular[regularIndex].foul!=""){@>
									<span class="value"><@=GM.data_regular[regularIndex].foul@></span>
									<@}else{@>
									<span class="none">--</span>
									<@}@>
								</span>
							</dd>
							<dd class="widthdd">
								<span class="col">
									<span class="key">三分球</span>
									<@if(GM.data_regular[regularIndex].tpa!=""){@>
									<span class="value"><@=GM.data_regular[regularIndex].tpa@></span>
									<@}else{@>
									<span class="none">--</span>
									<@}@>
								</span>
								<span class="col">
									<span class="key">三分命中率</span>
									<@if(GM.data_regular[regularIndex].tpp!=""){@>
									<span class="value"><@=GM.data_regular[regularIndex].tpp@>%</span>
									<@}else{@>
									<span class="none">--</span>
									<@}@>
								</span>
								<span class="col">
									<span class="key">&nbsp;</span>
									<span class="value">&nbsp;</span>
								</span>
							</dd>
							<dd class="widthdd">
								<span class="col">
									<span class="key">罚球</span>
									<@if(GM.data_regular[regularIndex].fta!=""){@>
									<span class="value"><@=GM.data_regular[regularIndex].fta@></span>
									<@}else{@>
									<span class="none">--</span>
									<@}@>
								</span>
								<span class="col">
									<span class="key">罚球命中率</span>
									<@if(GM.data_regular[regularIndex].ftp!=""){@>
									<span class="value"><@=GM.data_regular[regularIndex].ftp@>%</span>
									<@}else{@>
									<span class="none">--</span>
									<@}@>
								</span>
								<span class="col">
									<span class="key">&nbsp;</span>
									<span class="value">&nbsp;</span>
								</span>
							</dd>
						</dl>
					</script>
				</div>
			</div>
			<a href="{%$careerdataurl%}" target="_blank" class="all-link">数据表展示></a>
		</section>
		{%if $playerStats.PLAYOFF|count != 0%}
		<section class="mod-data playoff-data">
			<h2 class="mod-title-h2"><span class="icon"></span>季后赛</h2>
			<div class="bd">
				<div class="subnav" id="J-playoff-subNav">
					<a href="javascript:void(0);"><span>得分</span></a>
					<a href="javascript:void(0);" class="active"><span>常规数据</span></a>
					<a href="javascript:void(0);"><span>命中率</span></a>
				</div>
				<div class="chart">
					<div class="tips" id="J-playoff-tips">
						<div class="tip1" style="display: none;">
							<span><i class="blue"></i>上场时间</span>
							<span><i class="red"></i>得分</span>
						</div>
						<div class="tip1">
							<span><i class="blue"></i>篮板</span>
							<span><i class="red"></i>助攻</span>
							<span><i class="orange"></i>抢断</span>
							<span><i class="green"></i>盖帽</span>
						</div>
						<div class="tip3" style="display: none;">
							<span><i class="blue"></i>投篮命中率</span>
							<span><i class="red"></i>三分命中率</span>
							<span><i class="orange"></i>罚球命中率</span>
						</div>
					</div>
					<div class="main-wrap">
						<div class="playoff-chart" style="overflow:visible;-webkit-transform: translateZ(0);"></div>
					</div>
					<input type="hidden" id="J-playoff-input" value="">
				</div>
				<div class="detail-wrap" id="J-playoff-wrap">
					<dl class="detail">
						{%$PLAYOFF_length = {%$playerStats.PLAYOFF|count%} - 1%}
						<dt>
							<span class="title-col col1">
								<span class="key">赛季</span>
								{%if !empty($playerStats.PLAYOFF[$PLAYOFF_length].season)%}
								<span class="value">{%$playerStats.PLAYOFF[$PLAYOFF_length].season%}</span>
								{%else%}
								<span class="none">--</span>
								{%/if%}
								</span>
							<span class="title-col col2">
								<span class="line">|</span><span class="key">球队</span>
								{%if !empty($playerStats.PLAYOFF[$PLAYOFF_length].team_name)%}
								<span class="value">{%$playerStats.PLAYOFF[$PLAYOFF_length].team_name%}</span>
							    {%else%}
							    <span class="none">--</span>
							    {%/if%}
							</span>
						</dt>
						<dd>
							<span class="col">
								<span class="key">出场</span>
								{%if !empty($playerStats.PLAYOFF[$PLAYOFF_length].games)%}
								<span class="value">{%$playerStats.PLAYOFF[$PLAYOFF_length].games%}</span>
							    {%else%}
							    <span class="none">--</span>
							    {%/if%}
							</span>
							<span class="col">
								<span class="key">首发</span>
								{%if !empty($playerStats.PLAYOFF[$PLAYOFF_length].games_started)%}
								<span class="value">{%$playerStats.PLAYOFF[$PLAYOFF_length].games_started%}</span>
							    {%else%}
							    <span class="none">--</span>
							    {%/if%}
							</span>
							<span class="col">
								<span class="key">上场时间</span>
								{%if !empty($playerStats.PLAYOFF[$PLAYOFF_length].mins)%}
								<span class="value">{%$playerStats.PLAYOFF[$PLAYOFF_length].mins%}'</span>
							    {%else%}
							    <span class="none">--</span>
							    {%/if%}
							</span>
						</dd>
						<dd>
							<span class="col">
								<span class="key">得分</span>
								{%if !empty($playerStats.PLAYOFF[$PLAYOFF_length].pts)%}
								<span class="value">{%$playerStats.PLAYOFF[$PLAYOFF_length].pts%}</span>
							    {%else%}
							    <span class="none">--</span>
							    {%/if%}
							</span>
							<span class="col">
								<span class="key">篮板</span>
								{%if !empty($playerStats.PLAYOFF[$PLAYOFF_length].reb)%}
								<span class="value">{%$playerStats.PLAYOFF[$PLAYOFF_length].reb%}</span>
							    {%else%}
							    <span class="none">--</span>
							    {%/if%}
							</span>
							<span class="col">
								<span class="key">助攻</span>
								{%if !empty($playerStats.PLAYOFF[$PLAYOFF_length].asts)%}
								<span class="value">{%$playerStats.PLAYOFF[$PLAYOFF_length].asts%}</span>
							    {%else%}
							    <span class="none">--</span>
							    {%/if%}
							</span>
						</dd>
						<dd>
							<span class="col">
								<span class="key">抢断</span>
								{%if !empty($playerStats.PLAYOFF[$PLAYOFF_length].stl)%}
								<span class="value">{%$playerStats.PLAYOFF[$PLAYOFF_length].stl%}</span>
							    {%else%}
							    <span class="none">--</span>
							    {%/if%}
							</span>
							<span class="col">
								<span class="key">盖帽</span>
								{%if !empty($playerStats.PLAYOFF[$PLAYOFF_length].blk)%}
								<span class="value">{%$playerStats.PLAYOFF[$PLAYOFF_length].blk%}</span>
							    {%else%}
							    <span class="none">--</span>
							    {%/if%}
							</span>
							<span class="col">
								<span class="key">失误</span>
								{%if !empty($playerStats.PLAYOFF[$PLAYOFF_length].to)%}
								<span class="value">{%$playerStats.PLAYOFF[$PLAYOFF_length].to%}</span>
							    {%else%}
							    <span class="none">--</span>
							    {%/if%}
							</span>
						</dd>
						<dd>
							<span class="col">
								<span class="key">投篮</span>
								{%if !empty($playerStats.PLAYOFF[$PLAYOFF_length].fga)%}
								<span class="value">{%$playerStats.PLAYOFF[$PLAYOFF_length].fga%}</span>
							    {%else%}
							    <span class="none">--</span>
							    {%/if%}
							</span>
							<span class="col">
								<span class="key">投篮命中率</span>
								{%if !empty($playerStats.PLAYOFF[$PLAYOFF_length].fgp)%}
								<span class="value">{%$playerStats.PLAYOFF[$PLAYOFF_length].fgp%}%</span>
							    {%else%}
							    <span class="none">--</span>
							    {%/if%}
							</span>
							<span class="col">
								<span class="key">犯规</span>
								{%if !empty($playerStats.PLAYOFF[$PLAYOFF_length].foul)%}
								<span class="value">{%$playerStats.PLAYOFF[$PLAYOFF_length].foul%}</span>
							    {%else%}
							    <span class="none">--</span>
							    {%/if%}
							</span>
						</dd>
						<dd class="widthdd">
							<span class="col">
								<span class="key">三分球</span>
								{%if !empty($playerStats.PLAYOFF[$PLAYOFF_length].tpa)%}
								<span class="value">{%$playerStats.PLAYOFF[$PLAYOFF_length].tpa%}</span>
							    {%else%}
							    <span class="none">--</span>
							    {%/if%}
							</span>
							<span class="col">
								<span class="key">三分命中率</span>
								{%if !empty($playerStats.PLAYOFF[$PLAYOFF_length].tpp)%}
								<span class="value">{%$playerStats.PLAYOFF[$PLAYOFF_length].tpp%}%</span>
							    {%else%}
							    <span class="none">--</span>
							    {%/if%}
							</span>
							<span class="col">
								<span class="key">&nbsp;</span>
								<span class="value">&nbsp;</span>
							</span>
						</dd>
						<dd class="widthdd">
							<span class="col">
								<span class="key">罚球</span>
								{%if !empty($playerStats.PLAYOFF[$PLAYOFF_length].fta)%}
								<span class="value">{%$playerStats.PLAYOFF[$PLAYOFF_length].fta%}</span>
							    {%else%}
							    <span class="none">--</span>
							    {%/if%}
							</span>
							<span class="col">
								<span class="key">罚球命中率</span>
								{%if !empty($playerStats.PLAYOFF[$PLAYOFF_length].ftp)%}
								<span class="value">{%$playerStats.PLAYOFF[$PLAYOFF_length].ftp%}%</span>
							    {%else%}
							    <span class="none">--</span>
							    {%/if%}
							</span>
							<span class="col">
								<span class="key">&nbsp;</span>
								<span class="value">&nbsp;</span>
							</span>
						</dd>
					</dl>
					<script type="text/template" id="J-playoff-data-tpl">
						<dl class="detail">
							<dt>
								<span class="title-col col1">
									<span class="key">赛季</span>
									<@if(GM.data_playoff[playoffIndex].season!=""){@>
									<span class="value"><@=GM.data_playoff[playoffIndex].season@></span>
									<@}else{@>
									<span class="none">--</span>
									<@}@>
								</span>
								<span class="title-col col2">
									<span class="line">|</span><span class="key">球队</span>
									<@if(GM.data_playoff[playoffIndex].team_name!=""){@>
									<span class="value"><@=GM.data_playoff[playoffIndex].team_name@></span>
									<@}else{@>
									<span class="none">--</span>
									<@}@>
								</span>
							</dt>
							<dd>
								<span class="col">
									<span class="key">出场</span>
									<@if(GM.data_playoff[playoffIndex].games!=""){@>
									<span class="value"><@=GM.data_playoff[playoffIndex].games@></span>
									<@}else{@>
									<span class="none">--</span>
									<@}@>
								</span>
								<span class="col">
									<span class="key">首发</span>
									<@if(GM.data_playoff[playoffIndex].games_started!=""){@>
									<span class="value"><@=GM.data_playoff[playoffIndex].games_started@></span>
									<@}else{@>
									<span class="none">--</span>
									<@}@>
								</span>
								<span class="col">
									<span class="key">上场时间</span>
									<@if(GM.data_playoff[playoffIndex].mins!=""){@>
									<span class="value"><@=GM.data_playoff[playoffIndex].mins@>'</span>
									<@}else{@>
									<span class="none">--</span>
									<@}@>
								</span>
							</dd>
							<dd>
								<span class="col">
									<span class="key">得分</span>
									<@if(GM.data_playoff[playoffIndex].pts!=""){@>
									<span class="value"><@=GM.data_playoff[playoffIndex].pts@></span>
									<@}else{@>
									<span class="none">--</span>
									<@}@>
								</span>
								<span class="col">
									<span class="key">篮板</span>
									<@if(GM.data_playoff[playoffIndex].reb!=""){@>
									<span class="value"><@=GM.data_playoff[playoffIndex].reb@></span>
									<@}else{@>
									<span class="none">--</span>
									<@}@>
								</span>
								<span class="col">
									<span class="key">助攻</span>
									<@if(GM.data_playoff[playoffIndex].asts!=""){@>
									<span class="value"><@=GM.data_playoff[playoffIndex].asts@></span>
									<@}else{@>
									<span class="none">--</span>
									<@}@>
								</span>
							</dd>
							<dd>
								<span class="col">
									<span class="key">抢断</span>
									<@if(GM.data_playoff[playoffIndex].stl!=""){@>
									<span class="value"><@=GM.data_playoff[playoffIndex].stl@></span>
									<@}else{@>
									<span class="none">--</span>
									<@}@>
								</span>
								<span class="col">
									<span class="key">盖帽</span>
									<@if(GM.data_playoff[playoffIndex].blk!=""){@>
									<span class="value"><@=GM.data_playoff[playoffIndex].blk@></span>
									<@}else{@>
									<span class="none">--</span>
									<@}@>
								</span>
								<span class="col">
									<span class="key">失误</span>
									<@if(GM.data_playoff[playoffIndex].to!=""){@>
									<span class="value"><@=GM.data_playoff[playoffIndex].to@></span>
									<@}else{@>
									<span class="none">--</span>
									<@}@>
								</span>
							</dd>
							<dd>
								<span class="col">
									<span class="key">投篮</span>
									<@if(GM.data_playoff[playoffIndex].fga!=""){@>
									<span class="value"><@=GM.data_playoff[playoffIndex].fga@></span>
									<@}else{@>
									<span class="none">--</span>
									<@}@>
								</span>
								<span class="col">
									<span class="key">投篮命中率</span>
									<@if(GM.data_playoff[playoffIndex].fgp!=""){@>
									<span class="value"><@=GM.data_playoff[playoffIndex].fgp@>%</span>
									<@}else{@>
									<span class="none">--</span>
									<@}@>
								</span>
								<span class="col">
									<span class="key">犯规</span>
									<@if(GM.data_playoff[playoffIndex].foul!=""){@>
									<span class="value"><@=GM.data_playoff[playoffIndex].foul@></span>
									<@}else{@>
									<span class="none">--</span>
									<@}@>
								</span>
							</dd>
							<dd class="widthdd">
								<span class="col">
									<span class="key">三分球</span>
									<@if(GM.data_playoff[playoffIndex].tpa!=""){@>
									<span class="value"><@=GM.data_playoff[playoffIndex].tpa@></span>
									<@}else{@>
									<span class="none">--</span>
									<@}@>
								</span>
								<span class="col">
									<span class="key">三分命中率</span>
									<@if(GM.data_playoff[playoffIndex].tpp!=""){@>
									<span class="value"><@=GM.data_playoff[playoffIndex].tpp@>%</span>
									<@}else{@>
									<span class="none">--</span>
									<@}@>
								</span>
								<span class="col">
									<span class="key">&nbsp;</span>
									<span class="value">&nbsp;</span>
								</span>
							</dd>
							<dd class="widthdd">
								<span class="col">
									<span class="key">罚球</span>
									<@if(GM.data_playoff[playoffIndex].fta!=""){@>
									<span class="value"><@=GM.data_playoff[playoffIndex].fta@></span>
									<@}else{@>
									<span class="none">--</span>
									<@}@>
								</span>
								<span class="col">
									<span class="key">罚球命中率</span>
									<@if(GM.data_playoff[playoffIndex].ftp!=""){@>
									<span class="value"><@=GM.data_playoff[playoffIndex].ftp@>%</span>
									<@}else{@>
									<span class="none">--</span>
									<@}@>
								</span>
								<span class="col">
									<span class="key">&nbsp;</span>
									<span class="value">&nbsp;</span>
								</span>
							</dd>
						</dl>
					</script>
				</div>
			</div>
			<a href="{%$careerdataurl%}" target="_blank" class="all-link">数据表展示></a>
		</section>
		{%/if%}
		<section class="compare-data">
			<h2 class="mod-title-h2"><span class="icon"></span>生涯场均数据对比（常规赛 VS 季后赛）</h2>
			<dl {%if empty($playerStats.PLAYOFF_AVG.games)%}class="none"{%/if%}>
				<dt>
					<span class="col regular-col">常规赛</span>
					<span class="col"></span>
					<span class="col"></span>
					<span class="col"></span>
					<span class="col playoff-col">季后赛</span>
				</dt>
				<dd>
					<span class="col regular-col">{%$playerStats.REGULAR_AVG.games_started%}/{%$playerStats.REGULAR_AVG.count%}</span>
					<span class="progress col left-progress">
						<span class="inner red" style="width: {%($playerStats.REGULAR_AVG.games_started/$playerStats.REGULAR_AVG.count)*100%}%;"></span>
					</span>
					<span class="key col">首发/出场</span>
					<span class="progress col right-progress">
						<span class="inner red" style="width: {%($playerStats.PLAYOFF_AVG.games_started/$playerStats.PLAYOFF_AVG.count)*100%}%; {%if empty($playerStats.PLAYOFF_AVG.count)%}color: #cacaca;{%/if%}"></span>
					</span>
					<span class="col playoff-col">{%$playerStats.PLAYOFF_AVG.games_started|default:"--"%}/{%$playerStats.PLAYOFF_AVG.count|default:"--"%}</span>
				</dd>
				<dd>
					<span class="col regular-col">{%$playerStats.REGULAR_AVG.pts%}</span>
					<span class="progress col left-progress">
						<span class="inner" style="width: {%$playerStats.REGULAR_AVG.pts/$playerbestdata.REGULAR_AVG.pts.val*100%}%;"></span>
					</span>
					<span class="key col">得分</span>
					<span class="progress col right-progress">
						<span class="inner" style="width: {%$playerStats.PLAYOFF_AVG.pts/$playerbestdata.PLAYOFF_AVG.pts.val*100%}%;"></span>
					</span>
					<span class="col playoff-col">{%$playerStats.PLAYOFF_AVG.pts|default:"--"%}</span>
				</dd>
				<dd>
					<span class="col regular-col">{%$playerStats.REGULAR_AVG.reb%}</span>
					<span class="progress col left-progress">
						<span class="inner" style="width: {%$playerStats.REGULAR_AVG.reb/$playerbestdata.REGULAR_AVG.reb.val*100%}%;"></span>
					</span>
					<span class="key col">篮板</span>
					<span class="progress col right-progress">
						<span class="inner" style="width: {%$playerStats.PLAYOFF_AVG.reb/$playerbestdata.PLAYOFF_AVG.reb.val*100%}%;"></span>
					</span>
					<span class="col playoff-col">{%$playerStats.PLAYOFF_AVG.reb|default:"--"%}</span>
				</dd>
				<dd>
					<span class="col regular-col">{%$playerStats.REGULAR_AVG.asts%}</span>
					<span class="progress col left-progress">
						<span class="inner" style="width: {%$playerStats.REGULAR_AVG.asts/$playerbestdata.REGULAR_AVG.asts.val*100%}%;"></span>
					</span>
					<span class="key col">助攻</span>
					<span class="progress col right-progress">
						<span class="inner" style="width: {%$playerStats.PLAYOFF_AVG.asts/$playerbestdata.PLAYOFF_AVG.asts.val*100%}%;"></span>
					</span>
					<span class="col playoff-col">{%$playerStats.PLAYOFF_AVG.asts|default:"--"%}</span>
				</dd>
				<dd>
					<span class="col regular-col">{%$playerStats.REGULAR_AVG.stl%}</span>
					<span class="progress col left-progress">
						<span class="inner" style="width: {%$playerStats.REGULAR_AVG.stl/$playerbestdata.REGULAR_AVG.stl.val*100%}%;"></span>
					</span>
					<span class="key col">抢断</span>
					<span class="progress col right-progress">
						<span class="inner" style="width: {%$playerStats.PLAYOFF_AVG.stl/$playerbestdata.PLAYOFF_AVG.stl.val*100%}%;"></span>
					</span>
					<span class="col playoff-col">{%$playerStats.PLAYOFF_AVG.stl|default:"--"%}</span>
				</dd>
				<dd>
					<span class="col regular-col">{%$playerStats.REGULAR_AVG.blk%}</span>
					<span class="progress col left-progress">
						<span class="inner" style="width: {%$playerStats.REGULAR_AVG.blk/$playerbestdata.REGULAR_AVG.blk.val*100%}%;"></span>
					</span>
					<span class="key col">盖帽</span>
					<span class="progress col right-progress">
						<span class="inner" style="width: {%$playerStats.PLAYOFF_AVG.blk/$playerbestdata.PLAYOFF_AVG.blk.val*100%}%;"></span>
					</span>
					<span class="col playoff-col">{%$playerStats.PLAYOFF_AVG.blk|default:"--"%}</span>
				</dd>
				<dd>
					<span class="col regular-col">{%$playerStats.REGULAR_AVG.to%}</span>
					<span class="progress col left-progress">
						<span class="inner" style="width: {%$playerStats.REGULAR_AVG.to/$playerbestdata.REGULAR_AVG.to.val*100%}%;"></span>
					</span>
					<span class="key col">失误</span>
					<span class="progress col right-progress">
						<span class="inner" style="width: {%$playerStats.PLAYOFF_AVG.to/$playerbestdata.PLAYOFF_AVG.to.val*100%}%;"></span>
					</span>
					<span class="col playoff-col">{%$playerStats.PLAYOFF_AVG.to|default:"--"%}</span>
				</dd>
				<dd>
					<span class="col regular-col">{%$playerStats.REGULAR_AVG.fga%}</span>
					<span class="progress col left-progress">
						<span class="inner" style="width: {%$playerStats.REGULAR_AVG.fga/$playerbestdata.REGULAR_AVG.fga.val*100%}%;"></span>
					</span>
					<span class="key col">投篮</span>
					<span class="progress col right-progress">
						<span class="inner" style="width: {%$playerStats.PLAYOFF_AVG.fga/$playerbestdata.PLAYOFF_AVG.fga.val*100%}%;"></span>
					</span>
					<span class="col playoff-col">{%$playerStats.PLAYOFF_AVG.fga|default:"--"%}</span>
				</dd>
				<dd>
					<span class="col regular-col">{%$playerStats.REGULAR_AVG.fgp%}</span>
					<span class="progress col left-progress">
						<span class="inner" style="width: {%$playerStats.REGULAR_AVG.fgp/$playerbestdata.REGULAR_AVG.fgp.val*100%}%;"></span>
					</span>
					<span class="key col">投篮命中率</span>
					<span class="progress col right-progress">
						<span class="inner" style="width: {%$playerStats.PLAYOFF_AVG.fgp/$playerbestdata.PLAYOFF_AVG.fgp.val*100%}%;"></span>
					</span>
					<span class="col playoff-col">{%$playerStats.PLAYOFF_AVG.fgp|default:"--"%}</span>
				</dd>
				<dd>
					<span class="col regular-col">{%$playerStats.REGULAR_AVG.tpa%}</span>
					<span class="progress col left-progress">
						<span class="inner" style="width: {%$playerStats.REGULAR_AVG.tpa/$playerbestdata.REGULAR_AVG.tpa.val*100%}%;"></span>
					</span>
					<span class="key col">三分</span>
					<span class="progress col right-progress">
						<span class="inner" style="width: {%$playerStats.PLAYOFF_AVG.tpa/$playerbestdata.PLAYOFF_AVG.tpa.val*100%}%;"></span>
					</span>
					<span class="col playoff-col">{%$playerStats.PLAYOFF_AVG.tpa|default:"--"%}</span>
				</dd>
				<dd>
					<span class="col regular-col">{%$playerStats.REGULAR_AVG.tpp%}</span>
					<span class="progress col left-progress">
						<span class="inner" style="width: {%$playerStats.REGULAR_AVG.tpp/$playerbestdata.REGULAR_AVG.tpp.val*100%}%;"></span>
					</span>
					<span class="key col">三分命中率</span>
					<span class="progress col right-progress">
						<span class="inner" style="width: {%$playerStats.PLAYOFF_AVG.tpp/$playerbestdata.PLAYOFF_AVG.tpp.val*100%}%;"></span>
					</span>
					<span class="col playoff-col">{%$playerStats.PLAYOFF_AVG.tpp|default:"--"%}</span>
				</dd>
				<dd>
					<span class="col regular-col">{%$playerStats.REGULAR_AVG.fta%}</span>
					<span class="progress col left-progress">
						<span class="inner" style="width: {%$playerStats.REGULAR_AVG.fta/$playerbestdata.REGULAR_AVG.fta.val*100%}%;"></span>
					</span>
					<span class="key col">罚球</span>
					<span class="progress col right-progress">
						<span class="inner" style="width: {%$playerStats.PLAYOFF_AVG.fta/$playerbestdata.PLAYOFF_AVG.fta.val*100%}%;"></span>
					</span>
					<span class="col playoff-col">{%$playerStats.PLAYOFF_AVG.fta|default:"--"%}</span>
				</dd>
				<dd>
					<span class="col regular-col">{%$playerStats.REGULAR_AVG.ftp%}</span>
					<span class="progress col left-progress">
						<span class="inner" style="width: {%$playerStats.REGULAR_AVG.ftp/$playerbestdata.REGULAR_AVG.ftp.val*100%}%;"></span>
					</span>
					<span class="key col">罚球命中率</span>
					<span class="progress col right-progress">
						<span class="inner" style="width: {%$playerStats.PLAYOFF_AVG.ftp/$playerbestdata.PLAYOFF_AVG.ftp.val*100%}%;"></span>
					</span>
					<span class="col playoff-col">{%$playerStats.PLAYOFF_AVG.ftp|default:"--"%}</span>
				</dd>
				<dd>
					<span class="col regular-col">{%$playerStats.REGULAR_AVG.foul%}</span>
					<span class="progress col left-progress">
						<span class="inner" style="width: {%$playerStats.REGULAR_AVG.foul/$playerbestdata.REGULAR_AVG.foul.val*100%}%;"></span>
					</span>
					<span class="key col">犯规</span>
					<span class="progress col right-progress">
						<span class="inner" style="width: {%$playerStats.PLAYOFF_AVG.foul/$playerbestdata.PLAYOFF_AVG.foul.val*100%}%;"></span>
					</span>
					<span class="col playoff-col">{%$playerStats.PLAYOFF_AVG.foul|default:"--"%}</span>
				</dd>
			</dl>
		</section>
	</section>
{%/block%}
