{%if !isset($recap_tips)%}
    {%if $type == "football"%}
        {%if !empty($video_url) || !empty($title) || !empty($video_cover)%}
            {%if !empty($nopic) || empty($video_cover)%}
            <section class="section-item hot-nopic">
                <a {%if !empty($video_url)%}href="{%$video_url%}"{%else%}href="javascript:void(0);"{%/if%}>
                    <span>{%$title%}</span>
                    <i class="icon icon-arrow-right"></i>
                </a>
            </section>
            {%else%}
            <section class="section-item hot-pic" style="display:none;">
                <a {%if !empty($video_url)%}href="{%$video_url%}"{%else%}href="javascript:void(0);"{%/if%}>
                    <img src="{%$video_cover%}" alt="{%$title%}" />
                    <div class="title">
                        <p>{%$title%}</p>
                    </div>
                    {%if !empty($video_url)%}<i class="icon icon-play-b"></i>{%/if%}
                </a>
            </section>
            {%/if%}
        {%/if%}
    {%/if%}

    {%if $type == "cba"%}
        {%if !empty($recap.video_url) || !empty($video_title) || !empty($recap.video_cover)%}
            {%if !empty($nopic) || empty($recap.video_cover)%}
            <section class="section-item hot-nopic">
                <a {%if !empty($recap.video_url)%}href="{%$recap.video_url%}"{%else%}href="javascript:void(0);"{%/if%}>
                    <span>{%$recap.video_title%}</span>
                    <i class="icon icon-arrow-right"></i>
                </a>
            </section>
            {%else%}
            <section class="section-item hot-pic" style="display:none;">
                <a {%if !empty($recap.video_url)%}href="{%$recap.video_url%}"{%else%}href="javascript:void(0);"{%/if%}>
                    <img src="{%$recap.video_cover%}" alt="{%$recap.title%}" />
                    <div class="title">
                        <p>{%$recap.video_title%}</p>
                    </div>
                    {%if !empty($recap.video_url)%}<i class="icon icon-play-b"></i>{%/if%}
                </a>
            </section>
            {%/if%}
        {%/if%}
    {%/if%}

    {%if $type == "nba" || "cba"%}
        {%if !empty($video_collection)%}
            {%if !empty($nopic) || empty($video_collection[0].cover)%}
                <section class="section-item hot-nopic">
                    <a {%if !empty($video_collection[0].fromurl)%}href="browser://{%$video_collection[0].fromurl|escape:none%}"{%else%}href="javascript:void(0);"{%/if%}>
                        <span>{%$video_collection[0].title%}</span>
                        <i class="icon icon-arrow-right"></i>
                    </a>
                </section>
            {%else%}
                <section class="section-item hot-pic" style="display:none;">
                    <a {%if !empty($video_collection[0].fromurl)%}href="browser://{%$video_collection[0].fromurl|escape:none%}"{%else%}href="javascript:void(0);"{%/if%}>
                        <img src="{%$video_collection[0].cover%}" alt="{%$video_collection[0].title%}" />
                        <div class="title">
                            <p>{%$video_collection[0].title%}</p>
                        </div>
                        {%if !empty($video_collection[0].fromurl)%}<i class="icon icon-play-b"></i>{%/if%}
                    </a>
                </section>
            {%/if%}
        {%/if%}

        {%if !empty($video_collection) && $video_collection|count > 1%}
            <section class="section-item collection">
                <div class="hd">集锦</div>
                <div class="bd">
                    <ul class="list">
                        {%foreach $video_collection as $val%}
                            {%if $val@index > 0%}
                            <li class="{%if $info.extend|count <= 4%}
                                {%if $val@index > 3%}more-li{%/if%}
                            {%else%}
                                {%if $val@index > 2%}more-li{%/if%}
                            {%/if%}">
                                <a href="browser://{%$val.fromurl|escape:none%}">
                                    <span>{%$val.title%}</span>
                                    <i class="icon icon-arrow-right"></i>
                                </a>
                            </li>
                            {%/if%}
                        {%/foreach%}
                        {%if $video_collection|count > 4%}
                        <li>
                            <input type="hidden" name="name" id="left-video" value="{%$video_collection|count - 4%}">
                            <a href="javascript:;" id="J-more" class="more" data-more="1"><em>更多{%$video_collection|count - 4%}条视频</em><i class="icon icon-arrow-down"></i></a>
                        </li>
                        {%/if%}
                    </ul>
                </div>
            </section>
        {%/if%}

        {%if !empty($game_video)%}
            <section class="section-item video">
                <div class="hd">录像</div>
                <div class="bd">
                    <ul>
                        <li>
                            {%foreach $game_video as $val%}
                                {%if $val@index < 4%}
                                <a href="browser://{%$val.fromurl|escape:none%}">{%$val.title%}</a>
                                {%/if%}
                            {%/foreach%}
                        </li>
                        {%$game_video_left = 4-($game_video|count)%4 %}
                        {%if $game_video|count > 4%}
                        <li>
                            {%foreach $game_video as $val%}
                                {%if $val@index >= 4%}
                                <a href="browser://{%$val.fromurl|escape:none%}">{%$val.title%}</a>
                                {%/if%}
                            {%/foreach%}
                            {%section name="left" loop=$game_video_left%}
                                <a href="#" style="visibility:hidden;">加时n</a>
                            {%/section%}
                        </li>
                        {%/if%}
                    </ul>
                </div>
            </section>
        {%/if%}

        {%if (!empty($best_players.away) || !empty($best_players.home)) && $type == "nba"%}
            <section class="section-item player">
                <div class="hd">球员</div>
                <div class="bd">
                    <ul>
                        <li>
                            <div class="info">
                                <a href="kanqiu://nba/nba/player/{%$best_players.away[0].player_id%}">
                                    <span class="head"><img src="{%$best_players.away[0].header_image%}" alt="" /></span>
                                    <span class="name">{%$best_players.away[0].name%}</span>
                                </a>
                                <!-- <a href="#">
                                    <span class="fantasy">fantasy评分86 今日第3</span>
                                    <i class="icon icon-arrow-right"></i>
                                </a> -->
                            </div>
                            <div class="data">
                                <div class="item">
                                    <div class="value">{%$best_players.away[0].pts%}</div>
                                    <div class="key">得分</div>
                                </div>
                                <div class="item">
                                    <div class="value">{%$best_players.away[0].reb%}</div>
                                    <div class="key">篮板</div>
                                </div>
                                <div class="item">
                                    <div class="value">{%$best_players.away[0].asts%}</div>
                                    <div class="key">助攻</div>
                                </div>
                                <div class="item">
                                    <div class="value">{%$best_players.away[0].stl%}</div>
                                    <div class="key">抢断</div>
                                </div>
                                <div class="item">
                                    <div class="value">{%$best_players.away[0].blk%}</div>
                                    <div class="key">盖帽</div>
                                </div>
                            </div>
                        </li>
                        <li>
                            <div class="info">
                                <a href="kanqiu://nba/nba/player/{%$best_players.home[0].player_id%}">
                                    <span class="head"><img src="{%$best_players.home[0].header_image%}" alt="" /></span>
                                    <span class="name">{%$best_players.home[0].name%}</span>
                                </a>
                                <!-- <a href="#">
                                    <span class="fantasy">fantasy评分86 今日第3</span>
                                    <i class="icon icon-arrow-right"></i>
                                </a> -->
                            </div>
                            <div class="data">
                                <div class="item">
                                    <div class="value">{%$best_players.home[0].pts%}</div>
                                    <div class="key">得分</div>
                                </div>
                                <div class="item">
                                    <div class="value">{%$best_players.home[0].reb%}</div>
                                    <div class="key">篮板</div>
                                </div>
                                <div class="item">
                                    <div class="value">{%$best_players.home[0].asts%}</div>
                                    <div class="key">助攻</div>
                                </div>
                                <div class="item">
                                    <div class="value">{%$best_players.home[0].stl%}</div>
                                    <div class="key">抢断</div>
                                </div>
                                <div class="item">
                                    <div class="value">{%$best_players.home[0].blk%}</div>
                                    <div class="key">盖帽</div>
                                </div>
                            </div>
                        </li>
                    </ul>
                </div>
            </section>
        {%/if%}

        {%if (!empty($best_players.away) || !empty($best_players.home)) && $type == "cba"%}
            <section class="section-item player">
                <div class="hd">球员</div>
                <div class="bd">
                    <ul>
                        <li>
                            <div class="info">
                                <a href="kanqiu://cba/cba/player/{%$best_players.home[0].player_id%}">
                                    <span class="head"><img src="{%$best_players.home[0].header_image%}" alt="" /></span>
                                    <span class="name">{%$best_players.home[0].name%}</span>
                                </a>
                                <!-- <a href="#">
                                    <span class="fantasy">fantasy评分86 今日第3</span>
                                    <i class="icon icon-arrow-right"></i>
                                </a> -->
                            </div>
                            <div class="data">
                                <div class="item">
                                    <div class="value">{%$best_players.home[0].pts%}</div>
                                    <div class="key">得分</div>
                                </div>
                                <div class="item">
                                    <div class="value">{%$best_players.home[0].reb%}</div>
                                    <div class="key">篮板</div>
                                </div>
                                <div class="item">
                                    <div class="value">{%$best_players.home[0].asts%}</div>
                                    <div class="key">助攻</div>
                                </div>
                                <div class="item">
                                    <div class="value">{%$best_players.home[0].stl%}</div>
                                    <div class="key">抢断</div>
                                </div>
                                <div class="item">
                                    <div class="value">{%$best_players.home[0].blk%}</div>
                                    <div class="key">盖帽</div>
                                </div>
                            </div>
                        </li>
                        <li>
                            <div class="info">
                                <a href="kanqiu://cba/cba/player/{%$best_players.away[0].player_id%}">
                                    <span class="head"><img src="{%$best_players.away[0].header_image%}" alt="" /></span>
                                    <span class="name">{%$best_players.away[0].name%}</span>
                                </a>
                                <!-- <a href="#">
                                    <span class="fantasy">fantasy评分86 今日第3</span>
                                    <i class="icon icon-arrow-right"></i>
                                </a> -->
                            </div>
                            <div class="data">
                                <div class="item">
                                    <div class="value">{%$best_players.away[0].pts%}</div>
                                    <div class="key">得分</div>
                                </div>
                                <div class="item">
                                    <div class="value">{%$best_players.away[0].reb%}</div>
                                    <div class="key">篮板</div>
                                </div>
                                <div class="item">
                                    <div class="value">{%$best_players.away[0].asts%}</div>
                                    <div class="key">助攻</div>
                                </div>
                                <div class="item">
                                    <div class="value">{%$best_players.away[0].stl%}</div>
                                    <div class="key">抢断</div>
                                </div>
                                <div class="item">
                                    <div class="value">{%$best_players.away[0].blk%}</div>
                                    <div class="key">盖帽</div>
                                </div>
                            </div>
                        </li>
                    </ul>
                </div>
            </section>
        {%/if%}
    {%/if%}

    {%if $type == "football"%}
        {%if !empty($key_event.qt) || !empty($key_event.dq)%}
        <section class="section-item match">
            {%if !empty($key_event.qt)%}
            <div class="normal">
                <ul class="left">
                    {%foreach $key_event.qt[$home_tid] as $val%}
                    <li>
                        <a {%if !empty($val.event.player_id)%}href="kanqiu://soccerleagues/{%$league_name%}/player/{%$val.event.player_id%}"{%/if%} class="name">{%$val.event.player_name%}</a>
                        <span class="time">
                            {%if $val.half_id == 1 && $val.live_time > 45%}
                                45+{%$val.live_time - 45%}'
                            {%else if $val.half_id == 2 && $val.live_time > 90%}
                                90+{%$val.live_time - 90%}'
                            {%else if $val.half_id == 3 && $val.live_time > 105%}
                                105+{%$val.live_time - 105%}'
                            {%else if $val.half_id == 4 && $val.live_time > 120%}
                                120+{%$val.live_time - 120%}'
                            {%else%}
                                {%$val.live_time%}'
                            {%/if%}
                        </span>
                        <span class="icon-wrap">
                            {%if $val.event.id == 11%}
                            <span class="icon icon-goal"></span>
                            {%else if $val.event.id == 17%}
                            <span class="icon icon-point"></span>
                            {%else if $val.event.id == 28%}
                            <span class="icon icon-own"></span>
                            {%else if $val.event.id == 3%}
                            <span class="icon icon-red"></span>
                            {%else if $val.event.id == 18%}
                            <span class="icon icon-point-miss"></span>
                            {%/if%}
                        </span>
                    </li>
                    {%/foreach%}
                </ul>
                <ul class="right">
                    {%foreach $key_event.qt[$away_tid] as $val%}
                    <li>
                        <span class="icon-wrap">
                            {%if $val.event.id == 11%}
                            <span class="icon icon-goal"></span>
                            {%else if $val.event.id == 17%}
                            <span class="icon icon-point"></span>
                            {%else if $val.event.id == 28%}
                            <span class="icon icon-own"></span>
                            {%else if $val.event.id == 3%}
                            <span class="icon icon-red"></span>
                            {%else if $val.event.id == 18%}
                            <span class="icon icon-point-miss"></span>
                            {%/if%}
                        </span>
                        <span class="time">
                            {%if $val.half_id == 1 && $val.live_time > 45%}
                                45+{%$val.live_time - 45%}'
                            {%else if $val.half_id == 2 && $val.live_time > 90%}
                                90+{%$val.live_time - 90%}'
                            {%else if $val.half_id == 3 && $val.live_time > 105%}
                                105+{%$val.live_time - 105%}'
                            {%else if $val.half_id == 4 && $val.live_time > 120%}
                                120+{%$val.live_time - 120%}'
                            {%else%}
                                {%$val.live_time%}'
                            {%/if%}
                        </span>
                        <a {%if !empty($val.event.player_id)%}href="kanqiu://soccerleagues/{%$league_name%}/player/{%$val.event.player_id%}"{%/if%} class="name">{%$val.event.player_name%}</a>
                    </li>
                    {%/foreach%}
                </ul>
            </div>
            {%/if%}

            {%if !empty($key_event.dq)%}
            <div class="penalty-kick">
                <div class="title">点球大战</div>
                <div class="inner">
                    <ul class="left" {%if $key_event.dq_first_tid == $away_tid%}style="margin-top:10px;"{%/if%}>
                        {%foreach $key_event.dq[$home_tid] as $val%}
                        <li>
                            <a {%if !empty($val.event.player_id)%}href="kanqiu://soccerleagues/{%$league_name%}/player/{%$val.event.player_id%}"{%/if%} class="name">{%$val.event.player_name%}</a>
                            <span class="time">{%$val.live_time%}'</span>
                            <span class="icon-wrap">
                                {%if $val.event.id == 17%}
                                <span class="icon icon-point"></span>
                                {%else if $val.event.id == 18%}
                                <span class="icon icon-point-miss"></span>
                                {%/if%}
                            </span>
                        </li>
                        {%/foreach%}
                    </ul>
                    <ul class="right" {%if $key_event.dq_first_tid == $home_tid%}style="margin-top:10px;"{%/if%}>
                        {%foreach $key_event.dq[$away_tid] as $val%}
                        <li>
                            <span class="icon-wrap">
                                {%if $val.event.id == 17%}
                                <span class="icon icon-point"></span>
                                {%else if $val.event.id == 18%}
                                <span class="icon icon-point-miss"></span>
                                {%/if%}
                            </span>
                            <span class="time">{%$val.live_time%}'</span>
                            <a {%if !empty($val.event.player_id)%}href="kanqiu://soccerleagues/{%$league_name%}/player/{%$val.event.player_id%}"{%/if%} class="name">{%$val.event.player_name%}</a>
                        </li>
                        {%/foreach%}
                    </ul>
                </div>
            </div>
            {%/if%}
        </section>
        {%/if%}
    {%/if%}

    {%if !empty($recap) || !empty($list)%}
        <section class="section-item recap" id="J-main">
            <div class="bd">
                {%if $type == "football" && ($is_custom == "1" || !isset($is_custom))%}
                    <ul class="list">
                        {%foreach $list as $val%}
        				<li>
                            <span class="time">{%if !empty($val.match_time)%}{%$val.match_time%}'{%/if%}</span>
    						<p {%if empty($val.match_time)%}style="margin-left:0px;"{%/if%}>
                                {%$val.desc|escape:none%}
                                {%if $val.img_url%}
        							{%if $nopic%}
        			                    {%$defaultPic="//w3.hoopchina.com.cn/hybrid/resource/img/news_gif_nopic_2x_day.png?t={%$val@index%}"%}
        			                    {%if $night%}
        			                        {%$defaultPic="//w3.hoopchina.com.cn/hybrid/resource/img/news_gif_nopic_2x_night.png?t={%$val@index%}"%}
        			                    {%/if%}
        			                    {%if $val.img_url_src%}
        			                    <img src="{%$defaultPic%}" data-src="{%$val.img_url_src%}" data-gif="{%$val.img_url%}" alt="GIF {%$val.img_size%}MB"/>
        			                    {%else%}
        			                    <img src="{%$defaultPic%}" data-src="{%$val.img_url%}"/>
        			                    {%/if%}
        			                {%else%}
        			                    {%if $val.img_url_src%}
        			                    <img src="{%$val.img_url_src%}" data-gif="{%$val.img_url%}" alt="GIF {%$val.img_size%}MB"/>
        			                    {%else%}
        			                    <img src="{%$val.img_url%}"/>
        			                    {%/if%}
        			                {%/if%}
        		                {%/if%}
                            </p>
        				</li>
        				{%/foreach%}
                    </ul>
                {%else%}
                    <div class="gdc">
                        {%if $type == "cba"%}
                            {%$recap.content|escape:none%}
                        {%else%}
                            {%$recap|escape:none%}
                        {%/if%}
                    </div>
                {%/if%}
            </div>
        </section>
    {%/if%}

    {%if !empty($light_reply)%}
        <section class="section-item comments">
            <div class="hd">论坛亮回帖</div>
            <div class="bd">
                <ul>
                    {%foreach $light_reply as $val%}
                    <li>
                        <div class="user-info">
                            <div class="info">
                                <span class="head"><img src="{%$val.userImg%}?t={%$val@index%}" alt="" /></span>
                                <span class="name">{%$val.userName%}</span>
                            </div>
                            <div class="light">亮了 ({%$val.light_count%})</div>
                        </div>
                        <p>{%$val.content|escape:none%}</p>
                    </li>
                    {%/foreach%}
                    <li class="more"><a href="kanqiu://bbs/topic/{%$tid%}">更多论坛精彩讨论&nbsp;&nbsp;<i class="icon icon-arrow-right"></i></a></li>
                </ul>
            </div>
        </section>
    {%/if%}
{%else%}
    <section class="no-result">
        {%if $type == "nba"%}
        暂无战报，请先去「统计」看看吧
        {%else if $type == "football"%}
        暂无战报，请先去「赛况」看看吧
        {%/if%}
    </section>
{%/if%}
