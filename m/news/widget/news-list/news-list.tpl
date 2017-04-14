{%$isTieba = isset($smarty.get.m_from) && $smarty.get.m_from == "tieba"%}
<li>
    <a href="{%$data.url%}{%if $isTieba%}{%$fromurl|escape:none%}{%/if%}" class="news-link" dace-node="{%$id4dace%}_readNews">
        <div class="news-wrap">
            {%if $data.img != ''%}
            <div class="img-wrap" style="background-image:url({%$data.img%});"></div>
            {%/if%}
            <div class="news-txt">
                <h3>{%$data.title%}</h3>
                <div class="news-status-bar">
                    <div class="news-info">
                        <span class="news-source">{%$data.media%}</span>
                        <span class="news-time">{%$data.date%}</span>
                    </div>
                    {%if !$isTieba && !empty($data.reply_count)%}
                        <div class="news-view">
                            <i class="icon-comment"></i><span>{%$data.reply_count%}</span>
                        </div>
                    {%/if%}
                </div>
            </div>
        </div>
    </a>
</li>
