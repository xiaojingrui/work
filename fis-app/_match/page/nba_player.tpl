{%extends file="common/page/layout.tpl"%}

{%block name="title"%}
	{%if !empty($profile.player_name)%}
		{%$profile.player_name%}
	{%else%}
		{%$profile.player_enname%}
	{%/if%}
{%/block%}

{%block name="head_static"%}
	{%require name="common:static/js/zepto/zepto.js"%}
	{%require name="common:static/js/swiper/js/swiper.jquery.js"%}
    {%require name="common:static/js/swiper/css/swiper.css"%}
    {%require name="common:static/js/underscore/underscore.js"%}

	<script type="text/javascript" src="//w1.hoopchina.com.cn/hybrid/common/hpbridge_v1.0.1.js"></script>
	{%require name="match:static/page/nba_player.scss"%}
	{%script%}

		window.GM = {
            "client": "{%$client%}" || "x",
            "version":"{%$version%}"|| "7.0.6",
            "islogin": !!parseInt("{%$is_login%}", 10),
            "night": !!parseInt("{%$night%}", 10),
            "player_name": "{%$profile.player_name%}",
            "player_enname": "{%$profile.player_enname%}",
            "isBirth": !!parseInt("{%$profile.is_birthday%}", 10),
            "tid": "{%$profile.tid%}"
        };

        var nbaPlayer = require("match:widget/nba_player/nba_player.js");

        nbaPlayer.init();
    {%/script%}
{%/block%}

{%block name="content"%}
	<section class="nba-player-wrap" id="J-nba-player-wrap">
		<section class="info">
			<div class="head">
				<img {%if !empty($profile.player_header)%} src="{%$profile.player_header%}" {%else%} src="//b1.hoopchina.com.cn/games/default/nba_head.png" {%/if%} height="50">
				{%if !empty($night)%}<div class="mask"></div>{%/if%}
			</div>
			<ul class="detail">
				<li>
					<span>{%$team_info.full_name%}</span>
					{%if !empty($team_info.full_name) || !empty($profile.number) && !empty($profile.position)%}
					<i class="separator">|</i>
					{%/if%}
					{%if $profile.number!=""%}
					<span>{%$profile.number%}号</span>
					{%/if%}
					{%if $profile.number!="" && !empty($profile.position)%}
					<i class="separator">|</i>
					{%/if%}
					<span>{%$profile.position%}</span>
				</li>
				<li>
					{%if !empty($profile.death_time)%}
						<span>逝世({%$profile.birth_date%}-{%$profile.death_time%})</span>
					{%else%}
						<span>
							<span class="birth-status J-birth-status">
								<img src="//w1.hoopchina.com.cn/hybrid/resource/emoji/2x/1f382.png?t=1" width="15" height="15">
							</span>
							{%if $profile.tid != 0%}
								{%$profile.age%}
							{%/if%}
							<span class="birth-status J-birth-status">
								<img src="//w1.hoopchina.com.cn/hybrid/resource/emoji/2x/1f382.png" width="15" height="15">
							</span>
						</span>
						{%if !empty($profile.age) && !empty($profile.birth_date)%}
							{%if $profile.tid != 0%}
								<i class="separator">|</i>
							{%/if%}
						{%/if%}
						<span id="J-birth-date">{%$profile.birth_date%}</span>
					{%/if%}
				</li>
			</ul>
		</section>
		<ul class="tab clearfix" id="J-tab">
			<li class="active">资料</li>
			<li class="tab-map" data-playerid="{%$profile.player_id%}">投篮热图</li>
			<li>数据</li>
		</ul>
		<div class="swiper-container">
			<div class="swiper-wrapper">
				<section class="t-content swiper-slide t-info">
					<ul class="body-list">
						<li>
							<div class="type">身高</div>
							<div class="num">{%$profile.height%}</div>
						</li>
						<li>
							<div class="type">臂展</div>
							<div class="num">{%$profile.wingspan%}</div>
						</li>
						<li>
							<div class="type">站立摸高</div>
							<div class="num">{%$profile.standing_reach%}</div>
						</li>
						<li>
							<div class="type">体重</div>
							<div class="num">{%$profile.weight%}</div>
						</li>
					</ul>
					{%if !empty($profile.draft)||!empty($profile.college)||!empty($profile.salary)||!empty($profile.contract)%}
					<div class="info-list">
						<table width="100%">
							{%if !empty($injury)%}
								<tr>
									{%if $injury.injury_state == "1" %}
										<td  class="td1" width="26%"><img src="../static/page/img/player_add.png" alt="22" width="19" height="19"></td>
									{%else%}
										<td  class="td1" width="26%"><img src="../static/page/img/player_doubt.png" alt="22" width="19" height="19"></td>
									{%/if%}

									<td width="20%">伤停</br>
										<span>
											{%if !empty($injury.injury_part_cn) %}
												{%$injury.injury_part_cn%}
											{%else%}
												{%$injury.injury_part%}
											{%/if%}
										</span>
									</td>
									<td width="25%">起始时间</br><span>{%date('n月j日', strtotime($injury.injury_date))%}</span></td>
									<td>最新进展</br>
										<span>
											{%if !empty($injury.injury_returns_cn) %}
												{%$injury.injury_returns_cn%}
											{%else%}
												<span class="injury_returns_en">{%$injury.injury_returns%}</span>
											{%/if%}
										</span>
									</td>
								</tr>
								<tr>
									<td></td>
									<td colspan="3" class="hurt-detail">
										{%if !empty($injury.injury_detail_cn) %}
												{%$injury.injury_detail_cn%}
											{%else%}
												{%$injury.injury_detail%}
											{%/if%}
									</td>
								</tr>
							{%/if%}
							{%if !empty($profile.draft)%}
							<tr>
								<td  width="26%" class="td1">选秀</td>
								<td class="td2" colspan="3">{%$profile.draft%}</td>
							</tr>
							{%/if%}
							{%if !empty($profile.college)%}
							<tr>
								<td  width="26%" class="td1">来自</td>
								<td class="td2" colspan="3">{%$profile.college%}</td>
							</tr>
							{%/if%}
							{%if !empty($profile.salary)%}
							<tr>
								<td  width="26%" class="td1">薪水</td>
								<td class="td2" colspan="3">{%$profile.salary%}</td>
							</tr>
							{%/if%}
							{%if !empty($profile.contract)%}
							<tr>
								<td  width="26%" class="td1" valign="top">合同</td>
								<td class="td2" class="no-copy" colspan="3">
									<div>{%$profile.contract%}</div>
									<div class="contract-details">
										{%$profile.contract_details%}
									</div>
								</td>
							</tr>
							{%/if%}
						</table>
					</div>
					{%/if%}
					{%if !empty($profile.extend)%}
					<div class="analyze">
						<h2>扩展阅读</h2>
						<ul>
						{%foreach $profile.extend as $val%}
							<li>
								<a href="{%$val.link|escape:none%}" dace-node="nbawiki">
									<div class="link-title">
										<p class="title">{%$val.title%}</p>
									</div>
									<em><i></i></em>
								</a>
							</li>
						{%/foreach%}
						</ul>
					</div>
					{%/if%}
					<div class="data-list">
						<h2>赛季数据</h2>
						<ul class="clearfix">
							{%foreach $season_stats as $val%}
								{%if $val@index < 6 %}
								 	{%if $val@index < 3 %}
									<li class="mb">
									{%else%}
									<li>
									{%/if%}
										<div class="type">{%$val[0]%}</div>
										<div class="num">{%$val[1]%}</div>
										{%if !empty($val[2])%}
										<div class="rank">({%$val[2]%})</div>
										{%/if%}
									</li>
								{%/if%}
							{%/foreach%}
						</ul>
					</div>
				</section>

				<section class="t-content swiper-slide t-map" id="J-t-map">
					<!--
					level 1 2 3分别代表了投篮命中率的高低
					1：#ff7838（红）
					2：#ffd303（黄）
					3：#58cce0（蓝）
					4: #eeebeb (灰，代表此处无投篮次数)
					 -->
					<div class="map-data" id="J-map-data">
						<script id="J-map-tpl" type="text/template">
							<@ $(datas).each(function(index,item){ @>
							<input type="hidden" class="area_<@=item.areaId@>" data-fgp="<@=item.fgp@>" data-fgs="<@=item.fgs@>" <@ if(item.level ==1){ @>data-color="#ff7838"<@ }else if(item.level ==2){ @>data-color="#ffd303"<@ }else if(item.level ==3){ @>data-color="#58cce0"<@ }else{ @>data-color="#eeebeb"<@ } @> data-fgm="<@=item.fgm@>">
							<@ }); @>
						</script>
					</div>
					<div class="canvas-wrap">
						{%if empty($night)%}
						<div class="hoop hoop-day"></div>
						{%else%}
						<div class="hoop hoop-night"></div>
						{%/if%}
						<canvas id="myCanvas" width="750" height="700"></canvas>
						<div class="update-time">
							<span></span>更新
						</div>
						{%if !empty($night)%}
						<div class="mask"></div>
						{%/if%}
						<div class="logo"></div>
					</div>
					<input type="hidden" id="J-season-type" value="{%$season_type%}">
					<!--<div class="condition clearfix">
						<div class="select fl">
							<div class="inner">
								<div class="default"><span>{%$season[0]%}</span>赛季<i></i></div>
								<ul class="option" style="display: none;">
									{%foreach $season as $val%}
									<li data-season="{%$val%}">{%$val%}赛季</li>
									{%/foreach%}
								</ul>
							</div>
						</div>
						<div class="radio fr">
							<div class="inner">
								{%if $season_type == "regular"%}
								<span class="active" data-type="regular">常规赛</span><span data-type="playoff">季后赛</span>
								{%else%}
								<span data-type="regular">常规赛</span><span class="active" data-type="playoff">季后赛</span>
								{%/if%}
							</div>
						</div>
					</div>-->
					<dl class="tips">
						<dt>三个数据分别是：该区域的命中率、命中数和出手数</dt>
						<dd><span class="red"></span> 命中率高于联盟平均水平</dd>
						<dd><span class="yellow"></span> 命中率处于联盟平均水平</dd>
						<dd><span class="blue"></span> 命中率低于联盟平均水平</dd>
					</dl>
				</section>

				<section class="t-content swiper-slide t-data clearfix">
					<div class="left-table fl">
						<table>
							<thead>
								<tr>
									{%foreach $career_regular_glossary[1] as $val%}
									{%if $val@index < 2 %}
										<td>{%$val%}</td>
									{%/if%}
									{%/foreach%}
								</tr>
							</thead>
							<tbody>
								{%foreach $career_regular_stats as $val%}
								<tr>
									<td>{%$val.season%}</td>
									<td>{%$val.team_name%}</td>
								</tr>
								{%/foreach%}
							</tbody>
							<thead>
								<tr>
									{%foreach $career_playoff_glossary[1] as $val%}
									{%if $val@index < 2 %}
										<td>{%$val%}</td>
									{%/if%}
									{%/foreach%}
								</tr>
							</thead>
							<tbody>
								{%foreach $career_playoff_stats as $val%}
								<tr>
									<td>{%$val.season%}</td>
									<td>{%$val.team_name%}</td>
								</tr>
								{%/foreach%}
							</tbody>
						</table>
					</div>
					<div class="right-table fr swiper-no-swiping">
						<table>
							<thead>
								<tr>
									{%foreach $career_regular_glossary[1] as $val%}
									{%if $val@index >= 2 %}
										<td>{%$val%}</td>
									{%/if%}
									{%/foreach%}
								</tr>
							</thead>
							<tbody>
								{%foreach $career_regular_stats as $val%}
								<tr>
									<td>{%$val.game_play%}</td>
									<td>{%$val.game_start%}</td>
									<td>{%$val.min%}</td>
									<td>{%$val.pts%}</td>
									<td>{%$val.reb%}</td>
									<td>{%$val.asts%}</td>
									<td>{%$val.fga%}</td>
									<td>{%$val.tpa%}</td>
									<td>{%$val.fpt%}</td>
									<td>{%$val.stl%}</td>
									<td>{%$val.to%}</td>
									<td>{%$val.blk%}</td>
									<td>{%$val.pf%}</td>
								</tr>
								{%/foreach%}
							</tbody>
							<thead>
								<tr>
									{%foreach $career_playoff_glossary[1] as $val%}
									{%if $val@index >= 2 %}
										<td>{%$val%}</td>
									{%/if%}
									{%/foreach%}
								</tr>
							</thead>
							<tbody>
								{%foreach $career_playoff_stats as $val%}
								<tr>
									<td>{%$val.game_play%}</td>
									<td>{%$val.game_start%}</td>
									<td>{%$val.min%}</td>
									<td>{%$val.pts%}</td>
									<td>{%$val.reb%}</td>
									<td>{%$val.asts%}</td>
									<td>{%$val.fga%}</td>
									<td>{%$val.tpa%}</td>
									<td>{%$val.fpt%}</td>
									<td>{%$val.stl%}</td>
									<td>{%$val.to%}</td>
									<td>{%$val.blk%}</td>
									<td>{%$val.pf%}</td>
								</tr>
								{%/foreach%}
							</tbody>
						</table>
					</div>
				</section>
			</div>
		</div>
	</section>
{%/block%}
