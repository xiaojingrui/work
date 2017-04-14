<a href="{%$gameData.innerurl%}" class="match-wrap">
    <div class="match-info">
        <div class="match-team-info">
            <div class="team home-team">
                <span class="team-name">{%$gameData.home.name%}</span>
                <img src="{%$gameData.home.logourl%}" alt="">
            </div>
            <strong>
                <span>{%$gameData.scoreortime%}</span>
            </strong>
            <div class="team away-team">
                <img src="{%$gameData.away.logourl%}" alt="">
                <span class="team-name">{%$gameData.away.name%}</span>
            </div>
        </div>
        <div class="match-status-info">
            <div class="score home-score">
                {%if isset($gameData.home_win)%}
                    ({%$gameData.home_win%})
                {%/if%}
            </div>
            {%if isset($gameData.isovertime)%}
                {%if {%$gameData.isover%} == 0%}
                    <div class="match-status-txt overtime-ing">{%$gameData.process%}</div>
                {%else%}
                    <div class="match-status-txt overtime">{%$gameData.process%}</div>
                {%/if%}
            {%else%}
                <div class="match-status-txt">{%$gameData.process%}</div>
            {%/if%}
            <div class="score away-score">
                {%if isset($gameData.home_win)%}
                    ({%$gameData.away_win%})
                {%/if%}
            </div>
        </div>
    </div>
</a>