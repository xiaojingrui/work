{%extends file="common/page/layout.tpl"%}

{%block name="block_head_static"%}
    {%require name="match:static/soccer-battle/soccer-battle.scss"%}
    {%script%}
        require("match:widget/top-tips/top-tips.js");
    {%/script%}
{%/block%}

{%block name="content"%}
    {%widget
        name="common:widget/new-top-nav/new-top-nav.tpl"
        hasMidNav=true
        hasBreadNav=true
    %}
    {%assign var=top value=$adInfo.m_adword.nba_game_playbyplay%}
    {%widget
        name="match:widget/top-tips/top-tips.tpl"
        isOpen=$top.isopen
        content=$top.adword
        url=$top.adurl
    %}
    {%widget
        name="match:widget/soccer-header/soccer-header.tpl"
    %}
    {%widget
        name="common:widget/inner-tab/tab.tpl"
        tabClass="soccermatch"
        selected="阵容"
    %}

    <section class="match-soccer-battle">
        <div class="stadium">
            <div class="goal goal-top">
                <div class="goal-content"></div>
            </div>
            <ul class="stadium-list stadium-list-top">
                <li class="team-name">
                    {%$lineup["home_name"]%}<br />
                    {%$lineup["home_lineup"][2]|@count%}-{%$lineup["home_lineup"][3]|@count%}-{%$lineup["home_lineup"][6]|@count%}{%if isset($lineup["home_lineup"][4])%}-{%$lineup["home_lineup"][4]|@count%}{%/if%}
                </li>
                <li>
                    {%if isset($lineup["home_lineup"][1])%}
                        {%foreach from=$lineup["home_lineup"][1] item=val name=key%}
                            <div class="players-list">
                                <a href="{%$val["player_url"]%}">
                                    <div class="players-number">
                                        {%$val["jersey_num"]%}
                                    </div>
                                    <div class="name">
                                        {%$val["player_name"]%}
                                    </div>
                                </a>
                            </div>
                        {%/foreach%}
                    {%/if%}
                </li>
                <li>
                    {%if isset($lineup["home_lineup"][2])%}
                        {%foreach from=$lineup["home_lineup"][2] item=val name=key%}
                            <div class="players-list">
                                <a href="{%$val["player_url"]%}">
                                    <div class="players-number">
                                        {%$val["jersey_num"]%}
                                    </div>
                                    <div class="name">
                                        {%$val["player_name"]%}
                                    </div>
                                </a>
                            </div>
                        {%/foreach%}
                    {%/if%}
                </li>
                <li>
                    {%if isset($lineup["home_lineup"][3])%}
                        {%foreach from=$lineup["home_lineup"][3] item=val name=key%}
                            <div class="players-list">
                                <a href="{%$val["player_url"]%}">
                                    <div class="players-number">
                                        {%$val["jersey_num"]%}
                                    </div>
                                    <div class="name">
                                        {%$val["player_name"]%}
                                    </div>
                                </a>
                            </div>
                        {%/foreach%}
                    {%/if%}
                </li>
                <li>
                    {%if isset($lineup["home_lineup"][6])%}
                        {%foreach from=$lineup["home_lineup"][6] item=val name=key%}
                            <div class="players-list">
                                <a href="#">
                                    <div class="players-number">
                                        {%$val["jersey_num"]%}
                                    </div>
                                    <div class="name">
                                        {%$val["player_name"]%}
                                    </div>
                                </a>
                            </div>
                        {%/foreach%}
                    {%/if%}
                </li>
                <li>
                    {%if isset($lineup["home_lineup"][4])%}
                        {%foreach from=$lineup["home_lineup"][4] item=val name=key%}
                            <div class="players-list">
                                <a href="{%$val["player_url"]%}">
                                    <div class="players-number">
                                        {%$val["jersey_num"]%}
                                    </div>
                                    <div class="name">
                                        {%$val["player_name"]%}
                                    </div>
                                </a>
                            </div>
                        {%/foreach%}
                    {%/if%}
                </li>
            </ul>
            <div class="center-line"></div>
            <ul class="stadium-list">
                <li>
                    {%if isset($lineup["away_lineup"][4])%}
                        {%foreach from=$lineup["away_lineup"][4] item=val name=key%}
                            <div class="players-list">
                                <a href="{%$val["player_url"]%}">
                                    <div class="players-number">
                                        {%$val["jersey_num"]%}
                                    </div>
                                    <div class="name">
                                        {%$val["player_name"]%}
                                    </div>
                                </a>
                            </div>
                        {%/foreach%}
                    {%/if%}
                </li>
                <li>
                    {%if isset($lineup["away_lineup"][6])%}
                        {%foreach from=$lineup["away_lineup"][6] item=val name=key%}
                            <div class="players-list">
                                <a href="{%$val["player_url"]%}">
                                    <div class="players-number">
                                        {%$val["jersey_num"]%}
                                    </div>
                                    <div class="name">
                                        {%$val["player_name"]%}
                                    </div>
                                </a>
                            </div>
                        {%/foreach%}
                    {%/if%}
                </li>
                <li>
                    {%if isset($lineup["away_lineup"][3])%}
                        {%foreach from=$lineup["away_lineup"][3] item=val name=key%}
                            <div class="players-list">
                                <a href="{%$val["player_url"]%}">
                                    <div class="players-number">
                                        {%$val["jersey_num"]%}
                                    </div>
                                    <div class="name">
                                        {%$val["player_name"]%}
                                    </div>
                                </a>
                            </div>
                        {%/foreach%}
                    {%/if%}
                </li>
                <li>
                    {%if isset($lineup["away_lineup"][2])%}
                        {%foreach from=$lineup["away_lineup"][2] item=val name=key%}
                            <div class="players-list">
                                <a href="{%$val["player_url"]%}">
                                    <div class="players-number">
                                        {%$val["jersey_num"]%}
                                    </div>
                                    <div class="name">
                                        {%$val["player_name"]%}
                                    </div>
                                </a>
                            </div>
                        {%/foreach%}
                    {%/if%}
                </li>
                <li>
                    {%if isset($lineup["away_lineup"][1])%}
                        {%foreach from=$lineup["away_lineup"][1] item=val name=key%}
                            <div class="players-list">
                                <a href="{%$val["player_url"]%}">
                                    <div class="players-number">
                                        {%$val["jersey_num"]%}
                                    </div>
                                    <div class="name">
                                        {%$val["player_name"]%}
                                    </div>
                                </a>
                            </div>
                        {%/foreach%}
                    {%/if%}
                </li>
                <li class="team-name">
                    {%$lineup["away_lineup"][2]|@count%}-{%$lineup["away_lineup"][3]|@count%}-{%$lineup["away_lineup"][6]|@count%}{%if isset($lineup["away_lineup"][4])%}-{%$lineup["away_lineup"][4]|@count%}{%/if%}<br />
                    {%$lineup["away_name"]%}
                </li>
            </ul>
            <div class="goal goal-bottom">
                <div class="goal-content"></div>
            </div>
        </div>
        <table class="table">
            <thead>
                <tr>
                    <th colspan="2">替补</th>
                </tr>
            </thead>
            <tbody>
                {%if $lineup["home_bench_lineup"]|@count > $lineup["away_bench_lineup"]|@count%}
                    {%$bench = $lineup["home_bench_lineup"]%}
                {%else%}
                    {%$bench = $lineup["away_bench_lineup"]%}
                {%/if%}

                {%foreach from=$bench item=val key=keys%}
                    <tr>
                        <td class="number-1">
                            {%if isset($lineup["home_bench_lineup"][$keys]["jersey_num"])%}
                                <a href="{%$lineup["home_bench_lineup"][$keys]["player_url"]%}">
                                    {%$lineup["home_bench_lineup"][$keys]["jersey_num"]%}
                                    {%$lineup["home_bench_lineup"][$keys]["player_name"]%}
                                </a>
                            {%/if%}
                        </td>
                        <td class="number-2">
                            {%if isset($lineup["away_bench_lineup"][$keys]["jersey_num"])%}
                                <a href="{%$lineup["away_bench_lineup"][$keys]["player_url"]%}">
                                    {%$lineup["away_bench_lineup"][$keys]["player_name"]%}
                                    {%$lineup["away_bench_lineup"][$keys]["jersey_num"]%}
                                </a>
                            {%/if%}
                        </td>
                    </tr>
                {%/foreach%}
            </tbody>
            <thead>
                <tr>
                    <th colspan="2">教练</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td class="number-1">{%$home_official["official_name"]%}</td>
                    <td class="number-2">{%$away_official["official_name"]%}</td>
                </tr>
            </tbody>
        </table>
    </section>

{%/block%}
