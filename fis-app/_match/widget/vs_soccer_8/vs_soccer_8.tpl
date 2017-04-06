<div class="vs-wrap">
	<div class="vs-con">
		<section class="eight-game above-game">
			{%foreach array_slice($against_figure[4], 0, 2) as $val%}
			<div class="group">
				<div class="inner">
					{%if !empty($val.home_tid)%}
						<a class="left-logo" {%if !empty($val.home_tid) && $val.home_tid != 10000001%}href="kanqiu://soccerleagues/{%$leagueName%}/team/{%$val.home_tid%}"{%else%}href="javascript:;"{%/if%}>
							<img src="{%$val.home_logo|mb_substr:0:($val.home_logo|strlen-4)%}{%if $val.win == 2%}_d{%/if%}.png?t=1{%$val@index%}" alt="" />
							<span>{%$val.home_name%}</span>
						</a>
					{%else%}
						<div class="left-logo">
							<img src="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?t={%$val@index%}" alt="">
						</div>
					{%/if%}
					<div class="middle-info">
						{%if $val.round_1 == '未赛'%}
							<span>{%$val.round_1%}</span>
						{%else%}
							<span>{%$val.round_1%}</span>
							<span>{%$val.round_2%}</span>
						{%/if%}
						{%if $val.type == 2%}
							<i>点</i>
						{%/if%}
					</div>
					{%if !empty($val.away_tid)%}
						<a class="left-logo" {%if !empty($val.away_tid) && $val.away_tid != 10000001%}href="kanqiu://soccerleagues/{%$leagueName%}/team/{%$val.away_tid%}"{%else%}href="javascript:;"{%/if%}>
							<img src="{%$val.away_logo|mb_substr:0:($val.away_logo|strlen-4)%}{%if $val.win == 1%}_d{%/if%}.png?t=2{%$val@index%}" alt="" />
							<span>{%$val.away_name%}</span>
						</a>
					{%else%}
						<div class="right-logo">
							<img src="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?t={%$val@index%}" alt="">
						</div>
					{%/if%}
					<div class="line"></div>
				</div>
			</div>
			{%/foreach%}
		</section>
		<section class="semi-game above-game">
			{%assign var="semi" value = $against_figure[2][0]%}
			<div class="group">
				<div class="title">半决赛</div>
				{%if !empty($semi.home_tid)%}
					<a class="left-logo" {%if !empty($semi.home_tid) && $semi.home_tid != 10000001%}href="kanqiu://soccerleagues/{%$leagueName%}/team/{%$semi.home_tid%}"{%else%}href="javascript:;"{%/if%}>
						<img src="{%$semi.home_logo|mb_substr:0:($semi.home_logo|strlen-4)%}{%if $semi.win == 2%}_d{%/if%}.png?t=3{%$semi@index%}" alt="" />
						<span>{%$semi.home_name%}</span>
					</a>
				{%else%}
					<div class="left-logo">
						<img src="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?{%$semi@index+1%}" alt="">
					</div>
				{%/if%}
				<div class="middle-info">
					{%if $semi.round_1 == '未赛'%}
						<span>{%$semi.round_1%}</span>
					{%else%}
						<span>{%$semi.round_1%}</span>
						<span>{%$semi.round_2%}</span>
					{%/if%}

					{%if $semi.type == 2%}
						<i>点</i>
					{%/if%}
				</div>
				{%if !empty($semi.away_tid)%}
					<a class="left-logo" {%if !empty($semi.away_tid) && $semi.away_tid != 10000001%}href="kanqiu://soccerleagues/{%$leagueName%}/team/{%$semi.away_tid%}"{%else%}href="javascript:;"{%/if%}>
						<img src="{%$semi.away_logo|mb_substr:0:($semi.away_logo|strlen-4)%}{%if $semi.win == 1%}_d{%/if%}.png?t=4{%$semi@index%}" alt="" />
						<span>{%$semi.away_name%}</span>
					</a>
				{%else%}
					<div class="right-logo">
						<img src="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?{%$semi@index+2%}" alt="">
					</div>
				{%/if%}
				<div class="line"></div>
			</div>
		</section>
		<section class="final-game">
			{%assign var="final" value = $against_figure[1][0]%}
			<div class="final-group">
				<div class="title">决赛</div>
				{%if !empty($final.home_tid)%}
					<a class="left-logo" {%if !empty($final.home_tid) && $final.home_tid != 10000001%}href="kanqiu://soccerleagues/{%$leagueName%}/team/{%$final.home_tid%}"{%else%}href="javascript:;"{%/if%}>
						<img src="{%$final.home_logo|mb_substr:0:($final.home_logo|strlen-4)%}{%if $final.win == 2%}_d{%/if%}.png?t=5{%$final@index%}" alt="" />
						<span>{%$final.home_name%}</span>
					</a>
				{%else%}
					<div class="left-logo">
						<img src="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?7" alt="">
					</div>
				{%/if%}

				<div class="middle-info">
					{%if $final.round_1 == '未赛'%}
						<span class="score">{%$final.round_1%}</span>
					{%else%}
						<span>{%$final.round_1%}</span>
						<span>{%$final.round_2%}</span>
					{%/if%}

					{%if $final.type == 2%}
						<i>点</i>
					{%/if%}
				</div>
				{%if !empty($final.away_tid)%}
					<a class="left-logo" {%if !empty($final.away_tid) && $final.away_tid != 10000001%}href="kanqiu://soccerleagues/{%$leagueName%}/team/{%$final.away_tid%}"{%else%}href="javascript:;"{%/if%}>
						<img src="{%$final.away_logo|mb_substr:0:($final.away_logo|strlen-4)%}{%if $final.win == 1%}_d{%/if%}.png?t=6{%$final@index%}" alt="" />
						<span>{%$final.away_name%}</span>
					</a>
				{%else%}
					<div class="right-logo">
						<img src="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?8" alt="">
					</div>
				{%/if%}
			</div>
		</section>
		<section class="semi-game below-game">
			{%assign var="semi" value = $against_figure[2][1]%}
			<div class="group">
				<div class="title">半决赛</div>
				{%if !empty($semi.home_tid)%}
					<a class="left-logo" {%if !empty($semi.home_tid) && $semi.home_tid != 10000001%}href="kanqiu://soccerleagues/{%$leagueName%}/team/{%$semi.home_tid%}"{%else%}href="javascript:;"{%/if%}>
						<img src="{%$semi.home_logo|mb_substr:0:($semi.home_logo|strlen-4)%}{%if $semi.win == 2%}_d{%/if%}.png?t=7{%$semi@index%}" alt="" />
						<span>{%$semi.home_name%}</span>
					</a>
				{%else%}
					<div class="left-logo">
						<img src="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?9" alt="">
					</div>
				{%/if%}
				<div class="middle-info">
					{%if $semi.round_1 == '未赛'%}
						<span>{%$semi.round_1%}</span>
					{%else%}
						<span>{%$semi.round_1%}</span>
						<span>{%$semi.round_2%}</span>
					{%/if%}
					{%if $semi.type == 2%}
						<i>点</i>
					{%/if%}
				</div>
				{%if !empty($semi.away_tid)%}
					<a class="left-logo" {%if !empty($semi.home_tid) && $semi.away_tid != 10000001%}href="kanqiu://soccerleagues/{%$leagueName%}/team/{%$semi.away_tid%}"{%else%}href="javascript:;"{%/if%}>
						<img src="{%$semi.away_logo|mb_substr:0:($semi.away_logo|strlen-4)%}{%if $semi.win == 1%}_d{%/if%}.png?t=8{%$semi@index%}" alt="" />
						<span>{%$semi.away_name%}</span>
					</a>
				{%else%}
					<div class="right-logo">
						<img src="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?10" alt="">
					</div>
				{%/if%}
				<div class="line"></div>
			</div>
		</section>
		<section class="eight-game below-game">
			{%foreach array_slice($against_figure[4], 2, 2) as $val%}
			<div class="group">
				<div class="inner">
					{%if !empty($val.home_tid)%}
						<a class="left-logo" {%if !empty($val.home_tid) && $val.home_tid != 10000001%}href="kanqiu://soccerleagues/{%$leagueName%}/team/{%$val.home_tid%}"{%else%}href="javascript:;"{%/if%}>
							<img src="{%$val.home_logo|mb_substr:0:($val.home_logo|strlen-4)%}{%if $val.win == 2%}_d{%/if%}.png?t=9{%$val@index%}" alt="" />
							<span>{%$val.home_name%}</span>
						</a>
					{%else%}
						<div class="left-logo">
							<img src="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?t={%$val@index%}50{%$val@index%}" alt="">
						</div>
					{%/if%}
					<div class="middle-info">
						{%if $val.round_1 == '未赛'%}
							<span>{%$val.round_1%}</span>
						{%else%}
							<span>{%$val.round_1%}</span>
							<span>{%$val.round_2%}</span>
						{%/if%}

						{%if $val.type == 2%}
							<i>点</i>
						{%/if%}
					</div>
					{%if !empty($val.away_tid)%}
						<a class="left-logo" {%if !empty($val.away_tid) && $val.away_tid != 10000001%}href="kanqiu://soccerleagues/{%$leagueName%}/team/{%$val.away_tid%}"{%else%}href="javascript:;"{%/if%}>
							<img src="{%$val.away_logo|mb_substr:0:($val.away_logo|strlen-4)%}{%if $val.win == 1%}_d{%/if%}.png?t=10{%$val@index%}" alt="" />
							<span>{%$val.away_name%}</span>
						</a>
					{%else%}
						<div class="right-logo">
							<img src="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?t={%$val@index%}" alt="">
						</div>
					{%/if%}
					<div class="line"></div>
				</div>
			</div>
			{%/foreach%}
		</section>
	</div>
</div>
