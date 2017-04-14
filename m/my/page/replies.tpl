{%extends file="common/page/layout.tpl"%}
{%block name="block_head_static"%}
    {%require name="my:static/replies/replies.scss"%}
{%/block%}

{%block name="content"%}

{%widget
    name="common:widget/top-title/top-title.tpl"
    banner="{%if $isself %}我{%else%}{%$userinfos.username%}{%/if%}的回帖"
%}

    <div class="replies-wrap">
        {%if $userReplies.data|@count > 0%}
            {%foreach from=$userReplies.data item=val name=key%}
                <dl class="reply-list m-card-split-line">
                    <dt class="topic-title">
                        <a href="{%$val.url%}" dace-node="{%$id4dace%}_5051">{%$val.subject%}</a>
                    </dt>
                    <dd class="reply-content">
                        {%$val.content|escape:none%}
                    </dd>
                    <dd class="reply-bt">
                        <a href="{%$val.boardurl%}" class="tag" dace-node="{%$id4dace%}_5050">{%$val.boardname%}</a>
                        <span class="times">{%$val.time%}</span>
                    </dd>
                </dl>
            {%/foreach%}
        {%else%}
            <div class="not-message">
                暂无更多回帖
            </div>
        {%/if%}
    </div>

    {%widget
        name="common:widget/ui/page/page.tpl"
        pageCount=$userReplies.pages
        page=$userReplies.page
        urlBase="/my/userReplies/?page=#{page}"
    %}
{%/block%}