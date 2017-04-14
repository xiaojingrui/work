{%extends file="common/page/layout.tpl"%}
{%block name="block_head_static"%}
    {%require name="my:static/topic-post/topic-post.scss"%}
{%/block%}

{%block name="content"%}

{%widget
    name="common:widget/top-title/top-title.tpl"
    banner="{%if $isself %}我{%else%}{%$userinfos.username%}{%/if%}的主题帖"
%}

    <div class="topic-post-wrap">
        {%if $userThreads.data|@count > 0%}
            {%widget
                name = "common:widget/ui/bbs-list/bbs-list.tpl"
                data = $userThreads.data
            %}
        {%else%}
            <div class="not-message">
                暂无更多主题帖
            </div>
        {%/if%}
    </div>

    {%widget
        name="common:widget/ui/page/page.tpl"
        pageCount=$userThreads.pages
        page=$userThreads.page
        urlBase="/my/userThreads/?page=#{page}"
    %}
{%/block%}