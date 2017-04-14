{%$data=[]%}
{%** 球队tab **%}
{%if $tabClass == "team"%}
    {%$data=[
        [
            "iconClass"=>"icon-news",
            "name"=>"新闻",
            "url"=>"{%$news_link%}"
        ],
        [
            "iconClass"=>"icon-schedule",
            "name"=>"赛程",
            "url"=>"{%$schedule_link%}"
        ],
        [
            "iconClass"=>"icon-players",
            "name"=>"球员",
            "url"=>"{%$players_link%}"
        ],
        [
            "iconClass"=>"icon-data",
            "name"=>"数据",
            "dace"=>"{%$id4dace%}_live_{%$gameInfo.match_id%}",
            "url"=>"{%$stats_link%}"
        ]
    ]%}
{%elseif $tabClass == "players"%}
{%** 球员tab **%}
    {%$data=[
    [
        "iconClass"=>"icon-technical",
        "name"=>"技术统计",
        "url"=>"/nba/players/{%strtolower($playerBasic.first_name)%}{%strtolower($playerBasic.last_name)%}-{%$playerBasic.id%}/"
    ],
    [
        "iconClass"=>"icon-data",
        "name"=>"赛季数据",
        "url"=>"/nba/players/{%strtolower($playerBasic.first_name)%}{%strtolower($playerBasic.last_name)%}-{%$playerBasic.id%}/1"
    ],
    [
        "iconClass"=>"icon-data",
        "name"=>"生涯数据",
        "url"=>"/nba/players/{%strtolower($playerBasic.first_name)%}{%strtolower($playerBasic.last_name)%}-{%$playerBasic.id%}/2"
    ]
]%}

{%elseif $tabClass == "match"%}
    {%**
         比赛相关的tab数据
         比赛前: 无tab
         比赛中: 文字直播和统计
         比赛后: 文字直播、统计、战报、视频
         全局的
            $gameInfo.hasvideo = 0/1. 表示有无视频tab.
            $gameInfo.recap_title 表示战报的标题. 不存在则为"".
    **%}
    {%$data=[
        [
            "iconClass"=>"icon-text-live",
            "name"=>"文字直播",
            "dace"=>"{%$id4dace%}_live_{%$gameInfo.match_id%}",
            "url"=>"/nba/game/playbyplay_{%$gameInfo.match_id%}.html"
        ],
        [
            "iconClass"=>"icon-data",
            "name"=>"统计",
            "dace"=>"{%$id4dace%}_stats_{%$gameInfo.match_id%}",
            "url"=>"/nba/game/boxscore_{%$gameInfo.match_id%}.html"
        ]
    ]%}
    {%if !empty($gameInfo)%}
        {%$hasRecap = isset($gameInfo.recaptext) && $gameInfo.recaptext != ""%}
        {%$hasVideo = isset($gameInfo.hasvideo) && intval($gameInfo.hasvideo) === 1%}
        {%if $hasRecap%}
          {%$data = array_merge($data, [
                [
                    "iconClass"=>"icon-report",
                    "name"=>"战报",
                    "url" => "/nba/game/recap_{%$gameInfo.match_id%}.html"
                ]
            ])%}
        {%/if%}
        {%if $hasVideo%}
          {%$data = array_merge($data, [
                [
                    "iconClass"=>"icon-video",
                    "name"=>"视频",
                    "url" => "/nba/game/video_{%$gameInfo.match_id%}.html"
                ]
            ])%}
        {%/if%}
    {%/if%}
{%elseif $tabClass == "soccermatch"%}

    {%**
        足球比赛的数据
        比赛前:有阵容事件、统计链接不可点
        比赛中:阵容、事件、统计
        比赛后:阵容、事件、统计、战报
    **%}
    {%$data=[
        [
            "iconClass"=>"icon-line-up",
            "name"=>"阵容",
            "url"=>"{%$gameInfo.page_urls.lineup_url%}"
        ]
    ]%}

    {%if !empty($gameInfo) && isset($gameInfo.game_status) %}
        {%if isset($gameInfo.game_status) && $gameInfo.game_status == 0%}
            {%$data = array_merge($data, [
                [
                    "iconClass"=>"icon-event",
                    "name"=>"事件",
                    "url"=>"javascript:"
                ],
                [
                    "iconClass"=>"icon-data",
                    "name"=>"统计",
                    "url"=>"javascript:"
                ]
            ])%}
        {%else%}
            {%$data = array_merge($data, [
                [
                    "iconClass"=>"icon-event",
                    "name"=>"事件",
                    "url"=>"{%$gameInfo.page_urls.event_url%}"
                ],
                [
                    "iconClass"=>"icon-data",
                    "name"=>"统计",
                    "url"=>"{%$gameInfo.page_urls.stat_url%}"
                ]
            ])%}
        {%/if%}

        {%if $gameInfo.game_status == 30%}
            {%$data = array_merge($data, [
                [
                    "iconClass"=>"icon-report",
                    "name"=>"战报",
                    "url"=>"{%$gameInfo.page_urls.recap_url%}"
                ]
            ])%}
        {%/if%}
    {%/if%}

{%elseif $tabClass == "matchafter"%}
    {%**季后赛的数据**%}
    {%$data=[
        [
            "iconClass"=>"icon-top",
            "name"=>"排行",
            "url"=>"/nba/standings"
        ],
        [
            "iconClass"=>"icon-data",
            "name"=>"常规赛",
            "url"=>"/nba/stats"
        ]
    ]%}
{%elseif $tabClass == "soccer-team"%}
    {%**球队tab**%}
    {%$data=[
        [
            "iconClass"=>"icon-news",
            "name"=>"新闻",
            "url"=> $teamInfo["page_urls"]["news_url"]
        ],
        [
            "iconClass"=>"icon-schedule",
            "name"=>"赛程",
            "url"=> $teamInfo["page_urls"]["match_url"]
        ],
        [
            "iconClass"=>"icon-line-up",
            "name"=>"阵容",
            "url"=> $teamInfo["page_urls"]["players_url"]
        ],
        [
            "iconClass"=>"icon-data",
            "name"=>"场均数据",
            "url"=> $teamInfo["page_urls"]["stats_url"]
        ]
    ]%}
{%elseif $tabClass == "soccer-players"%}
    {%**球员tab**%}
    {%$data=[
        [
            "iconClass"=>"icon-report",
            "name"=>"基本信息",
            "url"=> $playerInfo["page_urls"]["info_url"]
        ],
        [
            "iconClass"=>"icon-technical",
            "name"=>"单场数据",
            "url"=>$playerInfo["page_urls"]["stats_url"]
        ]
    ]%}
{%/if%}

<nav class="nav-tab" id="J_fixednavTab">
    <ul class="nav-tab-list">
        {%foreach from=$data item=val key=keys%}
            {%**因为存在随机的tab数量，所以也可以使用name对比.**%}
            {%$isSelected = (($val@index+1) == $selected) || ($val.name == $selected)%}
            <li {%if $isSelected%}class="active"{%/if%}>
                <a href="{%if $isSelected%}javascript:{%else%}{%$val.url%}{%/if%}" dace-node="{%if !empty($val.dace)%}{%$val.dace%}{%/if%}">
                    <i class="{%$val.iconClass%}"></i>
                    {%$val.name%}
                </a>
            </li>
        {%/foreach%}
    </ul>
</nav>
{%script%}
    var innerTab = require("common:widget/inner-tab/tab.js");
    innerTab.init();
{%/script%}
