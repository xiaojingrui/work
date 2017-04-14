{%if {%$isOpen%} == 'on' && empty($smarty.cookies.matchtip) %}
<div class="top-tips" id="J_topTips">
    <p><a href="{%$url%}">{%$content%}</a></p>
    <span id="J_close"></span>
</div>
{%/if%}