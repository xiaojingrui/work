<p class="top-tips">暂无更多赛事信息</p>
<div class="match-list-wrap" id="J_content" data-start-time="{%$startTime%}" data-end-time="{%$endTime%}">
    {%foreach from=$data item=val name=key%}
        <section class="match-section {%if $smarty.foreach.key.index == 0%}match-today{%/if%}">
            <div class="time-label">
                <span>{%$val[0]["date"][0]%}&nbsp;{%$val[0]["week"]%}</span>
            </div>
            {%foreach from=$val item=val1 name=key1%}
                {%** 比赛状态 未开始 **%}
                {%if $val1["game_status"] == 0%}
                    {%$matchClassName="match-list-notstarted"%}
                {%** 比赛状态 结束 **%}
                {%elseif $val1["game_status"] == 30%}
                    {%$matchClassName="match-list-ended"%}
                {%else%}
                    {%$matchClassName="match-list-competition"%}
                {%/if%}
                <div class="match-list {%$matchClassName%}">
                    {%if isset($val1["away_formation"]) && isset($val1["home_formation"])%}
                        <a href="{%$val1["game_url"]%}">
                    {%else%}
                        <a href="javascript:" class="J_matchListNotLink">
                    {%/if%}
                            <div class="match-col-1">
                                {%** 比赛状态 未开始 **%}
                                {%if $val1["game_status"] == 0%}
                                    {%if isset($val1["away_formation"]) || isset($val1["home_formation"])%}
                                        <div class="match-state">{%$val1["date"][1]%}</div>
                                        <div class="match-tag">
                                            <i class="tag-battle">阵容</i>
                                        </div>
                                    {%else%}
                                        <div class="match-state match-state-top">{%$val1["date"][1]%}</div>
                                    {%/if%}
                                {%** 比赛状态 结束 **%}
                                {%elseif $val1["game_status"] == 30%}
                                    {%if isset($val1["home_shoot_out_score"]) || isset($val1["away_shoot_out_score"])%}
                                        <div class="match-state">已结束</div>
                                        <div class="match-tag">
                                            <i class="tag-thepenalty">点</i>
                                        </div>
                                    {%else%}
                                        <div class="match-state match-state-top">已结束</div>
                                    {%/if%}
                                {%** 比赛状态 推迟 **%}
                                {%elseif $val1["game_status"] == 1%}
                                    <div class="match-state match-state-top">推迟</div>
                                {%** 比赛状态 延期 **%}
                                {%elseif $val1["game_status"] == 2 || $val1["game_status"] == 3%}
                                    <div class="match-state match-state-top">延期</div>
                                {%** 比赛状态 弃赛 **%}
                                {%elseif $val1["game_status"] == 4%}
                                    <div class="match-state match-state-top">弃赛</div>
                                {%** 比赛状态 中断 **%}
                                {%elseif $val1["game_status"] == 5%}
                                    <div class="match-state match-state-top">中断</div>
                                {%else%}
                                    {%$val1["game_period_cn"]%}<br />
                                    {%$val1["game_time"]%}
                                {%/if%}
                            </div>
                            {%if isset($val1["home_score"])%}
                                <div class="match-score">
                                    {%$val1["home_score"]%}{%if isset($val1["home_shoot_out_score"])%}<span class="thepenalty">({%$val1["home_shoot_out_score"]%})</span>{%/if%}<br />
                                    {%$val1["away_score"]%}{%if isset($val1["away_shoot_out_score"])%}<span class="thepenalty">({%$val1["away_shoot_out_score"]%})</span>{%/if%}
                                </div>
                            {%/if%}
                            <div class="team-name">
                                <div class="team-name-list">
                                    {%if !empty($val1["home_logo"])%}
                                    <i class="team-logo">
                                        <img src="{%$val1["home_logo"]%}" alt=""/>
                                    </i>
                                    {%/if%}
                                    <h4>{%$val1["home_name"]%}</h4>
                                </div>
                                <div class="team-name-list">
                                    {%if !empty($val1["away_logo"])%}
                                    <i class="team-logo">
                                        <img src="{%$val1["away_logo"]%}" alt=""/>
                                    </i>
                                    {%/if%}
                                    <h4>{%$val1["away_name"]%}</h4>
                                </div>
                            </div>
                            <div class="match-played">
                                {%*适配全部比赛*%}
                                {%if !empty($val1["leagueCN"]) && $matchAll == "match_all"%}
                                    {%$val1["leagueCN"]%}<br />
                                {%else%}
                                    {%if !empty($leagueCN)%}{%$leagueCN%}<br />{%/if%}
                                {%/if%}

                                {%if !empty($val1["round_type_str"])%}
                                    {%$val1["round_type_str"]%}
                                {%elseif !empty($val1["match_day"])%}
                                    第{%$val1["match_day"]%}轮
                                {%/if%}
                            </div>
                    </a>
                </div>
            {%/foreach%}
        </section>
    {%/foreach%}
</div>


<script id="list-template" type="text/template">
    <@ _.each(datas.gameList, function(item,index) { @>
        <section class="match-section">
            <div class="time-label">
                <span><@=item[0].date[0]@> <@=item[0].week@></span>
            </div>
            <@ _.each(item, function(item1,index1) { @>
                <@ if( item1.game_status == 0 ) { @>
                    <div class="match-list match-list-notstarted">
                <@ }else if( item1.game_status == 30 ) { @>
                    <div class="match-list match-list-ended">
                <@ }else{ @>
                    <div class="match-list match-list-competition">
                <@ } @>
                <@ if( !_.isNull( item1.away_formation ) && !_.isNull( item1.home_formation ) ) { @>
                    <a href="<@=item1.game_url@>">
                <@ }else{ @>
                    <a href="javascript:" class="J_matchListNotLink">
                <@ } @>
                        <div class="match-col-1">
                            <!-- 比赛状态 未开始 -->
                            <@ if( item1.game_status == 0 ) { @>
                                <@ if( !_.isNull( item1.away_formation ) || !_.isNull( item1.home_formation ) ) { @>
                                    <div class="match-state"><@=item1.date[1]@></div>
                                    <div class="match-tag">
                                        <i class="tag-battle">阵容</i>
                                    </div>
                                <@ }else{ @>
                                    <div class="match-state match-state-top"><@=item1.date[1]@></div>
                                 <@ } @>
                            <!-- 比赛状态 结束 -->
                            <@ }else if( item1.game_status == 30 ) { @>
                                <@ if( item1.home_shoot_out_score || item1.away_shoot_out_score ) { @>
                                    <div class="match-state">已结束</div>
                                    <div class="match-tag">
                                        <i class="tag-thepenalty">点</i>
                                    </div>
                                <@ }else{ @>
                                    <div class="match-state match-state-top">已结束</div>
                                <@ } @>
                            <!-- 比赛状态 推迟 -->
                            <@ }else if( item1.game_status == 1 ) { @>
                                <div class="match-state match-state-top">推迟</div>
                            <!-- 比赛状态 延期 -->
                            <@ }else if( item1.game_status == 2 || item1.game_status == 3) { @>
                                <div class="match-state match-state-top">延期</div>
                            <!-- 比赛状态 弃赛 -->
                            <@ }else if( item1.game_status == 4) { @>
                                <div class="match-state match-state-top">弃赛</div>
                            <!-- 比赛状态 中断 -->
                            <@ }else if( item1.game_status == 5) { @>
                                <div class="match-state match-state-top">中断</div>
                            <@ }else{ @>
                                <@=item1.game_period_cn@><br />
                                <@=item1.game_time@>
                            <@ } @>
                        </div>
                        <@ if( !_.isNull( item1.home_score ) ) { @>
                            <div class="match-score">
                                <@=item1.home_score@><@ if( !_.isEmpty( item1.home_shoot_out_score ) ) { @><span class="thepenalty">(<@=item1.home_shoot_out_score@>)</span><@ } @><br />
                                <@=item1.away_score@><@ if( !_.isEmpty( item1.away_shoot_out_score ) ) { @><span class="thepenalty">(<@=item1.away_shoot_out_score@>)</span><@ } @>
                            </div>
                        <@ } @>
                        <div class="team-name">
                            <div class="team-name-list">
                                <@if(item1.home_logo){@>
                                <i class="team-logo">
                                    <img src="<@=item1.home_logo@>" alt="<@=item1.home_name@>"/>
                                </i>
                                <@}@>
                                <h4><@=item1.home_name@></h4>
                            </div>
                            <div class="team-name-list">
                                <@if(item1.away_logo){@>
                                <i class="team-logo">
                                    <img src="<@=item1.away_logo@>" alt="<@=item1.away_name@>"/>
                                </i>
                                <@}@>
                                <h4><@=item1.away_name@></h4>
                            </div>
                        </div>
                        <div class="match-played">
                            <@if (!datas.leagueCN) {@>
                                <@=item1.leagueCN@><br />
                            <@ }else{ @>
                                <@=datas.leagueCN@><br />
                            <@ } @>

                            <@ if( item1.round_type_str ) { @>
                                <@=item1.round_type_str@>
                           
                            <@ } else if(item1.match_day) {@>
                                第<@=item1.match_day@>轮
                            <@ } @>
                        </div>
                    </a>
                </div>
            <@ }); @>
        </section>
    <@ }); @>
</script>

{%script%}
var matchList = require("common:widget/ui/soccer-match-list/match-list.js");
var pageTool = require("common:widget/ui/page-tools/page-tools.js");
pageTool.initTools({
    today: true,
    todayHandler: function(){
        var _top = $('.match-today').offset().top;
        $('html,body').scrollTop(_top);
    }
});
{%/script%}
