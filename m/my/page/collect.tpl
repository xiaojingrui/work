{%extends file="common/page/layout.tpl"%}
{%block name="block_head_static"%}
    {%require name="my:static/collect/collect.scss"%}
    {%require name="my:static/collect/collect.js"%}
    {%script%}
        HPM.uid = {%$uid%} || '';
    {%/script%}
{%/block%}

{%block name="content"%}

{%widget
    name="common:widget/top-title/top-title.tpl"
    banner="{%if $isself %}我{%else%}{%$userinfos.username%}{%/if%}的收藏"
    right="<a href=\"javascript:\" class=\"button-collect\" id=\"J_buttonCollect\" dace-node=\"{%$id4dace%}_edit\">编辑</a>"
%}

    <div class="collect-wrap" id="J_collectWrap">
        {%if $favorThreads.data|@count > 0%}
            {%widget
                name = "common:widget/ui/bbs-list/bbs-list.tpl"
                data = $favorThreads.data
                collect = true
            %}
        {%else%}
            <div class="not-message">
                暂无更多收藏
            </div>
        {%/if%}
    </div>

    {%widget
        name="common:widget/ui/page/page.tpl"
        pageCount=$favorThreads.pages
        page = $favorThreads.page
        urlBase="/my/usercollectedthreads?page=#{page}"
    %}

{%/block%}