{%extends file="common/page/layout.tpl"%}

{%block name="title"%}提到我的{%/block%}

{%block name="head_static"%}
    <script type="text/javascript">
        window.GM = {
            "client": "{%$client%}" || "x",
            "projectId":"{%$projectId%}" || "3",
            "version":"{%$version%}" || "7.0.18",
            "pageStr": "{%$result.pageStr%}",
            "hasNextPage": !!parseInt("{%$result.hasNextPage%}", 10)
        };
    </script>
    {%require name="common:static/js/underscore/underscore.js"%}
    {%require name="common:static/js/zepto/zepto.js"%}
    {%require name="user:static/messagePost/messagePost.js"%}
    {%require name="user:static/messageMention/messageMention.scss"%}
{%/block%}

{%block name="content"%}
<div id="J-height"></div>
<section class="message-wrap message-mention">
    <div id="J_content" data-type="1">
        {%if !empty($result.data)%}
            {%$bHistory = true%}
            {%foreach $result.data as $val%}
                {%if ($val.is_new == 0 || $val.read == 1) && $bHistory%}
                    <div class="item-tip history">以下是历史消息</div>
                    {%$bHistory = false%}
                {%/if%}
                {%if $val.data_type == 1%}
                    <div class="item reply-mention">
                        <div class="hd">
                            <span class="title">[新闻]&nbsp;<a href="{%$val.news.url%}" class="t-name" dace-node="tab1_newsurl">{%$val.news.title%}</a>提到了你</span>
                            <span class="time">{%$val.format_time%}</span>
                        </div>
                        <a href="{%$val.comment_url%}" class="url-wrap" dace-node="tab1_quotecomment">
                            {%if $val.reply_is_hide == 1 || $val.reply_is_delete == 1 || $val.reply_audit_status == 1%}
                                <div class="other-reply hidden">
                                    {%if $val.reply_is_hide == 1%}
                                        该评论被灭过多，已被折叠
                                    {%else if $val.reply_is_delete == 1%}
                                        该用户回复您的评论由于违规，已被删除
                                    {%else if $val.reply_audit_status == 1%}
                                        该评论可能违规，已被隐藏
                                    {%/if%}
                                </div>
                            {%else%}
                                <div class="bd">
                                    <div class="other-info">
                                        <span class="other-head">
                                            <img src="{%$val.reply_header%}?t=2016{%$val@index%}">
                                            <span class="mask"></span>
                                        </span>
                                        <span class="other-name">{%$val.reply_user_name%}</span>
                                    </div>
                                    <div class="reply">
                                        {%if $val.is_hide == 1 || $val.is_delete == 1 || $val.audit_status == 1%}
                                            <div class="my-reply hidden">
                                                {%if $val.is_hide == 1%}
                                                    该评论被灭过多，已被折叠
                                                {%else if $val.is_delete == 1%}
                                                    该评论由于违规，已被删除
                                                {%else if $val.audit_status == 1%}
                                                    该评论可能违规，已被隐藏
                                                {%/if%}
                                            </div>
                                        {%else%}
                                            <div class="my-reply">
                                                <div class="my-name">{%$val.user_name%}</div>
                                                <div class="content">{%$val.content|escape:none%}</div>
                                            </div>
                                        {%/if%}
                                        <div class="other-reply">{%$val.reply_content|escape:none%}</div>
                                    </div>
                                </div>
                            {%/if%}
                        </a>
                    </div>
                {%else if $val.data_type == 2%}
                    {%if $val.pid == "0"%}
                        <a href="kanqiu://bbs/topic/{%$val.cid%}" class="item post-mention" dace-node="tab1_postlink">
                            <span class="title">[帖子]&nbsp;<span class="t-name">{%$val.title%}</span>主帖提到了你</span>
                            <span class="time">{%$val.format_time%}</span>
                        </a>
                    {%else if $val.pid != "0" && $val.post.quote == "0"%}
                        <div class="item comment-mention">
                            <div class="hd">
                                <span class="title">[帖子]&nbsp;<a href="kanqiu://bbs/topic/{%$val.cid%}" class="t-name" dace-node="tab1_postlink">{%$val.title%}</a>提到了你</span>
                                <span class="time">{%$val.format_time%}</span>
                            </div>
                            <a href="kanqiu://bbs/topic/{%$val.cid%}?page={%$val.post.page%}&pid={%$val.post.pid%}" class="url-wrap" dace-node="	tab1_bbsmessageAt">
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
                        </div>
                    {%else%}
                        <div class="item reply-mention">
                            <div class="hd">
                                <span class="title">[帖子]&nbsp;<a href="kanqiu://bbs/topic/{%$val.cid%}" class="t-name" dace-node="tab1_postlink">{%$val.title%}</a>提到了你</span>
                                <span class="time">{%$val.format_time%}</span>
                            </div>
                            <a href="kanqiu://bbs/topic/{%$val.cid%}?page={%$val.post.page%}&pid={%$val.post.pid%}" class="url-wrap" dace-node="	tab1_bbsmessageAt">
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
                        </div>
                    {%/if%}
                {%/if%}
            {%/foreach%}
            {%if empty($result.hasNextPage)%}
                <div class="item-tip nomore" {%if $result.data|count == 0%}style="padding-bottom:80%;"{%/if%}>没有更多了</div>
            {%/if%}
        {%else%}
            <div class="no-result"><p>暂时还没有收到消息</p></div>
        {%/if%}
    </div>
</section>

<script type="text/template" id="J-tpl">
    <@ _.each(datas, function(item, index){ @>
        <@ if(item.data_type == 1){ @>
            <div class="item reply-mention">
                <div class="hd">
                    <span class="title">[新闻]&nbsp;<a href="<@=item.news.url@>" class="t-name" dace-node="tab1_newsurl"><@=item.news.title@></a>提到了你</span>
                    <span class="time"><@=item.format_time@></span>
                </div>
                <a href="<@=item.comment_url@>" class="url-wrap" dace-node="tab1_quotecomment">
                    <@ if(item.reply_is_hide == 1 || item.reply_is_delete == 1 || item.reply_audit_status == 1){ @>
                        <div class="other-reply hidden">
                            <@ if(item.reply_is_hide == 1){ @>
                                该评论被灭过多，已被折叠
                            <@ }else if(item.reply_is_delete == 1){ @>
                                该用户回复您的评论由于违规，已被删除
                            <@ }else if(item.reply_audit_status == 1){ @>
                                该评论可能违规，已被隐藏
                            <@ } @>
                        </div>
                    <@ }else{ @>
                        <div class="bd">
                            <div class="other-info">
                                <span class="other-head">
                                    <img src="<@=item.reply_header@>?t=2016<@=index@>">
                                    <span class="mask"></span>
                                </span>
                                <span class="other-name"><@=item.reply_user_name@></span>
                            </div>
                            <div class="reply">
                                <@ if(item.is_hide == 1 || item.is_delete == 1 || item.audit_status == 1){ @>
                                    <div class="my-reply hidden">
                                        <@ if(item.is_hide == 1){ @>
                                            该评论被灭过多，已被折叠
                                        <@ }else if(item.is_delete == 1){ @>
                                            该评论由于违规，已被删除
                                        <@ }else if(item.audit_status == 1){ @>
                                            该评论可能违规，已被隐藏
                                        <@ } @>
                                    </div>
                                <@ }else{ @>
                                    <div class="my-reply">
                                        <div class="my-name"><@=item.user_name@></div>
                                        <div class="content"><@=_.unescape(item.content)@></div>
                                    </div>
                                <@ } @>
                                <div class="other-reply"><@=_.unescape(item.reply_content)@></div>
                            </div>
                        </div>
                    <@ } @>
                </a>
            </div>
        <@ }else if(item.data_type == 2){ @>
            <@ if(item.pid == "0"){ @>
                <a href="kanqiu://bbs/topic/<@=item.cid@>" class="item post-mention" dace-node="tab1_postlink">
                    <span class="title">[帖子]&nbsp;<span class="t-name"><@=item.title@></span>主帖提到了你</span>
                    <span class="time"><@=item.format_time@></span>
                </a>
            <@ }else if(item.pid != "0" && item.post.quote == "0"){ @>
                <div class="item comment-mention">
                    <div class="hd">
                        <span class="title">[帖子]&nbsp;<a href="kanqiu://bbs/topic/<@=item.cid@>" class="t-name" dace-node="tab1_postlink"><@=item.title@></a>提到了你</span>
                        <span class="time"><@=item.format_time@></span>
                    </div>
                    <a href="kanqiu://bbs/topic/<@=item.cid@>?page=<@=item.post.page@>&pid=<@=item.post.pid@>" class="url-wrap" dace-node="	tab1_bbsmessageAt">
                        <@ if(item.post.is_hide == 1 || item.post.is_delete == 1 || item.post.audit_status == 1){ @>
                            <div class="other-reply hidden">
                                <@ if(item.post.is_hide == 1){ @>
                                    该回帖被灭过多，已被折叠
                                <@ }else if(item.post.is_delete == 1){ @>
                                    该回帖由于违规，已被删除
                                <@ }else if(item.post.audit_status == 1){ @>
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
                </div>
            <@ }else{ @>
                <div class="item reply-mention">
                    <div class="hd">
                        <span class="title">[帖子]&nbsp;<a href="kanqiu://bbs/topic/<@=item.cid@>" class="t-name" dace-node="tab1_postlink"><@=item.title@></a>提到了你</span>
                        <span class="time"><@=item.format_time@></span>
                    </div>
                    <a href="kanqiu://bbs/topic/<@=item.cid@>?page=<@=item.post.page@>&pid=<@=item.post.pid@>" class="url-wrap" dace-node="	tab1_bbsmessageAt">
                        <@ if(item.post.is_hide == 1 || item.post.is_delete == 1 || item.post.audit_status == 1){ @>
                            <div class="other-reply hidden">
                                <@ if(item.post.is_hide == 1){ @>
                                    该回帖被灭过多，已被折叠
                                <@ }else if(item.post.is_delete == 1){ @>
                                    该回帖由于违规，已被删除
                                <@ }else if(item.post.audit_status == 1){ @>
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
                                    <@ if(item.post.quote_is_hide == 1 || item.post.quote_is_delete == 1 || item.post.quote_audit_statu == 1){ @>
                                    <div class="my-reply hidden">
                                        <@ if(item.post.quote_quote_is_hide == 1){ @>
                                            该回帖被灭过多，已被折叠
                                        <@ }else if(item.post.quote_is_delete == 1){ @>
                                            该回帖由于违规，已被删除
                                        <@ }else if(item.post.quote_audit_statu == 1){ @>
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
                                            <div class="content"><@=_.unescape(item.post.quote_content)@></div>
                                        </div>
                                    <@ } @>
                                    <div class="other-reply"><@=_.unescape(item.post.content)@></div>
                                </div>
                            </div>
                        <@ } @>
                    </a>
                </div>
            <@ } @>
        <@ } @>
    <@ }); @>
</script>
{%/block%}
