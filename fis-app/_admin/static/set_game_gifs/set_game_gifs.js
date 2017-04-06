
var set_game_gifs = {
		init:function() {
			this.render();
		},
		render: function() {
			var self = this;
			var recapList = document.getElementById("recap-list");

			var sort = Sortable.create(recapList, {
				  animation: 150, 
				  onEnd: function (evt){
				     var item = evt.item; 
				     var gifId = $("#recap-list").find(".gifId").eq(evt.newIndex).text();
				     var liSizeNow = $("#recap-list").find(".sort").eq(evt.newIndex).text();
				     var liSizeUp = $("#recap-list").find(".sort").eq(evt.newIndex-1).text();
				     var liSizeDown = $("#recap-list").find(".sort").eq(evt.newIndex+1).text();
				     console.log(liSizeUp,"90900")
				     if(evt.newIndex == 0) {
				     	var sort = parseFloat(liSizeNow) - 10;
				     }
				     else if(!liSizeDown){
				     	var sort = parseFloat(liSizeNow) + 10;
				     }else{
				     	var  sort = (parseFloat(liSizeUp) + parseFloat(liSizeDown))/2;
				     }
				     //self.accSub(liSizeUp,liSizeDown)
				     	set_game_gifs.ajax("/chuanshuo/setGifSort",{
								"gid": GM.gid,
								"gifId":gifId,
								"sort":sort
							},function(data) {
								//location.reload();
						})

				  }
				});
			//名单添加 删除
			var srd = $("#J-srd");
			var addBtn = $("#J-add-btn");
			//添加
			addBtn.on("click", function(){
				var html = [
	                "<li><table><tr><td></td><td></td><td rowspan='3'><div class='img'><img src='' class='img-preview' alt='预览图片'></div></td></tr>",
	                "<tr><td>图片地址：</td><td><input type='text' class='img-url' placeholder='URL'></td></tr>",
					"<tr><td>图片大小：</td><td><input type='text' class='img-size' placeholder='选填' style='width: 50px;'>M<small>(不是GIF图可不填)</small></td></tr>",
					"<tr><td>文字描述：</td><td><textarea class='desc' maxlength='400' placeholder='请输入'></textarea><em class='cur_num'>0</em>/400</td><td><a href='javascript:void(0);'' class='btn btn-primary updata'>更新</a><a href='javascript:void(0);' class='btn btn-danger delete'>删除</a></td></tr></table></li>"
	            ].join("");
           	if($("#J_img_url").val() == "") {
           		$("#J_img_url").focus();
           		alert("图片地址不能为空");
           		return false;
           	}
           	if($("#J_content").val() == "") {
           		alert("文字描述不能为空");
           		$("#J_content").focus();
           		return false;
           	}
           	set_game_gifs.ajax("/chuanshuo/addGameGif",{
								"gid": GM.gid,
								"url":$("#J_img_url").val(),
								"size":$("#J_img_size").val(),
								"content": $("#J_content").val()
							},function(data) {
								location.reload();
						})
	          
					});
			srd.on("input change blur", ".img-url", function(){
				$(this).parents("li").find(".img-preview").attr("src", $(this).val());
			});

			srd.on("keyup", ".desc", function(){
				$(this).next().html($(this).val().length);
			});
			//删除
			srd.on("click", ".delete", function(){
				var gifId = $(this).parents("li").find(".gifId").text();
				var r = confirm("你确定要删除吗？");
				if(r){
					set_game_gifs.ajax("/chuanshuo/delGameGif",{
								"gid": GM.gid,
								"gifId":gifId
							},function(data) {
								location.reload();
					})
					$(this).parents("li").remove();
				}else{
					return false;
				}
			});
			//更新
			srd.on("click", ".updata", function(){
				var gifId = $(this).parents("li").find(".gifId").text();
				var url = $(this).parents("li").find(".img-url").val();
				var size = $(this).parents("li").find(".img-size").val();
				var content = $(this).parents("li").find(".desc").val();
				var r = confirm("你确定要更新吗？");
				if(r){
					set_game_gifs.ajax("/chuanshuo/updateGameGif",{
								"gid": GM.gid,
								"gifId":gifId,
								"url":url,
								"size":size,
								"content":content
							},function(data) {
								console.log(data,"999")
								location.reload();
					})
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
		},
		ajax: function(url,data,callback) {
			$.ajax({
						url: url,
						type: "POST",
						dataType: 'json',
						data: data,
						success: function(res){
							callback && callback(res);
						}
					});
		},
		/*
		*浮点型数加法运算
		* arg1和arg2为相加的两个值
		 */
		accSub:function(arg1,arg2) {
			var r1,r2,m,n;
	    try{r1=arg1.toString().split(".")[1].length}catch(e){r1=0}
	    try{r2=arg2.toString().split(".")[1].length}catch(e){r2=0}
	    m=Math.pow(10,Math.max(r1,r2));
	    //动态控制精度长度
	    n=(r1>=r2)?r1:r2;
	    return ((arg1*m-arg2*m)/m).toFixed(n);
		}

}
set_game_gifs.init();