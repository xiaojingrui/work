<!-- title start -->
{%$isTieba = isset($smarty.get.m_from) && $smarty.get.m_from == "tieba"%}
<header class="artical-title">
    <h1 class="headline">{%$detail.title%}</h1>
    <div class="artical-info">
        <span class="author-name">
            <span class="media">{%$detail.media%}</span>
        </span>
        <span class="times">{%$detail.date%}</span>
        {%if !empty($commentsCount) && !$isTieba %}
            <span class="comment-number">
                <i class="icon-comment"></i>
                {%$commentsCount%}
            </span>
        {%/if%}
        {%if $isTieba%}
            <a href="http://mobile.hupu.com/download/games/?_r=tieba" dace-node="{%$id4dace%}_tiebadownload" class="down-app-spread">下载虎扑体育查看↓</a>
        {%/if%}
    </div>
</header>

<!-- title end -->
<!-- content start -->
<article class="article-content">
    <img src="{%$detail.img%}" data-src="{%$detail.img_url%}">
    {%$detail.content|escape:none%}
</article>
<!-- content end -->
