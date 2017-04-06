{%extends file="common/page/layout-admin.tpl"%}

{%block name="head_static"%}
	{%require name="admin:static/set_media_data/set_media_data.css"%}

	{%script%}
		$(function(){

			//伤停名单添加 删除
			var smd = $("#J-smd");
			var addBtn = $("#J-add-btn");

			smd.find(".media-radio").on("click", function(){
				addBtn.attr("data-type", $(this).data("type"));
			});

			addBtn.on("click", function(){
				var html = [
	                "<dd>",
	                	"<table>",
	                		"<tr>",
	                			"<td>直播源名称：</td>",
	                			"<td><input type='text' class='name' placeholder='请输入'></td>",
	                			"<td><a href='javascript:void(0);' class='btn btn-danger delete'>删除</a></td>",
					        "</tr>",
					        "<tr>",
					            "<td>视频地址：</td>",
					            "<td><input type='text' class='url' placeholder='URL'></td>",
					            "<td><input type='checkbox' class='pay' data-type='0'> 付费</td>",
					        "</tr>",
					   	"</table>",
					"</dd>"];

				if($(this).attr("data-type")==2){
					html.splice(10,1);
				}

				html = html.join("");

	            if($(this).attr("data-type")==0){
	            	smd.find(".tv-list").append(html);
	            }else if($(this).attr("data-type")==1){
	            	smd.find(".live-list").append(html);
	            }else if($(this).attr("data-type")==2){
	            	smd.find(".huputv-list").append(html);
	            }
			});

			smd.on("click", ".delete", function(){
				var r = confirm("你确定要删除吗？")
				if(r){
					$(this).parents("dd").remove();
				}else{
					return false;
				}
			});

			smd.on("click", ".pay", function(){
				console.log(1)
				if($(this).attr("data-pay")=="1"){
					$(this).attr("data-pay", "0");
				}else{
					$(this).attr("data-pay", "1");
				}
			});

			smd.on("click", ".save", function(){

				var bOn = true;
				//var reg = new RegExp(/[http(s)?:\/\/]([\w-]+\.)+[\w-]+(\/[\w- .\/?%&=]*)?/);

				$(".media-list dd").each(function(){
					if(!$(this).find(".name").val()){
						alert("请输入直播源名称！");
						bOn = false;
						return false;
					}
				});

				var list = [];
				var item = {};

				$(".media-list dd").each(function(){

					item = {
						"type": whichType($(this)),
						"name": $(this).find(".name").val(),
						"url": $(this).find(".url").val(),
						"pay": whichPay($(this))
					}

					list.push(item);

				});

				var data = {
					"lid": $("#lid").val(),
					"gid": $("#gid").val(),
					"video_play_title": $("#video-play-title").val(),
					"list": list
				}

				if(bOn){
					$.ajax({
						url: "/chuanshuo/saveGameLiveVideo",
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
				}
			});

			function whichType (obj){
				if(obj.parent().hasClass("tv-list")){
					return "1";
				}else if(obj.parent().hasClass("live-list")){
					return "2";
				}else{
					return "3";
				}
			}

			function whichPay (obj){
				if(obj.find(".pay").attr("data-pay")=="1"){
					return "1";
				}else{
					return "0";
				}
			}


		});

	{%/script%}
{%/block%}


{%block name="content"%}
<div class="set-media-data mod-wrap smd" id="J-smd">
	<input type="hidden" id="lid" value="{%$lid%}">
	<input type="hidden" id="gid" value="{%$gid%}">

	<div class="mod-title"><i class="icon-th-large"></i> <strong>设置视频直播</strong></div>

	<div class="header">
		<code>{%$begin_time|date_format:'%Y-%m-%d %H:%M:%S'%}</code>
		{%if $lid == 1%}
		<code class="team">{%$away_name%}</code>
		<code class="vs">{%$away_score%}-{%$home_score%}</code>
		<code class="team">{%$home_name%}</code>
		{%else%}
		<code class="team">{%$home_name%}</code>
		<code class="vs">{%$home_score%}-{%$away_score%}</code>
		<code class="team">{%$away_name%}</code>
		{%/if%}
		<code>{%$status.desc%}</code>
	</div>

	<div class="live-btn mod-box">
		<i class="icon-tags"></i> 直播时按钮名称：
		<input type="text" placeholder="请输入" id="video-play-title" value="{%$video_play_title%}">
	</div>

	<div class="media mod-box">
		<strong><i class="icon-tags"></i> 添加直播源</strong>&nbsp;&nbsp;&nbsp;&nbsp;
		<label for="tv"><input id="tv" class="media-radio" data-type="0" type="radio" name="media" checked="checked"> 电视</label>&nbsp;&nbsp;&nbsp;&nbsp;
		<label for="live"><input id="live" class="media-radio" data-type="1" type="radio" name="media"> 网络直播</label>&nbsp;&nbsp;&nbsp;&nbsp;
		<label for="huputv"><input id="huputv" class="media-radio" data-type="2" type="radio" name="media"> 虎扑TV</label>&nbsp;&nbsp;&nbsp;&nbsp;
		<a href="javascript:void(0);" class="btn btn-primary" data-type="0" id="J-add-btn">添加</a>
	</div>

	<div class="media-list clearfix">
		<div class="left mod-box fl">
			<dl class="tv-list">
				<dt><i class="icon-tags"></i> 电视</dt>
				{%foreach $list.tv as $val%}
				<dd>
					<table>
						<tr>
							<td>直播源名称：</td>
							<td><input type="text" class="name" placeholder="请输入" value="{%$val.name%}"></td>
							<td><a href="javascript:void(0);" class="btn btn-danger delete">删除</a></td>
						</tr>
						<tr>
							<td>视频地址：</td>
							<td><input type="text" class="url" placeholder="URL" value="{%$val.url%}"></td>
							<td><input type="checkbox" class="pay" {%if !empty($val.pay)%}checked="checked" data-pay="1"{%else%}data-pay="0"{%/if%}> 付费</td>
						</tr>
					</table>
				</dd>
				{%/foreach%}
			</dl>
		</div>
		<div class="center mod-box fl">
			<dl class="live-list">
				<dt><i class="icon-tags"></i> 网络直播</dt>
				{%foreach $list.net as $val%}
				<dd>
					<table>
						<tr>
							<td>直播源名称：</td>
							<td><input type="text" class="name" placeholder="请输入" value="{%$val.name%}"></td>
							<td><a href="javascript:void(0);" class="btn btn-danger delete">删除</a></td>
						</tr>
						<tr>
							<td>视频地址：</td>
							<td><input type="text" class="url" placeholder="URL" value="{%$val.url%}"></td>
							<td><input type="checkbox" class="pay" {%if !empty($val.pay)%}checked="checked" data-pay="1"{%else%}data-pay="0"{%/if%}> 付费</td>
						</tr>
					</table>
				</dd>
				{%/foreach%}
			</dl>
		</div>
		<div class="right mod-box fl">
			<dl class="huputv-list">
				<dt><i class="icon-tags"></i> 虎扑TV</dt>
				{%foreach $list.huputv as $val%}
				<dd>
					<table>
						<tr>
							<td>直播源名称：</td>
							<td><input type="text" class="name" placeholder="请输入" value="{%$val.name%}"></td>
							<td><a href="javascript:void(0);" class="btn btn-danger delete">删除</a></td>
						</tr>
						<tr>
							<td>视频地址：</td>
							<td><input type="text" class="url" placeholder="URL" value="{%$val.url%}"></td>
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
