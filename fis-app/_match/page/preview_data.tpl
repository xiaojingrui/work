{%extends file="common/page/layout.tpl"%}

{%block name="title"%}前瞻{%/block%}

{%block name="head_static"%}
    {%require name="match:static/preview_data/preview_data.scss"%}
    {%script%}
        window.GM = {
            "version": "{%$version%}"||"7.0.13"
        };

    	var tapLink = require("common:widget/tap-link/tap-link.js");
    	tapLink.init($("#J-preview-wrap"));

        var version = require("common:widget/ui-versions/ui-versions.js");
        if(version.gte(GM.version,"7.0.13")){
            $(".huputv").show();
        }
    {%/script%}
{%/block%}

{%block name="content"%}
	{%if empty($summary) && empty($home) && empty($away) && empty($live_video_list) && empty($rank)%}
		<script>
			var winHeight = window.innerHeight;
			var docHeight = document.body.offsetHeight;
			if(docHeight < winHeight){
				var style = document.createElement("style");
				style.innerHTML = "html,body{height:100%;}";
				document.body.appendChild(style);
			}
		</script>
		<div class="no-recap">暂无前瞻，请先去其他比赛看看吧！</div>
	{%else%}
	<section class="preview-wrap" id="J-preview-wrap">
		<section class="media" {%if empty($video_room_list) && empty($live_video_list.tv) && empty($live_video_list.huputv) && empty($live_video_list.net)%} style="margin-bottom: 0;"{%/if%}>
			{%if !empty($live_video_list.net)%}
			<div class="live">
				<h2>网络直播</h2>
				<ul class="clearfix">
					{%foreach $live_video_list.net as $val%}
					<li>
						<a {%if !empty($val.url)%}href="{%$val.url%}" dace-node="livevideo"{%else%}href="javascript:void(0);" {%/if%} class="item ellipsis {%if empty($val.url)%}no-link{%/if%}">{%$val.name|default:"网络直播{%$val@index+1%}"%}</a>
						{%if !empty($val.pay)%}
							<span class="pay">付费</span>
						{%/if%}
					</li>
					{%/foreach%}
				</ul>
			</div>
			{%/if%}
			{%if !empty($live_video_list.tv)%}
			<div class="tv">
				<h2>视频直播</h2>
				<ul class="clearfix">
					{%foreach $live_video_list.tv as $val%}
					<li>
						<a {%if !empty($val.url)%} href="{%$val.url%}" dace-node="livevideo"{%else%}href="javascript:void(0);"{%/if%} class="item ellipsis {%if empty($val.url)%}no-link{%/if%}">{%$val.name|default:"视频直播{%$val@index+1%}"%}</a>
						{%if !empty($val.pay)%}
							<span class="pay">付费</span>
						{%/if%}
					</li>
					{%/foreach%}
				</ul>
			</div>
			{%/if%}
            {%if !empty($live_video_list.huputv)%}
			<div class="huputv" style="display:none;">
				<h2>虎扑TV</h2>
				<ul class="clearfix">
					{%foreach $live_video_list.huputv as $val%}
					<li>
						<a {%if !empty($val.url)%} href="{%$val.url%}" dace-node="livevideo"{%else%}href="javascript:void(0);"{%/if%} class="item ellipsis {%if empty($val.url)%}no-link{%/if%}">{%$val.name|default:"虎扑TV直播{%$val@index+1%}"%}</a>
					</li>
					{%/foreach%}
				</ul>
			</div>
			{%/if%}
		</section>


		<!-- <section class="lottery">
			<h2>彩票</h2>
			<div class="list">
				<ul>
					<li class="win"><i>胜</i>1.5</li>
					<li class="draw"><i>平</i>1.5</li>
					<li class="lose"><i>负</i>1.5</li>
				</ul>
			</div>
			<div class="tip"><a href="">虎扑投注助手 ></a></div>
		</section> -->


		{%if !empty($summary) || !empty($home) || !empty($away)%}
		<section class="main">
			<ul>
				{%if !empty($summary)%}
				<li>
					<div class="left">
						<span style="font-size: 10px;">前瞻</span>
					</div>
					<div class="right">{%$summary|escape:none%}</div>
				</li>
				{%/if%}
				{%if !empty($home)%}
				<li>
					<div class="left">
						{%if !empty($home_logo)%}<img src="{%$home_logo%}?t=1">{%/if%}
					</div>
					<div class="right">{%$home|escape:none%}</div>
				</li>
				{%/if%}
				{%if !empty($away)%}
				<li>
					<div class="left">
						{%if !empty($away_logo)%}<img src="{%$away_logo%}?t=2">{%/if%}
					</div>
					<div class="right">{%$away|escape:none%}</div>
				</li>
				{%/if%}
			</ul>
		</section>
		{%/if%}


		{%if isset($absence)%}
		<section class="absence">
			<h2>缺席比赛</h2>
			<div class="teams clearfix">
				<div class="left fl">
					<span class="logo">{%if !empty($home_logo)%}<img src="{%$home_logo%}?t=3">{%/if%}</span><span class="name">{%$home_name%}</span>
				</div>
				<div class="right fr">
					<span class="name">{%$away_name%}</span><span class="logo">{%if !empty($away_logo)%}<img src="{%$away_logo%}?t=4">{%/if%}</span>
				</div>
			</div>
			{%if empty($absence)%}
			<!-- <div class="tables">
				<div class="left">
					<table>
						<tr>
							<td colspan="2" style="height: 21px; text-align: left; padding-left: 40px;">全员健康</td>
						</tr>
					</table>
				</div>
				<div class="left">
					<table>
						<tr>
							<td colspan="2" style="height: 21px; text-align: right; padding-right: 40px;">全员健康</td>
						</tr>
					</table>
				</div>
			</div> -->
			{%else%}
			<div class="tables">
				<div class="left">
					<table>
						{%foreach $absence[$home_tid] as $val%}
						<tr>
							<td>
								{%if $val.reason == 1%}
								<span class="yellow">
									<span class="card1"></span>
									<span class="card2"></span>
								</span>
								{%else if $val.reason == 2%}
								<span class="red"></span>
								{%else if $val.reason == 3%}
								<span class="suspended">停赛</span>
								{%else if $val.reason == 4%}
								<span class="injured">受伤</span>
								{%else%}
								<span>无</span>
								{%/if%}
							</td>
							<td class="link" link="kanqiu://soccerleagues/{%$league_name%}/player/{%$val.player_id%}">
								<div class="link-inner">
									<span class="player">{%$val.number%}</span>
									<span class="name ellipsis">{%$val.player_name%}</span>
								</div>
							</td>
						</tr>
						{%/foreach%}
						{%if $absence[$home_tid]|count <  $absence[$away_tid]|count%}
							{%$loop = $absence[$away_tid]|count-$absence[$home_tid]|count%}
							{%if $absence[$home_tid]|count == 0%}
								{%section name=list loop=$loop%}
								{%if $smarty.section.list.index == 0%}
								<tr>
									<td colspan="2" style="text-align: left; padding-left: 40px;">全员健康</td>
								</tr>
								{%else%}
								<tr>
									<td>&nbsp;&nbsp;</td>
									<td>&nbsp;&nbsp;</td>
								</tr>
								{%/if%}
								{%/section%}
							{%else%}
								{%section name=list loop=$loop%}
								<tr>
									<td>&nbsp;&nbsp;</td>
									<td>&nbsp;&nbsp;</td>
								</tr>
								{%/section%}
							{%/if%}
						{%/if%}
					</table>
				</div>
				<div class="right">
					<table>
						{%foreach $absence[$away_tid] as $val%}
						<tr>
							<td>
								{%if $val.reason == 1%}
								<span class="yellow">
									<span class="card1"></span>
									<span class="card2"></span>
								</span>
								{%else if $val.reason == 2%}
								<span class="red"></span>
								{%else if $val.reason == 3%}
								<span class="suspended">停赛</span>
								{%else if $val.reason == 4%}
								<span class="injured">受伤</span>
								{%else%}
								<span>无</span>
								{%/if%}
							</td>
							<td class="link" link="kanqiu://soccerleagues/{%$league_name%}/player/{%$val.player_id%}">
								<div class="link-inner">
									<span class="player">{%$val.number%}</span>
									<span class="name ellipsis">{%$val.player_name%}</span>
								</div>
							</td>
						</tr>
						{%/foreach%}
						{%if $absence[$away_tid]|count <  $absence[$home_tid]|count%}
							{%$loop = $absence[$home_tid]|count-$absence[$away_tid]|count%}
							{%if $absence[$away_tid]|count == 0%}
								{%section name=list loop=$loop%}
								{%if $smarty.section.list.index == 0%}
								<tr>
									<td colspan="2" style="text-align: right; padding-right: 40px;">全员健康</td>
								</tr>
								{%else%}
								<tr>
									<td>&nbsp;&nbsp;</td>
									<td>&nbsp;&nbsp;</td>
								</tr>
								{%/if%}
								{%/section%}
							{%else%}
								{%section name=list loop=$loop%}
								<tr>
									<td>&nbsp;&nbsp;</td>
									<td>&nbsp;&nbsp;</td>
								</tr>
								{%/section%}
							{%/if%}
						{%/if%}
					</table>
				</div>
			</div>
			{%/if%}
		</section>
		{%/if%}
		{%if isset($rank)%}
			{%if !empty($rank)%}
			<section class="rank">
				<table>
					<tr>
						<th>排行</th>
						<th>球队</th>
						<th>场次</th>
						<th>胜</th>
						<th>平</th>
						<th>负</th>
						<th>进/失</th>
						<th>积分</th>
					</tr>
					{%foreach $rank as $val%}
					<tr class="link" link="kanqiu://soccerleagues/{%$league_name%}/team/{%$val.team_id%}">
						<td class="num {%if $val.ranking == 1%} red {%/if%}">{%$val.ranking%}</td>
						<td class="logo">{%if !empty($val.team_logo)%}<img src="{%$val.team_logo%}?t=1{%$val@index%}">{%/if%}</td>
						<td>{%$val.played%}</td>
						<td>{%$val.wins%}</td>
						<td>{%$val.ties%}</td>
						<td>{%$val.losses%}</td>
						<td>{%$val.goalsFor_goalsAgainst%}</td>
						<td>{%$val.points%}</td>
					</tr>
					{%/foreach%}
				</table>
			</section>
			{%/if%}
		{%/if%}

		<!-- <section class="history">
			<h2>历史交锋</h2>
			<div class="inner clearfix">
				<div class="fl left"><img src="//b1.hoopchina.com.cn/games/teams/csl/9_3161_1.png" alt=""></div>
				<div class="fl center">
					<div class="win" style="-webkit-box-flex:2; -ms-flex:2; -webkit-flex:2; -moz-flex:2; flex:2;"><span>25胜</span></div>
					<div class="draw" style="-webkit-box-flex:4; -ms-flex:4; -webkit-flex:4; -moz-flex:4; flex:4;"><span>2平</span></div>
					<div class="lose" style="-webkit-box-flex:3; -ms-flex:3; -webkit-flex:3; -moz-flex:3; flex:3;"><span>15负</span></div>
				</div>
				<div class="fl right"><img src="//b1.hoopchina.com.cn/games/teams/csl/9_3259_1.png" alt=""></div>
			</div>
		</section> -->


		<!-- <section class="recent">
			<h2>近期战绩</h2>
			<div class="inner clearfix">
				<div class="fl">
					<span class="mod-circle circle-win">胜</span>
					<span class="mod-circle circle-lose">负</span>
					<span class="mod-circle circle-win">胜</span>
					<span class="mod-circle circle-draw">平</span>
					<span class="mod-circle circle-win">胜</span>
				</div>
				<div class="fr">
					<span class="mod-circle circle-win">胜</span>
					<span class="mod-circle circle-win">胜</span>
					<span class="mod-circle circle-lose">负</span>
					<span class="mod-circle circle-win">胜</span>
					<span class="mod-circle circle-win">胜</span>
				</div>
			</div>
		</section> -->

		{%if !empty($odds)%}
		<section class="odds">
			<ul>
				<li>
					欧赔即时：<span class="mod-circle circle-win">胜</span><span class="num">{%$odds.win%}</span><span class="mod-circle circle-draw">平</span><span class="num">{%$odds.draw%}</span><span class="mod-circle circle-lose">负</span><span class="num">{%$odds.lost%}</span>
				</li>
				<!-- <li>
					欧赔初赔：<span class="mod-circle circle-win">胜</span><span class="num">1.5</span><span class="mod-circle circle-draw">平</span><span class="num">1.5</span><span class="mod-circle circle-lose">负</span><span class="num">1.5</span>
				</li> -->
				<li>
					<a href="{%$odds.url%}" dace-node="matchlottery">更多赔率数据 ></a>
				</li>
			</ul>
		</section>
		{%/if%}
	</section>
	{%/if%}
{%/block%}
