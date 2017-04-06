{%if !empty($tplType) && $tplType == "php"%}
    {%foreach from=$data item=val name=key%}
        <dl class="reply-list">
            <dd class="operations-user">
                <div class="user-avatar">
                    <img src="{%$val.header%}" alt="">
                    <span class="mod-mask mask"></span>
                </div>
                <div class="user-info">
                    <div class="user-name">{%$val.user_name%}</div>
                    <div class="user-other">
                        <span class="times">
                            {%if !empty($val.format_time)%}{%$val.format_time%}{%else%}{%$val.create_time%}{%/if%}
                        </span>
                    </div>
                </div>
                <div class="operations">
                    <a href="javascript:" class="button-light">
                        亮了({%$val.light_count - $val.unlight_count%})
                    </a>
                </div>
            </dd>
            <dt class="reply-content" style="font-size:{%if intval($ft) < 12%}16{%else%}{%$ft-2%}{%/if%}px;">
                {%if !empty($val.quote_data)%}
                    {%if !empty($val.quote_data.is_delete)%}
                        <div class="reply-quote-delete">
                            该评论由于违规，已被删除
                        </div>
                    {%elseif !empty($val.quote_data.audit_status)%}
                        <div class="reply-quote-fold" data-type="replyQuotefold">
                            该评论可能违规，已被隐藏
                        </div>
                    {%else%}
                        {%if !empty($val.quote_data.is_hide)%}
                            <div class="reply-quote-hide" data-type="replyQuoteHide">
                                该评论被灭过多，已被折叠
                            </div>
                            <div class="reply-quote-content J_contentParent" style="display:none;">
                        {%else%}
                            <div class="reply-quote-content J_contentParent">
                        {%/if%}
                                <div class="reply-quote-hd" style="color:#434141">
                                    {%$val.quote_data.user_name%}
                                </div>
                                <div class="short-quote-content">
                                    {%$val.quote_data.content|escape:none%}
                                </div>
                            </div>
                    {%/if%}
                {%/if%}
                <div class="current-content J_contentParent J_currentContent">
                    <span class="short-content">
                        {%$val.content|escape:none%}
                    </span>
                </div>
            </dt>

        </dl>
    {%/foreach%}
{%else%}
    <script type="text/template" id="J_replyListTpl">
        <@if(typeof title !== "undefined"){@>
            <div class="title">
                <h2><@=title@></h2>
            </div>
            <div class="reply-inner">
        <@}@>
            <@if(typeof list !== "undefined"){@>
                <@_.each(list, function(item){@>
                    <@if( (typeof item.is_delete === "undefined" && item.audit_status != "1") || (item.audit_status === "1" && (GM.cid == item.cid || GM.uid == item.uid) ) ){@>
                        <dl class="reply-list <@if(typeof item.is_hide !== "undefined"){@>reply-list-hide<@}@>" <@if(typeof item.is_hide !== "undefined"){@>data-hide="1"<@}@> data-ncid="<@=item.ncid@>" data-uid="<@=item.uid@>" data-username="<@=item.user_name@>" data-lighted="<@=item.lighted@>">
                            <@if(typeof item.is_hide !== "undefined"){@>
                                <dd class="reply-hide" data-type="replyHide">
                                    该评论被灭过多，已被折叠
                                </dd>
                            <@}@>
                            <dd class="operations-user">
                                <div class="user-avatar">
                                    <@if(parseInt(item.puid, 10) > 0){@>
                                        <a href="kanqiu://people/<@=item.puid@>" class="J_preventName">
                                    <@}else{@>
                                        <a href="javascript:" class="J_buttonVisitor">
                                    <@}@>
                                            <img src="<@=item.header@>" class="J-user-avatar-img" alt="" >
                                            <span class="mod-mask mask"></span>
                                        </a>
                                </div>
                                <div class="user-info">
                                    <div class="user-name">
                                        <@if(parseInt(item.puid, 10) > 0){@>
                                            <a href="kanqiu://people/<@=item.puid@>" class="J_preventName">
                                        <@}else{@>
                                            <a href="javascript:" class="J_buttonVisitor">
                                        <@}@>
                                                <@=item.user_name@>
                                            </a>
                                    </div>
                                    <div class="user-other">
                                        <span class="times">
                                            <@=item.format_time@>
                                        </span>
                                    </div>
                                </div>
                                <div class="operations">
                                    <a href="javascript:" class="button-light">
                                        亮了(<span class="J_ligthCount"><@=item.light_count - item.unlight_count@></span>)
                                    </a>
                                </div>
                            </dd>
                            <dt class="reply-content" style="font-size:<@=GM.ft-2@>px;">
                                <@if(typeof item.quote_data !== "undefined"){@>
                                    <@if(typeof item.quote_data.is_delete !== "undefined"){@>
                                        <div class="reply-quote-delete">
                                            该评论由于违规，已被删除
                                        </div>
                                    <@} else if(typeof item.quote_data.audit_status !== "undefined"){@>
                                        <div class="reply-quote-fold" data-type="replyQuotefold">
                                            该评论可能违规，已被隐藏
                                        </div>
                                    <@}else{@>
                                        <@if(typeof item.quote_data.is_hide !== "undefined"){@>
                                            <div class="reply-quote-hide" data-type="replyQuoteHide">
                                                该评论被灭过多，已被折叠
                                            </div>
                                            <div class="reply-quote-content J_contentParent" style="display:none;">
                                        <@}else{@>
                                            <div class="reply-quote-content J_contentParent">
                                        <@}@>
                                            <div class="reply-quote-hd" style="color:#434141">
                                                <@=item.quote_data.user_name@>
                                            </div>
                                            <@if(typeof item.quote_data.short_content !== "undefined"){@>
                                                <div class="short-quote-content J_quoteShortContent">
                                                    <@=item.quote_data.short_content@>
                                                </div>
                                                <div class="reply-quote-bd J_quoteAllContent">
                                                    <@=item.quote_data.content@>
                                                </div>
                                                <div class="button-open-inner">
                                                    <a href="javascript:" class="button-open J_buttonOpenAll" title="展开" data-type="replyQuoteButtonOpen" dace-node="comment_expand">显示全部 <s class="arrow"></s></a>
                                                </div>
                                            <@}else{@>
                                                <div class="short-quote-content">
                                                    <@=item.quote_data.content@>
                                                </div>
                                            <@}@>
                                        </div>
                                    <@}@>
                                <@}@>
                                <div class="current-content J_contentParent J_currentContent">
                                    <span class="short-content">
                                        <@=item.content@>
                                    </span>
                                </div>
                            </dt>
                        </dl>
                    <@}@>
                <@})@>
            <@}@>
        <@if(typeof title !== "undefined"){@>
            </div>
        <@}@>
    </script>
{%/if%}
