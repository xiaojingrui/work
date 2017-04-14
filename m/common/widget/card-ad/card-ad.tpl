{%if !empty($data.adurl)%}
	{%if $from|default:"home" == "home"%}
	<section class="card-col-4 spread card-col-widget">
		<div class="card-wrap">
			<span class="spread-tag">推</span>
			<article class="bd">
				<a href="{%$data.adurl%}" target="_blank" dace-node="{%$id4dace%}_stream_{%$pos|default:'top'%}" class="list smail-pic-list">
					<div class="news-text">
						<div class="name">
							<span>{%$data.adword%}</span>
						</div>
					</div>
					<div class="small-pic" style="background-image: url({%$data.pic%})"></div>
				</a>
			</article>
		</div>
	</section>
	{%else%}
		<li class="spread">
		<div class="card-wrap">
			<span class="spread-tag">推</span>
			<a href="{%$data.adurl%}" target="_blank" dace-node="{%$id4dace%}_stream" class="news-link">
				<div class="news-txt">
					<h3>{%$data.adword%}</h3>
				</div>
				<div class="img-wrap" style="background-image:url({%$data.pic%})"></div>
			</a>
		</div>
		</li>
	{%/if%}
{%/if%}
