{%extends file="common/page/layout.tpl"%}

{%block name="block_head_static"%}
    {%require name="match:static/soccer-event/soccer-event.scss"%}
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
        selected="事件"
    %}

    <section class="match-soccer-event">
        <ul class="list">
            {%foreach from=$events item=val name=key%}

                {%if $val["event_type"] == 2
                    || $val["event_type"] == 3
                    || $val["event_type"] == 22
                    || $val["event_type"] == 11
                    || $val["event_type"] == 17
                    || $val["event_type"] == 28
                %}
                    <li class="col-flex {%if $val["event_type"] == 22%}col-substitution{%/if%}">
                        <span class="col-list col-left">
                            {%if $val["team_id"] == $events[0]["team_id"]%}
                                {%**黄牌**%}
                                {%if $val["event_type"] == 2%}
                                    <span class="team-name">
                                        {%$val["player_name"]%}
                                        <i class="icon-yellow-card"></i>
                                    </span>
                                {%/if%}

                                {%**红牌**%}
                                {%if $val["event_type"] == 3%}
                                    <span class="team-name">
                                        {%$val["player_name"]%}
                                        <i class="icon-red-card"></i>
                                    </span>
                                {%/if%}

                                {%**换人**%}
                                {%if $val["event_type"] == 22%}
                                    <span class="team-name">
                                        {%$val["player_name"]%}<br />
                                        <span class="gray">{%$val["player2_name"]%}</span>
                                    </span>
                                    <i class="icon-substitution">
                                        <img src="/static/soccer-event/icon-substitution.png" />
                                    </i>
                                {%/if%}

                                {%**进球11、点球17、乌龙球28**%}
                                {%if $val["event_type"] == 11 || $val["event_type"] == 17 || $val["event_type"] == 28%}
                                    <span class="team-name">
                                        {%$val["player_name"]%}
                                        <i class="icon-ball {%if $val["event_type"] == 17%}icon-thepenalty{%/if%}">
                                            {%if $val["event_type"] == 28%}
                                                <img src="/static/soccer-event/icon-oolong.png" />
                                            {%else%}
                                                <img src="/static/soccer-event/icon-ball.png" />
                                            {%/if%}
                                        </i>
                                    </span>
                                {%/if%}
                            {%else%}
                                {%**进球11、点球17、乌龙球28**%}
                                {%if $val["event_type"] == 11 || $val["event_type"] == 17 || $val["event_type"] == 28%}
                                    <span class="score">{%$val["score"]%}-{%$val["other_side_score"]%}</span>
                                {%/if%}
                            {%/if%}

                        </span>
                        <div class="col-center">
                            <span class="surplus-time">{%$val["game_min"]%}′</span>
                        </div>
                        <span class="col-list col-right">
                            {%if $val["team_id"] != $events[0]["team_id"]%}
                                {%**黄牌**%}
                                {%if $val["event_type"] == 2%}
                                    <span class="team-name">
                                        <i class="icon-yellow-card"></i>
                                        {%$val["player_name"]%}
                                    </span>
                                {%/if%}

                                {%**红牌**%}
                                {%if $val["event_type"] == 3%}
                                    <span class="team-name">
                                        <i class="icon-red-card"></i>
                                        {%$val["player_name"]%}
                                    </span>
                                {%/if%}

                                {%**换人**%}
                                {%if $val["event_type"] == 22%}
                                    <i class="icon-substitution">
                                        <img src="/static/soccer-event/icon-substitution.png" />
                                    </i>
                                    <span class="team-name">
                                        {%$val["player_name"]%}<br />
                                        <span class="gray">{%$val["player2_name"]%}</span>
                                    </span>
                                {%/if%}

                                {%**进球11、点球17、乌龙球28**%}
                                {%if $val["event_type"] == 11 || $val["event_type"] == 17 || $val["event_type"] == 28%}
                                    <span class="team-name">
                                        <i class="icon-ball {%if $val["event_type"] == 17%}icon-thepenalty{%/if%}">
                                            {%if $val["event_type"] == 28%}
                                                <img src="/static/soccer-event/icon-oolong.png" />
                                            {%else%}
                                                <img src="/static/soccer-event/icon-ball.png" />
                                            {%/if%}
                                        </i>
                                        {%$val["player_name"]%}
                                    </span>
                                {%/if%}
                            {%else%}
                                {%**进球11、点球17、乌龙球28**%}
                                {%if $val["event_type"] == 11 || $val["event_type"] == 17 || $val["event_type"] == 28%}
                                    <span class="score">{%$val["score"]%}-{%$val["other_side_score"]%}</span>
                                {%/if%}
                            {%/if%}
                        </span>
                    </li>
                {%elseif $val["event_type"] == 21 || $val["event_type"] == 30 || (!empty($val["game_period"]) && $val["game_period"] == 11)%}
                    <li>
                        <img src="/static/soccer-event/icon-whistle.png" class="icon-whistle" />
                    </li>
                {%elseif $val["event_type"] == 999%}
                    <li>
                        <span class="overtime">{%$val["game_period"]%}&nbsp;{%$val["score"]%}-{%$val["other_side_score"]%}</span>
                    </li>
                {%/if%}

            {%/foreach%}

        </ul>
    </section>

{%/block%}
