<header class="match-header">
    <div class="match-name">
        {%if !empty($gameInfo["round_type_str"])%}
            {%$gameInfo["leagueCN"]%} {%$gameInfo["round_type_str"]%}
        {%else%}
            {%$gameInfo["leagueCN"]%} 第{%$gameInfo["match_day"]%}轮  
        {%/if%}
    </div>
    <div class="match-info">
        <div class="team-logo home-team-name">
            <a href="{%$gameInfo["home_url"]%}">
                <img src="{%$gameInfo["home_logo"]%}" alt="{%$gameInfo["home_name"]%}"/>
            </a>
        </div>
        <div class="score-number">
            {%** 比赛状态 未开始 **%}
            {%if $gameInfo["game_status"] == 0%}
                <div class="times">{%$gameInfo["date"][0]%}<br />{%$gameInfo["date"][1]%}</div>
            {%else%}
                {%$gameInfo["home_score"]%} <span class="line">-</span> {%$gameInfo["away_score"]%}
            {%/if%}

        </div>
        <div class="team-logo away-team-name">
            <a href="{%$gameInfo["away_url"]%}">
                <img src="{%$gameInfo["away_logo"]%}" alt="{%$gameInfo["away_name"]%}"/>
            </a>
        </div>
    </div>
    <div class="team-name-state">
        <div class="team-name home-team-name">
            <a href="{%$gameInfo["home_url"]%}">{%$gameInfo["home_name"]%}</a>
        </div>
        <div class="match-state">
            {%** 比赛状态 未开始 **%}
            {%if $gameInfo["game_status"] == 0%}
            {%** 比赛状态 结束 **%}
            {%elseif $gameInfo["game_status"] == 30%}
                已结束
            {%else%}
                <div class="match-state-competition">{%$gameInfo["game_period_cn"]%} {%$gameInfo["game_time"]%}</div>
            {%/if%}
        </div>
        <div class="team-name away-team-name">
            <a href="{%$gameInfo["away_url"]%}">{%$gameInfo["away_name"]%}</a>
        </div>
    </div>
</header>