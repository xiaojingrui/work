<div class="m-row m-reply m-reply-all" id="J_replyContent">
    <div class="general-reply">
        <div class="reply-inner" id="J_reply_container">
            {%foreach from=$data item=val name=key%}
                {%if $val.is_hide!=1%}
                {%widget
                    name="bbs:widget/reply/reply-list.tpl"
                    data=$val
                %}
                {%/if%}
            {%/foreach%}
        </div>
    </div>
</div>

{%widget
    name="bbs:widget/reply/popup-reply.tpl"
%}
{%require name="bbs:static/comments/comments.js"%}