{%extends file="common/page/layout.tpl"%}


{%block name="title"%}
    {%if $result.puid == $result.author_puid%}我的{%/if%}论坛发帖
{%/block%}


{%block name="head_static"%}
    <script type="text/javascript" src="//w1.hoopchina.com.cn/hybrid/common/hpbridge_v1.0.1.js"></script>
    <script type="text/javascript">
        window.GM = {
            "page": 2,
            "client": "{%$client%}" || "x",
            "projectId":"{%$projectId%}"||"null",
            "version":"{%$version%}"||"7.0.5.0",
            "night":!!parseInt("{%$night%}", 10),
            "nopic":!!parseInt("{%$nopic%}", 10),
            "puid":parseInt("{%$result.author_puid%}", 10),
            "nextPage": "{%$result.nextPage%}" || 0
        };
    </script>
    {%require name="common:static/js/underscore/underscore.js"%}
    {%require name="common:static/js/zepto/zepto.js"%}
    {%require name="user:static/myPost/myPost.scss"%}
    {%require name="common:static/js/fastclick/fastclick.js"%}
    {%require name="user:static/myPost/myPost.js"%}

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
        {%/if%}
        还没有发表过帖子哦
    </div>
{%else%}

    <section class="my-post-wrap">
        <ul class="post-inner" id="J_content">

            {%foreach from=$result.list item=val name=key%}
                <li class="post-list" data-jump="kanqiu://bbs/topic/{%$val.tid%}">
                    <h3>{%$val.title%}</h3>
                    <div class="post-info">
                        <div class="left-info">
                            <div class="post-time">{%$val.time%}</div>
                            <div class="thread-board">
                               <a href="kanqiu://bbs/board/{%$val.forum.fid%}">{%$val.forum.name%}</a>
                            </div>
                        </div>
                        <div class="right-info">
                            {%if $val.nps >= 5%}
                            <div class="thread-recommend">
                                <i class="icon-recommend"></i>
                                {%$val.nps%}
                            </div>
                            {%/if%}
                            {%if $val.lights !== 0%}
                            <div class="thread-lights">
                                <i class="icon-light"></i>
                                {%$val.lights%}
                            </div>
                            {%/if%}
                            <div class="thread-comment">
                                <i class="icon-comment"></i>
                                {%$val.replies%}
                            </div>
                        </div>
                    </div>
                </li>
            {%/foreach%}
        </ul>
        {%if $result.nextPage != 'true'%}
            <div class="has-more-reply"><p>由于权限限制，部分帖子可能被隐藏</p></div>
        {%/if%}
        <script type="text/template" id="J-post-tpl">
            <@ _.each(datas, function(item,index) { @>
            <li class="post-list" data-jump="kanqiu://bbs/topic/<@=item.tid@>">
                <h3><@=item.title@></h3>
                <div class="post-info">
                    <div class="left-info">
                        <div class="post-time"><@=item.time@></div>
                        <div class="thread-board">
                            <a href="kanqiu://bbs/board/{%$val.forum.fid%}"><@=item.forum.name@></a>
                        </div>
                    </div>
                    <div class="right-info">
                        <@ if (item.nps >= 5) { @>
                            <div class="thread-recommend">
                                <i class="icon-recommend"></i>
                                <@=item.nps@>
                            </div>
                        <@ } @>
                        <@ if (item.lights != 0) { @>
                            <div class="thread-lights">
                                <i class="icon-light"></i>
                                <@=item.lights@>
                            </div>
                        <@ } @>
                        <div class="thread-comment">
                            <i class="icon-comment"></i>
                            <@=item.replies@>
                        </div>
                    </div>
                </div>
            </li>
            <@ }); @>
        </script>
    </section>
{%/if%}

{%/block%}
