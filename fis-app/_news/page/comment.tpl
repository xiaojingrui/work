{%extends file="common/page/layout.tpl"%}

{%block name="title"%}全部评论{%/block%}

{%block name="head_static"%}
    <script type="text/javascript" src="//w10.hoopchina.com.cn/hybrid/common/hpbridge_v1.0.1.js"></script>
    {%require name="common:static/js/zepto/zepto.js"%}
    {%require name="news:static/comment/comment.scss"%}
    <script>
        window.GM = {
            "nid": "{%$nid%}",
            "hid": "{%$hid%}",
            "islogin": !!parseInt("{%$is_login%}", 10),
            "client": "{%$client%}" || "x",
            "projectId":"{%$projectId%}"||"null",
            "version":"{%$version%}"||"7.0.6.0",
            "token": "{%$token%}",
            "night":!!parseInt("{%$night%}", 10),
            "nopic":!!parseInt("{%$nopic%}", 10),
            "cid": "{%$cid%}" || "",
            "top_ncid": "{%$top_ncid%}" || "",
            "uid": "{%$uid%}" || "",
            "user_name": "{%$user_name%}" || "",
            "puid": "{%$puid%}" || "",
            "header": "{%$header%}" || "//b3.hoopchina.com.cn/games/images/man.jpg",
            "leaguesEn": "{%$leaguesEn%}" || "epl",
            "is_admin": !!parseInt("{%$is_admin%}", 10),
            "ft": "{%if isset($ft)%}{%if intval($ft) < 12 %}18{%else%}{%$ft%}{%/if%}{%else%}18{%/if%}"
        };
    </script>
    {%script%}
        var app = require("common:widget/ui-app/ui-app.js");
        app.init(function(){
            var Reply = require("news:widget/reply/reply.js");
            Reply.init();
        }, ~location.search.indexOf("debug"));
    {%/script%}
{%/block%}

{%block name="content"%}
<section class="detail-wrap" id="J_replyWrap">
    <script type="text/template" id="J_titleTpl">
        {%widget
            name="news:widget/artical-title/title.tpl"
            tplType= "js"
        %}
    </script>

    <div id="J_replyTitle">

    </div>

    {%widget
        name="news:widget/reply/reply.tpl"
        replyType="comment"
    %}
</section>
{%/block%}
