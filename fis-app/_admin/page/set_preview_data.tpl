{%extends file="common/page/layout-admin.tpl"%}

{%block name="head_static"%}
	{%require name="admin:static/set_preview_data/set_preview_data.css"%}
	{%require name="admin:static/set_preview_data/liquidmetal.js"%}
	{%require name="admin:static/set_preview_data/jquery.flexselect.js"%}

	{%script%}
		$(function(){

			window.GM = {
				home_players: {%json_encode($home_players)%},
				away_players: {%json_encode($away_players)%}
			}

			//伤停名单添加 删除
			var spd = $("#J-spd");
			var addBtn = $("#J-add-btn");

			spd.find(".absence-radio").on("click", function(){
				addBtn.attr("data-type", $(this).data("type"));
			});

			addBtn.on("click", function(){
				var arr = [];
				if($(this).attr("data-type")==0){
	            	arr = GM.home_players;
	            }else if($(this).attr("data-type")==1){
	            	arr = GM.away_players;
	            }

				var html = [
	                "<dd>",
	                	"<table>",
	                		"<tr>",
	                			"<td>原因：</td>",
	                			"<td>",
					                "<select class='reason'>",
					                	"<option value='1'>黄牌停赛</option>",
					                	"<option value='2'>红牌停赛</option>",
					                	"<option value='3'>停赛</option>",
					                	"<option value='4'>伤病</option>",
					                	"<option value='5'>无</option>",
					                "</select>",
					            "</td>",
					            "<td rowspan='2' align='center'>",
					                "<a href='javascript:void(0);' class='btn btn-danger delete'>删除</a>",
					            "</td>",
					        "</tr>",
					        "<tr>",
					            "<td>球员：</td>",
					            "<td><select class='player-choose' data-playerid='-1'><option value='0'>请选择球员</option>"+optionsHtml(arr)+"</select></td>",
					        "</tr>",
					   	"</table>",
					"</dd>"
	            ].join("");

	            if($(this).attr("data-type")==0){
	            	spd.find(".home-list").append(html);
	            }else if($(this).attr("data-type")==1){
	            	spd.find(".guest-list").append(html);
	            }
			});

			spd.on("click", ".delete", function(){
				console.log(1)
				var r = confirm("你确定要删除吗？");
				if(r){
					$(this).parents("dd").remove();
				}else{
					return false;
				}
			});

			spd.on("change", ".player-choose", function(){
				$(this).attr("data-playerid", $(this).val());
				$(this).attr("data-playerid", $(this).val());
			});

			spd.find(".lottery").on("change input", function(){
				$(this).next().val($(this).val());
			});

			spd.on("click", ".save", function(){

				var list = [];
				var item = {};

				$(".absence-list dd").each(function(){

					if($(this).find(".player-choose").attr("data-playerid") == -1){
						alert("请选择球员！");
						return false;
					}

					item = {
						"type": whichType($(this)),
						"reason": $(this).find(".reason").val(),
						"tid": $(this).parent().attr("data-tid"),
						"player_id": $(this).find(".player-choose").attr("data-playerid"),
						"player_name": $(this).find(".player-choose option:selected").text(),
						"number": $(this).find(".player-choose option:selected").attr("data-number")
					}

					list.push(item);

				});

				var data = {
					"lid": $("#lid").val(),
					"gid": $("#gid").val(),
					"summary": $("#summary").val().replace(/\/n/g,"<br \/>"),
					"home": $("#home").val().replace(/\/n/g,"<br \/>"),
					"away": $("#away").val().replace(/\/n/g,"<br \/>"),
					"list": list,
					"fid": $(".lottery-id").val()
				}

				$.ajax({
					url: "/chuanshuo/saveSoccerPreview",
					type: "POST",
					dataType: 'json',
					data: data,
					success: function(res){
						if(res.status == 200){
							alert("你已经成功保存！");
                    		location.reload();
						}else{
							alert(res.msg);
						}
					}
				});
			});

			function optionsHtml (arr){
				var option = "";
				var options = "";

				for(var i=0; i<arr.length; i++){
					option = "<option value='"+arr[i].player_id+"' data-number='"+arr[i].number+"'>"+arr[i].player_name+"</option>";
					options += option;
				}

				return options;
			}

			function whichType (obj){
				if(obj.parent().hasClass("home-list")){
					return "1";
				}else{
					return "2";
				}
			}

		});

	{%/script%}
{%/block%}


{%block name="content"%}
<div class="set-preview-data mod-wrap spd" id="J-spd">
	<input type="hidden" id="lid" value="{%$lid%}">
	<input type="hidden" id="gid" value="{%$gid%}">

	<div class="mod-title"><i class="icon-th-large"></i> <strong>设置前瞻内容</strong></div>

	<div class="header">
		<code>{%$begin_time|date_format:'%Y-%m-%d %H:%M:%S'%}</code>
		<code class="team">{%$home_name%}</code>
		<code class="vs">{%$home_score%}-{%$away_score%}</code>
		<code class="team">{%$away_name%}</code>
		<code>{%$status.desc%}</code>
	</div>

	<div class="main clearfix">
		<div class="left mod-box fl">
			<dl>
				<dt><i class="icon-tags"></i> 前瞻文字</dt>
				<dd>
					<span>综述：</span>
					<textarea name="" id="summary" placeholder="请输入文字">{%$summary%}</textarea>
				</dd>
				<dd>
					<span>{%$home_name%}：</span>
					<textarea name="" id="home" placeholder="请输入文字">{%$home%}</textarea>
				</dd>
				<dd>
					<span>{%$away_name%}：</span>
					<textarea name="" id="away" placeholder="请输入文字">{%$away%}</textarea>
				</dd>
			</dl>
		</div>
		<div class="right mod-box fr">
			<dl>
				<dt><i class="icon-tags"></i> 彩票FID</dt>
				<dd>
					<select class="lottery">
						<option value="0" {%if !$fid%}selected="selected"{%/if%}>请选择</option>
						{%foreach $match_list as $val%}
							<option value="{%$val.fid%}" {%if $val.fid==$fid%}selected="selected"{%/if%}>{%$val.hname%} VS {%$val.aname%} {%$val.time%}</option>
						{%/foreach%}
					</select>
					<input type="hidden" class="lottery-id" value="{%$fid|default:0%}">
				</dd>
			</dl>
		</div>
	</div>

	<div class="absence mod-box">
		<strong><i class="icon-tags"></i> 伤停名单</strong>&nbsp;&nbsp;&nbsp;&nbsp;
		{%if $home_players || $away_players %}
		<label for="home"><input id="home" class="absence-radio" data-type="0" type="radio" name="team" checked="checked"> {%$home_name%}</label>&nbsp;&nbsp;&nbsp;&nbsp;
		<label for="guest"><input id="guest" class="absence-radio" data-type="1" type="radio" name="team"> {%$away_name%}</label>&nbsp;&nbsp;&nbsp;&nbsp;
		<a href="javascript:void(0);" class="btn btn-primary" data-type="0" id="J-add-btn">添加</a>
		{%else%}
		自定义比赛不支持伤停名单
		{%/if%}
	</div>

	<div class="absence-list clearfix">
		<div class="left mod-box fl">
			<dl class="home-list" data-tid="{%$home_players[0].tid%}">
				<dt><i class="icon-tags"></i> {%$home_name%}</dt>
				{%foreach $absence[$home_tid] as $val%}
				<dd>
					<table>
						<tr>
							<td>原因：</td>
							<td>
								<select class="reason">
									<option value="1" {%if $val.reason==1%}selected="selected"{%/if%}>黄牌停赛</option>
									<option value="2" {%if $val.reason==2%}selected="selected"{%/if%}>红牌停赛</option>
									<option value="3" {%if $val.reason==3%}selected="selected"{%/if%}>停赛</option>
									<option value="4" {%if $val.reason==4%}selected="selected"{%/if%}>伤病</option>
									<option value="5" {%if $val.reason==5%}selected="selected"{%/if%}>无</option>
								</select>
							</td>
							<td rowspan="2" align="center">
								<a href="javascript:void(0);" class="btn btn-danger delete">删除</a>
							</td>
						</tr>
						<tr>
							<td>球员：</td>
							<td>
								<select class="player-choose" data-playerid="{%$val.player_id%}">
								{%foreach $home_players as $subVal%}
									<option value="{%$subVal.player_id%}" data-number="{%$subVal.number%}" {%if $subVal.player_id==$val.player_id%}selected="selected"{%/if%}>{%$subVal.player_name%}</option>
								{%/foreach%}
								</select>
							</td>
						</tr>
					</table>
				</dd>
				{%/foreach%}
			</dl>
		</div>
		<div class="right mod-box fr">
			<dl class="guest-list" data-tid="{%$away_players[0].tid%}">
				<dt><i class="icon-tags"></i> {%$away_name%}</dt>
				{%foreach $absence[$away_tid] as $val%}
				<dd>
					<table>
						<tr>
							<td>原因：</td>
							<td>
								<select class="reason">
									<option value="1" {%if $val.reason==1%}selected="selected"{%/if%}>黄牌停赛</option>
									<option value="2" {%if $val.reason==2%}selected="selected"{%/if%}>红牌停赛</option>
									<option value="3" {%if $val.reason==3%}selected="selected"{%/if%}>停赛</option>
									<option value="4" {%if $val.reason==4%}selected="selected"{%/if%}>伤病</option>
									<option value="5" {%if $val.reason==5%}selected="selected"{%/if%}>无</option>
								</select>
							</td>
							<td rowspan="2" align="center">
								<a href="javascript:void(0);" class="btn btn-danger delete">删除</a>
							</td>
						</tr>
						<tr>
							<td>球员：</td>
							<td>
								<select class="player-choose" data-playerid="{%$val.player_id%}">
								{%foreach $away_players as $subVal%}
									<option value="{%$subVal.player_id%}" data-number="{%$subVal.number%}" {%if $subVal.player_id==$val.player_id%}selected="selected"{%/if%}>{%$subVal.player_name%}</option>
								{%/foreach%}
								</select>
							</td>
						</tr>
					</table>
				</dd>
				{%/foreach%}
			</dl>
		</div>
	</div>

	<div class="bottom">
		<a href="javascript:void(0);" class="btn btn-primary save">保存</a>
	</div>

<div>
{%/block%}
