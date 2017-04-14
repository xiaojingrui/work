<div class="m-reply" id="J_replyContent">
    {%if !empty($lightReplies) %}
        <div class="bright-reply">
            <div class="title">
                <h2>这些回帖亮了</h2>
            </div>
            <div class="reply-inner">
                {%foreach from=$lightReplies item=val name=key%}
                    {%if $val.is_hide!=1%}
                        {%widget
                            name="bbs:widget/reply/reply-list.tpl"
                            data=$val
                        %}
                    {%/if%}
                {%/foreach%}
            </div>
        </div>
    {%/if%}

    {%if isset($adInfo.m_partner.m_thread_detail_bright_reply_downside.adcode) && $page == "1"%}
        <section class="m-card-split-line ad-hide" id="u2740419">
            {%$adInfo.m_partner.m_thread_detail_bright_reply_downside.adcode|escape:none%}
        </section>
    {%/if%}

    {%if !empty($replies)%}
        <div class="replay_all">
            <div class="title" id="title">
                <h2>全部回帖</h2>
            </div>
            {%widget
                name="bbs:widget/comments/comments.tpl"
                data=$replies
            %}
            <div id="J-page" class="m-page m-row"></div>
    {%else%}
        <div class="comment-not-tips m-card-split-line">暂无回复</div>
        {%widget
            name="bbs:widget/reply/popup-reply.tpl"
        %}
        {%require name="bbs:static/comments/comments.js"%}
    {%/if%}
        <!--
        <a href="/bbs/allreplies/{%$thread.tid%}-1.html#pn=1" class="button-viewMore" dace-node="{%$id4dace%}_readMoreComment">查看全部回帖({%$thread.replies%}) ></a>
        -->
    </div>
</div>

{%script%}
    //var reply = require("bbs:widget/reply/reply.js");
    //reply.init();   comments.js中有引入
{%/script%}
