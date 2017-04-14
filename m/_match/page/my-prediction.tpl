{%extends file="common/page/layout.tpl"%}
{%block name="block_head_static"%}
    {%require name="match:static/match-prediction/match-prediction.scss"%}
    {%require name="match:static/my-predict/my-predict.js"%}
    <script>
        !function() {
            HPM.mintime = "{%$mindate%}";
            HPM.more = "{%$more%}";
            HPM.userid = "{%$userid%}";
            HPM.isself = "{%$isself%}";
        }()
    </script>
{%/block%}

{%block name="content"%}

{%widget
    name="common:widget/top-title/top-title.tpl"
    banner="{%$title%}"
%}
<div id="J_recordWrap">
    <div class="predict-record-wrap">
        <div class="predict-record">
            <div class="record-item">
                <div class="detail-con">
                    <strong>{%$mypredict.days%}</strong>
                    <p>打败{%$mypredict.dayspercent%}%<br>用户</p>
                </div>
                <div class="title">参与天数</div>
            </div>
            <div class="record-item">
                <div class="detail-con">
                    <strong>{%$mypredict.times%}</strong>
                    <p>打败{%$mypredict.timespercent%}%<br>用户</p>
                </div>
                <div class="title">参与次数</div>
            </div>
            <div class="record-item">
                <div class="detail-con">
                    <strong>{%$mypredict.correct%}</strong>
                    <p>打败{%$mypredict.correctpercent%}%<br>用户</p>
                </div>
                <div class="title">正确场数</div>
            </div>
            <div class="record-item">
                <div class="detail-con">
                    <strong>{%$mypredict.keepwin%}</strong>
                    <p>打败{%$mypredict.keepwinpercent%}%<br>用户</p>
                </div>
                <div class="title">最佳连胜数</div>
            </div>
        </div>
        {%if $isPredict%}
            <div class="prediction-entry">
                <a href="{%$predicturl%}">查看今明全部赛程<i></i></a>
            </div>
        {%else%}
            <div class="prediction-entry">
                <a href="javascript:;" class="empty-tips">今明两天暂无比赛</a>
            </div>
        {%/if%}
    </div>

    <div class="predict-history">
        {%foreach $predictseason as $key%}
            <div class="history-option option-num{%$predictseason|count%}">
                <a href="{%$key.url%}" class="option-con">
                    {%$key.text%}
                </a>
            </div>
        {%/foreach%}
    </div>

    <div class="prediction-list-wrap">
        {%if !empty($predictlist)%}
            <section class="prediction-section" id="J_content">
            {%foreach $predictlist as $key%}
                {%if is_int($key.timestr|strpos:'今日')%}
                    <a name="today"></a> 
                {%/if%}
                <div class="time-label">
                    <span><strong>{%$key.timestr%}</strong></span>
                </div>
                
                {%foreach $key.gameinfo as $val%}
                    <div class="prediction-info {%if !empty($val.userpre)%}{%if $val.userpre.result == 0%}predict-fail{%elseif $val.userpre.result == 1%}predict-success {%else%}predicting{%/if%}{%/if%}">
                        <a href="{%$val.gameurl%}" class="predict-link">
                            <div class="predict-detail">
                                <div class="time-status">
                                    <p>{%$val.stsstr|escape:none%}</p>
                                </div>
                                {%if $val.gamestatus != 3%}
                                    <div class="score">
                                        {%if $val.gametype == 1%}
                                            <p>{%$val.away.score%}</p> 
                                            <p>{%$val.home.score%}</p>
                                        {%else%}
                                            <p>{%$val.home.score%}</p> 
                                            <p>{%$val.away.score%}</p>
                                        {%/if%} 
                                    </div>
                                {%/if%}
                                <div class="match-info">
                                    <div class="team">
                                        {%if $val.gametype == 1%}
                                            <p><img src="{%$val.away.logourl%}" alt="">{%$val.away.name%}</p>
                                            <p><img src="{%$val.home.logourl%}" alt="">{%$val.home.name%}</p>
                                        {%else%}
                                            <p><img src="{%$val.home.logourl%}" alt="">{%$val.home.name%}</p>
                                            <p><img src="{%$val.away.logourl%}" alt="">{%$val.away.name%}</p>
                                        {%/if%}
                                    </div>
                                    <div class="period">
                                        <i></i>
                                        <p>{%$val.type|escape:none%}</p>
                                    </div>
                                </div>
                            </div>
                            {%if $val.showtype == 1%}
                                <div class="predict-result">
                                    {%if $val.userpre.predictteam != -1%}

                                        <p>{%if $isself%}您{%else%}Ta{%/if%}预测：<span class="sp">{%$val.userpre.predictteam%}</span>胜</p>
                                    {%else%}
                                        <p>{%if $isself%}您{%else%}Ta{%/if%}预测：<span class="sp">两队打平</span></p>
                                    {%/if%}
                                </div>
                            {%/if%}
                        </a>
                    </div>
                {%/foreach%}
            {%/foreach%}
            </section>
        {%else%}
            <div class="unpredict-tip">还未参加过预测</div>
        {%/if%}
    </div>

</div>

<script id="predict-histoty" type="text/template">
    <@ _.each(datas, function(item, index) { @> 
        <@ if(!_.isEmpty(item.timestr)) {@>
            <div class="time-label">
                <span><strong><@=item.timestr@></strong></span>
            </div>
        <@ } @>
        <@ _.each(item.gameinfo, function(item, index) { @>    
            <div class="prediction-info <@if (item.userpre){@> <@if (item.userpre.result == 0){@>predict-fail<@}else if(item.userpre.result == 1){@>predict-success<@}else{@>predicting<@}@> <@}@>">
                <a href="<@=item.gameurl@>" class="predict-link">
                    <div class="predict-detail">
                        <div class="time-status">
                            <p><@=_.unescape(item.stsstr)@></p>
                        </div>
                        <@ if (item.gamestatus != 3){ @>
                        <div class="score">
                            <@ if (item.gametype == 1){ @>
                                <p><@=item.away.score@></p>
                                <p><@=item.home.score@></p> 
                            <@ }else{ @>
                                <p><@=item.home.score@></p>
                                <p><@=item.away.score@></p> 
                            <@ }@>
                        </div>
                        <@ } @>
                        <div class="match-info">
                            <div class="team">
                                <@ if (item.gametype == 1){ @>
                                    <p><img src="<@=item.away.logourl@>" alt=""><@=item.away.name@></p>
                                    <p><img src="<@=item.home.logourl@>" alt=""><@=item.home.name@></p>
                                <@ }else{ @>
                                    <p><img src="<@=item.home.logourl@>" alt=""><@=item.home.name@></p>
                                    <p><img src="<@=item.away.logourl@>" alt=""><@=item.away.name@></p>
                                <@ }@>
                            </div>
                            <div class="period">
                                <i></i>
                                <p><@=_.unescape(item.type)@></p>
                            </div>
                        </div>
                    </div>
                    <@ if(item.showtype == 1){ @>
                        <div class="predict-result">
                            <@ if(item.userpre.predictteam != -1){ @>
                                <p><@ if(!_.isEmpty(isself)){@>您<@}else{@>Ta<@}@>预测：<span class="sp"><@=item.userpre.predictteam@></span>胜</p>
                            <@ }else{ @>
                                <p><@ if(!_.isEmpty(isself)){@>您<@}else{@>Ta<@}@>预测：<span class="sp">两队打平</span></p>
                            <@ } @>
                        </div>
                    <@ } @>
                </a>
            </div>
        <@ }) @>

    <@ }) @>
</script>

{%/block%}