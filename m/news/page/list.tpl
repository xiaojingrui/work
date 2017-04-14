{%extends file="common/page/layout.tpl"%}
{%block name="block_head_static"%}
    {%require name="news:static/list/list.scss"%}
{%/block%}

{%block name="content"%}
    {%widget
        name="common:widget/new-top-nav/new-top-nav.tpl"
        hasBreadNav=true
    %}

    {%if !empty($tagName)%}
    <p class="tag-title">以下是关于“<strong>{%$tagName%}</strong>”的新闻</p>
    {%/if%}
    {%if empty($newsList)%}
    <p class="tag-title tag-title2" id="J_newstitle">暂时没有相关新闻</p>
    {%/if%}
    <div class="common-list news-list" id="J_content" data-url="{%$newspageurl%}" data-pageCount="{%$pageCount%}">
        <ul>
            {%foreach from=$newsList item=newsItem name=newsItem%}
            {%assign var=floor value=$smarty.foreach.newsItem.index%}
            {%if $floor < 20%}
                {%if $floor === 10 && $project == "nba" && !empty($adInfo)%}
                    {%widget
                        name="common:widget/card-ad/card-ad.tpl"
                        data=$adInfo.m_adword.nba_news_home
                        from="newsIndex"
                    %}
                {%/if%}

                {%if $floor === 3 && $tags%}
                    <li class="news-tags">
                        <div>
                            {%foreach from=$tags item=itemVal name=itemKey%}
                                <a href="{%$itemVal.listrouter%}" class="tag-item1">{%$itemVal.name%}</a>
                            {%/foreach%}
                        </div>
                        <span class="bottom-icon"></span>
                    </li>
                {%/if%}
                {%widget
                    name="news:widget/news-list/news-list.tpl"
                    data=$newsItem
                    from="newsIndex"
                %}
            {%/if%}
            {%/foreach%}
        </ul>
    </div>

    {%widget name="common:widget/ui/page/page.tpl" pageCount=$pageCount page=$page urlBase="{%$newspageurl%}#{page}"%}

{%/block%}
{%block name="footer"%}
    {%widget name="common:widget/footer/footer.tpl" footerType="index"%}
{%/block%}
