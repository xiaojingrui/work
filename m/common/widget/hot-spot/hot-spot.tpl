{%if !empty($data)%}
<div class="hotspot-list m-card-split-line" dace-node="{%$dace%}" {%if !empty($sectionExposure)%}section-exposure="{%$sectionExposure%}"{%/if%}>
    <div class="title"><h2>推荐热点</h2></div>
    <ul>
        {%foreach from=$data item=val name=key%}
            <li><a href="{%$val.href%}">{%$val.title%}</a></li>
        {%/foreach%}
    </ul>
</div>
{%/if%}
