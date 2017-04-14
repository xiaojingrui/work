{%extends file="common/page/layout.tpl"%}
{%block name="block_head_static"%}
    <script type="text/javascript">
        window.GM = {
            "id": "{%$messages.list[$messages.list|count-1].id%}",
            "time": "{%$messages.list[$messages.list|count-1].update_time%}",
            "hasNextPage": !!parseInt("{%$messages.nextPage%}", 10)
        };
    </script>
    {%require name="my:static/messagePublic/messagePublic.js"%}
    {%require name="my:static/messagePublic/messagePublic.scss"%}
{%/block%}

{%block name="content"%}
    {%widget
        name="common:widget/top-title/top-title.tpl"
        banner="我的消息"
    %}

    <section class="tab-wrap">
        <div class="tab">
            <a href="{%$at_url%}">提到我的{%if $remind.at != 0%}<span class="remind">{%if $remind.at > 99%}99+{%else%}{%$remind.at%}{%/if%}</span>{%/if%}</a>
            <a href="javascript:;" class="active">帖子回复{%if $remind.reply != 0%}<span class="remind">{%if $remind.reply > 99%}99+{%else%}{%$remind.reply%}{%/if%}</span>{%/if%}</a>
            <a href="{%$light_url%}">推荐/亮了{%if $remind.light != 0%}<span class="remind">{%if $remind.light > 99%}99+{%else%}{%$remind.light%}{%/if%}</span>{%/if%}</a>
        </div>
    </section>

    <section class="message-post">
        <div id="J_content" data-type="2">
            {%$bHistory = true%}
            {%if !empty($messages.list)%}
                {%foreach $messages.list as $val%}
                    {%if $val.read == 1 && $bHistory%}
                        <div class="history">以下是历史消息</div>
                        {%$bHistory = false%}
                    {%/if%}
                    <a href="{%$val.thread_url%}" class="item">
                        <span>你的帖子</span>
                        <span class="title">{%$val.title%}</span>
                        <span>新增{%$val.num%}回复</span>
                        <span class="time">{%$val.format_time%}</span>
                    </a>
                {%/foreach%}
                {%if empty($messages.nextPage)%}
                    <div class="history" {%if $messages.list|count == 0%}style="padding-bottom:80%;"{%/if%}>没有更多了</div>
                {%/if%}
            {%else%}
                <div class="no-result"><p>暂时还没有收到消息</p></div>
            {%/if%}
        </div>
    </section>

    <script type="text/template" id="J-tpl">
        <@ _.each(datas, function(item, index){ @>
        <a href="<@=item.cid@>" class="item">
            <span>你的帖子</span>
            <span class="title"><@=item.title@></span>
            <span>新增<@=item.num@>回复</span>
            <span class="time"><@=item.format_time@></span>
        </a>
        <@ }); @>
    </script>
{%/block%}
