{%extends file="common/page/layout.tpl"%}

{%block name="block_head_static"%}
    {%require name="teams:static/nba-player-info/nba-player-info.scss"%}
    {%require name="teams:static/nba-player-info/nba-player-info.js"%}

    {%script%}
        var toShare = require("common:widget/ui/share/share.js");

        //全局分享事件, 每个页面单独注册.
        $(document).on("page:share", function(){
        	toShare();
        });
    {%/script%}
{%/block%}
{%block name="content"%}
    {%widget
        name="common:widget/new-top-nav/new-top-nav.tpl"
        hasBreadNav=false
    %}
    
    {%widget
        name="common:widget/inner-top-nav/nav.tpl"
    %}

	<section class="m-wrap nbaPlayerInfo-wrap">
		{%widget
            name="teams:widget/player-header/player-header.tpl"
            type="nba"
        %}
		<nav>
			<a href="javascript:void(0);" class="info active">基本信息</a><a href="{%$careerurl%}">生涯数据</a>
		</nav>
		<section class="basic-info">
			<ul>
				<li>
					<div class="key">
					{%if !empty($playerBasic.birth_date_fix2)%}
					{%$playerBasic.birth_date_fix2%}
					{%else%}
					--
					{%/if%}
					</div>
					<div class="value">出生年月</div>
				</li>
				<li>
					<div class="key">
					{%if !empty($playerBasic.country)%}
						{%foreach $playerBasic.country as $val%}
							{%$val%}
							{%if $val@index != $playerBasic.country|count-1%}/{%/if%}
						{%/foreach%}
					{%else%}
					不详
					{%/if%}
					</div>
					<div class="value">国籍</div>
				</li>
				<li>
					<div class="key">
					{%if !empty($playerBasic.salary)%}
					${%$playerBasic.salary%}万
					{%else%}
					--
					{%/if%}
					</div>
					<div class="value">薪金</div>
				</li>
			</ul>
		</section>
		<section class="extra-info">
			<table>
				{%if !empty($playerBasic.draft_year) && !empty($playerBasic.draft_round) && !empty($playerBasic.draft_pick)%}
				<tr>
					<td class="key" width="40"><span>选秀</span></td>
					<td class="value">{%$playerBasic.draft_year%}年{%$playerBasic.draft_round%}轮第{%$playerBasic.draft_pick%}顺位</td>
				</tr>
				{%/if%}
				{%if !empty($playerBasic.college_school) || !empty($playerBasic.high_school)%}
				<tr>
					<td class="key" width="40"><span>来自</span></td>
					<td class="value">
					{%if !empty($playerBasic.college_school)%}
					{%$playerBasic.college_school%}
					{%else%}
					{%$playerBasic.high_school%}
					{%/if%}
					</td>
				</tr>
				{%/if%}
				{%if !empty($playerBasic.wage)%}
				<tr>
					<td class="key" width="40" valign="top"><span>合同</span></td>
					<td class="value">{%$playerBasic.wage%}</td>
				</tr>
				{%/if%}
			</table>
		</section>
		<section class="body-info">
			<div class="body-bg">
				<div class="item item1">
					<div class="key">
					{%if !empty($playerBasic.height_fix)%}
					{%$playerBasic.height_fix%}米
					{%else%}
					--
					{%/if%}
					</div>
					<div class="value">身高</div>
				</div>
				<div class="item item2">
					<div class="key">
					{%if !empty($playerBasic.wingspan)%}
					{%$playerBasic.wingspan%}米
					{%else%}
					--
					{%/if%}
					</div>
					<div class="value">臂展</div>
				</div>
				<div class="item item3">
					<div class="key">
					{%if !empty($playerBasic.standing_reach)%}
					{%$playerBasic.standing_reach%}米
					{%else%}
					--
					{%/if%}
					</div>
					<div class="value">站立摸高</div>
				</div>
				<div class="item item4">
					<div class="key">
					{%if !empty($playerBasic.age)%}
					{%$playerBasic.age%}岁
					{%else%}
					--
					{%/if%}
					</div>
					<div class="value">年龄</div>
				</div>
				<div class="item item5">
					<div class="key">
					{%if !empty($playerBasic.weight_fix)%}
					{%$playerBasic.weight_fix%}公斤
					{%else%}
					--
					{%/if%}
					</div>
					<div class="value">体重</div>
				</div>
			</div>
		</section>
		{%if !empty($playerPlayoff)%}
		<section class="mod-data playoff-data">
			<h2 class="mod-title-h2"><span class="icon"></span>{%$season%}季后赛</h2>
			<ul class="list clearfix">
				<li class="item1">
					<div class="inner">
						<div class="icon"></div>
						<div class="data-info">
							<div class="value">{%$playerPlayoff.pts%}</div>
							<div class="key">得分</div>
							{%if !empty($playerPlayoffRank.pts)%}
							<div class="rank">(联盟第{%$playerPlayoffRank.pts%})</div>
							{%/if%}
						</div>
					</div>
				</li>
				<li class="item2">
					<div class="inner">
						<div class="icon"></div>
						<div class="data-info">
							<div class="value">{%$playerPlayoff.reb%}</div>
							<div class="key">篮板</div>
							{%if !empty($playerPlayoffRank.reb)%}
							<div class="rank">(联盟第{%$playerPlayoffRank.reb%})</div>
							{%/if%}
						</div>
					</div>
				</li>
				<li class="item3">
					<div class="inner">
						<div class="icon"></div>
						<div class="data-info">
							<div class="value">{%$playerPlayoff.asts%}</div>
							<div class="key">助攻</div>
							{%if !empty($playerPlayoffRank.asts)%}
							<div class="rank">(联盟第{%$playerPlayoffRank.asts%})</div>
							{%/if%}
						</div>
					</div>
				</li>
				<li class="item4">
					<div class="inner">
						<div class="icon"></div>
						<div class="data-info">
							<div class="value">{%$playerPlayoff.stl%}</div>
							<div class="key">抢断</div>
							{%if !empty($playerPlayoffRank.stl)%}
							<div class="rank">(联盟第{%$playerPlayoffRank.stl%})</div>
							{%/if%}
						</div>
					</div>
				</li>
				<li class="item5">
					<div class="inner">
						<div class="icon"></div>
						<div class="data-info">
							<div class="value">{%$playerPlayoff.blk%}</div>
							<div class="key">盖帽</div>
							{%if !empty($playerPlayoffRank.blk)%}
							<div class="rank">(联盟第{%$playerPlayoffRank.blk%})</div>
							{%/if%}
						</div>
					</div>
				</li>
				<li class="item6">
					<div class="inner">
						<div class="icon"></div>
						<div class="data-info">
							<div class="value">{%$playerPlayoff.to%}</div>
							<div class="key">失误</div>
						</div>
					</div>
				</li>
				<li class="item7">
					<div class="inner">
						<div class="icon"></div>
						<div class="data-info">
							<div class="value">{%$playerPlayoff.fgp%}</div>
							<div class="key">投篮命中</div>
							{%if !empty($playerPlayoffRank.fgp)%}
							<div class="rank">(联盟第{%$playerPlayoffRank.fgp%})</div>
							{%/if%}
						</div>
					</div>
				</li>
				<li class="item8">
					<div class="inner">
						<div class="icon"></div>
						<div class="data-info">
							<div class="value">{%$playerPlayoff.tpp%}</div>
							<div class="key">三分命中</div>
							{%if !empty($playerPlayoffRank.tpp)%}
							<div class="rank">(联盟第{%$playerPlayoffRank.tpp%})</div>
							{%/if%}
						</div>
					</div>
				</li>
				<li class="item9">
					<div class="inner">
						<div class="icon"></div>
						<div class="data-info">
							<div class="value">{%$playerPlayoff.ftp%}</div>
							<div class="key">罚球命中</div>
							{%if !empty($playerPlayoffRank.ftp)%}
							<div class="rank">(联盟第{%$playerPlayoffRank.ftp%})</div>
							{%/if%}
						</div>
					</div>
				</li>
				<li class="item10">
					<div class="inner">
						<div class="icon"></div>
						<div class="data-info">
							<div class="value">{%$playerPlayoff.games%}/{%$playerPlayoff.games_started%}</div>
							<div class="key">出场/首发</div>
						</div>
					</div>
				</li>
				<li class="item11">
					<div class="inner">
						<div class="icon"></div>
						<div class="data-info">
							<div class="value">{%$playerPlayoff.mins%}'</div>
							<div class="key">上场时间</div>
						</div>
					</div>
				</li>
			</ul>
		</section>
		{%/if%}
		<section class="map-data">
			<h2>投篮热图</h2>
			<div class="canvas-wrap">
				<canvas id="map-canvas" width="512" height="439" style="background-color: #999;"></canvas>
			</div>
			<div class="tips">
				<p>数据依次为：区域内命中率、命中次数、出手数。</p>
				<p>
					命中率在联盟中水平：
					<span class="square red"></span>高于&nbsp;&nbsp;&nbsp;&nbsp;
					<span class="square yellow"></span>平均&nbsp;&nbsp;&nbsp;&nbsp;
					<span class="square gray"></span>低于
				</p>
			</div>
			{%if !empty($hotmap)%}
			{%foreach $hotmap as $val%}
			<input type="hidden" id="map-area{%$val@index+1%}" data-level="{%$val.level%}" data-fgs="{%$val.fgs%}" data-fgm="{%$val.fgm%}" data-fgp="{%$val.fgp%}">
			{%/foreach%}
			{%/if%}
		</section>
		{%if !empty($playerStats)%}
		<section class="mod-data regular-data">
			<h2 class="mod-title-h2"><span class="icon"></span>{%$season%}常规赛</h2>
			<ul class="list clearfix">
				<li class="item1">
					<div class="inner">
						<div class="icon"></div>
						<div class="data-info">
							<div class="value">{%$playerStats.pts%}</div>
							<div class="key">得分</div>
							{%if !empty($playerStatsRank.pts)%}
							<div class="rank">(联盟第{%$playerStatsRank.pts%})</div>
							{%/if%}
						</div>
					</div>
				</li>
				<li class="item2">
					<div class="inner">
						<div class="icon"></div>
						<div class="data-info">
							<div class="value">{%$playerStats.reb%}</div>
							<div class="key">篮板</div>
							{%if !empty($playerStatsRank.reb)%}
							<div class="rank">(联盟第{%$playerStatsRank.reb%})</div>
							{%/if%}
						</div>
					</div>
				</li>
				<li class="item3">
					<div class="inner">
						<div class="icon"></div>
						<div class="data-info">
							<div class="value">{%$playerStats.asts%}</div>
							<div class="key">助攻</div>
							{%if !empty($playerStatsRank.asts)%}
							<div class="rank">(联盟第{%$playerStatsRank.asts%})</div>
							{%/if%}
						</div>
					</div>
				</li>
				<li class="item4">
					<div class="inner">
						<div class="icon"></div>
						<div class="data-info">
							<div class="value">{%$playerStats.stl%}</div>
							<div class="key">抢断</div>
							{%if !empty($playerStatsRank.stl)%}
							<div class="rank">(联盟第{%$playerStatsRank.stl%})</div>
							{%/if%}
						</div>
					</div>
				</li>
				<li class="item5">
					<div class="inner">
						<div class="icon"></div>
						<div class="data-info">
							<div class="value">{%$playerStats.blk%}</div>
							<div class="key">盖帽</div>
							{%if !empty($playerStatsRank.blk)%}
							<div class="rank">(联盟第{%$playerStatsRank.blk%})</div>
							{%/if%}
						</div>
					</div>
				</li>
				<li class="item6">
					<div class="inner">
						<div class="icon"></div>
						<div class="data-info">
							<div class="value">{%$playerStats.to%}</div>
							<div class="key">失误</div>
						</div>
					</div>
				</li>
				<li class="item7">
					<div class="inner">
						<div class="icon"></div>
						<div class="data-info">
							<div class="value">{%$playerStats.fgp%}</div>
							<div class="key">投篮命中</div>
							{%if !empty($playerStatsRank.fgp)%}
							<div class="rank">(联盟第{%$playerStatsRank.fgp%})</div>
							{%/if%}
						</div>
					</div>
				</li>
				<li class="item8">
					<div class="inner">
						<div class="icon"></div>
						<div class="data-info">
							<div class="value">{%$playerStats.tpp%}</div>
							<div class="key">三分命中</div>
							{%if !empty($playerStatsRank.tpp)%}
							<div class="rank">(联盟第{%$playerStatsRank.tpp%})</div>
							{%/if%}
						</div>
					</div>
				</li>
				<li class="item9">
					<div class="inner">
						<div class="icon"></div>
						<div class="data-info">
							<div class="value">{%$playerStats.ftp%}</div>
							<div class="key">罚球命中</div>
							{%if !empty($playerStatsRank.ftp)%}
							<div class="rank">(联盟第{%$playerStatsRank.ftp%})</div>
							{%/if%}
						</div>
					</div>
				</li>
				<li class="item10">
					<div class="inner">
						<div class="icon"></div>
						<div class="data-info">
							<div class="value">{%$playerStats.games%}/{%$playerStats.games_started%}</div>
							<div class="key">出场/首发</div>
						</div>
					</div>
				</li>
				<li class="item11">
					<div class="inner">
						<div class="icon"></div>
						<div class="data-info">
							<div class="value">{%$playerStats.mins%}'</div>
							<div class="key">上场时间</div>
						</div>
					</div>
				</li>
			</ul>
		</section>
		{%/if%}
		<section class="recent-data">
			<h2 class="mod-title-h2"><span class="icon"></span>最近比赛</h2>
			{%if !empty($lastgames)%}
			<table>
				<tr>
					<th>日期</th>
					<th>对手</th>
					<th>比分</th>
					<th>得分</th>
					<th>篮板/助攻/抢断/盖帽</th>
				</tr>
				<tbody>
					{%foreach $lastgames as $val%}
					<tr class="item">
						<td>{%$val.china_time_fix%}</td>
						<td>{%$val.opt_team_name%}</td>
						<td>{%$val.vs|escape:none%}</td>
						<td>{%$val.pts%}</td>
						<td>{%$val.reb%}/{%$val.asts%}/{%$val.stl%}/{%$val.blk%}</td>
					</tr>
					{%/foreach%}
				</tbody>
			</table>
			{%else%}
			<div class="mod_no_result">暂无最近比赛</div>
			{%/if%}
		</section>
	</section>
{%/block%}
