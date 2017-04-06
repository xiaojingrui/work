<section class="mod-rank {%if $type == "men"%}men-football{%else if $type == "women"%}women-football{%/if%} football-wrap swiper-slide swiper-no-swiping" id="{%if $type == "men"%}J-men-football{%else if $type == "women"%}J-women-football{%/if%}">
    {%if !empty($against_figure[$index-1])%}
        {%widget
            name="match:widget/vs_soccer_data/vs_soccer_data.tpl"
            leagueName=$league_name
            type=$type
            index=$index
        %}
    {%/if%}
    {%if !empty($rank[$index].ranks_data["A"]) || !empty($rank[$index].ranks_data["B"]) || !empty($rank[$index].ranks_data["C"]) || !empty($rank[$index].ranks_data["D"]) || !empty($rank[$index].ranks_data["E"]) || !empty($rank[$index].ranks_data["F"]) || !empty($rank[$index].ranks_data["G"])%}
        {%foreach $rank[$index].ranks_data as $val%}
    	<table class="mod-title">
    		<thead>
    			<tr>
    				<td width="8%" align="center">
                        {%if $type == "men"%}
                            {%if $val@index == 0%}A{%else if $val@index == 1%}B{%else if $val@index == 2%}C{%else if $val@index == 3%}D{%/if%}组
                        {%else if $type == "women"%}
                            {%if $val@index == 0%}E{%else if $val@index == 1%}F{%else if $val@index == 2%}G{%/if%}组
                        {%/if%}
                    </td>
    				<td width="34%" colspan="2" align="left">球队</td>
    				<td width="10%" align="center">场次</td>
    				<td width="7%" align="center">胜</td>
    				<td width="7%" align="center">平</td>
                    <td width="7%" align="center">负</td>
                    <td width="17%" align="center">进/失</td>
                    <td width="10%" align="center">积分</td>
    			</tr>
    		</thead>
    	</table>
    	<table class="mod-table">
    		<tbody>
    			{%foreach $val as $subVal%}
    			<tr class="tap">
    				<td width="8%" align="center">
                        <span class="num
                        {%if $type == "men"%}
                            {%if $subVal@index+1<3%}red{%/if%}
                        {%else if $type == "women"%}
                            {%if $subVal@index+1<4%}red{%/if%}
                        {%/if%}
                        ">{%$subVal@index+1%}</span>
                    </td>
                    <td width="10%" align="left">
    					<span class="logo"><img class="lazy" width="28" data-original="{%$subVal.logo%}?{%$val@index%}{%$subVal@index%}" /></span>
                    </td>
                    <td width="24%" align="left">{%$subVal.name%}</td>
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
    {%else%}
        <div class="no-data">暂无{%if $type == "men"%}男{%else%}女{%/if%}足数据</div>
    {%/if%}
</section>
