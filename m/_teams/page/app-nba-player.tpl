{%extends file="common/page/layout.tpl"%}

{%block name="title"%}
    {%if !empty($is_app)%}
        {%$info.name%}
    {%else%}
        {%$pageheader.title%}
    {%/if%}
{%/block%}

{%block name="block_head_static"%}
    {%require name="teams:static/app-nba-player/app-nba-player.scss"%}
    {%require name="common:static/js/swiper_new/swiper.css"%}
    {%require name="common:static/js/swiper_new/swiper.jquery.js"%}

    <script type="text/javascript" src="//w10.hoopchina.com.cn/hybrid/common/hpbridge_v1.0.2.js"></script>
    {%script%}
        {%if empty($is_app)%}
            var toShare = require("common:widget/ui/share/share.js");
            //全局分享事件, 每个页面单独注册.
            $(document).on("page:share", function(){
            	toShare();
            });
        {%/if%}

		window.GM = {
            "client": "{%$kanqiu.client%}" || "x",
            "projectId": "{%$kanqiu.projectId%}" || "3",
            "version": "{%$kanqiu.version%}" || "x",
            "night": !!parseInt("{%$kanqiu.night%}", 10),
            "type": "{%$type%}" || "nba",
            "player_name": "{%$info.name%}",
            "player_enname": "{%$info.eng_name%}",
            "cur_url": "{%$cur_url%}",
            "player_id": "{%$info.id%}",
            "isBirth": !!parseInt("{%$info.is_birthday%}", 10),
            "isApp": !!parseInt("{%$is_app%}", 10)
        };

        var nbaPlayer = require("teams:widget/app-nba-player/app-nba-player.js");
        nbaPlayer.init();
    {%/script%}
{%/block%}
{%block name="content"%}
    {%if empty($is_app)%}
    {%widget
        name="common:widget/new-top-nav/new-top-nav.tpl"
        hasBreadNav=false
    %}

    {%widget
        name="common:widget/inner-top-nav/nav.tpl"
    %}
    {%/if%}

    <section class="nba-player-wrap" id="J-nba-player-wrap">
		<section class="info">
            <div class="head">
				<img src="{%$info.big_photo%}">
				{%if !empty($kanqiu.night)%}<div class="mask"></div>{%/if%}
			</div>
			<ul class="detail">
                {%if !empty($is_app)%}
                {%$arr=[]%}
                {%if !empty($team_name)%}
                    {%$tmp=array_push($arr,$team_name)%}
                {%/if%}
                {%if $info.number != ""%}
                    {%$tmp=array_push($arr,$info.number|cat:"号")%}
                {%/if%}
                {%if !empty($info.positionZhName)%}
                    {%$tmp=array_push($arr,$info.positionZhName)%}
                {%/if%}

				<li>
                    {%foreach $arr as $val%}
                        <span>{%$val%}</span>
                        {%if $val@index != $arr|count - 1%}
                        <i class="separator">|</i>
                        {%/if%}
                    {%/foreach%}
				</li>
				<li>
                    {%if $info.team_id != 0%}
    					{%if !empty($info.death_time)%}
    						<span>逝世({%$info.birth_date_fix2%}-{%$info.death_time%})</span>
    					{%else%}
    						<span>
    							<span class="birth-status J-birth-status">
    								<img src="//w1.hoopchina.com.cn/hybrid/resource/emoji/2x/1f382.png?t=1" width="15" height="15">
    							</span>
    							{%$info.age%}岁
    							<span class="birth-status J-birth-status">
    								<img src="//w1.hoopchina.com.cn/hybrid/resource/emoji/2x/1f382.png" width="15" height="15">
    							</span>
    						</span>
    						{%if !empty($info.birth_date_fix2) && !empty($info.age)%}
                                <i class="separator">|</i>
    						{%/if%}
                            <span id="J-birth-date">{%$info.birth_date_fix2%}</span>
    					{%/if%}
                    {%else%}
                        <span id="J-birth-date">{%$info.birth_date_fix2%}</span>
                    {%/if%}
				</li>
                <li>
                    {%if !empty($info.country)%}
                        {%foreach $info.country as $val%}
                        <span class="country">
                            <span class="flag" style="background-image:url(//b3.hoopchina.com.cn/images/country/{%$val%}.jpg);">{%if !empty($kanqiu.night)%}<div class="mask"></div>{%/if%}</span><span class="name">{%$val%}</span>
                        </span>&nbsp;&nbsp;
                        {%/foreach%}
                    {%/if%}
                </li>
                {%else%}
                <li>
                    {%if !empty($info.name)%}
                        <span>{%$info.name%}</span>
                        {%if !empty($info.name) && !empty($info.eng_name)%}
                            <i class="separator">|</i>
                        {%/if%}
                        <span>{%$info.eng_name%}</span>
                    {%else%}
                        <span>{%$info.eng_name%}</span>
                    {%/if%}
                </li>
                <li>
					{%if $info.number!=""%}
                        <span>{%$info.number%}号</span>
					{%/if%}
                    {%if ($info.number!="" && !empty($info.positionZhName)) || ($info.number!="" && !empty($info.country))%}
		                 <i class="separator">|</i>
					{%/if%}
					<span>{%$info.positionZhName%}</span>
                    {%if !empty($info.positionZhName) && !empty($info.country)%}
		                 <i class="separator">|</i>
					{%/if%}
                    {%if !empty($info.country)%}
                         {%foreach $info.country as $val%}
                         <span class="country">
                             <span class="flag" style="background-image:url(//b3.hoopchina.com.cn/images/country/{%$val%}.jpg);">{%if !empty($kanqiu.night)%}<div class="mask"></div>{%/if%}</span><span class="name">{%$val%}</span>
                         </span>&nbsp;&nbsp;
                         {%/foreach%}
                    {%/if%}
				</li>
                <li>
                    {%if $info.team_id != 0%}
                        {%if !empty($info.death_time)%}
                            <span>逝世({%$info.birth_date_fix2%}-{%$info.death_time%})</span>
                        {%else%}
                            <span>
                                <span class="birth-status J-birth-status">
                                    <img src="//w1.hoopchina.com.cn/hybrid/resource/emoji/2x/1f382.png?t=1" width="15" height="15">
                                </span>
                                {%$info.age%}岁
                                <span class="birth-status J-birth-status">
                                    <img src="//w1.hoopchina.com.cn/hybrid/resource/emoji/2x/1f382.png" width="15" height="15">
                                </span>
                            </span>
                            {%if !empty($info.birth_date_fix2) && !empty($info.age)%}
                                <i class="separator">|</i>
                            {%/if%}
                            <span id="J-birth-date">{%$info.birth_date_fix2%}</span>
                        {%/if%}
                    {%else%}
                        <span id="J-birth-date">{%$info.birth_date_fix2%}</span>
                    {%/if%}
                </li>
                {%/if%}
			</ul>
		</section>
		<ul class="tab clearfix" id="J-tab">
			<li class="active">资料</li>
			<li class="tab-map" data-playerid="{%$info.player_id%}">投篮热图</li>
			<li>数据</li>
            <li>新闻</li>
		</ul>
		<div class="swiper-container">
			<div class="swiper-wrapper">
				<section class="t-content swiper-slide t-info">
					<ul class="section body-list">
						<li>
							<div class="num">
                                <span>{%$info.height_fix|default:"不详"%}
                                {%if !empty($info.height_fix)%}
                                <i>米</i>
                                {%/if%}
                                </span>
                            </div>
                            <div class="type">身高</div>
						</li>
						<li>
							<div class="num">
                                <span>{%$info.wingspan|default:"不详"%}
                                    {%if !empty($info.wingspan)%}
                                    <i>米</i>
                                    {%/if%}
                                </span>
                            </div>
                            <div class="type">臂展</div>
						</li>
                        <li>
							<div class="num">
                                <span>{%$info.standing_reach|default:"不详"%}
                                    {%if !empty($info.standing_reach)%}
                                    <i>米</i>
                                    {%/if%}
                                </span>
                            </div>
                            <div class="type">站立摸高</div>
						</li>
                        <li>
							<div class="num">
                                <span>{%$info.weight_fix|default:"不详"%}
                                    {%if !empty($info.weight_fix)%}
                                    <i class="two">公斤</i>
                                    {%/if%}
                                </span>
                            </div>
                            <div class="type">体重</div>
						</li>
                        <!-- <li>
							<div class="num">右手</div>
                            <div class="type">惯用手</div>
                        </li> -->
					</ul>
                    {%if !empty($info.draft_year)||!empty($info.draft_round)||!empty($info.draft_pick)||!empty($info.college)||!empty($info.salary)||!empty($info.contract)%}
					<div class="section info-list">
						<table width="100%">
							{%if !empty($injury)%}
								<tr>
									{%if $injury.injury_state == "1" %}
										<td  class="td1" width="26%"><img src="../static/app-nba-player/img/player_add.png" alt="22" width="19" height="19"></td>
									{%else%}
										<td  class="td1" width="26%"><img src="../static/app-nba-player/img/player_doubt.png" alt="22" width="19" height="19"></td>
									{%/if%}
									<td width="20%">伤停</br>
										<span>
											{%if !empty($injury.injury_part_cn) %}
												{%$injury.injury_part_cn%}
											{%else%}
												{%$injury.injury_part%}
											{%/if%}
										</span>
									</td>
									<td width="25%">起始时间</br><span>{%date('n月j日', strtotime($injury.injury_date))%}</span></td>
									<td>最新进展</br>
										<span>
											{%if !empty($injury.injury_returns_cn) %}
												{%$injury.injury_returns_cn%}
											{%else%}
												<span class="injury_returns_en">{%$injury.injury_returns%}</span>
											{%/if%}
										</span>
									</td>
								</tr>
								<tr>
									<td></td>
									<td colspan="3" class="hurt-detail">
										{%if !empty($injury.injury_detail_cn) %}
												{%$injury.injury_detail_cn%}
											{%else%}
												{%$injury.injury_detail%}
											{%/if%}
									</td>
								</tr>
							{%/if%}
							{%if !empty($info.draft_year) || !empty($info.draft_round) || !empty($info.draft_pick)%}
							<tr>
								<td  width="26%" class="td1">选秀</td>
								<td class="td2" colspan="3">
                                    {%if $info.territorial_pick == 1%}
                                        {%$info.draft_year%}年 地域选秀
                                        <a href=" https://nba.hupu.com/wiki/%E5%9C%B0%E5%9F%9F%E9%80%89%E7%A7%80" rel="noreferrer">
                                            <i class="icon-notice"></i>
                                        </a>
                                    {%else%}
                                        {%$info.draft_year%}年第{%$info.draft_round%}轮第{%$info.draft_pick%}顺位
                                    {%/if%}
                                </td>
							</tr>
							{%/if%}
							{%if !empty($info.college_school)%}
							<tr>
								<td  width="26%" class="td1">来自</td>
								<td class="td2" colspan="3">{%$info.college_school%}</td>
							</tr>
							{%/if%}
							{%if !empty($info.salary)%}
							<tr>
								<td  width="26%" class="td1">薪水</td>
								<td class="td2" colspan="3">{%$info.salary%}万美元</td>
							</tr>
							{%/if%}
							{%if !empty($info.wage)%}
							<tr>
								<td  width="26%" class="td1" valign="top">合同</td>
								<td class="td2" class="no-copy" colspan="3">
									<div>{%$info.wage%}</div>
									<div class="contract-details" style="display:none;">
										{%$info.contract_details%}
									</div>
                                    {%if !empty($info.contract_details)%}
                                    <div class="btn-detail" id="J-btn-detail"><i class="icon icon-down"></i><span>详细</span></div>
                                    {%/if%}
								</td>
							</tr>
							{%/if%}
						</table>
					</div>
					{%/if%}
					{%if !empty($info.extend)%}
					<div class="section analyze">
						<h2>扩展阅读</h2>
						<ul>
    						{%foreach $info.extend as $val%}
    							<li class="li-item
                                    {%if $info.extend|count <= 4%}
                                        {%if $val@index > 3%}more-li{%/if%}
                                    {%else%}
                                        {%if $val@index > 2%}more-li{%/if%}
                                    {%/if%}
                                ">
    								<a href="{%$val.video_link|escape:none%}" dace-node="nbawiki" rel="noreferrer">
    									<div class="link-title">
    										<p class="title">{%$val.video_title%}</p>
    									</div>
    									<em><i></i></em>
    								</a>
    							</li>
    						{%/foreach%}
                            {%if $info.extend|count > 4%}
                            <li class="other-item">
                                <input type="hidden" name="name" id="left-video" value="{%$info.extend|count - 3%}">
                                <a href="javascript:;" id="J-more" class="more" data-more="1"><em>更多{%$info.extend|count - 3%}篇</em><i class="icon icon-arrow-down"></i></a>
                            </li>
                            {%/if%}
						</ul>
					</div>
					{%/if%}
                    {%if !empty($equip)%}
                    <div class="section ad-info">
                        <div class="hd">
                            <span>{%if !empty($equip.name)%}{%$equip.name%}{%else%}{%$equip.eng_name%}{%/if%}上脚装备</span>
                            {%if !empty($equip.equip_info[0].more_href)%}
                            <a href="{%$equip.equip_info[0].more_href%}" dace-node="shihuomore">查看更多<i></i></a>
                            {%/if%}
                        </div>
                        <div class="bd">
                            <a href="{%$equip.equip_info[0].href%}" dace-node="shihuoclick">
                                <div class="pic">
                                    <img src="{%$equip.equip_info[0].img%}" alt="{%$equip.equip_info[0].title%}" />
                                    <div class="mask"></div>
                                </div>
                                <div class="text">
                                    <div class="title">{%$equip.equip_info[0].title%}</div>
                                    <div class="content">{%$equip.equip_info[0].description%}</div>
                                    <div class="price">识货全网低价<span>&yen;{%$equip.equip_info[0].price%}</span>起</div>
                                </div>
                            </a>
                        </div>
                    </div>
                    {%/if%}
					<div class="section data-list data-list1">
						<h2>赛季数据</h2>
						<ul class="clearfix">
							{%foreach $rank as $val%}
							 	{%if $val@index < 16 %}
								<li class="mb">
								{%else%}
								<li>
								{%/if%}
									<div class="num">{%$val[2]%}</div>
                                    <div class="type">{%$val[0]%}</div>
									{%if !empty($val[1]) && $val[1] < 100%}
			                            <div class="rank">
                                            <a {%if !empty($is_app)%}class="app-a"{%/if%}href="{%if !empty($is_app) && !empty($val[3])%}{%$val[3]|escape:none%}{%else%}javascript:void(0);{%/if%}">联盟第<span>{%$val[1]%}</span>&nbsp;{%if !empty($is_app) && !empty($val[3])%}<i></i>{%/if%}</a>
                                        </div>
									{%/if%}
								</li>
							{%/foreach%}
						</ul>
					</div>
                    <div class="section data-list data-list2">
						<h2>进阶数据</h2>
						<ul class="clearfix">
							{%foreach $advance as $val%}
							 	{%if $val@index < 8 %}
								<li class="mb">
								{%else%}
								<li>
								{%/if%}
									<div class="num">{%$val[2]%}</div>
                                    <div class="type">{%$val[0]%}</div>
									{%if !empty($val[1]) && $val[1] < 100%}
									<div class="rank">
                                        <a {%if !empty($is_app)%}class="app-a"{%/if%} href="{%if !empty($is_app)%}{%$val[3]|escape:none%}{%else%}javascript:void(0);{%/if%}">联盟第<span>{%$val[1]%}</span>&nbsp;{%if !empty($is_app)%}<i></i>{%/if%}</a>
                                    </div>
									{%/if%}
								</li>
							{%/foreach%}
						</ul>
                        <div class="analyze">
    						<ul>
        						<li class="li-item">
        							<a href="https://nba.hupu.com/wiki/%E8%BF%9B%E9%98%B6%E6%95%B0%E6%8D%AE" rel="noreferrer">
        								<div class="link-title">
        									<p class="title">虎扑篮球百科：PER、WS等进阶数据说明</p>
        								</div>
        								<em><i></i></em>
        							</a>
        						</li>
    						</ul>
    					</div>
					</div>
				</section>

				<section class="t-content swiper-slide t-map" id="J-t-map">
					<!--
					level 1 2 3分别代表了投篮命中率的高低
					1：#ff7838（红）
					2：#ffd303（黄）
					3：#58cce0（蓝）
					4: #eeebeb (灰，代表此处无投篮次数)
					 -->
                     <div class="map-data" id="J-map-data">
 						<script id="J-map-tpl" type="text/template">
 							<@ $(datas).each(function(index,item){ @>
 							<input type="hidden" class="area_<@=item.areaId@>" data-fgp="<@=item.fgp@>" data-fgs="<@=item.fgs@>" <@ if(item.level ==1){ @>data-color="#ff7838"<@ }else if(item.level ==2){ @>data-color="#ffd303"<@ }else if(item.level ==3){ @>data-color="#58cce0"<@ }else{ @>data-color="#eeebeb"<@ } @> data-fgm="<@=item.fgm@>">
 							<@ }); @>
 						</script>
 					</div>
					<div class="canvas-wrap">
						{%if empty($kanqiu.night)%}
						<div class="hoop hoop-day"></div>
						{%else%}
						<div class="hoop hoop-night"></div>
						{%/if%}
						<canvas id="myCanvas" width="750" height="700"></canvas>
						<div class="update-time">
							<span></span>更新
						</div>
						{%if !empty($kanqiu.night)%}
						<div class="mask"></div>
						{%/if%}
						<div class="logo"></div>
					</div>
					<div class="condition clearfix">
						<div class="select fl">
							<div class="inner">
								<div class="default"><span>{%$season|mb_substr:2:2:'utf-8'%}-{%$season|mb_substr:2:2:'utf-8' + 1%}</span>赛季<i></i></div>
								<ul class="option" style="display: none;">
									{%foreach $season_list as $val%}
									<li data-season="20{%$val|truncate:2:''%}" data-text="{%$val%}">{%$val%}赛季</li>
									{%/foreach%}
								</ul>
							</div>
						</div>
						<div class="radio fr">
							<input type="hidden" id="J-season-type" value="{%$season_type%}">
							<div class="inner">
								{%if $season_type == "regular"%}
								<span class="active" data-type="regular">常规赛</span><span data-type="playoff">季后赛</span>
								{%else%}
								<span data-type="regular">常规赛</span><span class="active" data-type="playoff">季后赛</span>
								{%/if%}
							</div>
						</div>
					</div>
					<dl class="tips">
						<dt>三个数据分别是：该区域的命中率、命中数和出手数</dt>
						<dd><span class="red"></span> 命中率高于联盟平均水平</dd>
						<dd><span class="yellow"></span> 命中率处于联盟平均水平</dd>
						<dd><span class="blue"></span> 命中率低于联盟平均水平</dd>
					</dl>
				</section>

				<section class="t-content swiper-slide t-data">
                    <div class="section clearfix">
                        <div class="left-table fl">
    						<table>
    							<thead>
    								<tr>
                                        <td>常规赛</td>
                                        <td>球队</td>
    								</tr>
    							</thead>
    							<tbody>
    								{%foreach $career.regular as $val%}
    								<tr>
    									<td>{%$val.season%}</td>
    									<td>{%$val.team_name%}</td>
    								</tr>
    								{%/foreach%}
    							</tbody>
    							<thead>
    								<tr>
                                        <td>季后赛</td>
                                        <td>球队</td>
    								</tr>
    							</thead>
    							<tbody>
    								{%foreach $career.playoff as $val%}
    								<tr>
    									<td>{%$val.season%}</td>
    									<td>{%$val.team_name%}</td>
    								</tr>
    								{%/foreach%}
    							</tbody>
    						</table>
    					</div>
    					<div class="right-table fr swiper-no-swiping">
    						<table>
    							<thead>
    								<tr>
                                        <td>年龄</td>
    									<td>出场</td>
                                        <td>首发</td>
                                        <td>时间</td>
                                        <td>得分</td>
                                        <td>篮板</td>
                                        <td>前板</td>
                                        <td>后板</td>
                                        <td>助攻</td>
                                        <td>抢断</td>
                                        <td>盖帽</td>
                                        <td>投篮</td>
                                        <td>三分</td>
                                        <td>eFG%</td>
                                        <td>罚球</td>
                                        <td>TS%</td>
                                        <td>失误</td>
                                        <td>犯规</td>
    								</tr>
    							</thead>
    							<tbody>
    								{%foreach $career.regular as $val%}
    								<tr>
                                        <td>{%$val.age%}</td>
    									<td>{%$val.game_play%}</td>
    									<td>{%$val.game_start%}</td>
    									<td>{%$val.min%}</td>
    									<td>{%$val.pts%}</td>
    									<td>{%$val.reb%}</td>
                                        <td>{%$val.oreb%}</td>
                                        <td>{%$val.dreb%}</td>
    									<td>{%$val.asts%}</td>
                                        <td>{%$val.stl%}</td>
                                        <td>{%$val.blk%}</td>
                                        <td>{%$val.fga%}</td>
                                        <td>{%$val.tpa%}</td>
                                        <td>{%$val.efgp%}</td>
                                        <td>{%$val.fpt%}</td>
                                        <td>{%$val.tsp%}</td>
                                        <td>{%$val.to%}</td>
                                        <td>{%$val.pf%}</td>
    								</tr>
    								{%/foreach%}
    							</tbody>
    							<thead>
    								<tr>
                                        <td>年龄</td>
    									<td>出场</td>
                                        <td>首发</td>
                                        <td>时间</td>
                                        <td>得分</td>
                                        <td>篮板</td>
                                        <td>前板</td>
                                        <td>后板</td>
                                        <td>助攻</td>
                                        <td>抢断</td>
                                        <td>盖帽</td>
                                        <td>投篮</td>
                                        <td>三分</td>
                                        <td>eFG%</td>
                                        <td>罚球</td>
                                        <td>TS%</td>
                                        <td>失误</td>
                                        <td>犯规</td>
    								</tr>
    							</thead>
    							<tbody>
    								{%foreach $career.playoff as $val%}
    								<tr>
                                        <td>{%$val.age%}</td>
    									<td>{%$val.game_play%}</td>
    									<td>{%$val.game_start%}</td>
    									<td>{%$val.min%}</td>
    									<td>{%$val.pts%}</td>
    									<td>{%$val.reb%}</td>
                                        <td>{%$val.oreb%}</td>
                                        <td>{%$val.dreb%}</td>
    									<td>{%$val.asts%}</td>
                                        <td>{%$val.stl%}</td>
                                        <td>{%$val.blk%}</td>
                                        <td>{%$val.fga%}</td>
                                        <td>{%$val.tpa%}</td>
                                        <td>{%$val.efgp%}</td>
                                        <td>{%$val.fpt%}</td>
                                        <td>{%$val.tsp%}</td>
                                        <td>{%$val.to%}</td>
                                        <td>{%$val.pf%}</td>
    								</tr>
    								{%/foreach%}
    							</tbody>
    						</table>
    					</div>
                    </div>
                    <div class="section analyze">
						<ul>
    						<li class="li-item">
    							<a href="https://nba.hupu.com/wiki/%E8%BF%9B%E9%98%B6%E6%95%B0%E6%8D%AE" rel="noreferrer">
    								<div class="link-title">
    									<p class="title">虎扑篮球百科：PER、WS等进阶数据说明</p>
    								</div>
    								<em><i></i></em>
    							</a>
    						</li>
						</ul>
					</div>
				</section>

                <section class="t-content swiper-slide t-news" id="J-t-news">
                    <ul id="J-news-wrap">
                        <script id="J-news-tpl" type="text/template">
                            <@ $(datas).each(function(index,item){ @>
                            <li>
                                <a href="
                                <@if(GM.isApp){@>
                                    <@=item.app_url@>
                                <@}else{@>
                                    <@=item.m_url@>
                                <@}@>">
                                    <div class="pic" style="background-image:url(<@=item.img@>);"><@if(GM.night){@><div class="mask"></div><@}@></div>
                                    <div class="text">
                                        <div class="title"><@=item.title@></div>
                                        <div class="intro"><@=item.summary@></div>
                                    </div>
                                    <div class="comment"><i></i><@=item.replies@></div>
                                </a>
                            </li>
                            <@ }); @>
                        </script>
                    </ul>
                </section>
            </div>
		</div>
	</section>
{%/block%}
