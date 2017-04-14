{%if !empty($data)%}
    <section class="card-col-4 {%if empty($banner)%}card-col-nobrfore{%/if%}" dace-node="{%$dace%}" {%if !empty($sectionExposure)%}section-exposure="{%$sectionExposure%}"{%/if%}>
        <div class="card-wrap">
        {%if !empty($banner)%}
        <article class="title">
            <h2>{%$banner%}</h2>
        </article>
        {%/if%}
        <article class="bd">
            {%$listClass=[]%}

            {%foreach from=$data item=val key=keys%}
                {%if isset($val["bigPic"])%}
                    {%$val["img"] = $val["bigPic"]%}
                {%/if%}

                {%* 有图 *%}
                {%if isset($val["img"])%}
                    {%* isBigShow 虎扑制造第一张图片是大图 *%}
                    {%if isset($isBigShow) && $keys == 0%}
                        {%$listClass="big-pic-list"%}
                    {%* 右侧小图 *%}
                    {%else%}
                        {%$listClass="smail-pic-list"%}
                    {%/if%}
                {%else%}
                    {%$listClass="general-list"%}
                {%/if%}

                <a href="{%$val["url"]%}{%if isset($smarty.get.m_from) && $smarty.get.m_from == "tieba"%}{%$from|escape:none%}{%/if%}" class="list {%$listClass%}">
                    {%if isset($isBigShow) && $keys == 0%}
                    {%else%}
                        {%if isset($val["img"])%}
                            <div class="small-pic" style="background-image: url({%$val["img"]%})"></div>
                        {%/if%}
                    {%/if%}
                    <div class="news-text">
                        <div class="name">
                            <span>{%$val["title"]%}</span>
                        </div>
                        {%if isset($isBigShow) && $keys == 0%}
                            <div class="big-pic">
                                <img src="{%$val["img"]%}" alt=""/>
                            </div>
                        {%/if%}
                        {%if !(isset($isBigShow) && $isBigShow) %}
                            <div class="other-info">
                                <div class="bt-lf">
                                    {%* showFrom来自隐藏 *%}
                                    {%if !empty($type) && $type == "soccer" && !empty($val["username"])%}
                                        {%$val["username"]%}
                                    {%else%}
                                        {%if !(isset($showFrom) && $showFrom) %}
                                            {%if $val["type"] == "bbs"%}
                                                {%$val["boardname"]%}
                                            {%else%}
                                                {%$val["media"]%}
                                            {%/if%}
                                        {%/if%}
                                    {%/if%}
                                </div>
                                {%if isset($val["replies"]) && $val["replies"] != "0"%}
                                    <span class="view-number">
                                        <i class="icon-comment"></i>
                                        {%$val["replies"]%}
                                    </span>
                                {%/if%}
                            </div>
                        {%/if%}
                    </div>
                </a>
            {%/foreach%}
        </article>
        {%if !empty($link)%}
        <article class="more-relative-info">
            <a href="{%$link%}">
                <span>进入{%$banner%}专区查看更多</span>
            </a>
        </article>
        {%/if%}
        </div>
    </section>
{%/if%}
