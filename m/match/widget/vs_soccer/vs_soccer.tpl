<div class="vs-wrap {%if $leagueName == "afccl"%}no-background{%/if%}">
	<div class="vs-con">
		<section class="elimination-game above-game">
			{%foreach array_slice($AgainstInfo[8], 0, 4) as $val%}
			<div class="group">
				{%if !empty($val.hlogo)%}
					<a class="left-logo" href="javascript:void(0);">
						<img src="{%$val.hlogo%}" alt="" class="swiper-lazy">
					</a>
				{%else%}
					<div class="left-logo">
						<img src="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?1" alt="" class="swiper-lazy">
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
				{%if !empty($val.alogo)%}
					<a class="left-logo" href="javascript:void(0);">
						<img src="{%$val.alogo%}"alt="" class="swiper-lazy">
					</a>
				{%else%}
					<div class="right-logo">
						<img src="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?2" alt="" class="swiper-lazy">
					</div>
				{%/if%}
			</div>
			{%/foreach%}
		</section>
		<section class="eight-game above-game">
			{%foreach array_slice($AgainstInfo[4], 0, 2) as $val%}
			<div class="group">
				{%if !empty($val.hlogo)%}
					<a class="left-logo" href="javascript:void(0);">
						<img src="{%$val.hlogo%}" alt="" class="swiper-lazy">
					</a>
				{%else%}
					<div class="left-logo">
						<img src="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?2016020{%$val@index+1%}" alt="" class="swiper-lazy">
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
				{%if !empty($val.alogo)%}
					<a class="left-logo" href="javascript:void(0);">
						<img src="{%$val.alogo%}" alt="" class="swiper-lazy">
					</a>
				{%else%}
					<div class="right-logo">
						<img src="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?2016030{%$val@index+3%}" alt="" class="swiper-lazy">
					</div>
				{%/if%}
				<div class="line"></div>
			</div>
			{%/foreach%}
		</section>
		<section class="semi-game above-game">
			{%assign var="semi" value = $AgainstInfo[2][0]%}
			<div class="group">
				<div class="title">半决赛</div>
				{%if !empty($semi.hlogo)%}
					<a class="left-logo" href="javascript:void(0);">
						<img src="{%$semi.hlogo%}" alt="" class="swiper-lazy">
					</a>
				{%else%}
					<div class="left-logo">
						<img src="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?{%$semi@index+1%}" alt="" class="swiper-lazy">
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
				{%if !empty($semi.alogo)%}
					<a class="left-logo" href="javascript:void(0);">
						<img src="{%$semi.alogo%}" alt="" class="swiper-lazy">
					</a>
				{%else%}
					<div class="right-logo">
						<img src="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?{%$semi@index+2%}" alt="" class="swiper-lazy">
					</div>
				{%/if%}
				<div class="line"></div>
			</div>
		</section>
		<section class="final-game">
			{%assign var="final" value = $AgainstInfo[1][0]%}
			<div class="final-group">
				<div class="title">决赛</div>
				{%if !empty($final.hlogo)%}
					<a class="left-logo" href="javascript:void(0);">
						<img src="{%$final.hlogo%}" alt="" class="swiper-lazy">
						<span>{%$final.home_name%}</span>
					</a>
				{%else%}
					<div class="left-logo">
						<img src="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?7" alt="" class="swiper-lazy">
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
				{%if !empty($final.alogo)%}
					<a class="left-logo" href="javascript:void(0);">
						<img src="{%$final.alogo%}" alt="" class="swiper-lazy">
						<span>{%$final.away_name%}</span>
					</a>
				{%else%}
					<div class="right-logo">
						<img src="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?8" alt="" class="swiper-lazy">
					</div>
				{%/if%}
			</div>
		</section>
		<section class="semi-game below-game">
			{%assign var="semi" value = $AgainstInfo[2][1]%}
			<div class="group">
				<div class="title">半决赛</div>
				{%if !empty($semi.hlogo)%}
					<a class="left-logo" href="javascript:void(0);">
						<img src="{%$semi.hlogo%}" alt="" class="swiper-lazy">
					</a>
				{%else%}
					<div class="left-logo">
						<img src="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?9" alt="" class="swiper-lazy">
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
				{%if !empty($semi.alogo)%}
					<a class="left-logo" href="javascript:void(0);">
						<img src="{%$semi.alogo%}" alt="" class="swiper-lazy">
					</a>
				{%else%}
					<div class="right-logo">
						<img src="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?10" alt="" class="swiper-lazy">
					</div>
				{%/if%}
				<div class="line"></div>
			</div>
		</section>
		<section class="eight-game below-game">
			{%foreach array_slice($AgainstInfo[4], 2, 2) as $val%}
			<div class="group">
				{%if !empty($val.hlogo)%}
					<a class="left-logo" href="javascript:void(0);">
						<img src="{%$val.hlogo%}" alt="" class="swiper-lazy">
					</a>
				{%else%}
					<div class="left-logo">
						<img src="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?2016050{%$val@index%}" alt="" class="swiper-lazy">
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
				{%if !empty($val.alogo)%}
					<a class="left-logo" href="javascript:void(0);">
						<img src="{%$val.alogo%}" alt="" class="swiper-lazy">
					</a>
				{%else%}
					<div class="right-logo">
						<img src="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?2016050{%$val@index+3%}" alt="" class="swiper-lazy">
					</div>
				{%/if%}
				<div class="line"></div>
			</div>
			{%/foreach%}
		</section>
		<section class="elimination-game below-game">
			{%foreach array_slice($AgainstInfo[8], 4, 4) as $val%}
			<div class="group">
				{%if !empty($val.hlogo)%}
					<a class="left-logo" href="javascript:void(0);">
						<img src="{%$val.hlogo%}" alt="" class="swiper-lazy">
					</a>
				{%else%}
					<div class="left-logo">
						<img src="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?2016070{%$val@index+3%}" alt="" class="swiper-lazy">
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
				{%if !empty($val.alogo)%}
					<a class="left-logo" href="javascript:void(0);">
						<img src="{%$val.alogo%}" alt="" class="swiper-lazy">
					</a>
				{%else%}
					<div class="right-logo">
						<img src="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?14" alt="" class="swiper-lazy">
					</div>
				{%/if%}
			</div>
			{%/foreach%}
		</section>
	</div>
</div>
