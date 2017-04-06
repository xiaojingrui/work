{%extends file="common/page/layout.tpl"%}

{%block name="title"%}{%$name%}{%if $name != "射手榜"%}榜{%/if%}{%/block%}

{%block name="head_static"%}
    {%require name="common:static/js/zepto/zepto.js"%}
    {%require name="match:widget/rank_list/rank_list.scss"%}
    <script type="text/javascript" src="//w1.hoopchina.com.cn/hybrid/common/hpbridge_v1.0.1.js"></script>
    {%script%}
        window.GM = {
            "client": "{%$client%}" || "x",
            "islogin": !!parseInt("{%$is_login%}", 10),
            "night": !!parseInt("{%$night%}", 10)
        };

        var allRankWrapContainer = $("#J-all-rank-wrap");
        var current = null;

        allRankWrapContainer.delegate(".link", "click", function(e){
            current = $(e.currentTarget);
            window.location.href = current.attr("link");
        });

        initBridge(function(){
			HupuBridge.send("hupu.ui.share", {
				open: false
			}, function(){});
		});

        function initBridge(callback) {
            if(window.HupuBridge){
                callback();
            }else{
                document.addEventListener("hupuBridgeReady", function(){
                    callback();
                });
            }
        }
    {%/script%}
    {%style%}
    .detail span {
        width: 95px;
        display: inline-block;
        line-height: normal;
        word-wrap: break-word;
        vertical-align: middle;
    }
    {%/style%}
{%/block%}

{%block name="content"%}
<section class="all-rank mod-rank" id="J-all-rank-wrap">
    <table class="mod-title fixed" style="position: fixed;">
        <thead>
            <tr>
                <td width="50%" colspan="3" class="type">{%if $rank_type == "goals" || $rank_type == "assits" ||  $rank_type|substr:"-2" === "_p"%}球员{%else%}球队{%/if%}</td>
                {%if $rank_type == "goals" || $rank_type == "assits" ||  $rank_type|substr:"-2" === "_p"%}
                    <td width="30%" align="center">球队</td>
                {%else%}
                    <td width="30%" align="center">&nbsp;</td>
                {%/if%}
                <td width="20%" align="center">数据{%**$title**%}</td>
            </tr>
        </thead>
    </table>
    {%if !empty($data)%}
    <section id="J-scroll-wrapper">
        <table class="mod-table">
            <tbody id="J-all-rank">
                {%foreach $data as $val%}
                <tr {%if $league_name != "afccl"%}class="link"{%/if%}
                {%if $rank_type == "goals" || $rank_type == "assits" || $rank_type|substr:"-2" === "_p"%}
                    {%if $league_name != "afccl"%}
                    link="kanqiu://soccerleagues/{%$league_name%}/player/{%$val.player_pid%}"
                    {%/if%}
                {%else%}
                link="kanqiu://soccerleagues/{%$league_name%}/team/{%$val.team_id%}"
                {%/if%}>
                    <td width="8%">
                        <span class="{%if $val@index==0%}red{%/if%} num">{%$val@index+1%}</span>
                    </td>
                    <td width="12%" {%if $rank_type != "goals" && $rank_type != "assits" && $rank_type|substr:"-2" != "_p"%}align="center"{%/if%}>
                        {%if $rank_type == "goals" || $rank_type == "assits" || $rank_type|substr:"-2" === "_p"%}
                            <span class="logo"><img src="{%$val.player_logo%}?t={%$val@index%}" width="30" />{%if !empty($night)%}<span class="mask"></span>{%/if%}</span>
                        {%else%}
                            <img src="{%$val.team_logo%}?t={%$val@index%}" width="34" />
                        {%/if%}
                    </td>
                    <td width="30%">
                        <span class="detail">
                            {%if $rank_type == "goals" || $rank_type == "assits" || $rank_type|substr:"-2" === "_p"%}
                            <span class="name">{%$val.player_name%}</span>
                            {%else%}
                            <span class="name">{%$val.team_name%}</span>
                            {%/if%}
                        </span>
                    </td>
                    {%if $rank_type == "goals" || $rank_type == "assits" || $rank_type|substr:"-2" === "_p"%}
                        <td width="30%" align="center">{%$val.team_name%}</td>
                        <td width="20%" align="center">
                            {%if $rank_type == "pass_per_p"%}
                                {%$val[$field]*100%}%
                            {%else%}
                                {%if $league_name == "afccl" || $league_name == "chlg" || $league_name == "uefael"%}
                                    {%$val[$field]%}
                                {%else%}
                                    {%$val[$rank_type]%}
                                {%/if%}
                            {%/if%}
                        </td>
                    {%else%}
                        <td width="30%" align="center">&nbsp;</td>
                        <td width="20%" align="center">
                            {%if $rank_type == "pass_per"%}
                                {%$val[$field]*100%}%
                            {%else%}
                                {%$val[$field]%}
                            {%/if%}
                        </td>
                    {%/if%}
                </tr>
                {%/foreach%}
            </tbody>
        </table>
    </section>
    {%else%}
    <div class="mod-no-result">暂无比赛数据</div>
    {%/if%}
</section>
{%/block%}
