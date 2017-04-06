<section class="mod-rank gold-rank swiper-slide swiper-no-swiping" id="J-gold-rank">
	<table class="mod-title">
		<thead>
			<tr>
				<td width="12%" align="center">排行</td>
				<td width="40%" colspan="2" align="left">国家/地区</td>
				<td width="12%" align="center" class="gold">金牌</td>
				<td width="12%" align="center" class="silver">银牌</td>
				<td width="12%" align="center" class="bronze">铜牌</td>
                <td width="12%" align="center">总数</td>
			</tr>
		</thead>
	</table>
	<table class="mod-table">
		<tbody>
		{%if !empty($rank[0].ranks_data)%}
			{%foreach $rank[0].ranks_data as $val%}
			<tr class="tap">
				<td width="12%" align="center">
                    <span class="num">{%$val@index+1%}</span>
                </td>
                <td width="12%" align="left">
					<span class="logo"><img class="lazy" width="28" data-original="{%$val.logo%}?{%$val@index%}" /></span>
                </td>
                <td width="28%" align="left">{%$val.name%}</td>
				<td width="12%" align="center">{%$val.gold%}</td>
				<td width="12%" align="center">{%$val.silver%}</td>
				<td width="12%" align="center">{%$val.bronze%}</td>
				<td width="12%" align="center">{%$val.total%}</td>
			</tr>
			{%/foreach%}
        {%else%}
        	<div class="no-data">暂无排行榜数据</div>
		{%/if%}
		</tbody>
	</table>
</section>
