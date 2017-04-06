{%extends file="common/page/layout-admin.tpl"%}

{%block name="head_static"%}
	{%require name="common:static/js/underscore/underscore.js"%}
	{%require name="admin:static/add_soccer_battle/draggabilly.pkgd.min.js"%}
	{%require name="admin:static/add_soccer_battle/add_soccer_battle.css"%}

	{%script%}
		
		window.GM = {
			data: {%json_encode($data)%}
		}

		var _ = require("underscore");
		var leftContainer = $("#J-left");
		var battleChoose = $("#J-battle-choose");
		var battleTplRender = _.template($("#J-battle-tpl").html());

		
		dragEvent();
		
		battleChoose.change(function(){
		 	var choose = $(this).val();
		 	var sdata = GM.data[choose];
			var html = battleTplRender( {datas: sdata } );
			$("#J-con").html( html );
			
			dragEvent();
			
		});

		function dragEvent(){
			$("#J-con").find('div').each(function(index){
		  		var $draggable = $('.draggable_'+(index+1)).draggabilly({ containment: true });
			  	var draggie = $draggable.data('draggabilly');
			  	$draggable.on( 'dragMove', function() {
			  		$(".x").html(draggie.position.x);
			  		$(".y").html(draggie.position.y);
			  	});
		  	})
		}



		$(".save").on("click", function(){
			
			var arr = [];
			var item = null;

			$(".player").each(function(index){
				item = {
					"position": $(this).data("position"),
					"position_name": $(this).data("positionname"),
					"x": parseInt($(this).css("left")),
					"y": parseInt($(this).css("top"))
				}

				arr.push(item);
			});

			$.ajax({
                url: "/chuanshuo/saveRosterConfig",
                type: "POST",
                dataType: "json",
                data: {
					"lineup_name": battleChoose.val(),
					"lineup_data": arr
                },
                success: function(data){
                    alert("保存成功");
                    location.reload();
                }
            });
		});
	{%/script%}
{%/block%}


{%block name="content"%}
<div class="add-soccer-battle asb">
	<h5><span class="add-on"><i class="icon-circle-arrow-right"></i> 添加足球阵容 (可拖拽移动球员位置)</span></h5>
	
	<div class="main">
		<div class="left fl" id="J-left">
			<input type="hidden" value="" id="J-data">
			<div class="container" id="J-con">
			{%foreach $data as $key => $val%}
				{%if $key == "4-4-2"%}
				{%foreach $val as $subVal%}
					<div class="player draggable_{%$subVal@index+1%}" data-position="{%$subVal.position%}" data-positionname="{%$subVal.position_name%}" style="left: {%$subVal.x%}px;top: {%$subVal.y%}px;">
						<div class="player_inner">
							{%$subVal.position%} <br>
							{%$subVal.position_name%}
						</div>
					</div>
				{%/foreach%}
				{%/if%}
			{%/foreach%}
			<script type="text/template" id="J-battle-tpl">
				<@$(datas).each(function(index, item){@>
					<div class="player draggable_<@=index+1@>" data-position="<@=item.position@>" data-positionname="<@=item.position_name@>" style="left: <@=item.x@>px;top: <@=item.y@>px;">
						<div class="player_inner">
							<@=item.position@> <br>
							<@=item.position_name@>
						</div>
					</div>
				<@})@>
			</script>
			</div>
		</div>
		<div class="right fl">
			足球阵容选择：<br /><br />
			<select name="" id="J-battle-choose">
				{%foreach $data as $key => $val%}
				<option value="{%$key%}">{%$key%}</option>
				{%/foreach%}
			</select>
			<div class="move">
				<div>当前位置：</div>
				X: <span class="x"></span><br>
				Y: <span class="y"></span>
			</div>
			<div class="submit">
				<button class="btn btn-primary btn-lg save">保存阵容</button>
			</div>
		</div>
	</div>
<div>
{%/block%}