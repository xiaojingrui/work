{%extends file="common/page/layout.tpl"%}

{%block name="block_head_static"%}
    {%require name="teams:static/teams-news/list.scss"%}

    {%script%}
        var toShare = require("common:widget/ui/share/share.js");

        //全局分享事件, 每个页面单独注册.
        $(document).on("page:share", function(){
            toShare();
        });
    {%/script%}
{%/block%}
{%block name="content"%}
    {%widget
        name="common:widget/new-top-nav/new-top-nav.tpl"
        hasBreadNav=false
    %}
    
    {%widget
        name="common:widget/inner-top-nav/nav.tpl"
    %}
    <section class="m-wrap teams-data-wrap">
        <!-- 球队信息 -->
        {%widget
            name="teams:widget/team-header/header.tpl"
        %}

        {%widget
            name="common:widget/inner-tab/tab.tpl"
            tabClass="team"
            selected=1
        %}

        {%if empty($news)%}
        <p class="tag-title tag-title2" id="J_newstitle">暂时没有相关新闻</p>
        {%/if%}
        <div class="common-list news-list" id="J_content" data-url="{%$newspageurl%}" data-pageCount="{%$pageCount%}">
            <ul>
                {%foreach from=$news item=newsItem name=newsItem%}
                {%assign var=floor value=$smarty.foreach.newsItem.index%}
                {%if $floor < 20%}
                    {%if $floor === 10 && $project == "nba"%}
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
                        name="teams:widget/news-list/news-list.tpl"
                        data=$newsItem
                        from="newsIndex"
                    %}
                {%/if%}
                {%/foreach%}
            </ul>

        </div>

        {%widget name="common:widget/ui/page/page.tpl" pageCount=$pageCount page=$page urlBase="{%$newspageurl%}#{page}"%}

        <script id="t2" type="text/template">
            <@ _.each(datas, function(item,index) { @>
                <li>
                    <a href="<@=item.url@>" class="news-link">
                        <div class="news-wrap">
                            <@ if( item.imgurl !== '' ) { @>
                                <div class="img-wrap"  style="background-image:url(<@=item.img@>)">
                                </div>
                            <@ } @>
                            <div class="news-txt">
                                <h3><@=item.title@></h3>
                                <div class="news-status-bar">
                                    <div class="news-info">
                                        <span class="news-source"><@=item.media@></span>
                                        <span class="news-time"><@=item.form_time@></span>
                                    </div>
                                    <@ if( !!item.reply_count ) { @>
                                    <div class="news-view"><i class="icon-comment"></i><span><@=item.reply_count@></span></div>
                                    <@ } @>
                                </div>
                            </div>
                        </div>
                    </a>
                </li>
            <@ }); @>
        </script>
    </section>
{%/block%}
