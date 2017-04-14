{%extends file="common/page/layout.tpl"%}
{%block name="block_head_static"%}
    {%require name="my:static/personal-news/personal-news.scss"%}
{%/block%}

{%block name="content"%}

{%widget
    name="common:widget/top-title/top-title.tpl"
    banner="{%if $isself %}我{%else%}{%$userinfos.username%}{%/if%}最新动态"
%}

    <div class="personal-news-wrap">
        {%widget
            name = "my:widget/personal-news-list/list.tpl"
            data = $userdynamic
        %}
    </div>

    {%widget
        name="common:widget/ui/page/page.tpl"
        pageCount=$userdynamic.pages
        page=$userdynamic.page
            urlBase="/my/userdynamic?page=#{page}{%if isset($smarty.get.uid)%}&uid={%$smarty.get.uid%}{%/if%}"
    %}
{%/block%}