<p class="top-tips">暂无更多赛事信息</p>
<div class="match-list-wrap" id="J_content">
    {%foreach from=$data item=itemVal name=itemKey%}
    {%if isset($itemVal.id)%}
    <section class="match-section match-today" latestId="{%$itemVal.id%}" match-date="{%$itemVal.date%}">
    {%else%}
    <section class="match-section" match-date="{%$itemVal.date%}">
    {%/if%}
        <div class="time-label">
            <span>
               <strong>{%$itemVal.timestr%}</strong>
            </span>
        </div>
        {%if !empty($itemVal.gameinfo)%}
        {%foreach from=$itemVal.gameinfo item=infoVal name=infoKey%}
        <a href="{%$infoVal.innerurl%}" class="match-wrap" dace-node="{%$id4dace%}_game">
            <div class="match-info">
                <div class="match-team-info">
                    <div class="team away-team">
                        <span class="team-name">{%$infoVal.away.name%}</span>
                        <img src="{%$infoVal.away.logourl%}" alt="">
                    </div>
                    <strong>
                        <span>{%$infoVal.scoreortime%}</span>
                    </strong>
                    <div class="team home-team">
                        <img src="{%$infoVal.home.logourl%}" alt="">
                        <span class="team-name">{%$infoVal.home.name%}</span>
                    </div>
                </div>
                <div class="match-status-info">
                    <div class="score away-score">
                        {%if isset($infoVal.home_win)%}
                        ({%$infoVal.away_win%})
                        {%/if%}
                    </div>
                    {%if isset($infoVal.isovertime)%}
                        {%if {%$infoVal.isover%} == 0%}
                        <div class="match-status-txt overtime-ing">{%$infoVal.process%}</div>
                        {%else%}
                        <div class="match-status-txt overtime">{%$infoVal.process%}</div>
                        {%/if%}
                    {%else%}
                    <div class="match-status-txt">{%$infoVal.process%}</div>
                    {%/if%}
                    <div class="score home-score">
                        {%if isset($infoVal.home_win)%}
                        ({%$infoVal.home_win%})
                        {%/if%}
                    </div>
                </div>
            </div>
            {%if isset($infoVal.recaptext) && !empty($infoVal.recaptext)%}
            <div class="match-report">
                <p><img src="./report.png" alt="">{%$infoVal.recaptext%}</p>
            </div>
            {%/if%}
        </a>
        {%/foreach%}
        {%/if%}
    </section>
    {%/foreach%}
</div>

<script id="t2" type="text/template">
    <@ _.each(datas, function(item,index) { @>
        <section class="match-section" match-date="<@=item.date@>">
            <div class="time-label">
                <span>
                   <strong><@=item.timestr@></strong>
                </span>
            </div>
            <@ if ( !_.isEmpty(item.gameinfo) ){ @>
                <@ _.each(item.gameinfo, function(item,index) { @>
                <a href="<@=item.innerurl@>" class="match-wrap" dace-node="{%$id4dace%}_game">
                    <div class="match-info">
                        <div class="match-team-info">
                            <div class="team away-team">
                                <span class="team-name"><@=item.away.name@></span>
                                <img src="<@=item.away.logourl@>" alt="">
                            </div>
                            <strong>
                                <span><@=item.scoreortime@></span>
                            </strong>
                            <div class="team home-team">
                                <img src="<@=item.home.logourl@>" alt="">
                                <span class="team-name"><@=item.home.name@></span>
                            </div>
                        </div>
                        <div class="match-status-info">
                            <div class="score away-score">
                               <@ if( item.away_win == 0 ){ @>
                                    (<@=item.away_win@>)
                                <@ }else if( !!(item.away_win) ){ @>
                                    (<@=item.away_win@>)
                                <@ }else{ @>
                                <@ } @>
                            </div>
                            <@ if( !!(item.isovertime) ){@>
                                <@ if (item.isover == 0){ @>
                                <div class="match-status-txt overtime-ing"><@=item.process@></div>
                                <@ }else{ @>
                                <div class="match-status-txt overtime"><@=item.process@></div>
                                <@ } @>
                            <@ }else{ @>
                                <div class="match-status-txt"><@=item.process@></div>
                            <@ } @>
                            <div class="score home-score">
                                <@ if( item.home_win == 0 ){ @>
                                    (<@=item.home_win@>)
                                <@ }else if( !!(item.home_win) ){ @>
                                    (<@=item.home_win@>)
                                <@ }else{ @>
                                <@ } @>
                            </div>
                        </div>
                    </div>
                    <@ if( !!(item.recaptext) ){@>
                    <div class="match-report">
                        <p><img src="./report.png" alt=""><@=item.recaptext@></p>
                    </div>
                    <@ } @>
                </a>
                <@ }); @>
            <@ } @>
        </section>
    <@ }); @>
</script>
