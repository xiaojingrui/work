{%extends file="common/page/layout.tpl"%}

{%block name="title"%}
    {%if $result.puid == $result.author_puid%}我的{%/if%}论坛回帖
{%/block%}

{%block name="head_static"%}
    <script type="text/javascript" src="//w1.hoopchina.com.cn/hybrid/common/hpbridge_v1.0.1.js"></script>
    <script type="text/javascript">
        window.GM = {
            "page": 2,
            "client": "{%$client%}" || "x",
            "projectId":"{%$projectId%}"||"null",
            "version":"{%$version%}"||"7.0.6.0",
            "night":!!parseInt("{%$night%}", 10),
            "nopic":!!parseInt("{%$nopic%}", 10),
            "puid":parseInt("{%$result.author_puid%}", 10),
            "nextPage": "{%$result.nextPage%}" || 0
        };
    </script>
    {%require name="common:static/js/underscore/underscore.js"%}
    {%require name="common:static/js/zepto/zepto.js"%}
    {%require name="user:static/myReply/myReply.scss"%}
    {%require name="common:static/js/fastclick/fastclick.js"%}
    {%require name="user:static/myReply/myReply.js"%}

{%/block%}

{%block name="content"%}

{%if empty($result.list) && $result.all_count == 0%}
    <div class="reply-empty">
        {%if $result.puid == $result.author_puid%}
            你
        {%elseif $result.puid == 0%}
            TA
        {%else%}
            TA
        {%/if%}还没有发表过回帖哦
    </div>
{%else%}
<section class="my-reply-wrap">
    <ul class="reply-inner" id="J_content">
        {%foreach from=$result.list item=val name=key%}
            <li class="reply-list" data-jump="kanqiu://bbs/topic/{%$val.tid%}?page={%$val.post.page%}&pid={%$val.post.pid%}">
                <div class="reply-info">
                    <div class="reply-time">{%$val.post.time%}</div>
                    <div class="reply-lights">
                        亮了({%$val.post.light_count%})
                    </div>
                </div>
                <div class="reply-content">
                    {%if !empty($val.post.quote) && is_array($val.post.quote)&& count($val.post.quote) > 0 %}
                        <div class="reply-quote-content J_contentParent">
                            {%if $val.post.quote_deleted%}
                                <div class="reply-quote-delete">
                                    {%$val.post.quote[0].content|escape:none%}
                                </div>
                            {%else%}
                                <div class="reply-quote-hd">
                                    {%$val.post.quote[0].header[0]|escape:none%}
                                </div>
                                {%if !empty($val.post.quote[0].togglecontent)%}
                                    <div class="short-quote-content J_shortContent">
                                        {%$val.post.quote[0].togglecontent|escape:none%}
                                    </div>
                                    <div class="reply-quote-bd J_allContent">
                                        {%$val.post.quote[0].content|escape:none%}
                                    </div>
                                    <div class="button-open-inner">
                                        <a href="javascript:" class="button-open J_buttonOpenAll" title="展开">显示全部 <s class="arrow"></s></a>
                                    </div>
                                {%else%}
                                    <div class="short-quote-content">
                                        {%$val.post.quote[0].content|escape:none%}
                                    </div>
                                {%/if%}
                            {%/if%}
                        </div>
                    {%/if%}
                    <div class="current-content J_contentParent J_currentContent">
                        <span class="short-content">
                            {%$val.post.content|escape:none%}
                        </span>
                    </div>
                </div>
                <h3>来自：<a href="kanqiu://bbs/topic/{%$val.tid%}">{%$val.title%}</a></h3>
            </li>
        {%/foreach%}
    </ul>

    {%if $result.nextPage != 'true'%}
        <div class="has-more-reply"><p>由于权限限制，部分回帖可能被隐藏</p></div>
    {%/if%}

    <script type="text/template" id="J-reply-tpl">
        <@ _.each(datas, function(item,index) { @>
        <li class="reply-list" data-jump="kanqiu://bbs/topic/<@=item.tid@>?page=<@=item.post.page@>&pid=<@=item.post.pid@>">

            <div class="reply-info">
                <div class="reply-time"><@=item.post.time@></div>
                <div class="reply-lights">
                    亮了(<@=item.post.light_count@>)
                </div>
            </div>
            <@ if( !_.isEmpty(item.post.quote) && _.isArray(item.post.quote) && item.post.quote.length > 0 ) { @>
                <div class="reply-quote-content J_contentParent">
                    <@if(item.post.quote_deleted){@>
                        <div class="reply-quote-delete">
                            <@=item.post.quote[0].content@>
                        </div>
                    <@}else{@>
                        <div class="reply-quote-hd">
                            <@=item.post.quote[0].header[0]@>
                        </div>
                        <@ if( !_.isEmpty( item.post.quote[0].togglecontent ) ) { @>
                            <div class="short-quote-content J_shortContent">
                                <@=item.post.quote[0].togglecontent@>
                            </div>
                            <div class="reply-quote-bd J_allContent">
                                <@=item.post.quote[0].content@>
                            </div>
                            <div class="button-open-inner">
                                <a href="javascript:" class="button-open J_buttonOpenAll" title="展开">显示全部 <s class="arrow"></s></a>
                            </div>
                        <@ }else{ @>
                            <div class="short-quote-content">
                                <@=item.post.quote[0].content@>
                            </div>
                        <@ } @>
                    <@}@>
                </div>
            <@ } @>
            <div class="current-content J_contentParent J_currentContent">
                <span class="short-content">
                    <@=item.post.content@>
                </span>
            </div>
            <h3>来自：<a href="kanqiu://bbs/topic/<@=item.tid@>"><@=item.title@></a></h3>
        </li>
        <@ }); @>
    </script>


</section>
{%/if%}

{%/block%}
