<@if($val.display_type == 1){@>
<li class="reply-list" data-jump="<@=$val.comment_url@>" dace-node="quoteCommentClick">
    <div class="reply-info">
        <div class="reply-time">
            <i></i>
            您的评论被其他JR回复了
        </div>
    </div>
<!--    <@if(!$val.is_delete){@> -->
    <div class="operations-user">
        <a href="kanqiu://people/<@=$val.reply_puid@>" class="user-avatar" dace-node="postuser">
            <img src="<@=$val.reply_header||'//w10.hoopchina.com.cn/hybrid/resource/avatar/man.png'@>?<@=index@>" class="J-user-avatar-img" alt="<@=$val.reply_user_name@>" >
            <span class="mod-mask mask"></span>
        </a>
        <div class="user-info">
            <div class="user-name clearfix">
                <span class="fl"><a dace-node="post_user" href="kanqiu://people/<@=$val.reply_puid@>"><@=$val.reply_user_name@></a></span>
            </div>
            <div class="source-left">
                <@if ($val.format_time){@>
                    <span class="postdate"><@=$val.format_time@></span>
                <@}@>
            </div>
        </div>
    </div>
    <!--
    <@}else{@>
    <div class="operations-user">
        <div class="source-left">
            <@if($val.format_time){@>
                <span class="postdate"><@=$val.format_time@></span>
            <@}@>
        </div>
    </div>
    <@}@> 
    -->
    <div class="reply-content">
        <@if($val.content){@>
            <@if(!$val.reply_is_delete && !$val.reply_is_hide){@>
                <div class="reply-quote-content J_contentParent">
                    <@if($val.is_delete){@>
                        <div class="reply-quote-delete">
                            **该评论涉及违规，已被删除**
                        </div>
                    <@}else if($val.is_hide){@>
                        <div class="reply-quote-delete">
                              **该评论被灭过多，已被折叠**
                        </div>
                    <@}else{@>
                        <div class="reply-quote-hd">
                            <@=$val.user_name@>
                        </div>
                        <@if($val.short_content){@>
                            <div class="short-quote-content J_shortContent">
                                <@=$val.short_content@>
                            </div>
                            <div class="reply-quote-bd J_allContent">
                                <@=$val.content@>
                            </div>
                            <div class="button-open-inner">
                                <a href="javascript:" class="button-open J_buttonOpenAll" title="展开">显示全部 <s class="arrow"></s></a>
                            </div>
                        <@}else{@>
                            <div class="short-quote-content">
                                <@=$val.content@>
                            </div>
                        <@}@>
                    <@}@>
                </div>
            <@}@>
        <@}@>
        <div class="current-content J_contentParent J_currentContent">
            <@if($val.reply_is_delete){@>
                <div class="reply-delete-content J-delete-content">
                    <span class="short-content">
                         **该用户回复您的评论涉及违规，已被删除，<br>很抱歉给您带来不便**
                    </span>
                </div>
            <@}else if($val.reply_is_hide){@>
                <div class="reply-delete-content">
                    <span class="short-content">
                          **该评论被灭过多，已被折叠** 
                    </span>
                </div>
            <@}else{@>
                <span class="short-content">
                    <@=$val.reply_content@>
                </span>
            <@}@>
        </div>
    </div>  
    <h3><span>来自：</span><a href="<@=$val.news.url@>" dace-node="newsUrlClick"><@=$val.news.title@></a></h3>
</li>

<@}else{@>
<li class="reply-list" data-jump="<@=$val.comment_url@>" dace-node="lightNumberClick">
    <div class="reply-info">
        <div class="reply-time">
            <b></b>
            <@=$val.light_content@>
        </div>
    </div>
    <div class="operations-user">
        <a href="kanqiu://people/<@=$val.puid@>" class="user-avatar" dace-node="postuser">
            <img src="<@=header||'//w10.hoopchina.com.cn/hybrid/resource/avatar/man.png'@><@=index@>" class="J-user-avatar-img" alt="<@=$val.user_name@>" >
            <span class="mod-mask mask"></span>
        </a>

        <div class="user-info">
            <div class="user-name clearfix">
                <span class="fl"><a dace-node="post_user" href="kanqiu://people/<@=$val.puid@>"><@=$val.user_name@></a></span>
            </div>
            <div class="source-left">
                <@if($val.format_time){@>
                    <span class="postdate"><@=$val.format_time@></span>
                <@}@>
            </div>
        </div>
    </div>
    <div class="reply-content">
        <@if($val.content){@>
            <@if(!$val.reply_is_delete && !$val.reply_is_hide){@>
                <div class="reply-quote-content J_contentParent day-night">
                    <@if($val.is_delete){@>
                        <div class="reply-quote-delete J-delete-content">
                            **该评论涉及违规，已被删除**
                        </div>
                    <@}else if($val.is_hide){@>
                        <div class="reply-quote-delete">
                              **该评论被灭过多，已被折叠**
                        </div>
                    <@}else{@>
                    <!--
                        <div class="reply-quote-hd">
                            <@=$val.user_name@>
                        </div>
                        -->
                        <@if($val.short_content){@>
                            <div class="short-quote-content J_shortContent">
                                <@=$val.short_content@>
                            </div>
                            <div class="reply-quote-bd J_allContent">
                                <@=$val.content@>
                            </div>
                            <div class="button-open-inner">
                                <a href="javascript:" class="button-open J_buttonOpenAll" title="展开">显示全部 <s class="arrow"></s></a>
                            </div>
                        <@}else{@>
                            <div class="short-quote-content">
                                <@=$val.content@>
                            </div>
                        <@}@>
                    <@}@>
                </div>
            <@}@>
        <@}@>
        <div class="current-content J_contentParent J_currentContent">
            <@if($val.reply_is_delete){@>
                <div class="reply-delete-content J-delete-content">
                    <span class="short-content">
                         *该评论涉及违规，已被删除**
                    </span>
                </div>
            <@}else if($val.reply_is_hide){@>
                <div class="reply-delete-content">
                    <span class="short-content">
                          **该评论被灭过多，已被折叠** 
                    </span>
                </div>
            <@}else{@>
                <span class="short-content">
                    <@=$val.reply_content@>
                </span>
            <@}@>
        </div>
    </div>  
    <h3><span>来自：</span><a href="<@=$val.news.url@>" dace-node="newsUrlClick"><@=$val.news.title@></a></h3>
</li>
<@}@>
