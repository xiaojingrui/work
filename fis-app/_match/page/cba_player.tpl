{%extends file="common/page/layout.tpl"%}

{%block name="title"%}{%$result.profile.player_name%}{%/block%}
{%block name="head_static"%}
		{%require name="common:static/js/underscore/underscore.js"%}
    {%require name="common:static/js/zepto/zepto.js"%}
    {%require name="common:static/js/swiper/js/swiper.jquery.js"%}
    {%require name="common:static/js/swiper/css/swiper.css"%}
	{%require name="match:static/page/cba_player.scss"%}
	<script type="text/javascript" src="//w10.hoopchina.com.cn/hybrid/common/hpbridge_v1.0.2.js"></script>
	{%script%}
		window.GM = {
            "client": "{%$client%}" || "x",
            "islogin": !!parseInt("{%$is_login%}", 10),
            "player_name": "{%$result.profile.player_name%}",
            "player_enname": "{%$result.profile.player_enname%}",
            "player_id": "{%$result.profile.player_id%}",
            "version": "{%$result.version%}" || "x",
            "night":!!parseInt("{%$night%}", 10),
            "isBirth": !!parseInt("{%$result.profile.is_birthday%}", 10)
        };
        var cbaPlayer = require("match:widget/cba_player/cba_player.js");
        cbaPlayer.init();
    {%/script%}
{%/block%}

{%block name="content"%}
	<section class="cba-player-wrap">
		<section class="info">
			<div class="head">
				<img src="{%$result.profile.player_header%}">
				{%if !empty($night)%}<div class="mask"></div>{%/if%}
			</div>
			<ul class="detail">
				<li>
					<span>{%$result.profile.team_name%}</span>
					{%if !empty($result.profile.team_name) || !empty($result.profile.team_number) && !empty($result.profile.position)%}
					<i class="separator">|</i>
					{%/if%}
					{%if $result.profile.team_number != "" %}
					<span>{%$result.profile.team_number%}号</span>
					{%/if%}
					{%if $result.profile.team_number != "" && !empty($result.profile.position) %}
					<i class="separator">|</i>
					{%/if%}
					<span>{%$result.profile.position%}</span>
					<input type="hidden" class="playerid" value="{%$result.profile.player_id%}">
				</li>
				<li>
					<span>
						<span class="birth-status J-birth-status">
							<img src="//w1.hoopchina.com.cn/hybrid/resource/emoji/2x/1f382.png?t=1" width="15" height="15">
						</span>
						{%$result.profile.age%}
						<span class="birth-status J-birth-status">
							<img src="//w1.hoopchina.com.cn/hybrid/resource/emoji/1f382.png" width="15" height="15">
						</span>
					</span>
					{%if !empty($result.profile.age) && !empty($result.profile.birth_date)%}
					<i class="separator">|</i>
					{%/if%}
					<span id="J-birth-date">{%$result.profile.birth_date%}</span>
				</li>
				<li>
					<span>{%$result.profile.height%}</span>
					{%if !empty($result.profile.height) && !empty($result.profile.weight)%}
					<i class="separator">|</i>
					{%/if%}
					<span>{%$result.profile.weight%}</span>
				</li>
			</ul>
		</section>
		<ul class="tab clearfix" id="J-tab">
			<li class="active">资料</li>
			<li>新闻</li>
		</ul>
		<!--
		<div class='no-news'><p>暂无该球员相关新闻</p></div>
		-->
		<div class="swiper-container">
			<div class="swiper-wrapper">
				<div class="swiper-slide player-height">
					<div class="slideWrap">
						<section class="data">
							<h2>赛季数据</h2>
							<ul class="main clearfix">
								{%foreach $result["season_stats"] as $val%}
									<a href='{%if $result.ranks[$val[2]] != "-"%}/cba/getPlayerAllPreRank?type={%$val[2]%}&page=1&client={%$client%}&night={%$night%}&entrance=1{%else%}javascript:void(0) {%/if%}'>
										<li>
											<div class="num">{%$val[1]%}</div>
											<div class="type">{%$val[0]%}</div>
											{%if $result.ranks[$val[2]] != "-"%}
												<div class="cba_rank">
														<span>
															联盟第
															<b>{%$result.ranks[$val[2]]%}</b>
															<i></i>
														</span>
												</div>
											{%/if%}
										</li>
									</a>
								{%/foreach%}
							</ul>
						</section>
						{%if !empty($result.profile.info)%}
							<section class="intro border_top">
								<h2>球员简介</h2>
								<p>{%$result.profile.info%}</p>
							</section>
						{%/if%}
						<div class="analyze">
				      <a href="https://nba.hupu.com/wiki/%E8%BF%9B%E9%98%B6%E6%95%B0%E6%8D%AE">
			          <div class="link-title">
		              <p class="title">虎扑篮球百科：真实命中率、有效命中率等数据说明</p>
		              <i></i>
			          </div>
				      </a>
			     </div>
		     </div>
				</div>
				<div class="swiper-slide" style="height: 100%;">
					<div class='no-news'><p>暂无该球员相关新闻</p></div>
					 <section class="t-content t-news" id="J-t-news">
                <ul id="J-news-wrap">
                    <script id="J-news-tpl" type="text/template">
                        <@ $(datas).each(function(index,item){ @>
                        <li>
                            <a href="<@=item.app_url@>">
                                <div class="pic" style="background-image:url(<@=item.img@>);"></div>
                                <div class="text">
                                    <div class="title"><@=item.title@></div>
                                    <div class="intro"><@=item.summary@></div>
                                </div>
                                <div class="comment"><i></i><@=item.replies@></div>
                            </a>
                        </li>
                        <@ }); @>
                    </script>
                </ul>
            </section>
					</div>
			</div>
		</div>
	</section>
{%/block%}
