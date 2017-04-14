<div class="board_wrap">	
		<div class="board">
			{%if !empty($collected) && $_islogin%}
				<h4>我的版块</h4>
				<div class="content">
					<ul class="clearfix">
						{%foreach from=$collected item=val%}
							<li><a href="{%$val.forumindex%}">{%$val.name%}</a></br><span>{%if $val.todayAddNum != 0%} {%$val.todayAddNum%}帖 {%/if%}</span></li>
						{%/foreach%}
					</ul>
				</div>
			{%else%}
				<h4>热门版块</h4>
				<div class="content">
					<ul class="clearfix">
						{%foreach from=$hotNav item=val%}
							<li>
								<a href="{%$val.forumindex%}">{%$val.name%}</a></br>
								
									<span>{%if $val.todayAddNum != 0%}{%$val.todayAddNum%}帖{%/if%}</span>
								
							</li>
						{%/foreach%}
					</ul>
				</div>
			{%/if%}
		</div>
	
	{%foreach from=$forums item=val%}
		<div class="board arrow_board">
			<h4 {%if $open_up != $val.name && $open_up != "all"%} class="arrowH4" {%/if%}>{%$val.name%}</h4>
			<div class="content" {%if $open_up == $val.name || $open_up == "all"%} style="display:block" {%/if%}>
				{%foreach from=$val.sub item=item%}
					<h5>{%$item.name%}</h5>
					<ul class="clearfix">
						{%foreach from=$item.data item=sub%}
							<li>
								<a href="{%$sub.forumindex%}">{%$sub.name%}</a></br>
								
									<span>{%if $sub.count != 0%} {%$sub.count%}帖{%/if%}</span>
								
							</li>
						{%/foreach%}
					</ul>
				{%/foreach%}
			</div>
		</div>
	{%/foreach%}
{%script%}
    var boardList = require("./board-list.js");
    boardList.init();
{%/script%}