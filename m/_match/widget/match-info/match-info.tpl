<div class="match-banner" data-status="{%$gameInfo.status%}">
    <p class="match-date">{%$gameInfo.year_desc%}</p>
    <div class="match-title-info">
        <div class="team-logo away-team-logo">
            <a href="{%$gameInfo.away.link%}" dace-node="{%$id4dace%}_team_{%$gameInfo.away.id%}">
                <img src="{%$gameInfo.away.logourl%}" alt="">
            </a>
        </div>
        <strong>
            <span id="J_scoreortime">{%$gameInfo.scoreortime%}</span>
        </strong>
        <div class="team-logo home-team-logo">
            <a href="{%$gameInfo.home.link%}" dace-node="{%$id4dace%}_team_{%$gameInfo.home.id%}">
                <img src="{%$gameInfo.home.logourl%}" alt="">
            </a>
        </div>
    </div>
    <div class="match-detail">
        <div class="team-name away-team-name">
            <a href="{%$gameInfo.away.link%}" dace-node="{%$id4dace%}_team_{%$gameInfo.away.id%}">
                <span>(客)</span><strong>{%$gameInfo.away.name%}</strong>
            </a>
        </div>
        <div class="team-status" id="J_process">
            {%$gameInfo.process%}
        </div>
        <div class="team-name home-team-name">
            <a href="{%$gameInfo.home.link%}" dace-node="{%$id4dace%}_team_{%$gameInfo.home.id%}">
                <strong>{%$gameInfo.home.name%}</strong><span>(主)</span>
            </a>
        </div>
        
    </div>
    <!-- 未开始或进行中  1 结束 2 进行中 3 未开始 -->
    {%if $gameInfo.status != 1%}
    <div class="balance-info" match-id="{%$gameInfo.match_id%}">
        <div class="bal-btn away-btn">
            <div class="btn" style="background-color:rgb({%$gameInfo.away.color%})">
                <div class="load-left"><span></span></div>
                <div class="load-right"><span></span></div>
                {%if $gameInfo.status == 3%}
                <a href="javascript:;" class="inner" dace-node="{%$id4dace%}_forecast_{%$gameInfo.away.id%}" style="color:rgb({%$gameInfo.away.color%});font-size: 16px;">胜</a>
                {%else%}
                <a href="javascript:;" class="inner icon-support-away" dace-node="{%$id4dace%}_for_{%$gameInfo.away.id%}"></a>
                {%/if%}
            </div>
        </div>
        <div class="balance-bar-area">
            <div class="bar" style="background-color:rgb({%$gameInfo.home.color%})">
                <span class="away-bar" style="width:{%$gameForcastInfo.awayWidth%};background-color:rgb({%$gameInfo.away.color%})"></span>
            </div>
            <div class="rate">
                <span class="away-rate">{%$gameForcastInfo.awayWidth%}</span>
                <span class="home-rate">{%$gameForcastInfo.homeWidth%}</span>
            </div>
        </div>
        <div class="bal-btn home-btn">
            <div class="btn" style="background-color:rgb({%$gameInfo.home.color%})">
                <div class="load-right"><span></span></div>
                {%if $gameInfo.status == 3%}
                <a href="javascript:;" class="inner" dace-node="{%$id4dace%}_forecast_{%$gameInfo.home.id%}" style="color:rgb({%$gameInfo.home.color%});font-size: 16px;">胜</a>
                {%else%}
                <a href="javascript:;" class="inner icon-support" dace-node="{%$id4dace%}_for_{%$gameInfo.home.id%}"></a>
                {%/if%}
            </div>
        </div>
        
    </div>

    <!-- 已结束 -->
    {%else%}
    
    <div class="balance-info" match-id="{%$gameInfo.match_id%}">
        <div class="bal-btn away-btn">
            <div class="btn-result icon-support"></div>
        </div>
        <div class="balance-bar-area">
            <div class="bar" style="background-color:rgb({%$gameInfo.home.color%})">
                <span class="away-bar" style="width:{%$gameForcastInfo.awayWidth%};background-color:rgb({%$gameInfo.away.color%})"></span>
            </div>
            <div class="rate">
                <span class="away-rate">{%$gameForcastInfo.awayWidth%}</span>
                <span class="home-rate">{%$gameForcastInfo.homeWidth%}</span>
            </div>
        </div>
        <div class="bal-btn home-btn">
        <!-- 为了配合左客右主的调整，icon的class会有颠倒 -->
            <div class="btn-result icon-support-away"></div>
        </div>
        
        
    </div>

    {%/if%}
    <div class="tips"></div>
</div>