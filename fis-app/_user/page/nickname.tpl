{%extends file="common/page/layout.tpl"%}

{%block name="title"%}设置昵称{%/block%}

{%block name="head_static"%}
    <script type="text/javascript" src="//w1.hoopchina.com.cn/hybrid/common/hpbridge_v1.0.1.js"></script>
    {%require name="common:static/js/underscore/underscore.js"%}
    {%require name="common:static/js/zepto/zepto.js"%}
    {%require name="user:static/nickname/nickname.scss"%}
    <script>
        window.GM = {
            "nid": "{%$news.nid%}",
            "islogin": !!parseInt("{%$is_login%}", 10),
            "client": "{%$client%}" || "x",
            "projectId":"{%$projectId%}"||"1",
            "version":"{%$version%}"||"7.0.6",
            "night":!!parseInt("{%$night%}", 10),
            "nopic":!!parseInt("{%$nopic%}", 10)
        };
    </script>
    {%require name="user:static/nickname/nickname.js"%}
{%/block%}

{%block name="content"%}
<section class="my-nickname-wrap">
    <form action="">
        <div class="title">给自己取个拉风的昵称吧</div>
        <input type="text" value="{%$nickname%}" placeholder="输入昵称" name="nickname" class="nick-ipt">
        <p>只允许汉字、字母、数字，3到10个汉字，提交后无法修改。该昵称仅用于展示，无法用于登录</p>
        <input type="submit" value="保存" class="save-btn">
    </form>
</section>
{%/block%}
