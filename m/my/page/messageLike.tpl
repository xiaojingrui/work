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
            <a href="{%$reply_url%}">帖子回复{%if $remind.reply != 0%}<span class="remind">{%if $remind.reply > 99%}99+{%else%}{%$remind.reply%}{%/if%}</span>{%/if%}</a>
            <a href="javascript:;" class="active">推荐/亮了{%if $remind.light != 0%}<span class="remind">{%if $remind.light > 99%}99+{%else%}{%$remind.light%}{%/if%}</span>{%/if%}</a>
        </div>
    </section>

    <section class="message-wrap message-like">
        <div id="J_content" data-type="3">
            {%$bHistory = true%}
            {%if !empty($messages.list)%}
                {%foreach $messages.list as $val%}
                    {%if !isset($val.is_new) && $bHistory%}
                        <div class="item-tip history">以下是历史消息</div>
                        {%$bHistory = false%}
                    {%/if%}
                    {%if isset($val.rec_num)%}
                        <a href="{%$val.thread_url%}" class="item post-mention">
                            <span class="title">[帖子]&nbsp;你的帖子<span class="t-name">{%$val.title%}</span>被{%$val.rec_num%}人推荐</span>
                            <span class="time">{%$val.format_time%}</span>
                        </a>
                    {%else if $val.pid != "0" && $val.post.quote == "0"%}
                        <a href="{%$val.thread_url%}" class="item comment-mention">
                            <div class="hd">
                                <span class="title">[帖子]&nbsp;你在<span class="t-name">{%$val.title%}</span>中的回复被亮了{%$val.light_num%}次</span>
                                <span class="time">{%$val.format_time%}</span>
                            </div>
                            {%if $val.post.is_hide == 1 || $val.post.is_delete == 1 || $val.post.audit_status == 1%}
                                <div class="other-reply hidden">
                                    {%if $val.post.is_hide == 1%}
                                        该回帖被灭过多，已被折叠
                                    {%else if $val.post.is_delete == 1%}
                                        该回帖由于违规，已被删除
                                    {%else if $val.post.audit_status == 1%}
                                        该回帖可能违规，已被隐藏
                                    {%/if%}
                                </div>
                            {%else%}
                                <div class="bd">
                                    <div class="other-info">
                                        <span class="other-head">
                                            <img src="{%$val.post.header_small%}?t=2016{%$val@index%}">
                                            <span class="mask"></span>
                                        </span>
                                        <span class="other-name">{%$val.post.user_name%}</span>
                                    </div>
                                    <div class="reply">{%$val.post.content|escape:none%}</div>
                                </div>
                            {%/if%}
                        </a>
                    {%else%}
                        <a href="{%$val.thread_url%}" class="item reply-mention">
                            <div class="hd">
                                <span class="title">[帖子]&nbsp;你在<span class="t-name">{%$val.title%}</span>中的回复被亮了{%$val.light_num%}次</span>
                                <span class="time">{%$val.format_time%}</span>
                            </div>
                            {%if $val.post.is_hide == 1 || $val.post.is_delete == 1 || $val.post.audit_status == 1%}
                                <div class="other-reply hidden">
                                    {%if $val.post.is_hide == 1%}
                                        该回帖被灭过多，已被折叠
                                    {%else if $val.post.is_delete == 1%}
                                        该回帖由于违规，已被删除
                                    {%else if $val.post.audit_status == 1%}
                                        该回帖可能违规，已被隐藏
                                    {%/if%}
                                </div>
                            {%else%}
                                <div class="bd">
                                    <div class="other-info">
                                        <span class="other-head">
                                            <img src="{%$val.post.header_small%}?t=2016{%$val@index%}">
                                            <span class="mask"></span>
                                        </span>
                                        <span class="other-name">{%$val.post.user_name%}</span>
                                    </div>
                                    <div class="reply">
                                        {%if $val.post.quote_is_hide == 1 || $val.post.quote_is_delete == 1 || $val.post.quote_audit_status == 1%}
                                            <div class="my-reply hidden">
                                                {%if $val.post.quote_is_hide == 1%}
                                                    该回帖被灭过多，已被折叠
                                                {%else if $val.post.quote_is_delete == 1%}
                                                    该回帖由于违规，已被删除
                                                {%else if $val.post.quote_audit_status == 1%}
                                                    该回帖可能违规，已被隐藏
                                                {%/if%}
                                            </div>
                                        {%else%}
                                            <div class="my-reply">
                                                <p class="quote">
                                                    引用{%$val.post.quote_floor%}楼
                                                    @<span>{%$val.post.quote_username%}</span>
                                                    发表的：
                                                </p>
                                                <div class="content">{%$val.post.quote_content|escape:none%}</div>
                                            </div>
                                        {%/if%}
                                        <div class="other-reply">{%$val.post.content|escape:none%}</div>
                                    </div>
                                </div>
                            {%/if%}
                        </a>
                    {%/if%}
                {%/foreach%}
                {%if empty($messages.nextPage)%}
                    <div class="item-tip nomore" {%if $messages.list|count == 0%}style="padding-bottom:80%;"{%/if%}>没有更多了</div>
                {%/if%}
            {%else%}
                <div class="no-result"><p>暂时还没有收到消息</p></div>
            {%/if%}
        </div>
    </section>

    <script type="text/template" id="J-tpl">
        <@ _.each(datas, function(item, index){ @>
            <@ if(item.rec_num){ @>
                <a href="<@=item.thread_url@>" class="item post-mention">
                    <span class="title">[帖子]&nbsp;你的帖子<span class="t-name"><@=item.title@></span>被<@=item.rec_num@>人推荐</span>
                    <span class="time"><@=item.format_time@></span>
                </a>
            <@ }else if(item.pid != "0" && item.post.quote_info == "0"){ @>
                <a href="<@=item.thread_url@>" class="item comment-mention">
                    <div class="hd">
                        <span class="title">[帖子]&nbsp;你在<span class="t-name"><@=item.title@></span>中的回复被亮了<@=item.light_num@>次</span>
                        <span class="time"><@=item.format_time@></span>
                    </div>
                    <@ if(item.post.is_hide == 1 || item.post.is_delete == 1 || item.post.audit_statu == 1){ @>
                        <div class="other-reply hidden">
                            <@ if(item.post.is_hide == 1){ @>
                                该回帖被灭过多，已被折叠
                            <@ }else if(item.post.is_delete == 1){ @>
                                该回帖由于违规，已被删除
                            <@ }else if(item.post.audit_statu == 1){ @>
                                该回帖可能违规，已被隐藏
                            <@ } @>
                        </div>
                    <@ }else{ @>
                        <div class="bd">
                            <div class="other-info">
                                <span class="other-head">
                                    <img src="<@=item.post.header_small@>?t=2016<@=index@>">
                                    <span class="mask"></span>
                                </span>
                                <span class="other-name"><@=item.post.user_name@></span>
                            </div>
                            <div class="reply"><@=_.unescape(item.post.content)@></div>
                        </div>
                    <@ } @>
                </a>
            <@ }else{ @>
                <a href="<@=item.thread_url@>" class="item reply-mention">
                    <div class="hd">
                        <span class="title">[帖子]&nbsp;你在<span class="t-name"><@=item.title@></span>中的回复被亮了<@=item.light_num@>次</span>
                        <span class="time"><@=item.format_time@></span>
                    </div>
                    <@ if(item.post.is_hide == 1 || item.post.is_delete == 1 || item.post.audit_statu == 1){ @>
                        <div class="other-reply hidden">
                            <@ if(item.post.is_hide == 1){ @>
                                该回帖被灭过多，已被折叠
                            <@ }else if(item.post.is_delete == 1){ @>
                                该回帖由于违规，已被删除
                            <@ }else if(item.post.audit_statu == 1){ @>
                                该回帖可能违规，已被隐藏
                            <@ } @>
                        </div>
                    <@ }else{ @>
                        <div class="bd">
                            <div class="other-info">
                                <span class="other-head">
                                    <img src="<@=item.post.header_small@>?t=2016<@=index@>">
                                    <span class="mask"></span>
                                </span>
                                <span class="other-name"><@=item.post.user_name@></span>
                            </div>
                            <div class="reply">
                                <@ if(item.post.quote_is_hide == 1 || item.post.quote_is_delete == 1 || item.post.quote_audit_status == 1){ @>
                                    <div class="my-reply hidden">
                                        <@ if(item.post.quote_is_hide == 1){ @>
                                            该回帖被灭过多，已被折叠
                                        <@ }else if(item.post.quote_is_delete == 1){ @>
                                            该回帖由于违规，已被删除
                                        <@ }else if(item.post.quote_audit_status == 1){ @>
                                            该回帖可能违规，已被隐藏
                                        <@ } @>
                                    </div>
                                <@ }else{ @>
                                    <div class="my-reply">
                                        <p class="quote">
                                            引用<@=item.post.quote_floor@>楼
                                            @<span><@=item.post.quote_floor@></span>
                                            发表的：
                                        </p>
                                        <div class="content"><@=_.unescape(item.post.quote_info)@></div>
                                    </div>
                                <@ } @>
                                <div class="other-reply"><@=_.unescape(item.post.content)@></div>
                            </div>
                        </div>
                    <@ } @>
                </a>
            <@ } @>
        <@ }); @>
    </script>
{%/block%}
