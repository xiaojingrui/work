<div class="news-list">
    {%if !empty($data.data)%}
        <ul class="list">
            {%foreach from=$data.data item=val name=key%}
                <li>
                    <h4 class="sub-title">
                        {%$val.title|escape:none%}
                    </h4>
                    <div class="time">
                        {%$val.time%}
                    </div>
                </li>
            {%/foreach%}
        </ul>
    {%else%}
        <div class="not-tip">
            {%if empty($data.error)%}
                该用户很低调，最近未留下任何记录
            {%else%}
                {%$data.error%}
            {%/if%}
        </div>
    {%/if%}
</div>


{%script%}
    var dace = require("common:widget/ui/page-dace/page-dace.js");

    var pageId = __daceDataNameOfPage;
    $('.news-list a').on('click', function(){
        dace.send(pageId + "_5051");
    })
{%/script%}