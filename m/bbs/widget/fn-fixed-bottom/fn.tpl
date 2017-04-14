<div class="fn-fixed-bottom">
    {%if !empty($bottom)%}
        <a href="{%$thread.mobileurl%}" class="button-returnList" dace-node="{%$id4dace%}_5050_floatingbar">正文</a>
        {%else%}
        <a href="{%$thread.mobileeboardurl%}" class="button-returnList" dace-node="{%$id4dace%}_5050_floatingbar">专区</a>
    {%/if%}
    
    <a href="javascript:" class="button-reply" id="J_buttonReply" dace-node="{%$id4dace%}_reply">回复本帖</a>
    <ul class="fn-list-right">
        {%if $bottom != "commentsDetail"%}
        <li>
            {%$commentURL = "/bbs/allreplies/{%$thread.tid%}-1.html#pn=1"%}

            <a href="{%$commentURL%}" dace-node="{%$id4dace%}_readmorecomment">
                {%if !empty($thread.replies)%}
                    <span class="comment-number">
                        {%$thread.replies%}
                    </span>
                {%/if%}
                <i class="icon-comment"></i>
            </a>
        </li>
        {%/if%}
        <li id="J_top_star" data-uid="{%$uid%}" data-tid="{%$thread.tid%}" dace-node="{%$id4dace%}_fav">
            <i class="icon-collect"></i>
        </li>
        <li id="J_buttonShare" dace-node="{%$id4dace%}_share">
            <i class="icon-share"></i>
        </li>
    </ul>
</div>

{%script%}
    var FnFixedButton = require('bbs:widget/fn-fixed-bottom/fn.js');

    FnFixedButton.init();
{%/script%}