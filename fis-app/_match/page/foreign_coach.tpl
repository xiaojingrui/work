{%extends file="common/page/layout.tpl"%}

{%block name="title"%}{%$profile.coach_full_name%}{%/block%}

{%block name="head_static"%}
    {%require name="common:static/js/zepto/zepto.js"%}
	{%require name="match:static/foreign_coach/foreign_coach.scss"%}
	<script type="text/javascript" src="//w1.hoopchina.com.cn/hybrid/common/hpbridge_v1.0.1.js"></script>
	{%script%}
		window.GM = {
            "client": "{%$client%}" || "x",
            "islogin": !!parseInt("{%$is_login%}", 10),
            "night":!!parseInt("{%$night%}", 10),
            "version":"{%$version%}"||"7.0.7",
            "player_name": "{%$profile.coach_full_name%}",
            "player_enname": "{%$profile.coach_enname%}",
            "isBirth": !!parseInt("{%$profile.is_birthday%}", 10)
        };

    {%/script%}
	{%require name="match:static/foreign_coach/foreign_coach.js"%}
{%/block%}

{%block name="content"%}
	<section class="foreign-coach-wrap">
		<section class="info">
			<div class="head">
				<img src="{%$profile.coach_header%}">
				{%if !empty($night)%}<div class="mask"></div>{%/if%}
			</div>
			<ul class="detail">
				<li>
					<span>{%$profile.team_name%}</span>
					<i class="separator">|</i>
					<span>{%$profile.country%}</span>
					<input type="hidden" class="coachid" value="{%$profile.coach_id%}">
				</li>
				<li>
					<span>{%$profile.role%}</span>
				</li>
				<li>
					<span>
						<span class="birth-status">
							<img src="//w1.hoopchina.com.cn/hybrid/resource/emoji/2x/1f382.png?t=1" width="15" height="15">
						</span>
						{%$profile.age%}
						<span class="birth-status">
							<img src="//w1.hoopchina.com.cn/hybrid/resource/emoji/1f382.png" width="15" height="15">
						</span>
					</span>
					{%if !empty($profile.age) && !empty($profile.birth_date)%}
						<i class="separator">|</i>
						<span id="J-birth-date">{%$profile.birth_date%}</span>
					{%/if%}
				</li>
			</ul>
		</section>
		<section class="other-info">
			<div class="info-item">

				<div class="info-label">
					加入球队
				</div>
				<div class="info-con">
					{%$profile.join_date%}
				</div>
			</div>
			<!-- 7.0.7不做 GDC无数据 -->
			<!-- <div class="info-item">
				<div class="info-label">
					合同到期
				</div>
				<div class="info-con">
					2018年7月6日
				</div>
			</div> -->
			{%if !empty($profile.season_record)%}
				<div class="info-item">
					<div class="info-label">
						联赛成绩
					</div>
					<div class="info-con">
						<span>共{%$profile.win+$profile.draw+$profile.lose%}场</span><span>{%$profile.season_record%}</span><span>胜率{%$profile.win_per%}</span>
					</div>
				</div>
			{%/if%}
			<div class="info-item">

				<div class="info-label">
					偏好阵型
				</div>
				<div class="info-con">
					{%if !empty($profile.prefer_tactic)%}
						<div class="tactic">
							<span>{%$profile.prefer_tactic%}</span>
							<em class="notice"></em>
						</div>
					{%else%}
						不详
					{%/if%}
				</div>
			</div>
		</section>
		{%if !empty($profile.intro)%}
			<section class="intro">
				{%if !empty($profile.intro)%}
					<h2>教练简介</h2>
					<p class="intro-con">{%$profile.intro%}</p>
				{%/if%}

				<!-- 教练页深度剖析 7.0.7 暂时没数据 -->
				<!-- <div class="analyze">
					<h2>深度剖析</h2>
					<ul>
						<li>
							<a href="#">
								<div class="link-title">
									<p class="title">极速80秒！感受下梅西与C罗逆天小技术</p>
									<span class="time">2015-20-21</span>
								</div>
								<em><i></i></em>
							</a>
						</li>
						<li>
							<a href="#">
								<div class="link-title">
									<p class="title">极速80秒！感受下梅西与C罗逆天小技术</p>
									<span class="time">2015-20-21</span>
								</div>
								<em><i></i></em>
							</a>
						</li>
					</ul>
				</div> -->
			</section>
		{%/if%}

		{%if !empty($profile.official_record)%}
		<section class="career">
			<div class="summary">
				<h2>执教生涯</h2>
				<!-- <div class="info-item">
					<div class="info-label">
						执教时间
					</div>
					<div class="info-con">
						24年（自1980年）
					</div>
				</div>
				<div class="info-item">
					<div class="info-label">
						生涯执教胜率
					</div>
					<div class="info-con">
						61%胜 19.5%平 19％负
					</div>
				</div> -->
			</div>
			<div class="list">
				<table>
					<tr>
						<th>时间</th>
						<th>球队</th>
						<th>比赛数</th>
						<th>胜率</th>
					</tr>
					{%foreach $profile.official_record as $val%}
						<tr>
							<td>{%$val.appointed_date%} - {%$val.until_date%}</td>
							<td>{%$val.team_name%}</td>
							<td><span class="match">{%$val.matches%}</span></td>
							<td><span class="rate">{%$val.rate%}</span></td>
						</tr>
					{%/foreach%}
				</table>
			</div>
		</section>
		{%/if%}
		<div class="source">
			<div>数据支持：</div>
		</div>

		{%if !empty($profile.official_tactic)%}
			<div class="cover"></div>
			<div class="formation m-hide">
				<div class="bd">
					<div class="title">
						最近{%$profile.total_tactic%}场比赛所使用的首发阵型统计：
					</div>
					<div class="sum-wrap">
						{%foreach $profile.official_tactic as $val%}
						<div class="sum-item">
							<span class="tactic-name">{%$val.tactic_name%}</span>
							<span>{%$val.used_times%}</span>
						</div>
						{%/foreach%}
					</div>
					<!-- <div class="sum-item">
						<span>4-3-2-1  </span>
						<span>20场</span>
					</div>
					<div class="sum-item">
						<span>4-3-2-1  </span>
						<span>20场</span>
					</div>
					<div class="sum-item">
						<span>4-3-2-1  </span>
						<span>20场</span>
					</div>
					<div class="sum-item">
						<span>4-3-2-1  </span>
						<span>20场</span>
					</div> -->
				</div>
				<div class="close">
					关闭
				</div>
			</div>
		{%/if%}
	</section>
{%/block%}
