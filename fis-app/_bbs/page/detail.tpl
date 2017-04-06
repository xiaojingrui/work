{%extends file="common/page/layout.tpl"%}

{%block name="title"%}{%$title%}{%/block%}

{%block name="head_static"%}
    <!--论坛bridge脚本-->
    <script type="text/javascript" src="//w10.hoopchina.com.cn/hybrid/common/hpbridge_v1.0.1.js"></script>

    {%require name="common:static/js/underscore/underscore.js"%}
    {%require name="common:static/js/zepto/zepto.js"%}
    {%require name="bbs:static/detail/detail.scss"%}
    {%script%}
    {%if empty($smarty.get.page)%}
        {%$page = 1%}
    {%else%}
        {%$page = intval($smarty.get.page)%}
    {%/if%}

    window.GM = {
        "prev": !!parseInt("{%$smarty.get.prev%}"),
        "tid": "{%$tid%}",
        "last": !!parseInt("{%$smarty.get.last%}"),
        "isNew": !!parseInt("{%$smarty.get.isnew%}", 10) || 0,
        "author_puid": "{%$author_puid%}",
        "unlights_enable": !!parseInt("{%$forum.unlights_enable%}"),
        "hasPraise": !!parseInt("{%$show_post_praise%}"),
        "pid": "{%$smarty.get.pid%}" || 0,
        "fid": "{%$fid%}",
        "surprise": {%json_encode($surprise)%},
        "puid": "{%$puid%}" || "",
        "isOwner": parseInt("{%$smarty.get.postAuthorPuid%}", 10) || 0,
        "page": parseInt("{%$page%}", 10) || 1,
        "islogin": !!parseInt("{%$is_login%}", 10),
        "totalPage": parseInt("{%$totalPage%}", 10) || 1,
        "client": "{%$client%}" || "x",
        "projectId":"{%$projectId%}"||"null",
        "version":"{%$version%}"||"7.0.5.0",
        "title":"{%$title%}",
        "night":parseInt("{%$night%}", 10),
        "nopic":parseInt("{%$nopic%}", 10),
        "wasError": !!parseInt("{%!!$error%}" , 10),
        "ft": "{%if intval($ft) < 14 && !empty($ft)%}18{%else%}{%$ft%}{%/if%}"
    };

    var app = require("common:widget/ui-app/ui-app.js");
    app.init(function(){
        var reply = require("bbs:widget/reply/reply.js");
        reply.init();
    }, ~location.search.indexOf("debug"));

    {%/script%}
{%/block%}

{%block name="content"%}
{%if empty($smarty.get.page)%}
    {%$page = 1%}
{%else%}
    {%$page = intval($smarty.get.page)%}
{%/if%}
<section class="detail-wrap">
    <section class="detail-content" id="J-page-container" {%if $page != 1%}style="display:none"{%/if%}>
        {%if empty($error)%}
        {%if !empty($merge_title)%}<p class="tips"><em></em>{%$merge_title%}</p>{%/if%}
        <header class="artical-title">
            <h1 class="headline">{%$title%}</h1>
            <div class="artical-info">
                <span class="times">{%$time%}</span>
                <span class="post-board">
                    {%if !empty($is_admin)%}
                        <em>版务操作
                            <select class="J-bbsrecommend-manage">
                                {%if empty($is_recommend_filter)%}
                                    <option value="1">隐藏推荐</option>
                                {%else%}
                                    <option value="-1">取消隐藏推荐</option>
                                {%/if%}
                                <option value="0" selected="selected">取消</option>
                            </select>
                        </em>
                    {%/if%}
                    <a href="kanqiu://bbs/board/{%$fid%}" dace-node="postBoard">{%if !empty($forum.name)%}{%$forum.name%}{%/if%}</a>
                </span>
            </div>
            <div class="line"></div>
        </header>
        <article class="article-content">
            <div class="article-author clearfix">
                <a href="kanqiu://people/{%$author_puid%}" dace-node="postuser" class="author_title"><img src="{%$userImg%}" class="author-icon J-user-avatar-img" /> {%$username%}
                    <span class="mod-mask mask"></span>
                </a>
                {%if !empty($certurl) && !empty($certuser)%}
                <a href="kanqiu://people/{%$author_puid%}" class="certification">
                    {%$type = 1%}
                    {%$info = ""%}
                    {%if intval($night)%}
                        {%$mergesrc="night"%}
                    {%else%}
                        {%$mergesrc="day"%}
                    {%/if%}

                    {%if !empty($certuser["1"]) && !empty($certuser["2"]) %}
                        {%$type = 3%}
                        {%$info = join("、", [$certuser["1"].cert_info, $certuser["2"].cert_info])%}
                    {%else%}
                        {%if !empty($certuser["1"]) %}
                            {%$type = 1%}
                            {%$info = $certuser["1"].cert_info%}
                        {%elseif !empty($certuser["2"]) %}
                            {%$type = 2%}
                            {%$info = $certuser["2"].cert_info%}
                        {%/if%}
                    {%/if%}


                    {%if $type == 1%}
                        <img src="//w10.hoopchina.com.cn/hybrid/resource/cert/author_{%$mergesrc%}.png" alt="author" height="22">
                    {%elseif $type == 2%}
                        <img src="//w10.hoopchina.com.cn/hybrid/resource/cert/official_{%$mergesrc%}.png" alt="official" height="22">
                    {%elseif $type == 3%}
                        <img src="//w10.hoopchina.com.cn/hybrid/resource/cert/merge_{%$mergesrc%}.png" alt="author+official" height="22">
                    {%/if%}
                    <span>{%$info%}</span>
                </a>
                {%/if%}
            </div>
            <div class="J-article-content" style="font-size:{%if !empty($ft)%}{%if intval($ft) < 14%}18{%else%}{%$ft%}{%/if%}{%else%}17{%/if%}px;">
              {%$content|escape:none%}
            </div>
        </article>

          <!--赞赏-->
          {%if !empty($praise) && $praise.status == 200%}
            {%widget
              name="common:widget/mod-zan/mod-zan.tpl"
              author=$praise.userinfo
              users=$praise.list.goldUsers
              type="bbs"
              callname="楼主"
              userCount=$praise.list.userCount
              goldCount=$praise.list.goldCount
              typeid=$tid
              fid=$forum.fid
              tips=$praise.tips
            %}
          {%/if%}
        {%/if%}
    </section>

    {%widget
        name="bbs:widget/reply/reply.tpl"
    %}
</section>
{%if !empty($error)%}
<div class="detail-error">
    <p>{%$error.text%}</p>
</div>
{%/if%}
{%/block%}
