<!-- title start -->
<header class="m-row artical-title">
    <h1 class="headline">{%$thread.subject|escape:none%}</h1>
    <div class="artical-info">
        <span class="author-name">
            <a href="{%$thread.my%}">{%$thread.username%}</a>
        </span>
        <span class="times">{%$thread._postdate%}</span>

        <div class="show-comments">
            {%if empty($author)%}                
                <span class="comment-control">只看楼主</span>
            {%else%}
                <span class="comment-control all-commment">全部评论</span>
            {%/if%}
        </div>
            
            {%script%}
                var showComment = require("bbs:widget/detail-title/title.js");
                showComment.init();
            {%/script%}
        <!--
        {%if isset($focus_author)%}

            <div class="show-comments">
                {%if !$focus_author%}                
                    <span class="comment-control">只看楼主</span>
                {%else%}
                    <span class="comment-control all-commment">全部评论</span>
                {%/if%}
            </div>
            
            {%script%}
                var showComment = require("bbs:widget/detail-title/title.js");
                showComment.init();
            {%/script%}
        {%else%}
        <span class="topic-link">
            <a href="{%$thread.mobileeboardurl%}" dace-node="{%$id4dace%}_5050">{%$thread.boardname%}</a>
        </span>
        {%/if%}
        -->
    </div>
</header>
<!-- title end -->


