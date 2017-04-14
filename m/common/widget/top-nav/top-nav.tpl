{%$level2Nav=[]%}
{%$className=[]%}
{%if (isset($level2) && !empty($level2))%}
    {%$level2Nav = $level2%}
{%** M站首页 **%}
{%elseif isset($channel) && $channel == "sports"%}
    {%$level2Nav = $topNav%}
{%else%}
{%/if%}
{%if isset($isTwoNav)%}
    {%$className="m-top-nav-station m-top-nav-fixed"%}
{%else%}
    {%$className="m-top-nav-station"%}
{%/if%}
    <section class="{%$className%}">
        <section class="m-top-nav" id="J_mTopNav">
            <section class="m-top-bar {%if empty($isTwoNav) && (isset($channel) && $channel != "bbsdetail")%}m-top-bar-shadow{%/if%} {%if !isset($node)%}m-top-bar-crumbs{%/if%}">
                <h2 class="m-logo">
                    <a href="{%$baseurl%}" dace-node="{%$id4dace%}_navigation_0">
                        {%if isset($channel) && $channel == "sports"%}
                            <img src="./logo-sports.png" class="logo-sports" alt="" />
                        {%else%}
                            <img src="./logo.png" alt="" />
                        {%/if%}
                    </a>
                </h2>
                {%if isset($node) %}
                    <ul class="crumbs-list">
                        {%foreach from=$node item=val name=key%}
                            {%if $val.url == "#"%}
                                <li>
                                    <span>{%$val.title%}</span>
                                </li>
                            {%else%}
                                <li>
                                    <a href="{%$val.url%}" class="title_len_{%$val@index%}" dace-node="{%$id4dace%}_navigation_{%$val@index+1%}">{%$val.title%}</a>
                                </li>
                            {%/if%}
                        {%/foreach%}
                    </ul>
                {%/if%}
                {%** bbs频道单独处理 **%}
                {%if isset($channel) && $channel == "bbs"%}
                <div class="nav-itembar">
                    {%if !empty($fromPage) && $fromPage == "index"%}
                        <a href="{%$baseurl%}/bbs/searchthreads" dace-node="{%$id4dace%}_search" class="search-link"><i class="icon icon-search"></i></a>
                    {%else%}
                        <a href="{%$baseurl%}/bbs/searchthreads?fid={%$fid%}&fromBBS={%$fid%}" dace-node="{%$id4dace%}_search" class="search-link"><i class="icon icon-search"></i></a>
                    {%/if%}
                    <a href="{%$baseurl%}/my" dace-node="{%$id4dace%}_my" class="pc-link button-link-my icon-basic-info"></a>
                    {%if $message_unread != 0%}
                    <span class="num-notice" {%if $message_unread > 99%}style="right:2px;"{%/if%}>{%if $message_unread > 99%}99+{%else%}{%$message_unread%}{%/if%}</span>
                    {%/if%}
                </div>

                {%** M站首页 channel == sports **%}
                {%elseif isset($channel) && $channel == "sports"%}
                    <a href="{%$baseurl%}/my" dace-node="{%$id4dace%}_user" class="button-link-my icon-basic-info"></a>
                    {%if $message_unread != 0%}
                    <span class="num-notice" {%if $message_unread > 99%}style="right:2px;"{%/if%}>{%if $message_unread > 99%}99+{%else%}{%$message_unread%}{%/if%}</span>
                    {%/if%}
                {%elseif isset($channel) && $channel == "bbsdetail"%}
                    <a href="javascript:" class="button-star icon-collect " id="J_top_star" data-uid="{%$uid%}" data-tid="{%$thread.tid%}" dace-node="{%$id4dace%}_fav" title="收藏"></a>
                    <a href="javascript:" class="button-share icon-share" id="J_top_share" dace-node="{%$id4dace%}_share" title="分享"></a>
                    <a href="{%$baseurl%}/my" dace-node="{%$id4dace%}_my" class="pc-link button-link-my icon-basic-info"></a>
                    {%if $message_unread != 0%}
                    <span class="num-notice" {%if $message_unread > 99%}style="right:2px;"{%/if%}>{%if $message_unread > 99%}99+{%else%}{%$message_unread%}{%/if%}</span>
                    {%/if%}
                {%else%}
                    <a href="javascript:" dace-node="{%$id4dace%}_mainNavigation" class="button-all-nav J_topNavButtonAllNav">
                        <i class="point"></i>
                    </a>
                {%/if%}

                {%if isset($topNav) && !empty($topNav)%}
                    <a href="javascript:" class="button-close-nav J_topNavButtonCloseNav"></a>
                {%/if%}
            </section>
            {%if !empty($topNav)%}
                <div class="m-one-nav" id="J_topOneNav">
                    <ul class="m-one-nav-list">
                        {%foreach from=$topNav item=val name=key%}
                        <li>
                            <a href="{%$val.url%}">{%$val.title%}</a>
                        </li>
                        {%/foreach%}
                    </ul>
                </div>
            {%/if%}
            {%if !empty($isTwoNav)%}
                <nav id="J_topMainNav" class="m-main-nav{%if $level2Nav|count > 6%} m-main-nav-more{%/if%}">
                    <ul class="main-nav-list">
                        {%foreach from=$level2Nav item=val name=key%}
                            <li>
                                <a href="{%$val.url%}" dace-node="{%$id4dace%}_{%$val.router%}">
                                    {%if isset($val.name)%}
                                        {%$val.name%}
                                    {%else%}
                                        {%$val.title%}
                                    {%/if%}
                                </a>
                            </li>
                        {%/foreach%}
                    </ul>
                </nav>
            {%/if%}

            {%if !empty($bbsnav) && isset($channel) && $channel == "bbs" %}
                {%** bbs数据转换 **%}
                {%$bbs_side_nav=[]%}
                {%$bbs_forums=[]%}

                {%foreach from=$bbsnav item=val name=key%}
                    {%$ret = array_push($bbs_side_nav,$val.name)%}
                    {%$ret1 = array_push($bbs_forums,$val.forums)%}
                {%/foreach%}

                <div class="popup-bbs-nav" id="J_topPopBbsNav">
                    <div class="popup-bbs-nav-bd">
                        <div class="side-nav-list J_popBbsNavList">
                            <ul class="list">
                                {%foreach from=$bbs_side_nav item=val key=keys%}
                                    <li {%if $keys == 0%}class="active"{%/if%} >
                                        <a href="javascript:">{%$val%}</a>
                                    </li>
                                {%/foreach%}
                            </ul>
                        </div>
                        <div class="bbs-nav-link J_popBbsNavContent">
                            {%foreach from=$bbs_forums[0] item=val name=key%}
                                {%**var_dump($val.name)**%}
                                <a href="{%$val.url%}">{%$val.name%}</a>
                            {%/foreach%}
                        </div>
                    </div>
                </div>
            {%/if%}
        </section>
    </section>

<script id="top-nav-bbs-template" type="text/template">
    <@ _.each(datas, function(item,index) { @>
        <a href="<@=item.url@>"><@=item.name@></a>
    <@ }); @>
</script>
{%script%}
    {%if !empty($bbsnav) && isset($channel) && $channel == "bbs" %}
        HPM.bbsNavJson = {%json_encode($bbs_forums)%};
    {%/if%}
    var TopNav = require("common:widget/top-nav/top-nav.js");
    TopNav.init({%if isset($isTwoNav) && $isTwoNav%}true{%else%}false{%/if%});

    {%if !empty($channel) && $channel == "bbsdetail"%}
        //触发挂载在document上的"page:share"事件.
        $("#J_top_share").bind("click", function(){
            $(document).trigger("page:share");
        });
    {%/if%}
{%/script%}
