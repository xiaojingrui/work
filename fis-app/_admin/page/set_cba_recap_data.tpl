{%extends file="common/page/layout-admin-low.tpl"%}

{%block name="head_static"%}
	{%require name="admin:static/set_recap_data/set_recap_data.css"%}

    <script type="text/javascript" src="//b1.hoopchina.com.cn/xheditor/xheditor-1.1.14-zh-cn.min.js"></script>
	{%script%}
		_$(function(){

			_$("#J-srd").on("click", ".none", function(){
				var pid = _$(this).parents("dd").attr("data-pid");
				var ishidden = _$(this).parents("dd").attr("data-ishidden");
				var that = _$(this);
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
							"lid": _$("#lid").val(),
							"gid": _$("#gid").val(),
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
		});

	{%/script%}
{%/block%}


{%block name="content"%}
<div class="set-recap-data mod-wrap srd" id="J-srd">
	<input type="hidden" id="lid" value="{%$lid%}">
	<input type="hidden" id="gid" value="{%$gid%}">

	<div class="mod-title"><i class="icon-th-large"></i>&nbsp;&nbsp;<strong>{%if $is_custom != "0"%}设置CBA战报{%else%}战报（GDC战报不可编辑）{%/if%}</strong></div>

	<div class="header">
		<code>{%$begin_time|date_format:'%Y-%m-%d %H:%M:%S'%}</code>
		<code class="team">{%$home_name%}</code>
		<code class="vs">{%$home_score%}-{%$away_score%}</code>
		<code class="team">{%$away_name%}</code>
		<code>{%$status.desc%}</code>
	</div>

	<form id="liveForm" action="/chuanshuo/saveCbaRecap" class="form-horizontal" method="post">
		<div class="main clearfix">
			<input type="hidden" name="gid" value="{%$gid%}">
			<div class="left fl">
				<div class="mod-box">
					<dl>
						<dd>
							<span class="key">战报标题：</span>
							<input type="text" placeholder="请输入" name="video_title" value="{%$video_title%}" {%if $is_custom == "0"%}disabled="disabled"{%/if%}/>
						</dd>
						<dd>
							<span class="key">视频地址：</span>
							<input type="text" placeholder="URL" name="video_url" value="{%$video_url%}" {%if $is_custom == "0"%}disabled="disabled"{%/if%}/>
						</dd>
						<dd>
							<span class="key">视频封面：</span>
							<input type="text" placeholder="URL" name="video_cover" value="{%$video_cover%}" {%if $is_custom == "0"%}disabled="disabled"{%/if%}/>
						</dd>
					</dl>
				</div>
				<div class="mod-box">
					<div class="dt"><i class="icon-tags"></i>&nbsp;&nbsp;<strong>战报{%if $is_custom == "0"%}(来自：GDC不可编辑){%/if%}</strong></div>
	                {%if $is_custom == "0"%}
	                    {%$content|escape:none%}
	                {%else%}
	                    <textarea id="content" name="content" class="xheditor" placeholder="战报内容" style="width:100%; height:400px;">{%$content|escape:none%}</textarea>
	                {%/if%}
				</div>
			</div>
			<div class="right mod-box fr">
				<dl class="topic-list">
					<dt>
						<i class="icon-tags"></i>&nbsp;&nbsp;帖子ID：<input type="text" placeholder="帖子ID" name="tid" value="{%$tid%}"><br>
						<small>过滤掉有图的亮回帖 比赛结束后的一小时内，每五分钟更新</small>
					</dt>
					{%foreach $light_reply as $val%}
					<dd data-pid="{%$val.pid%}" data-ishidden="{%$val.is_hidden%}">
						<div class="info">
							<span class="num">{%$val@index+1%}</span>
							<span>昵称:{%$val.userName%}</span>
							<span>亮了:{%$val.light_count%}</span>
						</div>
						<div class="content1">{%$val.content%}</div>
						<div class="hide-topic"><a href="javascript:void(0);" class="btn btn-danger none">{%if $val.is_hidden == 1%}显示这个帖子{%else%}不显示这个帖子{%/if%}</a></div>
					</dd>
					{%/foreach%}
				</dl>
			</div>
		</div>
		<div class="bottom">
			<button type="submit" class="btn btn-primary">保存</button>
		</div>
	</form>
<div>
{%/block%}
