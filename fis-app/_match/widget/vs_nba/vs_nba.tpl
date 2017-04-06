<section class="vs-box-wrap" id="J-vs-box-wrap">
	<div class="vs-box">
		<!-- 东部 -->
		<div class="top">
	    	<!-- 8强 -->
			<div class="vs-8">
				<ul>
					<li link="kanqiu://nba/nba/team/{%$rankings.east.r1[1].tid%}" {%if $rankings.east.r1[1].score lt $rankings.east.r1[8].score && $rankings.east.r1[8].score eq "4"%} class="vs_gray link" {%else%} class="link" {%/if%}>
						<p>1</p>
						<p><img class="lazy"
						{%if !empty($rankings.east.r1[1].tid)%}
						data-original="//b1.hoopchina.com.cn/games/teams/nba/1_{%$rankings.east.r1[1].tid%}_2x_alpha{%if $rankings.east.r1[1].score lt $rankings.east.r1[8].score && $rankings.east.r1[8].score eq "4"%}_gray{%/if%}.png?t=1"
						{%else%}
						data-original="//b1.hoopchina.com.cn/games/teams/nba/nba-none.png?t=2"
						{%/if%}/></p>
						<p class="team">{%$rankings.east.r1[1].name%}</p>
					</li>
					<li class="score">{%$rankings.east.r1[1].score%}-{%$rankings.east.r1[8].score%}</li>
					<li link="kanqiu://nba/nba/team/{%$rankings.east.r1[8].tid%}" {%if $rankings.east.r1[8].score lt $rankings.east.r1[1].score && $rankings.east.r1[1].score eq "4"%} class="vs_gray link" {%else%} class="link" {%/if%}>
						<p>8</p>
						<p><img class="lazy"
						{%if !empty($rankings.east.r1[8].tid)%}
						data-original="//b1.hoopchina.com.cn/games/teams/nba/1_{%$rankings.east.r1[8].tid%}_2x_alpha{%if $rankings.east.r1[8].score lt $rankings.east.r1[1].score && $rankings.east.r1[1].score eq "4"%}_gray{%/if%}.png?t=3"
						{%else%}
						data-original="//b1.hoopchina.com.cn/games/teams/nba/nba-none.png?t=4"
						{%/if%}/></p>
						<p class="team">{%$rankings.east.r1[8].name%}</p>
					</li>
				</ul>
				<ul>
					<li link="kanqiu://nba/nba/team/{%$rankings.east.r1[4].tid%}" {%if $rankings.east.r1[4].score lt $rankings.east.r1[5].score && $rankings.east.r1[5].score eq "4"%} class="vs_gray link" {%else%} class="link" {%/if%}>
						<p>4</p>
						<p><img class="lazy"
						{%if !empty($rankings.east.r1[4].tid)%}
						data-original="//b1.hoopchina.com.cn/games/teams/nba/1_{%$rankings.east.r1[4].tid%}_2x_alpha{%if $rankings.east.r1[4].score lt $rankings.east.r1[5].score && $rankings.east.r1[5].score eq "4"%}_gray{%/if%}.png?t=5"
						{%else%}
						data-original="//b1.hoopchina.com.cn/games/teams/nba/nba-none.png?t=6"
						{%/if%}/></p>
						<p class="team">{%$rankings.east.r1[4].name%}</p>
					</li>
					<li class="score">{%$rankings.east.r1[4].score%}-{%$rankings.east.r1[5].score%}</li>
					<li link="kanqiu://nba/nba/team/{%$rankings.east.r1[5].tid%}" {%if $rankings.east.r1[5].score lt $rankings.east.r1[4].score  && $rankings.east.r1[4].score eq "4"%} class="vs_gray link" {%else%} class="link" {%/if%}>
						<p>5</p>
						<p><img class="lazy"
						{%if !empty($rankings.east.r1[5].tid)%}
						data-original="//b1.hoopchina.com.cn/games/teams/nba/1_{%$rankings.east.r1[5].tid%}_2x_alpha{%if $rankings.east.r1[5].score lt $rankings.east.r1[4].score && $rankings.east.r1[4].score eq "4"%}_gray{%/if%}.png?t=7"
						{%else%}
						data-original="//b1.hoopchina.com.cn/games/teams/nba/nba-none.png?t=8"
						{%/if%}/></p>
						<p class="team">{%$rankings.east.r1[5].name%}</p>
					</li>
				</ul>
				<ul>
					<li link="kanqiu://nba/nba/team/{%$rankings.east.r1[3].tid%}" {%if $rankings.east.r1[3].score lt $rankings.east.r1[6].score  && $rankings.east.r1[6].score eq "4"%} class="vs_gray link" {%else%} class="link" {%/if%}>
						<p>3</p>
						<p><img class="lazy"
						{%if !empty($rankings.east.r1[3].tid)%}
						data-original="//b1.hoopchina.com.cn/games/teams/nba/1_{%$rankings.east.r1[3].tid%}_2x_alpha{%if $rankings.east.r1[3].score lt $rankings.east.r1[6].score && $rankings.east.r1[6].score eq "4"%}_gray{%/if%}.png?t=9"
						{%else%}
						data-original="//b1.hoopchina.com.cn/games/teams/nba/nba-none.png?t=10"
						{%/if%}/></p>
						<p class="team">{%$rankings.east.r1[3].name%}</p>
					</li>
					<li class="score">{%$rankings.east.r1[3].score%}-{%$rankings.east.r1[6].score%}</li>
					<li link="kanqiu://nba/nba/team/{%$rankings.east.r1[6].tid%}" {%if $rankings.east.r1[6].score lt $rankings.east.r1[3].score && $rankings.east.r1[3].score eq "4"%} class="vs_gray link" {%else%} class="link" {%/if%}>
						<p>6</p>
						<p><img class="lazy"
						{%if !empty($rankings.east.r1[6].tid)%}
						data-original="//b1.hoopchina.com.cn/games/teams/nba/1_{%$rankings.east.r1[6].tid%}_2x_alpha{%if $rankings.east.r1[6].score lt $rankings.east.r1[3].score && $rankings.east.r1[3].score eq "4"%}_gray{%/if%}.png?t=11"
						{%else%}
						data-original="//b1.hoopchina.com.cn/games/teams/nba/nba-none.png?t=12"
						{%/if%}/></p>
						<p class="team">{%$rankings.east.r1[6].name%}</p>
					</li>
				</ul>
				<ul>
					<li link="kanqiu://nba/nba/team/{%$rankings.east.r1[2].tid%}" {%if $rankings.east.r1[2].score lt $rankings.east.r1[7].score && $rankings.east.r1[7].score eq "4"%} class="vs_gray link" {%else%} class="link" {%/if%}>
						<p>2</p>
						<p><img class="lazy"
						{%if !empty($rankings.east.r1[2].tid)%}
						data-original="//b1.hoopchina.com.cn/games/teams/nba/1_{%$rankings.east.r1[2].tid%}_2x_alpha{%if $rankings.east.r1[2].score lt $rankings.east.r1[7].score && $rankings.east.r1[7].score eq "4"%}_gray{%/if%}.png?t=13"
						{%else%}
						data-original="//b1.hoopchina.com.cn/games/teams/nba/nba-none.png?t=14"
						{%/if%}/></p>
						<p class="team">{%$rankings.east.r1[2].name%}</p>
					</li>
					<li class="score">{%$rankings.east.r1[2].score%}-{%$rankings.east.r1[7].score%}</li>
					<li link="kanqiu://nba/nba/team/{%$rankings.east.r1[7].tid%}" {%if $rankings.east.r1[7].score lt $rankings.east.r1[2].score && $rankings.east.r1[2].score eq "4"%} class="vs_gray link" {%else%} class="link" {%/if%}>
						<p>7</p>
						<p><img class="lazy"
						{%if !empty($rankings.east.r1[7].tid)%}
						data-original="//b1.hoopchina.com.cn/games/teams/nba/1_{%$rankings.east.r1[7].tid%}_2x_alpha{%if $rankings.east.r1[7].score lt $rankings.east.r1[2].score && $rankings.east.r1[2].score eq "4"%}_gray{%/if%}.png?t=15"
						{%else%}
						data-original="//b1.hoopchina.com.cn/games/teams/nba/nba-none.png?t=16"
						{%/if%}/></p>
						<p class="team">{%$rankings.east.r1[7].name%}</p>
					</li>
				</ul>
			</div>
			<!-- 4强 -->
			<div class="vs-4">
				<ul>
					<li link="kanqiu://nba/nba/team/{%$rankings.east.r2[1].tid%}" {%if $rankings.east.r2[1].score < $rankings.east.r2[2].score && $rankings.east.r2[2].score eq "4"%} class="vs_gray link" {%else%} class="link" {%/if%}>
						<p><img class="lazy"
						{%if !empty($rankings.east.r2[1].tid)%}
						data-original="//b1.hoopchina.com.cn/games/teams/nba/1_{%$rankings.east.r2[1].tid%}_2x_alpha{%if $rankings.east.r2[1].score < $rankings.east.r2[2].score && $rankings.east.r2[2].score eq "4"%}_gray{%/if%}.png?t=17"
						{%else%}
						data-original="//b1.hoopchina.com.cn/games/teams/nba/nba-none.png?t=18"
						{%/if%}/></p>
						<p class="team">{%$rankings.east.r2[1].name%}</p>
					</li>
					<li class="score">{%$rankings.east.r2[1].score%}-{%$rankings.east.r2[2].score%}</li>
					<li link="kanqiu://nba/nba/team/{%$rankings.east.r2[2].tid%}" {%if $rankings.east.r2[2].score lt $rankings.east.r2[1].score && $rankings.east.r2[1].score eq "4"%} class="vs_gray link" {%else%} class="link" {%/if%}>
						<p><img class="lazy"
						{%if !empty($rankings.east.r2[2].tid)%}
						data-original="//b1.hoopchina.com.cn/games/teams/nba/1_{%$rankings.east.r2[2].tid%}_2x_alpha{%if $rankings.east.r2[2].score lt $rankings.east.r2[1].score && $rankings.east.r2[1].score eq "4"%}_gray{%/if%}.png?t=19"
						{%else%}
						data-original="//b1.hoopchina.com.cn/games/teams/nba/nba-none.png?t=20"
						{%/if%}/></p>
						<p class="team">{%$rankings.east.r2[2].name%}</p>
					</li>
				</ul>
				<ul>
					<li link="kanqiu://nba/nba/team/{%$rankings.east.r2[3].tid%}" {%if $rankings.east.r2[3].score lt $rankings.east.r2[4].score && $rankings.east.r2[4].score eq "4"%} class="vs_gray link" {%else%} class="link" {%/if%}>
						<p><img class="lazy"
						{%if !empty($rankings.east.r2[3].tid)%}
						data-original="//b1.hoopchina.com.cn/games/teams/nba/1_{%$rankings.east.r2[3].tid%}_2x_alpha{%if $rankings.east.r2[3].score lt $rankings.east.r2[4].score && $rankings.east.r2[4].score eq "4"%}_gray{%/if%}.png?t=21"
						{%else%}
						data-original="//b1.hoopchina.com.cn/games/teams/nba/nba-none.png?t=22"
						{%/if%}/></p>
						<p class="team">{%$rankings.east.r2[3].name%}</p>
					</li>
					<li class="score">{%$rankings.east.r2[3].score%}-{%$rankings.east.r2[4].score%}</li>
					<li link="kanqiu://nba/nba/team/{%$rankings.east.r2[4].tid%}" {%if $rankings.east.r2[4].score lt $rankings.east.r2[3].score && $rankings.east.r2[3].score eq "4"%} class="vs_gray link" {%else%} class="link" {%/if%}>
						<p><img class="lazy"
						{%if !empty($rankings.east.r2[4].tid)%}
						data-original="//b1.hoopchina.com.cn/games/teams/nba/1_{%$rankings.east.r2[4].tid%}_2x_alpha{%if $rankings.east.r2[4].score lt $rankings.east.r2[3].score && $rankings.east.r2[3].score eq "4"%}_gray{%/if%}.png?t=23"
						{%else%}
						data-original="//b1.hoopchina.com.cn/games/teams/nba/nba-none.png?t=24"
						{%/if%}/></p>
						<p class="team">{%$rankings.east.r2[4].name%}</p>
					</li>
				</ul>
			</div>
			<!-- 2强 -->
			<div class="vs-2">
				<ul>
					<li link="kanqiu://nba/nba/team/{%$rankings.east.r3[1].tid%}" {%if $rankings.east.r3[1].score lt $rankings.east.r3[2].score && $rankings.east.r3[2].score eq "4"%} class="vs_gray link" {%else%} class="link" {%/if%}>
						<p><img class="lazy"
						{%if !empty($rankings.east.r3[1].tid)%}
						data-original="//b1.hoopchina.com.cn/games/teams/nba/1_{%$rankings.east.r3[1].tid%}_2x_alpha{%if $rankings.east.r3[1].score lt $rankings.east.r3[2].score && $rankings.east.r3[2].score eq "4"%}_gray{%/if%}.png?t=25"
						{%else%}
						data-original="//b1.hoopchina.com.cn/games/teams/nba/nba-none.png?t=26"
						{%/if%}/></p>
						<p class="team">{%$rankings.east.r3[1].name%}</p>
					</li>
					<li class="score">{%$rankings.east.r3[1].score%}-{%$rankings.east.r3[2].score%}</li>
					<li link="kanqiu://nba/nba/team/{%$rankings.east.r3[2].tid%}" {%if $rankings.east.r3[2].score lt $rankings.east.r3[1].score && $rankings.east.r3[1].score eq "4"%} class="vs_gray link" {%else%} class="link" {%/if%}>
						<p><img class="lazy"
						{%if !empty($rankings.east.r3[2].tid)%}
						data-original="//b1.hoopchina.com.cn/games/teams/nba/1_{%$rankings.east.r3[2].tid%}_2x_alpha{%if $rankings.east.r3[2].score lt $rankings.east.r3[1].score && $rankings.east.r3[1].score eq "4"%}_gray{%/if%}.png?t=27"
						{%else%}
						data-original="//b1.hoopchina.com.cn/games/teams/nba/nba-none.png?t=28"
						{%/if%}/></p>
						<p class="team">{%$rankings.east.r3[2].name%}</p>
					</li>
				</ul>
			</div>
		</div>
		<!-- 决赛 -->
		<div class="vs">
			<span class="tips">总决赛</span>
			<ul>
				<li link="kanqiu://nba/nba/team/{%$rankings.east.r4[1].tid%}" {%if $rankings.east.r4[1].score lt $rankings.west.r4[1].score && $rankings.west.r4[1].score eq "4"%} class="vs_gray link" {%else%} class="link" {%/if%}>
					<p><img class="lazy"
					{%if !empty($rankings.east.r4[1].tid)%}
					data-original="//b1.hoopchina.com.cn/games/teams/nba/1_{%$rankings.east.r4[1].tid%}_2x_alpha{%if $rankings.east.r4[1].score lt $rankings.west.r4[1].score && $rankings.west.r4[1].score eq "4"%}_gray{%/if%}.png?t=29"
					{%else%}
					data-original="//b1.hoopchina.com.cn/games/teams/nba/nba-none.png?t=30"
					{%/if%}/></p>
					<p class="team">{%$rankings.east.r4[1].name%}({%$rankings.east.r4[1].score%})</p>
				</li>
				<li class="score"></li>
				<li link="kanqiu://nba/nba/team/{%$rankings.west.r4[1].tid%}" {%if $rankings.west.r4[1].score lt $rankings.east.r4[1].score && $rankings.east.r4[1].score eq "4"%} class="vs_gray link" {%else%} class="link" {%/if%}>
					<p><img class="lazy"
					{%if !empty($rankings.west.r4[1].tid)%}
					data-original="//b1.hoopchina.com.cn/games/teams/nba/1_{%$rankings.west.r4[1].tid%}_2x_alpha{%if $rankings.west.r4[1].score lt $rankings.east.r4[1].score && $rankings.east.r4[1].score eq "4"%}_gray{%/if%}.png?t=31"
					{%else%}
					data-original="//b1.hoopchina.com.cn/games/teams/nba/nba-none.png?t=32"
					{%/if%}/></p>
					<p class="team">{%$rankings.west.r4[1].name%}({%$rankings.west.r4[1].score%})</p>
				</li>
			</ul>
		</div>
		<!-- 西部 -->
		<div class="bottom">
			<!-- 2强 -->
			<div class="vs-2">
				<ul>
					<li link="kanqiu://nba/nba/team/{%$rankings.west.r3[1].tid%}" {%if $rankings.west.r3[1].score lt $rankings.west.r3[2].score && $rankings.west.r3[2].score eq "4"%} class="vs_gray link" {%else%} class="link" {%/if%}>
						<p><img class="lazy"
						{%if !empty($rankings.west.r3[1].tid)%}
						data-original="//b1.hoopchina.com.cn/games/teams/nba/1_{%$rankings.west.r3[1].tid%}_2x_alpha{%if $rankings.west.r3[1].score lt $rankings.west.r3[2].score && $rankings.west.r3[2].score eq "4"%}_gray{%/if%}.png?t=33"
						{%else%}
						data-original="//b1.hoopchina.com.cn/games/teams/nba/nba-none.png?t=34"
						{%/if%}/></p>
						<p class="team">{%$rankings.west.r3[1].name%}</p>
					</li>
					<li class="score">{%$rankings.west.r3[1].score%}-{%$rankings.west.r3[2].score%}</li>
					<li link="kanqiu://nba/nba/team/{%$rankings.west.r3[2].tid%}" {%if $rankings.west.r3[2].score lt $rankings.west.r3[1].score && $rankings.west.r3[1].score eq "4"%} class="vs_gray link" {%else%} class="link" {%/if%}>
						<p><img class="lazy"
						{%if !empty($rankings.west.r3[2].tid)%}
						data-original="//b1.hoopchina.com.cn/games/teams/nba/1_{%$rankings.west.r3[2].tid%}_2x_alpha{%if $rankings.west.r3[2].score lt $rankings.west.r3[1].score && $rankings.west.r3[1].score eq "4"%}_gray{%/if%}.png?t=35"
						{%else%}
						data-original="//b1.hoopchina.com.cn/games/teams/nba/nba-none.png?t=36"
						{%/if%}/></p>
						<p class="team">{%$rankings.west.r3[2].name%}</p>
					</li>
				</ul>
			</div>
			<!-- 4强 -->
			<div class="vs-4">
				<ul>
					<li link="kanqiu://nba/nba/team/{%$rankings.west.r2[1].tid%}" {%if $rankings.west.r2[1].score lt $rankings.west.r2[2].score && $rankings.west.r2[2].score eq "4"%} class="vs_gray link" {%else%} class="link" {%/if%}>
						<p><img class="lazy"
						{%if !empty($rankings.west.r2[1].tid)%}
						data-original="//b1.hoopchina.com.cn/games/teams/nba/1_{%$rankings.west.r2[1].tid%}_2x_alpha{%if $rankings.west.r2[1].score lt $rankings.west.r2[2].score && $rankings.west.r2[2].score eq "4"%}_gray{%/if%}.png?t=37"
						{%else%}
						data-original="//b1.hoopchina.com.cn/games/teams/nba/nba-none.png?t=38"
						{%/if%}/></p>
						<p class="team">{%$rankings.west.r2[1].name%}</p>
					</li>
					<li class="score">{%$rankings.west.r2[1].score%}-{%$rankings.west.r2[2].score%}</li>
					<li link="kanqiu://nba/nba/team/{%$rankings.west.r2[2].tid%}" {%if $rankings.west.r2[2].score lt $rankings.west.r2[1].score && $rankings.west.r2[1].score eq "4"%} class="vs_gray link" {%else%} class="link" {%/if%}>
						<p><img class="lazy"
						{%if !empty($rankings.west.r2[2].tid)%}
						data-original="//b1.hoopchina.com.cn/games/teams/nba/1_{%$rankings.west.r2[2].tid%}_2x_alpha{%if $rankings.west.r2[2].score lt $rankings.west.r2[1].score && $rankings.west.r2[1].score eq "4"%}_gray{%/if%}.png?t=39"
						{%else%}
						data-original="//b1.hoopchina.com.cn/games/teams/nba/nba-none.png?t=40"
						{%/if%}/></p>
						<p class="team">{%$rankings.west.r2[2].name%}</p>
					</li>
				</ul>
				<ul>
					<li link="kanqiu://nba/nba/team/{%$rankings.west.r2[3].tid%}" {%if $rankings.west.r2[3].score lt $rankings.west.r2[4].score && $rankings.west.r2[4].score eq "4"%} class="vs_gray link" {%else%} class="link" {%/if%}>
						<p><img class="lazy"
						{%if !empty($rankings.west.r2[3].tid)%}
						data-original="//b1.hoopchina.com.cn/games/teams/nba/1_{%$rankings.west.r2[3].tid%}_2x_alpha{%if $rankings.west.r2[3].score lt $rankings.west.r2[4].score && $rankings.west.r2[4].score eq "4"%}_gray{%/if%}.png?t=41"
						{%else%}
						data-original="//b1.hoopchina.com.cn/games/teams/nba/nba-none.png?t=42"
						{%/if%}/></p>
						<p class="team">{%$rankings.west.r2[3].name%}</p>
					</li>
					<li class="score">{%$rankings.west.r2[3].score%}-{%$rankings.west.r2[4].score%}</li>
					<li link="kanqiu://nba/nba/team/{%$rankings.west.r2[4].tid%}" {%if $rankings.west.r2[4].score lt $rankings.west.r2[3].score && $rankings.west.r2[3].score eq "4"%} class="vs_gray link" {%else%} class="link" {%/if%}>
						<p><img class="lazy"
						{%if !empty($rankings.west.r2[4].tid)%}
						data-original="//b1.hoopchina.com.cn/games/teams/nba/1_{%$rankings.west.r2[4].tid%}_2x_alpha{%if $rankings.west.r2[4].score lt $rankings.west.r2[3].score && $rankings.west.r2[3].score eq "4"%}_gray{%/if%}.png?t=43"
						{%else%}
						data-original="//b1.hoopchina.com.cn/games/teams/nba/nba-none.png?t=44"
						{%/if%}/></p>
						<p class="team">{%$rankings.west.r2[4].name%}</p>
					</li>
				</ul>
			</div>
			<!-- 8强 -->
			<div class="vs-8">
				<ul>
					<li link="kanqiu://nba/nba/team/{%$rankings.west.r1[1].tid%}" {%if $rankings.west.r1[1].score lt $rankings.west.r1[8].score && $rankings.west.r1[8].score eq "4"%} class="vs_gray link" {%else%} class="link" {%/if%}>
						<p>1</p>
						<p><img class="lazy"
						{%if !empty($rankings.west.r1[1].tid)%}
						data-original="//b1.hoopchina.com.cn/games/teams/nba/1_{%$rankings.west.r1[1].tid%}_2x_alpha{%if $rankings.west.r1[1].score lt $rankings.west.r1[8].score && $rankings.west.r1[8].score eq "4"%}_gray{%/if%}.png?t=45"
						{%else%}
						data-original="//b1.hoopchina.com.cn/games/teams/nba/nba-none.png?t=46"
						{%/if%}/></p>
						<p class="team">{%$rankings.west.r1[1].name%}</p>
					</li>
					<li class="score">{%$rankings.west.r1[1].score%}-{%$rankings.west.r1[8].score%}</li>
					<li link="kanqiu://nba/nba/team/{%$rankings.west.r1[8].tid%}" {%if $rankings.west.r1[8].score lt $rankings.west.r1[1].score && $rankings.west.r1[1].score eq "4"%} class="vs_gray link" {%else%} class="link" {%/if%}>
						<p>8</p>
						<p><img class="lazy"
						{%if !empty($rankings.west.r1[8].tid)%}
						data-original="//b1.hoopchina.com.cn/games/teams/nba/1_{%$rankings.west.r1[8].tid%}_2x_alpha{%if $rankings.west.r1[8].score lt $rankings.west.r1[1].score && $rankings.west.r1[1].score eq "4"%}_gray{%/if%}.png?t=47"
						{%else%}
						data-original="//b1.hoopchina.com.cn/games/teams/nba/nba-none.png?t=48"
						{%/if%}/></p>
						<p class="team">{%$rankings.west.r1[8].name%}</p>
					</li>
				</ul>
				<ul>
					<li link="kanqiu://nba/nba/team/{%$rankings.west.r1[4].tid%}" {%if $rankings.west.r1[4].score lt $rankings.west.r1[5].score && $rankings.west.r1[5].score eq "4"%} class="vs_gray link" {%else%} class="link" {%/if%}>
						<p>4</p>
						<p><img class="lazy"
						{%if !empty($rankings.west.r1[4].tid)%}
						data-original="//b1.hoopchina.com.cn/games/teams/nba/1_{%$rankings.west.r1[4].tid%}_2x_alpha{%if $rankings.west.r1[4].score lt $rankings.west.r1[5].score && $rankings.west.r1[5].score eq "4"%}_gray{%/if%}.png?t=49"
						{%else%}
						data-original="//b1.hoopchina.com.cn/games/teams/nba/nba-none.png?t=50"
						{%/if%}/></p>
						<p class="team">{%$rankings.west.r1[4].name%}</p>
					</li>
					<li class="score">{%$rankings.west.r1[4].score%}-{%$rankings.west.r1[5].score%}</li>
					<li link="kanqiu://nba/nba/team/{%$rankings.west.r1[5].tid%}" {%if $rankings.west.r1[5].score lt $rankings.west.r1[4].score && $rankings.west.r1[4].score eq "4"%} class="vs_gray link" {%else%} class="link" {%/if%}>
						<p>5</p>
						<p><img class="lazy"
						{%if !empty($rankings.west.r1[5].tid)%}
						data-original="//b1.hoopchina.com.cn/games/teams/nba/1_{%$rankings.west.r1[5].tid%}_2x_alpha{%if $rankings.west.r1[5].score lt $rankings.west.r1[4].score && $rankings.west.r1[4].score eq "4"%}_gray{%/if%}.png?t=51"
						{%else%}
						data-original="//b1.hoopchina.com.cn/games/teams/nba/nba-none.png?t=52"
						{%/if%}/></p>
						<p class="team">{%$rankings.west.r1[5].name%}</p>
					</li>
				</ul>
				<ul>
					<li link="kanqiu://nba/nba/team/{%$rankings.west.r1[3].tid%}" {%if $rankings.west.r1[3].score lt $rankings.west.r1[6].score && $rankings.west.r1[6].score eq "4"%} class="vs_gray link" {%else%} class="link" {%/if%}>
						<p>3</p>
						<p><img class="lazy"
						{%if !empty($rankings.west.r1[3].tid)%}
						data-original="//b1.hoopchina.com.cn/games/teams/nba/1_{%$rankings.west.r1[3].tid%}_2x_alpha{%if $rankings.west.r1[3].score lt $rankings.west.r1[6].score && $rankings.west.r1[6].score eq "4"%}_gray{%/if%}.png?t=533"
						{%else%}
						data-original="//b1.hoopchina.com.cn/games/teams/nba/nba-none.png?t=54"
						{%/if%}/></p>
						<p class="team">{%$rankings.west.r1[3].name%}</p>
					</li>
					<li class="score">{%$rankings.west.r1[3].score%}-{%$rankings.west.r1[6].score%}</li>
					<li link="kanqiu://nba/nba/team/{%$rankings.west.r1[6].tid%}" {%if $rankings.west.r1[6].score lt $rankings.west.r1[3].score && $rankings.west.r1[3].score eq "4"%} class="vs_gray link" {%else%} class="link" {%/if%}>
						<p>6</p>
						<p><img class="lazy"
						{%if !empty($rankings.west.r1[6].tid)%}
						data-original="//b1.hoopchina.com.cn/games/teams/nba/1_{%$rankings.west.r1[6].tid%}_2x_alpha{%if $rankings.west.r1[6].score lt $rankings.west.r1[3].score && $rankings.west.r1[3].score eq "4"%}_gray{%/if%}.png?t=55"
						{%else%}
						data-original="//b1.hoopchina.com.cn/games/teams/nba/nba-none.png?t=56"
						{%/if%}/></p>
						<p class="team">{%$rankings.west.r1[6].name%}</p>
					</li>
				</ul>
				<ul>
					<li link="kanqiu://nba/nba/team/{%$rankings.west.r1[2].tid%}" {%if $rankings.west.r1[2].score lt $rankings.west.r1[7].score && $rankings.west.r1[7].score eq "4"%} class="vs_gray link" {%else%} class="link" {%/if%}>
						<p>2</p>
						<p><img class="lazy"
						{%if !empty($rankings.west.r1[2].tid)%}
						data-original="//b1.hoopchina.com.cn/games/teams/nba/1_{%$rankings.west.r1[2].tid%}_2x_alpha{%if $rankings.west.r1[2].score lt $rankings.west.r1[7].score && $rankings.west.r1[7].score eq "4"%}_gray{%/if%}.png?t=57"
						{%else%}
						data-original="//b1.hoopchina.com.cn/games/teams/nba/nba-none.png?t=58"
						{%/if%}/></p>
						<p class="team">{%$rankings.west.r1[2].name%}</p>
					</li>
					<li class="score">{%$rankings.west.r1[2].score%}-{%$rankings.west.r1[7].score%}</li>
					<li link="kanqiu://nba/nba/team/{%$rankings.west.r1[7].tid%}" {%if $rankings.west.r1[7].score < $rankings.west.r1[2].score && $rankings.west.r1[2].score eq "4"%} class="vs_gray link" {%else%} class="link" {%/if%}>
						<p>7</p>
						<p><img class="lazy"
						{%if !empty($rankings.west.r1[7].tid)%}
						data-original="//b1.hoopchina.com.cn/games/teams/nba/1_{%$rankings.west.r1[7].tid%}_2x_alpha{%if $rankings.west.r1[7].score < $rankings.west.r1[2].score && $rankings.west.r1[2].score eq "4"%}_gray{%/if%}.png?t=58"
						{%else%}
						data-original="//b1.hoopchina.com.cn/games/teams/nba/nba-none.png?t=60"
						{%/if%}/></p>
						<p class="team">{%$rankings.west.r1[7].name%}</p>
					</li>
				</ul>
			</div>
		</div>
	</div>
</section>
