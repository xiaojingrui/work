{%extends file="common/page/layout-empty.tpl"%}

{%block name="title"%}赛前前瞻-虎扑体育{%/block%}

{%block name="head_static"%}
	{%require name="match:static/page/preview.scss"%}
{%/block%}

{%block name="content"%}
	<section class="media" {%if empty($video_room_list) && empty($live_video_list.tv) && empty($live_video_list.net) && empty($live_video_list.huputv)%} style="margin-bottom: 0;"{%/if%}>
			{%if !empty($video_room_list)%}
			<div class="huputv">
				<h2>虎扑TV</h2>
				<ul class="clearfix">
					{%foreach $video_room_list as $val%}
					<li>
						<a href="kanqiu://room/{%$val.id%}/2" class="item ellipsis">{%$val.name%}</a>
						<div class="anchor"><i></i>{%$val.anchor_list%}</div>
					</li>
					{%/foreach%}
				</ul>
			</div>
			{%/if%}
			{%if !empty($live_video_list.net)%}
			<div class="live">
				<h2>网络直播</h2>
				<ul class="clearfix">
					{%foreach $live_video_list.net as $val%}
					<li>
						<a {%if !empty($val.url)%}href="{%$val.url%}"{%else%}href="javascript:void(0);" {%/if%} class="item ellipsis {%if empty($val.url)%}no-link{%/if%}">{%$val.name|default:"网络直播{%$val@index+1%}"%}</a>
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
						<a {%if !empty($val.url)%} href="{%$val.url%}"{%else%}href="javascript:void(0);"{%/if%} class="item ellipsis {%if empty($val.url)%}no-link{%/if%}">{%$val.name|default:"视频直播{%$val@index+1%}"%}</a>
						{%if !empty($val.pay)%}
							<span class="pay">付费</span>
						{%/if%}
					</li>
					{%/foreach%}
				</ul>
			</div>
			{%/if%}
			{%if !empty($live_video_list.huputv)%}
			<div class="huputv">
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

	{%if !empty($preview)%}
		<div class="preview">{%$preview|escape:none%}</div>
	{%else%}
		{%if empty($video_room_list) && empty($live_video_list.tv) && empty($live_video_list.net) && empty($injurys.home) && empty($injurys.away)%}
			<div class="preview_tips"><p>{%$preview_tips|escape:none%}</p></div>
		{%/if%}
	{%/if%}
<section class="hurt">
	{%if !empty($injurys.home) || !empty($injurys.away)%}
		<h2>伤停情况</h2>
	{%/if%}
	<div class="hurt-info">
		<ul class="hurt-player player_away">
			{%if !empty($injurys.away)%}
				<h3><img src="{%$gameInfo.away_logo%}">{%$gameInfo.away_name%}</h3>
				{%foreach from=$injurys.away item=val%}
					<li>
						<a href="kanqiu://nba/nba/player/{%$val.hupu_pid%}"  target="_blank">
							{%if $val.injury_state == "1" %}
								<div class="player-name"><img src="../static/page/img/player_add.png?_{%$val@index%}" /><span class="injury_returns_name">{%$val.player_name%}</span></div>
							{%else%}
								<div class="player-name"><img src="../static/page/img/player_doubt.png?{%$val@index%}" /><span class="injury_returns_name">{%$val.player_name%}</span></div>
							{%/if%}
							<div class="hurt-name">
								{%if !empty($val.injury_part_cn) %}
									<span class="injury_returns_name">{%$val.injury_part_cn%}</span>
								{%else%}
									<span class="injury_returns_name">{%$val.injury_part%}</span>
								{%/if%}
							</div>
							<div class="back-time">
								<span>
									{%if !empty($val.injury_returns_cn) %}
										<span class="injury_returns_en">{%$val.injury_returns_cn%}</span>
									{%else%}
										<span class="injury_returns_en">{%$val.injury_returns%}</span>
									{%/if%}
								</span>
							</div>
							<div class="hurt-arrow"><i class="icon-arrow"></i></div>
							</a>
						</li>

				{%/foreach%}
			{%/if%}
		</ul>
		<ul class="hurt-player player_home">
			{%if !empty($injurys.home)%}
				<h3><img src="{%$gameInfo.home_logo%}">{%$gameInfo.home_name%}</h3>
				{%foreach from=$injurys.home item=val%}
					<li>
						<a href="kanqiu://nba/nba/player/{%$val.hupu_pid%}"  target="_blank">
							{%if $val.injury_state == "1" %}
								<div class="player-name"><img src="../static/page/img/player_add.png?{%$val@index%}" /><span class="injury_returns_name">{%$val.player_name%}</span></div>
							{%else%}
								<div class="player-name"><img src="../static/page/img/player_doubt.png?{%$val@index%}" /><span class="injury_returns_name">{%$val.player_name%}</span></div>
							{%/if%}
							<div class="hurt-name">
								{%if !empty($val.injury_part_cn) %}
									<span class="injury_returns_name">{%$val.injury_part_cn%}</span>
								{%else%}
									<span class="injury_returns_name">{%$val.injury_part%}</span>
								{%/if%}
							</div>
							<div class="back-time">
								<span>
									{%if !empty($val.injury_returns_cn) %}
										<span class="injury_returns_en">{%$val.injury_returns_cn%}</span>
									{%else%}
										<span class="injury_returns_en">{%$val.injury_returns%}</span>
									{%/if%}
								</span>
							</div>
							<div class="hurt-arrow"><i class="icon-arrow"></i></div>
							</a>
						</li>

				{%/foreach%}
			{%/if%}
		</ul>
	</div>
</section>

	<script>
		var winHeight = window.innerHeight;
		var docHeight = document.body.offsetHeight;
		if(docHeight < winHeight){
			var style = document.createElement("style");
			style.innerHTML = "html,body{height:100%;}";
			document.body.appendChild(style);
		}
	</script>
{%/block%}
