{%if isset($data) && !empty($data)%}
    <section class="card-col-4" dace-node="{%$dace%}">
        <div class="card-wrap">
            <article class="title">
                <h2>{%$banner%}</h2>
            </article>
            <article class="bd card-shihuo">
                {%foreach $data as $key => $val%}
                    {%if $val@index === 0%}
                        <div class="list pic-list">
                                <a href="{%$val.detail_url%}" class="small-pic" style="background-image: url({%$val.img_path%})"></a>
                                <div class="title">
                                    <a href="{%$val.detail_url%}">
                                    <h4>{%$val.title%}</h4>
                                    <span>{%$val.subtitle%}</span>
                                    </a>
                                </div>
                        </div>
                    {%else%}
                        <div class="list general-list">
                                <div class="news-text">
                                    <div class="name">
                                        <a href="{%$val.detail_url%}">{%$val.title%}</a>
                                    </div>
                                </div>
                        </div>
                    {%/if%}
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

