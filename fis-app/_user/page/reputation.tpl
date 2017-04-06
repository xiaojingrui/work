{%extends file="common/page/layout.tpl"%}

{%block name="title"%}{%$title%}{%/block%}

{%block name="head_static"%}
    <script type="text/javascript" src="//w1.hoopchina.com.cn/hybrid/common/hpbridge_v1.0.1.js"></script>
    {%require name="user:static/reputation/reputation.scss"%}
    {%script%}
    window.GM = {
        "client": "{%$client%}" || "x",
        "projectId":"{%$projectId%}"||"null",
        "version": "{%$version%}"||"7.0.10.0",
        "nextPage": !!parseInt("{%$info.hasNextPage%}", 10),
        "hasList": !!parseInt("{%count($list)%}", 10),
        "puid": "{%$smarty.get.puid%}",
        "lastId": "{%if !empty($list)%}{%$list[count($list)-1]['id']%}{%/if%}"
    };

    var reputation = require("user:widget/reputation/reputation.js");
    reputation.init();
    {%/script%}
{%/block%}

{%block name="content"%}
    {%$level=1%}
    {%foreach $info.list as $item%}
        {%if $item.name == $info.title%}
            {%$level=$item@index+1%}
        {%/if%}
    {%/foreach%}
    <div class="rep-background gradient-{%$level%}" id="J-reputation-background">
        <div class="rep-info" id="J-reputation-top-tips" dace-node="prestigeTip">&nbsp;每日2点更新</div>
        <div class="rep-main">
            <div class="rep-count">{%$info.incoming%}</div>
            <div class="rep-name">{%$info.title%}</div>
        </div>
        <div class="rep-tips">
            <div class="rep-left-bor"></div>
            <div class="rep-right-bor"></div>
            虎扑声望是JRs成长的见证
        </div>
        <div class="rep-control clearfix">
            <div class="rep-up" id="J-reputation-up" dace-node="prestigeUp">提升方法</div>
            <div class="rep-use" id="J-reputation-use" dace-node="prestigeUse">声望用途</div>
        </div>
    </div>
    <div class="rep-content" {%if empty($list)%}style="display:none"{%/if%}>
        <h4>我的声望明细:</h4>
        <ul class="rep-list" id="J-rep-list">
        {%if !empty($list)%}
        {%foreach $list as $item%}
            <li>
                <div class="con-l">{%$item.desc%}</div>
                <div class="con-r">
                {%if intval($item.incoming) > 0%}
                    <div class="score red">+{%$item.incoming%}</div>
                {%else%}
                    <div class="score green">{%$item.incoming%}</div>
                {%/if%}
                    <div class="date">{%$item.timeline%}</div>
                </div>
            </li>
        {%/foreach%}
        {%/if%}
        </ul>
        <div id="J-last-tips" class="rep-nomore"><p>没有更多了</p></div>
    </div>
    <script type="text/template" id="J_rep-tpl">
        <@datas.forEach(function(item){@>
            <li>
                <div class="con-l"><@=item.desc@></div>
                <div class="con-r">
                    <@if(parseInt(item.incoming) > 0){@>
                        <div class="score red">+<@=item.incoming@></div>
                    <@}else{@>
                        <div class="score green"><@=item.incoming@></div>
                    <@}@>
                    <div class="date"><@=item.timeline@></div>
                </div>
            </li>
        <@})@>
    </script>
{%/block%}
