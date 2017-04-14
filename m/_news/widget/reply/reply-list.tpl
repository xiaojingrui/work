<dl class="reply-list">
    <dd class="operations-user">
        <div class="wrap">
            <div class="user-name">
                {%if !(isset($smarty.get.m_from) && $smarty.get.m_from == "tieba") %}
                    <a dace-node="{%$id4dace%}_home" href="/my/{%$data.uid%}">
                        {%$data.user%}
                    </a>
                {%else%}
                    {%$data.user%}
                {%/if%}
            </div>
            <div class="time">
                {%$data.time%}
            </div>
        </div>

        {%** 合作tieba **%}
        {%if !(isset($smarty.get.m_from) && $smarty.get.m_from == "tieba") %}
            <div class="operations">
                <a href="javascript:" class="button-bright J_buttonBright" data-pid="{%$data.id%}" data-uid="{%$data.uid%}">
                        {%if !empty($data.light)%}
                        <span class="text">亮了</span><span class="bright-number-box">(<span class="J_brightNumber">{%$data.light%}</span>)</span>
                        {%else%}
                        <span class="text">亮了</span><span class="bright-number-box">(<span class="J_brightNumber">0</span>)</span>
                        {%/if%}
                    </a>
                <a href="javascript:" dace-node="{%$id4dace%}_quote" class="button-quote J_buttonQuote" data-pid="{%$data.id%}" data-floor="{%$data.floor%}">
                    <span class="qoute-smail-content">{%if !empty($data.smallcontent)%}{%$data.smallcontent|escape:none%}{%/if%}</span>
                    <span class="text">引用</span>
                </a>
            </div>
        {%/if%}
    </dd>
    <dt class="reply-content">
        {%if !empty($data.quote) && is_array($data.quote) && count($data.quote) > 0 %}
            <div class="reply-quote-content J_contentParent">
                <div class="reply-quote-hd">
                    {%$data.quote.header|escape:none%}
                    {%if $data.quote.togglecontent != ''%}
                    <a href="javascript:" class="button-open J_buttonOpenAll" title="展开"></a>
                    {%/if%}
                </div>
                {%if !empty($data.quote.togglecontent) && $data.quote.togglecontent != ''%}
                <div class="short-quote-content J_shortContent">
                    {%$data.quote.togglecontent|escape:none%}
                </div>
                <div class="reply-quote-bd J_allContent">
                    {%$data.quote.content|escape:none%}
                </div>
                {%else%}
                <div class="short-quote-content">
                    {%$data.quote.content|escape:none%}
                </div>
                {%/if%}
            </div>
        {%/if%}
        <div class="current-content J_contentParent">
            <span class="short-content">
                {%$data.content|escape:none%}
            </span>
        </div>
    </dt>
</dl>
