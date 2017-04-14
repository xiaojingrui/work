{%if !empty($data)%}

<div class="match-board">
    <ul>
        {%foreach $data as $game%}
        <li class="{%if $game.status == 0%}end{%elseif $game.status == 1%}ing{%else%}wait{%/if%}">
            <a href="{%$game.gameurl%}" class="game-link">
                <div class="game-info">
                    {%if !empty($from)%}
                    <div class="league {%if $game.leaguetype == 0%}basketball{%else%}soccer{%/if%}">
                        {%$game.leaguename%}
                    </div>
                    {%/if%}
                    <div class="team">
                        {%if $game.leaguetype == 0%}
                            {%$game.awayteam%} vs {%$game.hometeam%}
                        {%else%}
                            {%$game.hometeam%} vs {%$game.awayteam%}
                        {%/if%}
                    </div>
                    <div class="result">
                        {%$game.score|escape:none%}
                    </div>
                </div>
                <div class="game-status">
                    <div class="status-info">
                        <p>{%$game.progress%}</p>
                        <p>{%$game.gamestatus%}</p>
                    </div>
                </div>
            </a>
        </li>
        {%/foreach%}
    </ul>
</div>
{%if !empty($isPredict)%}
    <div class="prediction-entry">
        <a href="{%$predicturl%}"><span>查看今明全部赛程，并参与预测</span><i></i></a>
    </div>
{%/if%}
{%/if%}