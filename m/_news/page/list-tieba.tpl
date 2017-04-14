{%extends file="common/page/layout.tpl"%}
{%block name="block_head_static"%}
    {%require name="news:static/list/list.scss"%}
    {%require name="news:static/list-tieba/list-tieba.scss"%}
    {%require name="news:static/list-tieba/list-tieba.js"%}
{%/block%}

{%block name="content"%}

    <div class="common-list news-list" id="J_content" data-url="{%$newspageurl%}" data-pageCount="{%$pageCount%}">
        <ul>
            {%**
                第一列插入一条广告
            **%}
            {%if !empty($adInfo.m_adapp.baidutieba.adurl)%}
                <li class="list-spread">
                    <a dace-node="{%$id4dace%}_tiebadownload" section-exposure="{%$id4dace%}_tiebashowapp" href="{%$adInfo.m_adapp.baidutieba.adurl%}">
                        <img src="{%$adInfo.m_adapp.baidutieba.pic%}" alt=""/>
                    </a>
                </li>
            {%/if%}

            {%foreach from=$newsList item=newsItem name=newsItem%}
            {%assign var=floor value=$smarty.foreach.newsItem.index%}
            {%if $floor < 20%}

                {%widget
                    name="news:widget/news-list/news-list.tpl"
                    data=$newsItem
                    fromurl=$from
                    from="newsIndex"
                %}

            {%/if%}
            {%/foreach%}
        </ul>

    </div>

    {%if $pageCount > 1%}
        <div class="more-button-inner">
            <div class="preloader-loading"><span class="loading-arrow"></span>正在加载中，请稍候</div>
            <a href="javascript:" class="button-load-more" id="J_buttonViewMore" data-page="1">加载更多新闻</a>
        </div>
    {%/if%}

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
                                <span class="news-time"><@=item.date@></span>
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
{%/block%}

{%block name="footer"%}

{%/block%}