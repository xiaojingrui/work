{%extends file="common/page/layout.tpl"%}
{%block name="block_head_static"%}
    {%require name="match:static/match-prediction/match-prediction.scss"%}
    {%require name="match:static/match-prediction/match-prediction.js"%}
{%/block%}

{%block name="content"%}

{%widget
    name="common:widget/top-title/top-title.tpl"
    banner="赛事预测"
    right="<a href=\"javascript:;\" class=\"button-mypredict\" id=\"J_myPredict\" dace-node=\"{%$id4dace%}_mypredict\" data-href=\"{%$mypredurl%}\">我的预测</a>"
%}

<div class="prediction-list-wrap" id="">
    <section class="prediction-section">
    {%foreach $gamelist as $key%}
        <div class="time-label">
            <span><strong>{%$key.timestr%}</strong></span>
        </div>
        {%foreach $key.gameinfo as $val%}
            <div class="prediction-info {%if !empty($val.userpre)%}{%if $val.userpre.result == 0%}predict-fail{%elseif $val.userpre.result == 1%}predict-success {%else%}predicting{%/if%}{%else%}unPredicted{%/if%}">
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
                            {%if $val.showtype == 2%}
                            <div class="prebtn-area J_preBtn" data-home="{%$val.home.name%}" data-homeid="{%$val.home.id%}" data-away="{%$val.away.name%}" data-awayid="{%$val.away.id%}" data-type="{%$val.gametype%}" data-gid="{%$val.gameid%}" >
                                <span class="predict-btn">预测</span>
                            </div>
                            {%/if%}
                            <div class="period">
                                <i></i>
                                <p>{%$val.type|escape:none%}</p>
                            </div>
                        </div>
                    </div>
                    {%if $val.showtype == 1%}
                        <div class="predict-result">
                            {%if $val.userpre.predictteam != -1%}
                                <p>您预测：<span class="sp">{%$val.userpre.predictteam%}</span>胜</p>
                            {%else%}
                                <p>您预测：<span class="sp">两队打平</span></p>
                            {%/if%}
                        </div>
                    {%elseif $val.showtype == 2 && !empty($val.pstr)%}
                        <div class="predict-result">
                            <p><span class="sp">{%$val.pstr%}</span></p>
                        </div>
                    {%/if%}
                </a>
            </div>
        {%/foreach%}
    {%/foreach%}
    </section>
</div>

<script id="predict-tips" type="text/template">
    <div class="predict-scroll" id="J_preScroll">
        <ul class="scroll-list">
            <@ _.each(datas, function(item,index) { @>
                <li class="scroll-item"><p><@=item@></p></li>
            <@})@>
        </ul>
    </div>
</script>

<script id="predict-popup" type="text/template">

    <div class="mask" id="J_mask"></div>
    <div class="predict-popup" id="J_prePopup">
        <h4 class="title">赛事预测</h4>
        <div class="predict-option" data-type="<@=type@>" data-gid="<@=gid@>">
            <@ if( type == 1 ) {@>
                <div class="option-item" data-value="<@=away@>" data-id="<@=awayid@>">
                    <div class="team-name"><@=away@></div>
                    <span>胜出</span>
                </div>
                <div class="option-item" data-value="<@=home@>" data-id="<@=homeid@>">
                    <div class="team-name"><@=home@></div>
                    <span>胜出</span>
                </div>
            <@ }else{ @>
                <div class="option-item" data-value="<@=home@>" data-id="<@=homeid@>">
                    <div class="team-name"><@=home@></div>
                    <span>胜出</span>
                </div>

                <div class="option-item" data-value="tail" data-id="-1">
                    <div class="tail">两队打平</div>
                </div>

                <div class="option-item" data-value="<@=away@>" data-id="<@=awayid@>">
                    <div class="team-name"><@=away@></div>
                    <span>胜出</span>
                </div>
            <@ } @>
            <div class="btn">
                <span class="cancel" id="J_cancel">取消</span>
                <span class="confirm" id="J_confirm">确认</span>
            </div>
        </div>
    </div>
</script>

{%/block%}
