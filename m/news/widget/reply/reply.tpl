{%if !empty($commentsCount) %}
    <div class="m-reply" id="J_replyContent">
        {%if !empty($lightComments) %}
            <div class="bright-reply">
                <div class="title">
                    <h2>这些评论亮了</h2>
                </div>
                <div class="reply-inner">
                    {%foreach from=$lightComments item=lComVal name=lComKey%}
                        {%widget
                            name="news:widget/reply/reply-list.tpl"
                            data=$lComVal
                        %}
                    {%/foreach%}
                </div>
            </div>
        {%/if%}

        {%if isset($adInfo.m_partner.m_news_detail_bright_reply_downside.adcode)%}
        <section class="m-card-split-line" id="u2740418">
            {%$adInfo.m_partner.m_news_detail_bright_reply_downside.adcode|escape:none%}
        </section>
        {%/if%}

        {%if !empty($commentsInfo)%}
            <div class="newest-reply" data-pagecount="{%$pageCount%}">
                <div class="title">
                    <h2>最新评论</h2>
                </div>
                <div class="reply-inner">
                    {%foreach from=$commentsInfo item=itemVal name=itemVal%}
                        {%widget
                            name="news:widget/reply/reply-list.tpl"
                            data=$itemVal
                        %}
                    {%/foreach%}
                </div>
                <div class="button-inner">
                    {%if $commentsCount > 5%}
                        <a href="javascript:" dace-node="{%$id4dace%}_readMoreComment" class="button-viewMore" id="J_buttonViewMore" data-page="{%$page%}">查看全部评论</a>
                    {%else%}
                        <span class="finish-loading">暂无更多评论</span>
                    {%/if%}
                </div>
            </div>
        {%/if%}
    </div>
{%/if%}


{%widget
    name="news:widget/reply/popup-reply.tpl"
%}

{%script%}
    var reply = require("news:widget/reply/reply.js");
    reply.init();
{%/script%}
