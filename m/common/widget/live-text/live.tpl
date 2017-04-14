{%if !empty($data)%}
    <div class="m-row live-text" id="J_live_container">
        <ul id="J_live_content">
            {%foreach $data as $item%}
                {%if !empty($item["title"]) %}
                    <li><a dace-node="{%$id4dace%}_scrollbar" href="{%$item["url"]%}">{%$item["title"]%}</a></li>
                {%/if%}
            {%/foreach%}
        </ul>
    </div>
{%/if%}