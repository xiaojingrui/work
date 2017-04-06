<section class="trade-info mod-rank swiper-slide swiper-no-swiping" id="J-trade-info">
	<script id="J-trade-info-tpl" type="text/template">
		<div class="nav">
			<ul>
				<@ $(datas).each(function(index,item) { @>
				<li <@ if(index==0){ @> class="active" <@ } @>><a href="javascript:void(0);"><@=item.name@></a></li>
				<@ }); @>
			</ul>
		</div>
		<ul class="main">
			<@ $(datas).each(function(index,item) { @>
			<li>
				<@ if(item.en == "trade"){ @>
				<table class="mod-title title">
					<thead>
						<tr>
							<td width="40%" class="type" colspan="2"><@=item.name@></td>
							<td width="30%" align="left" class="th3">送出</td>
							<td width="30%" align="left" class="th4">得到</td>
						</tr>
					</thead>
				</table>
				<table class="mod-table special-table">
					<tbody>
						<@ if(item.data.length!=0){ @>
							<@ $(item.data).each(function(subIndex,subItem){ @>
								<@ $(subItem).each(function(subSubIndex,subSubItem){ @>
									<tr class="link" link="kanqiu://nba/nba/team/<@=subSubItem.tid@>">
										<td width="15%" valign="top">
											<span class="logo"><img class="lazy" data-original="<@=subSubItem.logo@>?t=<@=index@><@=subIndex@><@=subSubIndex@>"/></span>
										</td>
										<td width="25%" class="td2" valign="top"><@=subSubItem.name@></td>
										<td width="30%" align="left" valign="top" class="td3">
											<div><@=subSubItem.cost@></div>
										</td>
										<td width="30%" align="left" valign="top" class="td4">
											<div><@=subSubItem.earn@></div>
										</td>
									</tr>
									<@ if(subSubIndex+1 == $(item.data[subIndex]).length && subIndex+1 != $(item.data).length){ @>
									<tr>
										<td colspan="4" class="line"></td>
									</tr>
									<@ } @>
								<@ }); @>
							<@ }); @>
							<@ if(item.is_more){ @>
							<tr class="last-tr">
								<td colspan="4" align="center">
									<span class="view-all link all-link" link="<@=item.allURL@>">查看全部 ></span>
								</td>
							</tr>
							<@ } @>
						<@ }else{ @>
						<tr>
							<td align="center" class="no-data">暂无球员变动</td>
						</tr>
						<@ } @>
					</tbody>
				</table>
				<@ }else{ @>
				<table class="mod-title title">
					<thead>
						<tr>
							<td width="50%" class="type" colspan="2"><@=item.name@></td>
							<td width="25%" align="center">原球队</td>
							<td width="25%" align="center"><@ if(item.en == "free"){ @>备注<@ }else{ @>新球队<@ } @></td>
						</tr>
					</thead>
				</table>
				<table class="mod-table">
					<tbody>
						<@ if($(item.data).length!=0){ @>
						<@ $(item.data).each(function(subIndex,subItem){ @>
						<tr class="link" link="kanqiu://nba/nba/player/<@=subItem.hupu_pid@>">
							<td>
								<table class="data-table">
									<tr>
										<td width="15%" <@ if(item.en != "free" && subItem.memo){ @>rowspan="2" valign="top"<@ } @>>
											<span class="logo"><img class="lazy" data-original="<@=subItem.photo@>?t=<@=index@><@=subIndex@>"/><@if(GM.night){ @><span class="mask"></span><@ } @></span>
										</td>
										<td width="35%" class="td2"><@=subItem.alias@></td>
										<td width="25%" align="center" class="td3"><@=subItem.from_team_name@></td>
										<td width="25%" <@ if(item.en == "free"){ @>align="left"<@ }else{ @>align="center"<@ } @>class="td4">
											<@ if(item.en == "free"){ @>
											<@=subItem.memo@>
											<@ }else{ @>
											<@=subItem.to_team_name@>
											<@ } @>
										</td>
									</tr>
									<@ if(item.en != "free" && subItem.memo){ @>
									<tr>
										<td colspan="3" class="contract"><@=subItem.memo@></td>
									</tr>
									<@ } @>
								</table>
							</td>
						</tr>
						<@ }); @>
							<@ if(item.is_more){ @>
							<tr class="last-tr">
								<td colspan="4" align="center">
									<span class="view-all link all-link" link="<@=item.allURL@>">查看全部 ></span>
								</td>
							</tr>
							<@ } @>
						<@ }else{ @>
						<tr>
							<td align="center" class="no-data">暂无球员变动</td>
						</tr>
						<@ } @>
					</tbody>
				</table>
				<@ } @>
			</li>
			<@ }); @>
		</ul>
	</script>
</section>
