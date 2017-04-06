{%extends file="common/page/layout.tpl"%}

{%block name="title"%}
	{%if !empty($profile.player_full_name) || !empty($profile.player_enname)%}
		{%if !empty($profile.player_full_name)%}
			{%$profile.player_full_name%}
		{%else%}
			{%$profile.player_enname%}
		{%/if%}
	{%else%}
		饮水机守护神
	{%/if%}
{%/block%}

{%block name="head_static"%}
	{%require name="common:static/js/zepto/zepto.js"%}
	{%require name="common:static/js/swiper/js/swiper.jquery.js"%}
    {%require name="common:static/js/swiper/css/swiper.css"%}
	{%require name="match:static/foreign_soccer_player/foreign_soccer_player.scss"%}
	<script type="text/javascript" src="//w1.hoopchina.com.cn/hybrid/common/hpbridge_v1.0.1.js"></script>
	{%require name="match:static/foreign_soccer_player/foreign_soccer_player.js"%}

	{%script%}
		window.GM = {
            "client": "{%$client%}" || "x",
            "islogin": !!parseInt("{%$is_login%}", 10),
            "night":!!parseInt("{%$night%}", 10),
            "version":"{%$version%}"||"7.0.7",
            "player_name": "{%$profile.player_full_name%}" || "",
            "player_enname": "{%$profile.player_enname%}",
            "isBirth": !!parseInt("{%$profile.is_birthday%}", 10)
        };

        var birth = require("match:widget/birth/birth.js");
        var localKey = "soccerplayer_" + $(".playerid").val() + "_dropTimes";
        birth.init(localKey);
    {%/script%}
{%/block%}

{%block name="content"%}
	<div class="foreign-player-wrap">
		<section class="info">
			<div class="head">
				<img src="{%$profile.player_header%}">
				{%if !empty($night)%}<div class="mask"></div>{%/if%}
			</div>
			<ul class="detail">
				{%if $team_info|count != 0%}
				<li>
					{%foreach $team_info as $val%}
						{%if $val@index !=0%}<i class="separator">|</i>{%/if%}
						<span>{%$val.name%}</span>
						<span>{%if !empty($val.number)%}{%$val.number%}号{%/if%}</span>
						{%if $val.is_captain%}
							<span class="captain">c</span>
						{%/if%}
					{%/foreach%}
				</li>
				{%/if%}
				{%if !empty($profile.country)%}
				<li>
					<span>国籍 {%$profile.country|default:"不详"%}</span>
				</li>
				{%/if%}
				{%if $profile.height!="" || $profile.weight!="" || $profile.foot!=""%}
				<li>
					<span>{%if $profile.height!="不详"%}{%$profile.height%}{%/if%}</span>
					{%if $profile.height!="不详" && $profile.weight!="不详"%}<i class="separator">|</i>{%/if%}
					<span>{%if $profile.weight!="不详"%}{%$profile.weight%}{%/if%}</span>
					{%if $profile.foot!="不详"%}<i class="separator">|</i>{%/if%}
					<span>{%if $profile.foot!="不详"%}{%$profile.foot%}{%/if%}</span>
				</li>
				{%/if%}
			</ul>
		</section>

		<ul class="tab" id="J-tab">
			<li class="tab-info active">资料</li>
			<li class="tab-data">数据</li>
		</ul>
		<div class="swiper-container">
			<div class="swiper-wrapper">
				<div class="swiper-slide swiper-info" id="">
					<section class="base-info">
						<div class="base-item">
							<span id="J-birth-date">{%$profile.birth_date|default:"不详"%}</span>
							<strong>
								<i class="birth-status">
									<img src="//w1.hoopchina.com.cn/hybrid/resource/emoji/2x/1f382.png?t=1" width="15" height="15">
								</i>
								{%$profile.age|default:"不详"%}
								<i class="birth-status">
									<img src="//w1.hoopchina.com.cn/hybrid/resource/emoji/1f382.png" width="15" height="15">
								</i>
							</strong>
						</div>
						<div class="base-item">
							<span>参考身价</span>
							<strong>{%$profile.salary|default:"不详"%}</strong>
						</div>
						<div class="base-item">
							<span>合同到期</span>
							<strong>{%$profile.contract_until|default:"不详"%}</strong>
						</div>
					</section>

					</section>
					{%if !empty($profile.detailed_position)%}
						<section class="position">
						<h2>球场位置</h2>
						<!-- <div class="position-info">
							<span><em>主要</em>左边锋</span>
							<span><em>其他</em>右边锋、攻击型中场</span>
						</div> -->
						<div class="court-wrap">
							<div class="court-bg">
								{%if !empty($profile.detailed_position.main_position)%}
									<div class="pos pos{%$profile.detailed_position.main_position.type%} main">
										<span></span>
										<em>{%$profile.detailed_position.main_position.name_zh%}(主要)</em>
									</div>
								{%/if%}
								{%if !empty($profile.detailed_position.side_position)%}
								{%foreach $profile.detailed_position.side_position as $val%}
									<div class="pos pos{%$val.type%}">
										<span></span>
										<em>{%$val.name_zh%}</em>
									</div>
								{%/foreach%}
								{%/if%}
								<!-- <div class="pos pos1"></div>
								<div class="pos pos2"></div>
								<div class="pos pos3"></div>
								<div class="pos pos4"><span></span><em>攻击型中场</em></div>
								<div class="pos pos5"><span></span><em>右边锋</em></div>
								<div class="pos pos6"></div>
								<div class="pos pos7 main"><span></span><em>左边锋(主)</em></div>
								<div class="pos pos8"></div>
								<div class="pos pos9"></div>
								<div class="pos pos10"></div>
								<div class="pos pos11"></div>
								<div class="pos pos12"></div>
								<div class="pos pos13"></div>
								<div class="pos pos14"></div> -->
							</div>
							<div class="hupu-logo"></div>
						</div>
						</section>
					{%/if%}
					{%if !empty($profile.intro) || !empty($profile.depth_profiling)%}
					<section class="intro">
						{%if !empty($profile.intro)%}
							<h2>球员简介</h2>
							<p class="intro-con">{%$profile.intro%}</p>
						{%/if%}

						{%if !empty($profile.depth_profiling)%}
						<div class="analyze">
							<h2>深度剖析</h2>
							<ul>
							{%foreach $profile.depth_profiling as $val%}
								<li>
									<a href="{%$val.depth_link%}" dace-node="weblinks">
										<div class="link-title">
											<p class="title">{%$val.depth_title%}</p>
											<span class="time">{%$val.depth_date%}</span>
										</div>
										<em><i></i></em>
									</a>
								</li>
							{%/foreach%}
							</ul>
						</div>
						{%/if%}
					</section>
					{%/if%}
					{%if !empty($profile.player_video)%}
						<section class="video">
							<h2>球员视频</h2>
							{%foreach $profile.player_video as $val%}
								<a href="{%$val.video_link%}" class="video-link" dace-node="playervideo">
									<div class="video-img">
										<em></em>
										<img data-src="{%$val.video_thumbnails%}" class="swiper-lazy" alt="">
									</div>
									<p>{%$val.video_title%}</p>
								</a>
							{%/foreach%}
						</section>
					{%/if%}

					<!-- {%if !empty($stats[0].season_data)%}
					<section class="season-data">
						<h2>赛季数据&nbsp;&nbsp;{%$team_info[0].name%}</h2>
						<div class="data-info">
							{%foreach $stats[0].season_data as $val%}
								<div class="base-data">
									<span>{%$val[0]%}</span>
									<strong>{%$val[1]%}</strong>
								</div>
							{%/foreach%}
						</div>
					</section>
					{%/if%} -->

					<!-- {%if !empty($stats[1].season_data)%}
					<section class="season-data">
						<h2>赛季数据&nbsp;&nbsp;{%$team_info[1].name%}</h2>
						<div class="data-info">
							{%foreach $stats[1].season_data as $val%}
								<div class="base-data">
									<span>{%$val[0]%}</span>
									<strong>{%$val[1]%}</strong>
								</div>
							{%/foreach%}
						</div>
					</section>
					{%/if%} -->
					<div class="source">
						<div>数据支持：</div>
					</div>
				</div>
				<div class="swiper-slide swiper-data" id="">
					{%if !empty($team_info[0].name)%}
					<section class="season-data">
						<h2>{%if $team_info[0].is_country%}{%$team_info[0].league_name%}{%else%}{%$team_info[0].season_str%}{%/if%}&nbsp;&nbsp;{%$team_info[0].name%}</h2>
						<div class="data-info">
							{%foreach $stats[0].season_data as $val%}
								<div class="base-data">
									<span>{%$val[0]%}</span>
									<strong>{%$val[1]%}</strong>
								</div>
							{%/foreach%}
						</div>
						{%if !empty($stats[0].total_data)%}
						<div class="data-table">
							<div class="table-title">
								<table class="table">
										<tr>
											<th>赛事</th>
										</tr>
										{%foreach $stats[0].total_data as $val%}
										<tr>
											<td>{%$val.block%}</td>
										</tr>
										{%/foreach%}
								</table>
							</div>
							<div class="table-scroll swiper-no-swiping">
								<table class="table">
									<tr>
										{%foreach $stats[0].total_data[0].data as $val%}
											<th>{%$val[0]%}</th>
										{%/foreach%}
									</tr>
									{%foreach $stats[0].total_data as $key%}
										<tr>
											{%foreach $key.data as $val%}
												<td>{%$val[1]%}</td>
											{%/foreach%}
										</tr>
									{%/foreach%}
								</table>
							</div>
						</div>
						{%/if%}
					</section>
					{%/if%}

					{%if !empty($team_info[1].name)%}
					<section class="season-data">
						<h2>{%if $team_info[1].is_country%}{%$team_info[1].league_name%}{%else%}{%$team_info[1].season_str%}{%/if%}&nbsp;&nbsp;{%$team_info[1].name%}</h2>
						<div class="data-info">
							{%foreach $stats[1].season_data as $val%}
								<div class="base-data">
									<span>{%$val[0]%}</span>
									<strong>{%$val[1]%}</strong>
								</div>
							{%/foreach%}
						</div>
						{%if !empty($stats[1].total_data)%}
						<div class="data-table">
							<div class="table-title">
								<table class="table">
										<tr>
											<th>赛事</th>
										</tr>
										{%foreach $stats[1].total_data as $val%}
										<tr>
											<td>{%$val.block%}</td>
										</tr>
										{%/foreach%}
								</table>
							</div>
							<div class="table-scroll swiper-no-swiping">

								<table class="table">
									<tr>
										{%foreach $stats[1].total_data[0].data as $val%}
											<th>{%$val[0]%}</th>
										{%/foreach%}
									</tr>
									{%foreach $stats[1].total_data as $key%}
										<tr>
											{%foreach $key.data as $val%}
												<td>{%$val[1]%}</td>
											{%/foreach%}
										</tr>
									{%/foreach%}
								</table>
							</div>
						</div>
						{%/if%}
					</section>
					{%/if%}
					{%if !empty($profile.transfer_history)%}
					<section class="transfer">
						<h2>转会纪录</h2>
						<div class="table-wrap">
							<table>
								<tr>
									<th>时间</th>
									<th>转会至</th>
									<th>转会费</th>
								</tr>
								{%foreach $profile.transfer_history as $val%}
								<tr>
									<td>{%$val.transfer_date%}</td>
									<td>{%$val.moving_to_team_name%}</td>
									<td>
										{%if !empty({%$val.loan%})%}
											{%$val.loan%}
										{%else%}
											{%$val.transfer_fee%}
										{%/if%}
									</td>
								</tr>
								{%/foreach%}
							</table>
						</div>
					</section>
					{%/if%}
					{%if !empty($profile.performance)%}
					<section class="career-history">
						<h2>职业生涯</h2>
						<div class="table-wrap">
							<table>
								<tr>
									<th><span>球队</span></th>
									<th>进球</th>
									<th>助攻</th>
								</tr>
								{%foreach $profile.performance as $val%}
								<tr>
									<td>{%$val.team_name%}</td>
									<td>
									<span>
									{%if !empty($val.goals)%}
										{%$val.goals%}
									{%else%}
										-
									{%/if%}
									</span>
									</td>
									<td>
									<span>
										{%if !empty($val.assists)%}
											{%$val.assists%}
										{%else%}
											-
										{%/if%}
									</span>
									</td>
								</tr>
								{%/foreach%}
							</table>
						</div>
						<p><em></em><span>{%$desc%}</span></p>
					</section>
					{%/if%}
					<div class="source">
						<div>数据支持：</div>
					</div>
				</div>
			</div>
		</div>



	</div>
{%/block%}
