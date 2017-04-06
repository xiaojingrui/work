<section class="draft-result mod-rank swiper-slide swiper-no-swiping" id="J-draft-result">
	<script id="J-draft-result-tpl" type="text/template">
		<div class="nav">
			<ul>
				<@ $(datas).each(function(index,item) { @>
				<li <@ if(index==0){ @> class="active" <@ } @>><a href="javascript:void(0);"><@=item.name@></a></li>
				<@ }); @>
			</ul>
		</div>
		<ul class="main">
			<@ if($(datas)[0].data.length>0 || $(datas)[1].data.length>0){ @>
				<@ $(datas).each(function(index,item) { @>
				<li>
					<table class="mod-title title">
						<thead>
							<tr>
								<td width="100" colspan="5" class="type"><@=item.name@></td>
							</tr>
						</thead>
					</table>
					<table class="mod-table">
						<tbody>
							<@ $(item.data).each(function(subIndex,subItem){ @>
							<tr class="link" link="kanqiu://nba/nba/player/<@=subItem.hupuid@>">
								<td width="8%" align="center"><span class="num"><@=subIndex+1@></span></td>
								<td width="20%" class="td2"><@=subItem.team_draft@></td>
								<td width="12%">
									<span class="logo"><img class="lazy" data-original="<@=subItem.photo@>?t=<@=index@><@=subIndex@>"/><@if(GM.night){ @><span class="mask"></span><@ } @></span>
								</td>
								<td width="26%" class="td4"><@=subItem.alias@></td>
								<td width="36%" class="td5">
									<div class="info"><@=subItem.position@>&nbsp;<@=subItem.height@></div>
									<@ if(subItem.team){ @>
									<div class="other">交易至<@=subItem.team@></div>
									<@ } @>
								</td>
							</tr>
							<@ }); @>
						</tbody>
					</table>
				</li>
				<@ }); @>
			<@ }else{ @>
				<li class="no-result">
					<p>2016年NBA选秀大会将于6月24日上午7时开始，虎扑体育将第一时间为您更新选秀结果。</p>
					<p>祝周琦选秀顺利。</p>
				</li>
			<@ } @>
		</ul>
	</script>
</section>
