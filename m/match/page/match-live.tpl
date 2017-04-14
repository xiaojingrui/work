{%extends file="common/page/layout.tpl"%}

{%block name="block_head_static"%}
    {%require name="match:static/match-live/match-live.scss"%}
    {%require name="match:static/match-live/match-live.js"%}
    {%script%}
        require("match:widget/match-info/match-info.js");
        require("match:widget/top-tips/top-tips.js");
    {%/script%}
{%/block%}

{%block name="content"%}
    {%widget
        name="common:widget/new-top-nav/new-top-nav.tpl"
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
        name="match:widget/match-info/match-info.tpl"
    %}

    {%widget
        name="common:widget/inner-tab/tab.tpl"
        tabClass="match"
        selected="文字直播"
    %}



     {%if isset($live.prevpid)%}
     <div class="match-live" game-id="{%$gameId%}" prev-id="{%$live.prevpid%}" next-id="{%$live.nextpid%}" isover="{%$gameInfo.isover%}">
     {%else%}
     <div class="match-live" game-id="{%$gameId%}" next-id="{%$live.nextpid%}" isover="1">
     {%/if%}
        <ul class="live-list" id="J_content">
            {%foreach from=$live.liveText item=item%}
            {%if !empty($item.event_type) && $item.event_type == "14"%}
            <li class="quater">{%$item.event%}</li>
            {%else%}
            <li>
                <span class="live-time">{%$item.left_time%}</span>
                <div>
                    <span class="live-text">{%$item.event%}</span>
                    <span class="live-score">
                    (&nbsp;
                    {%if $item.score_change == 1%}
                        {%if $item.team == "home"%}
                           {%$item.away_score%}&nbsp;-&nbsp;<span class="addScore">{%$item.home_score%}</span>
                        {%else%}
                           <span class="addScore">{%$item.away_score%}</span>&nbsp;-&nbsp;{%$item.home_score%}
                        {%/if%}
                    {%else%}
                        {%$item.vs|replace:"-":" - "%}
                    {%/if%}
                    )</span>
                </div>
            </li>
            {%/if%}
            {%/foreach%}

        </ul>
    </div>

     <script id="live" type="text/template">
        <@ _.each(datas, function(item,index) { @>
            <@ if (item.event_type && item.event_type == "14"){ @>
                <li class="quater"><@=item.event@></li>
            <@ }else{ @>
                <li class="<@if(type==1){@>new<@}@>">
                    <span class="live-time"><@=item.left_time@></span>
                    <div>
                        <span class="live-text"><@=item.event@></span>
                        <span class="live-score">
                        (
                            <@ if( item.score_change == 1 ) {@>
                                <@ if( item.team == "home" ) {@>
                                    <@=item.away_score@> - <span class="addScore"><@=item.home_score@></span>
                                <@ }else{ @>
                                    <span class="addScore"><@=item.away_score@></span> - <@=item.home_score@>
                                <@ } @>
                            <@ }else{ @>
                                 <@=item.vs.replace("-"," - ")@>
                            <@ } @>
                        )
                        </span>
                    </div>
                </li>
            <@ } @>
        <@ }); @>
    </script>

{%/block%}
