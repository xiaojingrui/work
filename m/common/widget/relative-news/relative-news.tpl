{%if !empty($data)%}
<div class="hot-news-list news-list m-card-split-line" dace-node="{%$dace%}" {%if !empty($sectionExposure)%}section-exposure="{%$sectionExposure%}"{%/if%}>
    <div class="title"><h2>热门新闻</h2></div>
    <ul>
        {%$isTieba = isset($smarty.get.m_from) && $smarty.get.m_from == "tieba"%}
        {%foreach from=$data item=val name=key%}
            <li>
                <a href="{%$val.url%}{%if $isTieba%}{%$from|escape:none%}{%/if%}{%if !empty($urlfrom)%}{%if $isTieba%}&{%else%}?{%/if%}dace_from={%$urlfrom%}{%/if%}" class="news-link">
                    <div class="news-wrap">
                        {%if !empty($val.img)%}
                            <div class="img-wrap" style="background-image:url({%$val.img%})"></div>
                        {%/if%}
                        <div class="news-txt">
                            <h3>{%$val.title%}</h3>
                            <div class="news-status-bar">
                                <div class="news-info">
                                    <span class="news-source">{%$val.media%}</span>
                                    <span class="news-time">{%$val.date%}</span>
                                </div>
                                {%if !(isset($smarty.get.m_from) && $smarty.get.m_from == "tieba") && !empty($val.reply_count)%}
                                    <div class="news-view">
                                    <i class="icon-comment"></i><span>{%$val.reply_count%}</span>
                                    </div>
                                {%/if%}
                            </div>

                        </div>
                    </div>
                </a>
            </li>
        {%/foreach%}
    </ul>
</div>
{%/if%}
