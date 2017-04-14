{%if !empty($pageCount) && $pageCount > 1%}

	{%if $page > 2%}
		{%$prev=$page - 1%}
	{%else%}
		{%$prev=1%}
	{%/if%}

	{%if $page < $pageCount%}
		{%$next=$page + 1%}
	{%else%}
		{%$next=$pageCount%}
	{%/if%}
	
	<div class="m-page" id="J_page">
		<a dace-node="{%$id4dace%}_homepage" class="{%if $page == 1%}disabled{%/if%}" href="{%$urlBase|urlformat:1%}">首页</a>
		<a dace-node="{%$id4dace%}_previouspage" class="{%if $page <  2%}disabled{%/if%}" href="{%$urlBase|urlformat:$prev%}">上页</a>
		<div class="pager_btn">
			<span class="page_num">{%$page%}/{%$pageCount%}</span>
			<select id="J_selectcontainer"></select>
		</div>
		<a dace-node="{%$id4dace%}_nextpage" class="{%if $page > $pageCount - 1%}disabled{%/if%}" href="{%$urlBase|urlformat:$next%}">下页</a>
		<a dace-node="{%$id4dace%}_lastpage" class="{%if $page == $pageCount%}disabled{%/if%}" href="{%$urlBase|urlformat:$pageCount%}">末页</a>
	</div>
	{%script%}
		var pager = require("common:widget/ui/page/page.js");
		pager({
			isAjax : false,
			currntPage : "{%$page%}",
			pageCount: "{%$pageCount%}",
			urlFormat: "{%$urlBase%}"
		});
	{%/script%}
{%/if%}