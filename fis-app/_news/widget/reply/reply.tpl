<div class="m-reply" id="J_mReply">
    {%if !empty($replyType) && $replyType == "detail"%}
        <div class="bright-reply" id="J_brightReply"></div>
        <div class="button-inner" id="J_replayButtonInner">
            <a href="kanqiu://news/comment/{%$news.nid%}?leaguesEn={%$leaguesEn%}" class="button-viewMore" dace-node="comment_more">查看更多评论({%$news.replies%})</a>
        </div>
    {%elseif !empty($replyType) && $replyType == "shareComment"%}
        {%if !empty($news.light_comments)%}
            <div class="bright-reply">
                <div class="title">
                    <h2>这些评论亮了</h2>
                </div>
                <div class="reply-inner">
                    {%widget
                        name="news:widget/reply-single/reply-single.tpl"
                        tplType="php"
                        data= $news.light_comments
                    %}
                </div>
            </div>
        {%/if%}
    {%else%}
        <div id="J_jumpReply"></div>
        <div class="bright-reply" id="J_brightReply"></div>
        <div class="general-reply" id="J_generalReply"></div>
    {%/if%}

    {%widget
        name="news:widget/reply-single/reply-single.tpl"
        tplType="js"
    %}
</div>
