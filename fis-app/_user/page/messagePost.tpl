{%extends file="common/page/layout.tpl"%}

{%block name="title"%}帖子回复{%/block%}

{%block name="head_static"%}
    <script type="text/javascript">
        window.GM = {
            "client": "{%$client%}" || "x",
            "projectId":"{%$projectId%}" || "null",
            "version":"{%$version%}" || "7.0.18",
            "pageStr": "{%$result.pageStr%}",
            "hasNextPage": !!parseInt("{%$result.hasNextPage%}", 10)
        };
    </script>
    {%require name="common:static/js/underscore/underscore.js"%}
    {%require name="common:static/js/zepto/zepto.js"%}
    {%require name="user:static/messagePost/messagePost.js"%}
    {%require name="user:static/messagePost/messagePost.scss"%}
{%/block%}

{%block name="content"%}
<div id="J-height"></div>
<section class="message-post">
    <div id="J_content" data-type="2">
        {%if !empty($result.data)%}
            {%$bHistory = true%}
            {%foreach $result.data as $val%}
                {%if $val.read == 1 && $bHistory%}
                    <div class="history">以下是历史消息</div>
                    {%$bHistory = false%}
                {%/if%}
                <a href="kanqiu://bbs/topic/{%$val.cid%}?page={%$val.post.page%}&pid={%$val.post.pid%}" class="item" dace-node="tab2_mypostreply">
                    <span>你的帖子</span>
                    <span class="title"><span>{%$val.title%}</span></span>
                    <span>新增{%$val.num%}回复</span>
                    <span class="time">{%$val.format_time%}</span>
                </a>
            {%/foreach%}
            {%if empty($result.hasNextPage)%}
                <div class="history" {%if $result.data|count == 0%}style="padding-bottom:80%;"{%/if%}>没有更多了</div>
            {%/if%}
        {%else%}
            <div class="no-result"><p>暂时还没有收到消息</p></div>
        {%/if%}
    </div>
</section>

<script type="text/template" id="J-tpl">
    <@ _.each(datas, function(item, index){ @>
    <a href="kanqiu://bbs/topic/<@=item.cid@>?page=<@=item.post.page@>&pid=<@=item.post.pid@>" class="item">
        <span>你的帖子</span>
        <span class="title"><span><@=item.title@></span></span>
        <span>新增<@=item.num@>回复</span>
        <span class="time"><@=item.format_time@></span>
    </a>
    <@ }); @>
</script>
{%/block%}
