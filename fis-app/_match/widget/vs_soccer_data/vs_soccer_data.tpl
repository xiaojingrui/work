{%* 8强去除线框 *%}
{%if $leagueName == "amerciacup" || $leagueName == "olympic"%}
<style>
	.eight-game .group:before { height: 0;}
</style>
{%/if%}
{%* 欧洲杯美洲杯对阵图 （类似于NBA对阵图结构，支持自适应， 且支持8强、16强结构） *%}
<div class="vs-wrap {%if $leagueName == "eurocup"%}euro-bg{%else if $leagueName == "amerciacup"%}america-bg{%/if%}">
	{%* 欧洲杯16强且有季军赛   美洲杯只有8强且有季军赛 *%}
	{%if $leagueName == "eurocup"%}
	<section class="elimination-game above-game">
		{%foreach array_slice($against_figure[8], 0, 4) as $val%}
		<div class="elimination-group">
			<div class="left">
				<a {%if $leagueName == "olympic"%}href="javascript:void(0);"{%else%}href="kanqiu://soccerleagues/{%$leagueName%}/team/{%$val.home_tid%}"{%/if%} class="logo">
					{%if $val.home_tid%}
					<img data-original="{%$val.home_logo|mb_substr:0:($val.home_logo|strlen-4)%}{%if $val.win == 2%}_d{%/if%}.png?t=121{%$val@index%}" class="lazy">
					{%else%}
					<img data-original="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?t=121{%$val@index%}" class="lazy">
					{%/if%}
				</a>
				<div class="name">{%$val.home_name%}</div>
			</div>
			<div class="right">
				<a {%if $leagueName == "olympic"%}href="javascript:void(0);"{%else%}href="kanqiu://soccerleagues/{%$leagueName%}/team/{%$val.away_tid%}"{%/if%} class="logo">
					{%if $val.away_tid%}
					<img data-original="{%$val.away_logo|mb_substr:0:($val.away_logo|strlen-4)%}{%if $val.win == 1%}_d{%/if%}.png?t=122{%$val@index%}" class="lazy">
					{%else%}
					<img data-original="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?t=122{%$val@index%}" class="lazy">
					{%/if%}
				</a>
				<div class="name">{%$val.away_name%}</div>
			</div>
			<div class="soccer">
			{%if $val.round_1 == '未赛'%}
				{%$val.round_1%}
			{%else%}
				{%$val.round_1%}
				{%if $val.type == 2%}
					<i class="point"></i>
				{%/if%}
			{%/if%}
			</div>
		</div>
		{%/foreach%}
	</section>
	{%/if%}
	<section class="eight-game above-game">
        {%if $leagueName == "olympic"%}
            {%$against_figure_4_1 = $against_figure[$index-1][4]%}
        {%else%}
            {%$against_figure_4_1 = $against_figure[4]%}
        {%/if%}
		{%foreach array_slice($against_figure_4_1, 0, 2) as $val%}
		<div class="group eight-group">
			<div class="inner">
				<div class="left">
					<a {%if $leagueName == "olympic"%}href="javascript:void(0);"{%else%}href="kanqiu://soccerleagues/{%$leagueName%}/team/{%$val.home_tid%}"{%/if%} class="logo">
						{%if $val.home_tid%}
						<img data-original="{%$val.home_logo|mb_substr:0:($val.home_logo|strlen-4)%}{%if $val.win == 2%}_d{%/if%}.png?t=123{%$val@index%}" class="lazy">
						{%else%}
						<img data-original="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?t=123{%$val@index%}" class="lazy">
						{%/if%}
					</a>
					<div class="name">{%$val.home_name%}</div>
				</div>
				<div class="right">
					<a {%if $leagueName == "olympic"%}href="javascript:void(0);"{%else%}href="kanqiu://soccerleagues/{%$leagueName%}/team/{%$val.away_tid%}"{%/if%} class="logo">
						{%if $val.away_tid%}
						<img data-original="{%$val.away_logo|mb_substr:0:($val.away_logo|strlen-4)%}{%if $val.win == 1%}_d{%/if%}.png?t=124{%$val@index%}" class="lazy">
						{%else%}
						<img data-original="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?t=124{%$val@index%}" class="lazy">
						{%/if%}
					</a>
					<div class="name">{%$val.away_name%}</div>
				</div>
				<div class="soccer">
				{%if $val.round_1 == '未赛'%}
					{%$val.round_1%}
				{%else%}
					{%$val.round_1%}
					{%if $val.type == 2%}
						<i class="point"></i>
					{%/if%}
				{%/if%}
				</div>
			</div>
		</div>
		{%/foreach%}
	</section>
	<section class="semi-game above-game">
        {%if $leagueName == "olympic"%}
            {%$against_figure_2_1 = $against_figure[$index-1][2]%}
        {%else%}
            {%$against_figure_2_1 = $against_figure[2]%}
        {%/if%}
		{%foreach array_slice($against_figure_2_1, 0, 1) as $val%}
		<div class="group semi-group">
			<div class="inner">
				<div class="left">
					<a {%if $leagueName == "olympic"%}href="javascript:void(0);"{%else%}href="kanqiu://soccerleagues/{%$leagueName%}/team/{%$val.home_tid%}"{%/if%} class="logo">
						{%if $val.home_tid%}
						<img data-original="{%$val.home_logo|mb_substr:0:($val.home_logo|strlen-4)%}{%if $val.win == 2%}_d{%/if%}.png?t=125{%$val@index%}" class="lazy">
						{%else%}
						<img data-original="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?t=125{%$val@index%}" class="lazy">
						{%/if%}
					</a>
					<div class="name">{%$val.home_name%}</div>
				</div>
				<div class="right">
					<a {%if $leagueName == "olympic"%}href="javascript:void(0);"{%else%}href="kanqiu://soccerleagues/{%$leagueName%}/team/{%$val.away_tid%}"{%/if%} class="logo">
						{%if $val.away_tid%}
						<img data-original="{%$val.away_logo|mb_substr:0:($val.away_logo|strlen-4)%}{%if $val.win == 1%}_d{%/if%}.png?t=126{%$val@index%}" class="lazy">
						{%else%}
						<img data-original="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?t=126{%$val@index%}" class="lazy">
						{%/if%}
					</a>
					<div class="name">{%$val.away_name%}</div>
				</div>
				<div class="soccer">
				{%if $val.round_1 == '未赛'%}
					{%$val.round_1%}
				{%else%}
					{%$val.round_1%}
					{%if $val.type == 2%}
						<i class="point"></i>
					{%/if%}
				{%/if%}
				</div>
			</div>
		</div>
		{%/foreach%}
	</section>
	<section class="final-game">
        {%if $leagueName == "olympic"%}
            {%$against_figure_1 = $against_figure[$index-1][1]%}
        {%else%}
            {%$against_figure_1 = $against_figure[1]%}
        {%/if%}
		{%foreach array_slice($against_figure_1, 0, 2) as $val%}
		<div class="group {%if $val@index == 0%}final-group{%else%}third-place-group{%/if%}">
			<div class="inner">
				<div class="left">
					<a {%if $leagueName == "olympic"%}href="javascript:void(0);"{%else%}href="kanqiu://soccerleagues/{%$leagueName%}/team/{%$val.home_tid%}"{%/if%} class="logo">
						{%if $val.home_tid%}
						<img data-original="{%$val.home_logo|mb_substr:0:($val.home_logo|strlen-4)%}{%if $val.win == 2%}_d{%/if%}.png?t=127{%$val@index%}" class="lazy">
						{%else%}
						<img data-original="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?t=127{%$val@index%}" class="lazy">
						{%/if%}
					</a>
					<div class="name">{%$val.home_name%}</div>
				</div>
				<div class="right">
					<a {%if $leagueName == "olympic"%}href="javascript:void(0);"{%else%}href="kanqiu://soccerleagues/{%$leagueName%}/team/{%$val.away_tid%}"{%/if%} class="logo">
						{%if $val.away_tid%}
						<img data-original="{%$val.away_logo|mb_substr:0:($val.away_logo|strlen-4)%}{%if $val.win == 1%}_d{%/if%}.png?t=128{%$val@index%}" class="lazy">
						{%else%}
						<img data-original="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?t=128{%$val@index%}" class="lazy">
						{%/if%}
					</a>
					<div class="name">{%$val.away_name%}</div>
				</div>
				<div class="title">{%if $val@index == 0%}决赛{%else%}3-4名决赛{%/if%}</div>
				<div class="soccer" {%if $val.round_1 == '未赛'%}style="top: 42%;"{%/if%}>
				{%if $val.round_1 == '未赛'%}
					{%$val.round_1%}
				{%else%}
					<div class="normal-soccer">{%$val.round_1%}</div>
					{%if $val.type == 2%}
						<div class="total-soccer">({%$val.round_2%})</div>
						<i class="point"></i>
					{%/if%}
				{%/if%}
				</div>
			</div>
		</div>
		{%/foreach%}
	</section>
	<section class="semi-game below-game">
        {%if $leagueName == "olympic"%}
            {%$against_figure_2_2 = $against_figure[$index-1][2]%}
        {%else%}
            {%$against_figure_2_2 = $against_figure[2]%}
        {%/if%}
		{%foreach array_slice($against_figure_2_2, 1, 2) as $val%}
		<div class="group semi-group">
			<div class="inner">
				<div class="left">
					<a {%if $leagueName == "olympic"%}href="javascript:void(0);"{%else%}href="kanqiu://soccerleagues/{%$leagueName%}/team/{%$val.home_tid%}"{%/if%} class="logo">
						{%if $val.home_tid%}
						<img data-original="{%$val.home_logo|mb_substr:0:($val.home_logo|strlen-4)%}{%if $val.win == 2%}_d{%/if%}.png?t=129{%$val@index%}" class="lazy">
						{%else%}
						<img data-original="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?t=129{%$val@index%}" class="lazy">
						{%/if%}
					</a>
					<div class="name">{%$val.home_name%}</div>
				</div>
				<div class="right">
					<a {%if $leagueName == "olympic"%}href="javascript:void(0);"{%else%}href="kanqiu://soccerleagues/{%$leagueName%}/team/{%$val.away_tid%}"{%/if%} class="logo">
						{%if $val.away_tid%}
						<img data-original="{%$val.away_logo|mb_substr:0:($val.away_logo|strlen-4)%}{%if $val.win == 1%}_d{%/if%}.png?t=1210{%$val@index%}" class="lazy">
						{%else%}
						<img data-original="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?t=1210{%$val@index%}" class="lazy">
						{%/if%}
					</a>
					<div class="name">{%$val.away_name%}</div>
				</div>
				<div class="soccer">
				{%if $val.round_1 == '未赛'%}
					{%$val.round_1%}
				{%else%}
					{%$val.round_1%}
					{%if $val.type == 2%}
						<i class="point"></i>
					{%/if%}
				{%/if%}
				</div>
			</div>
		</div>
		{%/foreach%}
	</section>
	<section class="eight-game below-game">
        {%if $leagueName == "olympic"%}
            {%$against_figure_4_2 = $against_figure[$index-1][4]%}
        {%else%}
            {%$against_figure_4_2 = $against_figure[4]%}
        {%/if%}
		{%foreach array_slice($against_figure_4_2, 2, 4) as $val%}
		<div class="group eight-group">
			<div class="inner">
				<div class="left">
					<a {%if $leagueName == "olympic"%}href="javascript:void(0);"{%else%}href="kanqiu://soccerleagues/{%$leagueName%}/team/{%$val.home_tid%}"{%/if%} class="logo">
						{%if $val.home_tid%}
						<img data-original="{%$val.home_logo|mb_substr:0:($val.home_logo|strlen-4)%}{%if $val.win == 2%}_d{%/if%}.png?t=1211{%$val@index%}" class="lazy">
						{%else%}
						<img data-original="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?t=1211{%$val@index%}" class="lazy">
						{%/if%}
					</a>
					<div class="name">{%$val.home_name%}</div>
				</div>
				<div class="right">
					<a {%if $leagueName == "olympic"%}href="javascript:void(0);"{%else%}href="kanqiu://soccerleagues/{%$leagueName%}/team/{%$val.away_tid%}"{%/if%} class="logo">
						{%if $val.away_tid%}
						<img data-original="{%$val.away_logo|mb_substr:0:($val.away_logo|strlen-4)%}{%if $val.win == 1%}_d{%/if%}.png?t=1212{%$val@index%}" class="lazy">
						{%else%}
						<img data-original="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?t=1212{%$val@index%}" class="lazy">
						{%/if%}
					</a>
					<div class="name">{%$val.away_name%}</div>
				</div>
				<div class="soccer">
				{%if $val.round_1 == '未赛'%}
					{%$val.round_1%}
				{%else%}
					{%$val.round_1%}
					{%if $val.type == 2%}
						<i class="point"></i>
					{%/if%}
				{%/if%}
				</div>
			</div>
		</div>
		{%/foreach%}
	</section>
	{%if $leagueName == "eurocup"%}
	<section class="elimination-game below-game">
		{%foreach array_slice($against_figure[8], 4, 8) as $val%}
		<div class="elimination-group">
			<div class="left">
				<a {%if $leagueName == "olympic"%}href="javascript:void(0);"{%else%}href="kanqiu://soccerleagues/{%$leagueName%}/team/{%$val.home_tid%}"{%/if%} class="logo">
					{%if $val.home_tid%}
					<img data-original="{%$val.home_logo|mb_substr:0:($val.home_logo|strlen-4)%}{%if $val.win == 2%}_d{%/if%}.png?t=1213{%$val@index%}" class="lazy">
					{%else%}
					<img data-original="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?t=1213{%$val@index%}" class="lazy">
					{%/if%}
				</a>
				<div class="name">{%$val.home_name%}</div>
			</div>
			<div class="right">
				<a {%if $leagueName == "olympic"%}href="javascript:void(0);"{%else%}href="kanqiu://soccerleagues/{%$leagueName%}/team/{%$val.away_tid%}"{%/if%} class="logo">
					{%if $val.away_tid%}
					<img data-original="{%$val.away_logo|mb_substr:0:($val.away_logo|strlen-4)%}{%if $val.win == 1%}_d{%/if%}.png?t=1214{%$val@index%}" class="lazy">
					{%else%}
					<img data-original="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?t=1214{%$val@index%}" class="lazy">
					{%/if%}
				</a>
				<div class="name">{%$val.away_name%}</div>
			</div>
			<div class="soccer">
			{%if $val.round_1 == '未赛'%}
				{%$val.round_1%}
			{%else%}
				{%$val.round_1%}
				{%if $val.type == 2%}
					<i class="point"></i>
				{%/if%}
			{%/if%}
			</div>
		</div>
		{%/foreach%}
	</section>
	{%/if%}
</div>
