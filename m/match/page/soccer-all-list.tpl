{%extends file="common/page/layout.tpl"%}

{%block name="block_head_static"%}
    {%require name="match:static/soccer-list/soccer-list.scss"%}

{%/block%}

{%block name="content"%}
    {%widget
        name="common:widget/new-top-nav/new-top-nav.tpl"
        hasMidNav=true
        hasBreadNav=true
    %}

    {%widget
        name="common:widget/ui/soccer-match-list/match-list.tpl"
        data=$match_list
        matchAll="match_all"
    %}
{%/block%}
