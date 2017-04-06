<section class="team-rank swiper-slide swiper-no-swiping" id="J-team-rank">
	<div class="main">
		<table class="mod-title">
			<thead>
				<tr>
					<td width="40%" class="type">球队</td>
					<td width="20%" align="center">场次</td>
					<td width="10%" align="center">胜</td>
					<td width="10%" align="center">负</td>
					<td width="20%" align="center">胜率</td>
				</tr>
			</thead>
		</table>
		<table class="mod-table">
			<tbody>
				{%foreach $standings as $val%}
				<tr class="link" link="kanqiu://cba/cba/team/{%$val.id%}">
					<td width="40%">
						{%if $val@index+1<=8 %}
						<span class="red num">{%$val@index+1%}</span>
						{%else%}
						<span class="num">{%$val@index+1%}</span>
						{%/if%}<span class="logo"><img class="swiper-lazy" data-src="//b1.hoopchina.com.cn/games/teams/cba/2_{%$val.id%}{%if ($val['id'] == 14) or ($val['id'] == 21)%}_new{%/if%}{%if ($val['id'] == 12)%}_1{%/if%}.png" width="28" /></span><span class="name">{%$val.name%}</span>
					</td>
					<td width="20%" align="center">{%$val.bout%}</td>
					<td width="10%" align="center">{%$val.win%}</td>
					<td width="10%" align="center">{%$val.los%}</td>
					<td width="20%" align="center">{%$val.rate%}</td>
				</tr>
				{%/foreach%}
			</tbody>
		</table>
	</div>
</section>
