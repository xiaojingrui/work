<section id="J-nav-wrap">
    {%if !empty($level2)%}
    <section class="main-nav-wrap {%if !empty($isDetail)%}no-fixed{%/if%}" {%if empty($hasMidNav) && empty($subnav)%}style="border-bottom: 1px solid #e1e1e1;"{%/if%}>
        <div class="mod-nav main-nav">
            {%foreach $level2 as $val%}
                <a href="{%if !empty($val.url)%}{%$val.url%}{%else%}javascript:;{%/if%}" class="{%if !empty($val.is_current)%}active{%/if%} {%if empty($val.url)%}no-link{%/if%}">
                    {%$val.name%}
                    {%if !empty($val.is_current)%}
                        {%if !empty($hasMidNav) || !empty($subnav)%}
                            <span class="triangle"></span>
                        {%else%}
                            <span class="line"></span>
                        {%/if%}
                    {%/if%}
                </a>
            {%/foreach%}
        </div>
    </section>
    {%/if%}

    {%if !empty($hasMidNav) || !empty($subnav)%}
        <section class="mod-nav mid-nav">
            {%foreach $subnav as $val%}
            <a href="{%$val.url%}" {%if !empty($val.is_current)%}class="active"{%/if%}>{%$val.name%}</a>
            {%/foreach%}
        </section>
    {%/if%}

    {%if !empty($hasBreadNav)%}
        <section class="mod-nav sub-nav">
            <div class="bread-nav">
                <a href="/">首页</a>
                {%foreach $node as $val%}
                    <span class="icon64 icon64-arrow"></span>
                    <a href="{%$val.url%}" {%if $val.url == "#"%}class="current"{%/if%}>{%$val.title%}</a>
                {%/foreach%}
            </div>
            {%if !empty($hasUserTools)%}
                <div class="tools">
                    <a href="
                    {%if !empty($fromPage) && $fromPage == "index"%}
                        {%$baseurl%}/bbs/searchthreads
                    {%else%}
                        {%$baseurl%}/bbs/searchthreads?fid={%$fid%}&fromBBS={%$fid%}
                    {%/if%}
                    " dace-node="{%$id4dace%}_search" class="icon64 icon64-search search-link" title="搜索"></a>
                    <a href="{%$baseurl%}/my" dace-node="{%$id4dace%}_my" class="icon64 icon64-user" title="个人中心">
                        {%if $message_unread != 0%}
                            <span class="remind" {%if $message_unread > 10 && $message_unread <= 99%}style="right:-8px;"{%else if $message_unread > 99%}style="right:-14px;"{%/if%}>{%if $message_unread > 99%}99+{%else%}{%$message_unread%}{%/if%}</span>
                        {%/if%}
                    </a>
                </div>
            {%/if%}
            {%if !empty($hasPostTools)%}
                <div class="tools">
                    <a href="javascript:;" class="icon64 icon64-share" id="J_top_share" dace-node="{%$id4dace%}_share" title="分享"></a>
                    <a href="javascript:;" class="icon64 icon64-collect" id="J_top_star" data-uid="{%$uid%}" data-tid="{%$thread.tid%}" dace-node="{%$id4dace%}_fav" title="收藏"></a>
                    <a href="{%$baseurl%}/my" dace-node="{%$id4dace%}_my" class="icon64 icon64-user" title="个人中心">
                        {%if $message_unread != 0%}
                            <span class="remind" {%if $message_unread > 10 && $message_unread <= 99%}style="right:-8px;"{%else if $message_unread > 99%}style="right:-14px;"{%/if%}>{%if $message_unread > 99%}99+{%else%}{%$message_unread%}{%/if%}</span>
                        {%/if%}
                    </a>
                </div>
            {%/if%}
        </section>
    {%/if%}
</section>

{%script%}
    var newTopNav = require("common:widget/new-top-nav/new-top-nav.js");
    newTopNav.init();

    var toShare = require("common:widget/ui/share/share.js");
    //全局分享事件, 每个页面单独注册.
    $(document).on("page:share", function(){
        toShare();
    });
    //触发挂载在document上的"page:share"事件.
    $("#J_top_share").bind("click", function(){
        $(document).trigger("page:share");
    });
{%/script%}
