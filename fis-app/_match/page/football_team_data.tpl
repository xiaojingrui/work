{%extends file="common/page/layout.tpl"%}

{%block name="title"%}足球球队页{%/block%}

{%block name="head_static"%}
	{%require name="common:static/js/zepto/zepto.js"%}

	<script type="text/javascript" src="//w1.hoopchina.com.cn/hybrid/common/hpbridge_v1.0.1.js"></script>
	{%require name="match:static/page/football_team_data.scss"%}
{%/block%}
final_ent_avg saves goals_setpiece
{%block name="content"%}
	<section class="football-team-data">
		<div class="data-list">
			<ul>
				{%foreach from=$data item=val key=key%}
					<li>
						<a href="/data/footballAllRank?client={%$client%}&league_name={%$league_name%}&rank_type={%$key%}&from_type=2%}">
							{%if $key == possession_percentage || $key == pass_per%}
								<div class="score">{%($val.value_avg*100)|round:1%}%</div>
							{%elseif $key == goals || $key == goals_conceded || $key == clean_sheet || $key == total_yel_card  || $key == total_red_card%}
								<div class="score">{%$val.value_count%}</div>
							{%else%}
								<div class="score">{%$val.value_avg%}</div>
							{%/if%}
							<div>{%$val.title%}</div>
							{%if $val.rank_index != "-"%}
								<span>联赛第<b>{%$val.rank_index%}</b><img height=9; src="../static/page/img/arrow-right-day.png" alt="arrow"></span>
							{%/if%}
						</a>
					</li>
				{%/foreach%}				
			</ul>
		</div>
	</section>
{%/block%}
