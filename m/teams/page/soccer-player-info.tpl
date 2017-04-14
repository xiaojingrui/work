{%extends file="common/page/layout.tpl"%}

{%block name="block_head_static"%}
    {%require name="teams:static/soccer-player-info/soccer-player-info.scss"%}

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

	<section class="m-wrap soccerPlayerInfo-wrap">
		{%widget
            name="teams:widget/player-header/player-header.tpl"
            type="soccer"
        %}
		<nav>
			<a href="javascript:void(0);" class="info active">基本信息</a><a href="{%$playerInfo.page_urls.stats_url%}">赛季数据</a>
		</nav>
		<section class="basic-info">
			<ul>
				<li>
					<div class="key">
					{%if !empty($playerInfo.country)%}
					{%$playerInfo.birth_date%}
					{%else%}
					--
					{%/if%}
					</div>
					<div class="value">出生年月</div>
				</li>
				<li>
					<div class="key">
					{%if !empty($playerInfo.country)%}
						{%foreach $playerInfo.country as $val%}
							{%$val%}
							{%if $val@index != $playerInfo.country|count-1%}/{%/if%}
						{%/foreach%}
					{%else%}
					不详
					{%/if%}
					</div>
					<div class="value">国籍</div>
				</li>
				<li>
					<div class="key">
					{%if !empty($playerInfo.market_value)%}
					€{%$playerInfo.market_value%}万
					{%else%}
					--
					{%/if%}
					</div>
					<div class="value">身价</div>
				</li>
			</ul>
		</section>
		<section class="body-info">
			<div class="body-bg">
				<div class="item item1">
					<div class="key">
					{%if !empty($playerInfo.age)%}
					{%$playerInfo.age%}岁
					{%else%}
					--
					{%/if%}
					</div>
					<div class="value">年龄</div>
				</div>
				<div class="item item2">
					<div class="key">
					{%if !empty($playerInfo.height)%}
					{%$playerInfo.height%}米
					{%else%}
					--
					{%/if%}
					</div>
					<div class="value">身高</div>
				</div>
				<div class="item item3">
					<div class="key">
					{%if !empty($playerInfo.weight)%}
					{%$playerInfo.weight%}公斤
					{%else%}
					--
					{%/if%}
					</div>
					<div class="value">体重</div>
				</div>
				<div class="item item4">
					<div class="key">
					{%if $playerInfo.preferred_foot == 1%}
					左脚
					{%else if $playerInfo.preferred_foot ==2%}
					右脚
					{%else if $playerInfo.preferred_foot ==3%}
					双脚
					{%else%}
					未知
					{%/if%}
					</div>
					<div class="value">惯用脚</div>
				</div>
			</div>
			{%if !empty($playerInfo.contract_until)%}
			<div class="contract">（{%$playerInfo.contract_until%}&nbsp;&nbsp;合同到期）</div>
			{%/if%}
		</section>
		<section class="mod-data">
			<h2 class="mod-title-h2"><span class="icon"></span>赛季综合({%$season%})</h2>
			{%if $playerInfo.position_type == 3 || $playerInfo.position_type == 4%}
			<ul class="list list-type1 clearfix">
				<li class="item1 goals">
					<div class="inner">
						<div class="icon"></div>
						<div class="data-info">
							<div class="value">{%$playerStats.goals|default:"--"%}/{%$playerStats.att_pen_goal|default:"--"%}</div>
							<div class="key">进球/点球</div>
						</div>
					</div>
				</li>
				<li class="item2 assist">
					<div class="inner">
						<div class="icon"></div>
						<div class="data-info">
							<div class="value">{%$playerStats.goal_assist|default:"--"%}</div>
							<div class="key">助攻</div>
						</div>
					</div>
				</li>
				<li class="item3 pass">
					<div class="inner">
						<div class="icon"></div>
						<div class="data-info">
							<div class="value">{%$playerStats.total_pass|default:"--"%}</div>
							<div class="key">传球</div>
						</div>
					</div>
				</li>
				<li class="item4 card">
					<div class="inner">
						<div class="icon"></div>
						<div class="data-info">
							<div class="value">{%$playerStats.yellow_card|default:"--"%}/{%$playerStats.red_card|default:"--"%}</div>
							<div class="key">黄/红牌</div>
						</div>
					</div>
				</li>
				<li class="item5 played">
					<div class="inner">
						<div class="icon"></div>
						<div class="data-info">
							<div class="value">{%$playerStats.played|default:"--"%}/{%$playerStats.status|default:"--"%}</div>
							<div class="key">出场/首发</div>
						</div>
					</div>
				</li>
				<li class="item6 time">
					<div class="inner">
						<div class="icon"></div>
						<div class="data-info">
							<div class="value">{%$playerStats.mins_played|default:"--"%}'</div>
							<div class="key">上场时间</div>
						</div>
					</div>
				</li>
			</ul>
			{%else if $playerInfo.position_type == 2%}
			<ul class="list list-type2 clearfix">
				<li class="item1 tackle">
					<div class="inner">
						<div class="icon"></div>
						<div class="data-info">
							<div class="value">{%$playerStats.total_tackle|default:"--"%}</div>
							<div class="key">抢断</div>
						</div>
					</div>
				</li>
				<li class="item2 clearance">
					<div class="inner">
						<div class="icon"></div>
						<div class="data-info">
							<div class="value">{%$playerStats.total_clearance|default:"--"%}</div>
							<div class="key">解围</div>
						</div>
					</div>
				</li>
				<li class="item3 interception">
					<div class="inner">
						<div class="icon"></div>
						<div class="data-info">
							<div class="value">{%$playerStats.interception|default:"--"%}</div>
							<div class="key">拦截</div>
						</div>
					</div>
				</li>
				<li class="item4 card">
					<div class="inner">
						<div class="icon"></div>
						<div class="data-info">
							<div class="value">{%$playerStats.yellow_card|default:"--"%}/{%$playerStats.red_card|default:"--"%}</div>
							<div class="key">黄/红牌</div>
						</div>
					</div>
				</li>
				<li class="item5 played">
					<div class="inner">
						<div class="icon"></div>
						<div class="data-info">
							<div class="value">{%$playerStats.played|default:"--"%}/{%$playerStats.status|default:"--"%}</div>
							<div class="key">出场/首发</div>
						</div>
					</div>
				</li>
				<li class="item6 time">
					<div class="inner">
						<div class="icon"></div>
						<div class="data-info">
							<div class="value">{%$playerStats.mins_played|default:"--"%}'</div>
							<div class="key">上场时间</div>
						</div>
					</div>
				</li>
			</ul>
			{%else if $playerInfo.position_type == 1%}
			<ul class="list list-type3 clearfix">
				<li class="item1 saves">
					<div class="inner">
						<div class="icon"></div>
						<div class="data-info">
							<div class="value">{%$playerStats.saves|default:"--"%}</div>
							<div class="key">扑救</div>
						</div>
					</div>
				</li>
				<li class="item2 pass">
					<div class="inner">
						<div class="icon"></div>
						<div class="data-info">
							<div class="value">{%$playerStats.total_pass|default:"--"%}</div>
							<div class="key">传球</div>
						</div>
					</div>
				</li>
				<li class="item4 card">
					<div class="inner">
						<div class="icon"></div>
						<div class="data-info">
							<div class="value">{%$playerStats.yellow_card|default:"--"%}/{%$playerStats.red_card|default:"--"%}</div>
							<div class="key">黄/红牌</div>
						</div>
					</div>
				</li>
				<li class="item5 played">
					<div class="inner">
						<div class="icon"></div>
						<div class="data-info">
							<div class="value">{%$playerStats.played|default:"--"%}/{%$playerStats.status|default:"--"%}</div>
							<div class="key">出场/首发</div>
						</div>
					</div>
				</li>
				<li class="item6 time">
					<div class="inner">
						<div class="icon"></div>
						<div class="data-info">
							<div class="value">{%$playerStats.mins_played|default:"--"%}'</div>
							<div class="key">上场时间</div>
						</div>
					</div>
				</li>
			</ul>
			{%else%}
			<ul class="list list-type1 clearfix">
				<li class="item1 goals">
					<div class="inner">
						<div class="icon"></div>
						<div class="data-info">
							<div class="value">{%$playerStats.goals|default:"--"%}/{%$playerStats.att_pen_goal|default:"--"%}</div>
							<div class="key">进球/点球</div>
						</div>
					</div>
				</li>
				<li class="item2 assist">
					<div class="inner">
						<div class="icon"></div>
						<div class="data-info">
							<div class="value">{%$playerStats.goal_assist|default:"--"%}</div>
							<div class="key">助攻</div>
						</div>
					</div>
				</li>
				<li class="item3 pass">
					<div class="inner">
						<div class="icon"></div>
						<div class="data-info">
							<div class="value">{%$playerStats.total_pass|default:"--"%}</div>
							<div class="key">传球</div>
						</div>
					</div>
				</li>
				<li class="item4 card">
					<div class="inner">
						<div class="icon"></div>
						<div class="data-info">
							<div class="value">{%$playerStats.yellow_card|default:"--"%}/{%$playerStats.red_card|default:"--"%}</div>
							<div class="key">黄/红牌</div>
						</div>
					</div>
				</li>
				<li class="item5 played">
					<div class="inner">
						<div class="icon"></div>
						<div class="data-info">
							<div class="value">{%$playerStats.played|default:"--"%}/{%$playerStats.status|default:"--"%}</div>
							<div class="key">出场/首发</div>
						</div>
					</div>
				</li>
				<li class="item6 time">
					<div class="inner">
						<div class="icon"></div>
						<div class="data-info">
							<div class="value">{%$playerStats.mins_played|default:"--"%}'</div>
							<div class="key">上场时间</div>
						</div>
					</div>
				</li>
			</ul>
			{%/if%}
		</section>
		<section class="map-data">
			<h2>球员位置</h2>
			<div class="position">
				<img src="//b1.hoopchina.com.cn/touch/static/teams/soccer-player-info/soccer_player_12_dacfd51.jpg" alt="">
				<span class="item{%$playerInfo.detailed_position.main_position.type%} red">{%$playerInfo.detailed_position.main_position.name_zh%}</span>
				{%if !empty($playerInfo.detailed_position.side_position)%}
				{%foreach $playerInfo.detailed_position.side_position as $val%}
				<span class="item{%$val.type%}">{%$val.name_zh%}</span>
				{%/foreach%}
				{%/if%}
			</div>
		</section>
		<section class="transfer-data">
			<h2 class="mod-title-h2"><span class="icon"></span>转会记录</h2>
			{%if !empty($PlayerTransfer)%}
			<table>
				<thead>
					<tr>
						<th>转会时间</th>
						<th>转入球队</th>
						<th>转会费</th>
					</tr>
				</thead>
				<tbody>
					{%foreach $PlayerTransfer as $val%}
					<tr class="item">
						<td class="date">{%$val.transfer_date%}</td>
						<td width="50%">
						{%if !empty($val.moving_to_team_name_zh)%}
						{%$val.moving_to_team_name_zh%}
						{%else%}
						不详
						{%/if%}
						</td>
						<td class="fee">
						{%if !empty($val.transfer_fee)%}
						€{%$val.transfer_fee%}万
						{%else%}
						--
						{%/if%}
						</td>
					</tr>
					{%/foreach%}
				</tbody>
			</table>
			{%else%}
			<div class="mod_no_result">暂无转会记录</div>
			{%/if%}
		</section>
	</section>
{%/block%}
