{%extends file="common/page/layout-empty1.tpl"%}

{%block name="title"%}2016虎扑年会热线{%/block%}

{%block name="head_static"%}
    {%require name="common:static/js/zepto/zepto.js"%}
    {%require name="common:static/js/underscore/underscore.js"%}
    {%require name="events:static/annual2016/annual2016.scss"%}
	  {%script%}
		window.GM = {
        "roomid": "{%$smarty.get.rid%}"
		};
    {%/script%}
{%/block%}

{%block name="content"%}
    <div class="container">
    <h2 class="title">{%if !empty($smarty.get.title)%}{%$smarty.get.title%}{%else%}虎扑年会{%/if%}</h2>
    	{%widget
            name="events:widget/annual_hotline2015/annual_hotline2015.tpl"
        %}
    </div>
{%/block%}
