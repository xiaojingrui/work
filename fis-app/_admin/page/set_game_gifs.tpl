{%extends file="common/page/layout-admin.tpl"%}

{%block name="head_static"%}
	{%require name="admin:static/set_recap_data/set_recap_data.css"%}
	{%require name="admin:static/set_recap_data/jquery-sortable.js"%}
	{%require name="admin:static/set_game_gifs/set_game_gifs.js"%}
	<script type="text/javascript">
        window.GM = {
            "gid": "{%$gid%}"
        };
    </script>
{%/block%}


{%block name="content"%}
<div class="set-recap-data mod-wrap srd" id="J-srd">
	<input type="hidden" id="lid" value="{%$lid%}">
	<input type="hidden" id="gid" value="{%$gameInfo.status.id%}">

	<div class="mod-title"><i class="icon-th-large"></i>&nbsp;&nbsp;<strong>{%if $is_custom != "0"%}设置轮播图{%else%}战报（GDC战报不可编辑）{%/if%}</strong></div>

	<div class="header">
		<code>{%$gameInfo.begin_time|date_format:'%Y-%m-%d %H:%M:%S'%}</code>
		<code class="team">{%$gameInfo.home_name%}</code>
		<code class="vs">{%$gameInfo.home_score%}-{%$gameInfo.away_score%}</code>
		<code class="team">{%$gameInfo.away_name%}</code>
		<code>{%$gameInfo.status.desc%}</code>
	</div>

	<div class="main clearfix">
		<div class="left set_game_gifs">
			<div class="mod-box">
					<ul class="recap-list">
						<li>
							<table>
								<tr>
									<td>图片地址：</td>
									<td><input type="text" class="img-url" id="J_img_url" placeholder="URL" value=""></td>
								</tr>
								<tr>
									<td>图片大小：</td>
									<td><input type="text" class="img-size" id="J_img_size" placeholder="选填" value="" style="width: 50px;">M<small>(不是GIF图可不填)</small></td>
								</tr>
								<tr>
									<td>文字描述：</td>
									<td><textarea class="desc" maxlength="100" id="J_content" placeholder="请输入"></textarea><em class="cur_num">0</em>/100</td>
									<td><a href="javascript:void(0);" class="btn btn-primary" id="J-add-btn">添加</a></td>
								</tr>
							</table>
						</li>
					</ul>
				</div>
			{%if $is_custom != "0"%}
			<div class="mod-box">
				<div class="dt"><i class="icon-tags"></i>&nbsp;&nbsp;<strong>轮播图(可拖拽排序哦！)</strong></div>
				<ul class="recap-list" id="recap-list">
					{%foreach $gifs as $val%}
						<li>
							<table>
								<tr>
									<td></td>
									<td></td>
									<td rowspan="3"><div class="img"><img src="{%$val.url%}" class="img-preview" alt="预览图片"></div></td>
								</tr>
								<tr>
									<td>图片地址：</td>
									<td><input type="text" class="img-url aaa" placeholder="URL" value="{%$val.url%}"></td>
								</tr>
								<tr>
									<td>图片大小：</td>
									<td><input type="text" class="img-size" placeholder="选填" value="{%$val.size%}" style="width: 50px;">M<small>(不是GIF图可不填)</small></td>
								</tr>
								<tr>
									<td>文字描述：</td>
									<td><textarea class="desc" maxlength="100" placeholder="请输入">{%$val.content%}</textarea><em class="cur_num">{%$val.content|mb_strlen%}</em>/100</td>
									<td>
										<span class="gifId" style="display:none">{%$val.gifId%}</span>
										<span class="sort" style="display:none">{%$val.sort%}</span>
										<a href="javascript:void(0);" class="btn btn-primary updata">更新</a>
										<a href="javascript:void(0);" class="btn btn-danger delete">删除</a>
									</td>
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
	</div>
	{%if $is_custom != "0"%}
	<!--
	<div class="bottom">
		<a href="javascript:void(0);" class="btn btn-primary save">保存</a>
	</div>
	-->
	{%/if%}
<div>
{%/block%}
