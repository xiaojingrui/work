<section class="mod-rank swiper-slide swiper-no-swiping" id="{%if $code == "w173"%}J-asia{%else if $code == "w172"%}J-europe{%else if $code == "w174"%}J-s-america{%else if $code == "w175"%}J-nc-america{%else if $code == "w176"%}J-africa{%else if $code == "w177"%}J-oceanica{%/if%}">
	<div class="main">
		{%if !empty($data[$code])%}
			{%foreach $data[$code] as $val%}
			<table class="mod-title title">
				<thead>
					<td width="10%" align="center">
						{%if $code == "w174" || $code == "w175"%}
							排行
						{%else%}
							{%if $val@index == 0%}A{%else if $val@index == 1%}B{%else if $val@index == 2%}C{%else if $val@index == 3%}D{%else if $val@index == 4%}E{%else if $val@index == 5%}F{%else if $val@index == 6%}G{%else if $val@index == 7%}H{%else if $val@index == 8%}I{%/if%}组
						{%/if%}
					</td>
					<td width="32%" colspan="2" align="left">球队</td>
					<td width="10%" align="center">场次</td>
					<td width="7%" align="center">胜</td>
					<td width="7%" align="center">平</td>
					<td width="7%" align="center">负</td>
					<td width="17%" align="center">进/失</td>
					<td width="10%" align="center">积分</td>
				</thead>
			</table>
			<table class="mod-table">
				<tbody>
					{%foreach $val as $subVal%}
					<tr class="tap {%if !empty($subVal.tid)%}link{%/if%}" {%if !empty($subVal.tid)%}link="kanqiu://soccerleagues/{%$league_name%}/team/{%$subVal.tid%}"{%/if%}>
	    				<td width="10%" align="center">
							{%**
							* 亚洲 w173
							* 小组前二出线（标红色），小组第三进附加赛（标黄色）
							*
							* 欧洲 w172
							* 小组第一出线（标红色），小组第二进下一轮（标黄色）
							*
							* 南美 w174
							* 小组前四出线（标红色），小组第五进下一轮（标黄色）
							*
							* 中北美 w175
							* 小组前二出线（标红色） :第五轮规则 小组前三出线（标红色），小组第四进下一轮（标黄色）
							*
							* 非洲 w176
							* 小组第一出线（标红色）
							*
							* 大洋洲 w177
							* 小组第一进下一轮（标黄色）
							*
							**%}
	                        <span class="num
							{%if $code == "w173"%}
								{%if $subVal.rank < 3%}
								red
								{%else if $subVal.rank == 3%}
								yellow
								{%/if%}
							{%else if $code == "w172"%}
								{%if $subVal.rank == 1%}
								red
								{%else if $subVal.rank == 2%}
								yellow
								{%/if%}
							{%else if $code == "w174"%}
								{%if $subVal.rank < 5%}
								red
								{%else if $subVal.rank == 5%}
								yellow
								{%/if%}
							{%else if $code == "w175"%}
								{%if $subVal.rank < 4%}
								red
								{%else if $subVal.rank == 4%}
								yellow
								{%/if%}
							{%else if $code == "w176"%}
								{%if $subVal.rank == 1%}
								red
								{%/if%}
							{%else if $code == "w177"%}
								{%if $subVal.rank == 1%}
								yellow
								{%/if%}
							{%/if%}
							">{%$subVal.rank%}</span>
	                    </td>
	                    <td width="10%" align="left">
	    					<span class="logo"><img class="lazy" width="28" data-original="{%$subVal.logo%}?{%$val@index%}{%$subVal@index%}" /></span>
	                    </td>
	                    <td width="22%" align="left">{%$subVal.name%}</td>
						<td width="10%" align="center">{%$subVal.mp%}</td>
	    				<td width="7%" align="center">{%$subVal.won%}</td>
	    				<td width="7%" align="center">{%$subVal.draw%}</td>
	    				<td width="7%" align="center">{%$subVal.lose%}</td>
	                    <td width="17%" align="center">{%$subVal.gf%}/{%$subVal.ga%}</td>
	                    <td width="10%" align="center">{%$subVal.pts%}</td>
	    			</tr>
					{%/foreach%}
				</tbody>
			</table>
			{%/foreach%}
			<div class="rule {%if $code == "w176"%}short-rule{%/if%}">
				<i></i>
				{%if $code == "w173"%}
				<p>当前为亚洲区第3轮，小组前两名直接出线，两个组的第三名进入亚洲区第4轮进行主客场对决，胜者将与中北美赛区第5轮的小组第四进行附加赛，胜者出线。</p>
				{%else if $code == "w172"%}
				<p>当前为欧洲区第1轮，九个小组的第一直接出线，八个成绩最好的第二名进入第2轮，分四组进行主客场对决，四个胜者出线。</p>
				{%else if $code == "w174"%}
				<p>南美十支球队将进行主客场双循环比赛，前四名直接出线，第五名将与大洋洲胜者进行附加赛，胜者出线。</p>
				{%else if $code == "w175"%}
				<p>当前为中北美区第5轮，六支队伍在一个组内进行主客场对决，前三名出线，第四名将与亚洲区第4轮的胜者进行附加赛，胜者出线。</p>
				{%else if $code == "w176"%}
				<p class="short">当前为非洲区第3轮，五个小组的第一名出线。</p>
				{%else if $code == "w177"%}
				<p>当前为大洋洲区第3轮，两个小组的第一名将进行主客场对决，胜者将与南美洲第五名进行附加赛，胜者出线。</p>
				{%/if%}
			</div>
		{%else%}
			<div class="no-data">暂无数据</div>
		{%/if%}
	</div>
</section>
