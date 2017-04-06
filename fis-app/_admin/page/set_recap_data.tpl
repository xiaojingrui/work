{%extends file="common/page/layout-admin.tpl"%}

{%block name="head_static"%}
	{%require name="admin:static/set_recap_data/set_recap_data.css"%}
	{%require name="admin:static/set_recap_data/jquery-sortable.js"%}


	{%script%}
		$(function(){

			var recapList = document.getElementById("recap-list");
			if(recapList){
				new Sortable(recapList, { group: "omega" });
			}


			//伤停名单添加 删除
			var srd = $("#J-srd");
			var addBtn = $("#J-add-btn");

			addBtn.on("click", function(){
				var html = [
	                "<li><table><tr><td>比赛时间：</td><td><input type='text' class='match-time' placeholder='请输入' style='width: 50px;'><small>可填数值 1-150整数;0或为空，客户端不显示时间</small></td><td rowspan='3'><div class='img'><img src='' class='img-preview' alt='预览图片'></div></td></tr>",
	                "<tr><td>图片地址：</td><td><input type='text' class='img-url' placeholder='URL'></td></tr>",
					"<tr><td>图片大小：</td><td><input type='text' class='img-size' placeholder='选填' style='width: 50px;'>M<small>(不是GIF图可不填)</small></td></tr>",
					"<tr><td>文字描述：</td><td><textarea class='desc' maxlength='400' placeholder='请输入'></textarea><em class='cur_num'>0</em>/400</td><td><a href='javascript:void(0);' class='btn btn-danger delete'>删除</a></td></tr></table></li>"
	            ].join("");

	            srd.find(".recap-list").append(html);
			});

			srd.on("input change blur", ".img-url", function(){
				console.log($(this).val())
				$(this).parents("li").find(".img-preview").attr("src", $(this).val());
			});

			srd.on("keyup", ".desc", function(){
				$(this).next().html($(this).val().length);
			});

			srd.on("click", ".delete", function(){
				var r = confirm("你确定要删除吗？")
				if(r){
					$(this).parents("li").remove();
				}else{
					return false;
				}
			});

			srd.on("click", ".none", function(){
				var pid = $(this).parents("dd").attr("data-pid");
				var ishidden = $(this).parents("dd").attr("data-ishidden");
				var that = $(this);
				var url = "";

				if(ishidden==1){
					url = "showReplyForSoccerRecap";
				}else{
					url = "hideReplyForSoccerRecap";
				}


				var r = confirm("你确定要不显示这个帖子吗？")
				if(r){
					$.ajax({
						url: "/chuanshuo/"+url,
						type: "POST",
						dataType: 'json',
						data: {
							"lid": $("#lid").val(),
							"gid": $("#gid").val(),
							"pid": pid
						},
						success: function(res){
							if(res.status == 200){
								if(ishidden==1){
									that.html("不显示这个帖子");
									that.parents("dd").attr("data-ishidden", "0");
								}else{
									that.html("显示这个帖子");
									that.parents("dd").attr("data-ishidden", "1");
								}
							}
						}
					});
				}else{
					return false;
				}
			});

			var ajaxOn = true;
			srd.on("click", ".save", function(){

				$("#recap-list li").each(function(){
					if(!$(this).find(".img-url").val() && !$(this).find(".desc").val()){
						ajaxOn = false;
						alert("请输入战报图片或文字描述");
						return false;
					}else{
						ajaxOn = true;
					}
				});

				var recap_list = [];
				var item = {};

				$(".recap-list li").each(function(){
					item = {
						"match_time": $(this).find(".match-time").val(),
						"img_url": $(this).find(".img-url").val(),
						"img_size": $(this).find(".img-size").val(),
						"desc": $(this).find(".desc").val().replace(/\/n/g,"<br \/>")
					}

					recap_list.push(item);
				});


				var data = {
					"lid": $("#lid").val(),
					"gid": $("#gid").val(),
					"title": $("#title").val(),
					"video_url": $("#video-url").val(),
					"video_cover": $("#video-cover").val(),
					"tid": $("#tid").val(),
					"list": recap_list
				}

				if(ajaxOn || $("#recap-list li").size()==0){
					$.ajax({
						url: "/chuanshuo/saveSoccerRecap",
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
		});

	{%/script%}
{%/block%}


{%block name="content"%}
<div class="set-recap-data mod-wrap srd" id="J-srd">
	<input type="hidden" id="lid" value="{%$lid%}">
	<input type="hidden" id="gid" value="{%$gid%}">

	<div class="mod-title"><i class="icon-th-large"></i>&nbsp;&nbsp;<strong>{%if $is_custom != "0"%}设置战报{%else%}战报（GDC战报不可编辑）{%/if%}</strong></div>

	<div class="header">
		<code>{%$begin_time|date_format:'%Y-%m-%d %H:%M:%S'%}</code>
		<code class="team">{%$home_name%}</code>
		<code class="vs">{%$home_score%}-{%$away_score%}</code>
		<code class="team">{%$away_name%}</code>
		<code>{%$status.desc%}</code>
	</div>

	<div class="main clearfix">
		<div class="left fl">
			<div class="mod-box">
				<dl>
					<dd>
						<span class="key">战报标题：</span>
						<input type="text" placeholder="请输入" id="title" value="{%$title%}" {%if $is_custom == "0"%}disabled="disabled"{%/if%}/>
					</dd>
					<dd>
						<span class="key">视频地址：</span>
						<input type="text" placeholder="URL" id="video-url" value="{%$video_url%}" {%if $is_custom == "0"%}disabled="disabled"{%/if%}/>
					</dd>
					<dd>
						<span class="key">视频封面：</span>
						<input type="text" placeholder="URL" id="video-cover" value="{%$video_cover%}" {%if $is_custom == "0"%}disabled="disabled"{%/if%}/>
					</dd>
				</dl>
			</div>

			{%if $is_custom != "0"%}
			<div class="recap mod-box">
				<strong><i class="icon-tags"></i>&nbsp;&nbsp;添加战报</strong>&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="javascript:void(0);" class="btn btn-primary" id="J-add-btn">添加</a>
			</div>

			<div class="mod-box">
				<div class="dt"><i class="icon-tags"></i>&nbsp;&nbsp;<strong>战报(可拖拽排序哦！)</strong></div>
				<ul class="recap-list" id="recap-list">
					{%foreach $list as $val%}
					<li>
						<table>
							<tr>
								<td>比赛时间：</td>
								<td><input type="text" class="match-time" placeholder="请输入" style="width: 50px;" value="{%$val.match_time%}"><small>可填数值 1-150整数;0或为空，客户端不显示时间</small></td>
								<td rowspan="3"><div class="img"><img src="{%$val.img_url%}" class="img-preview" alt="预览图片"></div></td>
							</tr>
							<tr>
								<td>图片地址：</td>
								<td><input type="text" class="img-url" placeholder="URL" value="{%$val.img_url%}"></td>
							</tr>
							<tr>
								<td>图片大小：</td>
								<td><input type="text" class="img-size" placeholder="选填" value="{%$val.img_size%}" style="width: 50px;">M<small>(不是GIF图可不填)</small></td>
							</tr>
							<tr>
								<td>文字描述：</td>
								<td><textarea class="desc" maxlength="400" placeholder="请输入">{%$val.desc%}</textarea><em class="cur_num">{%$val.desc|mb_strlen%}</em>/400</td>
								<td><a href="javascript:void(0);" class="btn btn-danger delete">删除</a></td>
							</tr>
						</table>
					</li>
					{%/foreach%}
				</ul>
			</div>
			{%else%}
			<div class="mod-box">
				<div class="dt"><i class="icon-tags"></i>&nbsp;&nbsp;<strong>战报(来自：GDC)</strong></div>
				<div class="content">
					{%$content|escape:none%}
				</div>
			</div>
			{%/if%}
		</div>
		<div class="right mod-box fr">
			<dl class="topic-list">
				<dt>
					<i class="icon-tags"></i>&nbsp;&nbsp;帖子ID：<input type="text" placeholder="帖子ID" id="tid" value="{%$tid%}" {%if $is_custom == "0"%}disabled="disabled"{%/if%}><br>
					<small>过滤掉有图的亮回帖 比赛结束后的一小时内，每五分钟更新</small>
				</dt>
				{%foreach $light_reply as $val%}
				<dd data-pid="{%$val.pid%}" data-ishidden="{%$val.is_hidden%}">
					<div class="info">
						<span class="num">{%$val@index+1%}</span>
						<span>昵称:{%$val.userName%}</span>
						<span>亮了:{%$val.light_count%}</span>
					</div>
					<div class="content">{%$val.content%}</div>
					<div class="hide-topic"><a href="javascript:void(0);" class="btn btn-danger none">{%if $val.is_hidden == 1%}显示这个帖子{%else%}不显示这个帖子{%/if%}</a></div>
				</dd>
				{%/foreach%}
			</dl>
		</div>
	</div>
	{%if $is_custom != "0"%}
	<div class="bottom">
		<a href="javascript:void(0);" class="btn btn-primary save">保存</a>
	</div>
	{%/if%}
<div>
{%/block%}
