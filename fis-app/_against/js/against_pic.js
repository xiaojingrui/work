
var against = {
	init:function() {
		this.bind();
		this.jeDate();
	},
	bind:function() {
		var self = this;
		var flagAd = false;
		var flagAdmin = false;
		var onlineList = $(".online-list");
		var adList = $(".ad-list");
		var adminList = $(".admin-list");
		var tab;
		var onlineVal = onlineList.find(".pic-url").val();
		var adVal = adList.find(".pic-url").val();
		var adminVal = adminList.find(".pic-url").val();
		//tab导航切换
		 $(".againsts-nav").find("li").on("click", function(){
        $(this).addClass("active").siblings().removeClass("active");
        $(".pics-list").eq($(this).index()).show().siblings(".pics-list").hide();
        	//广告图库
        if($(this).index() == 1) {
        	tab = "ad";
        	// if(flagAd) return;
        	// flagAd = true;
	        self.ajax("http://192.168.8.79:5001/get_pics",{
	        	"type":"ad",
	        	"unit":10,
	        	"page":1
	        },function(data){
	        		self.Pagination(Math.ceil(data.total/10),"Pagination1",function(index,item){
	        			$(".J_ad_list").empty().append(_.template( $('#J_tpl').html(),{datas: data.data} )); //装载对应分页的内容
	        			self.ajax("http://192.168.8.79:5001/get_pics",{
				        	"type":"ad",
				        	"unit":10,
				        	"page":index+1
				        },function(data){
				        		$(".J_ad_list").empty().append(_.template( $('#J_tpl').html(),{datas: data.data} )); //装载对应分页的内容
				        })
	        		});
	        })
        }
        //其他违禁图库管理
        if($(this).index() == 2){
        	tab = "other";
        	// if(flagAdmin) return;
        	// flagAdmin = true;
        	self.ajax("http://192.168.8.79:5001/get_pics",{
	        	"type":"other",
	        	"unit":10,
	        	"page":1
	        },function(data){
	        		self.Pagination(Math.ceil(data.total/10),"Pagination2",function(index,item){
	        			$('.J_admin_list').empty().append(_.template( $('#J_tpl').html(),{datas: data.data} ));
	        			self.ajax("http://192.168.8.79:5001/get_pics",{
				        	"type":"other",
				        	"unit":10,
				        	"page":index+1
				        },function(data){
				        		$(".J_admin_list").empty().append(_.template( $('#J_tpl').html(),{datas: data.data} )); //装载对应分页的内容
				        })
	        		});
	        })
        }       
    });
		//搜索当前图片
		$(".pics-list").on("click",".J_img_search",function() {
			var url = self.newsUrl();
			var inputVal = $(this).parents(".pic-search").find(".pic-url").val();
			var that = $(this);
			if(!inputVal) {
				alert("图片url不能为空");
				return false;
			}
			if(tab == "ad") {
				self.ajax("http://192.168.8.79:5001/search",{
					"imageurl":inputVal,
					"type":"ad"
	        },function(data){
	        	searchImg(data,that);
	        },"该图片不在当前图库中")
			}
			else if(tab == "other"){
				self.ajax("http://192.168.8.79:5001/search",{
					"imageurl":inputVal,
					"type":"other"
	        },function(data){
	        	searchImg(data,that);
	        },"该图片不在当前图库中")
			}
			else{
				var urlNew = url[0] + "?" + "m="+url[1] + "&start_time="+url[2] + "&end_time="+url[3] + "&keyword="+inputVal + "&page="+url[5];
				location.href = urlNew;
			}
		})
		//按日期搜索
		$(".J_date_search").on("click",function() {
			var url = self.newsUrl();
			var inpstart = $("#inpstart").val();
			var inpend = $("#inpend").val();
			if(!inpstart) {
				alert("开始日期不能为空");
				return false;
			}
			if(!inpend) {
				alert("结束日期不能为空");
				return false;
			}
			var urlNew = url[0] + "?" + "m="+url[1] + "&start_time="+inpstart + "&end_time="+inpend + "&keyword="+url[4] + "&page="+url[5] + "#" + tab;
			location.href = urlNew;
		});
		//添加到当前图库ad(广告)
		$(".pics-list").on("click",".J_add_img_ad",function() {
			var inputVal = $(this).parents(".pic-search").find(".pic-url").val();
			var that = $(this);
			if(!inputVal) {
				alert("图片url不能为空");
				return false;
			}
			var trLen = $(this).parents(".pics-list").find("table tr").size();
			self.ajax("http://192.168.8.79:5001/add_pic",{
				"imageurl": inputVal,
				"type":"ad",
				"user":GM.uid
			},function(data) {
				addNo(data,trLen,that);			
			},"添加失败")
		})
		//添加到当前图库admin（其他违禁图）
		$(".pics-list").on("click",".J_add_img_admin",function() {
			var inputVal = $(this).parents(".pic-search").find(".pic-url").val();
			var that = $(this);
				if(!inputVal) {
					alert("图片url不能为空");
					return false;
				}
				var trLen = $(this).parents(".pics-list").find("table tr").size();
				self.ajax("http://192.168.8.79:5001/add_pic",{
					"imageurl": inputVal,
					"type":"other",
					"user":GM.uid
				},function(data) {
					addNo(data,trLen,that);
				},"添加失败")
			})
		//搜索重置数据
		function searchImg(data,that) {
			that.parents(".pics-list").find(".table-td").remove();
    	that.parents(".pics-list").find(".table-hd").after(
				"<tr class='table-td'>"+
					"<td>1</td>"+
					"<td><img width='150' src="+data[0]+"><a class='imgA' target='_blank' href="+ data[0]+">链接</a></td>"+
					"<td></td>"+
					"<td><p>从图库中删除图片</p></td>"+
				"</tr>"
				)
		}
		//添加数据(ajax请求成功之后执行)
		function addNo(data,len,that) {
			if(data.result == "add") {
					that.parents(".pics-list").find(".table-hd").after(
					"<tr>"+
						"<td>"+len+"</td>"+
						"<td><img width='150' src="+data.url+"<a class='imgA' href='#''>链接</a></td>"+
						"<td></td>"+
						"<td><p>从图库中删除图片</p></td>"+
					"</tr>"
					)
				}else{
					alert("图片已经存在图库中");
				}
		}
		//删除图片事件
		$('.pics-list').on("click","p",function() {
			var that = $(this);
			var imglink = that.parents().find("a").attr("href");
			var r = confirm("你确定要删除吗？");
				if(r){
						self.ajax("http://192.168.8.79:5001/delete_pic",{
							"imageurl":imglink,
							"type":    tab
						},function(data) {
							if(data.result == "success"){
								that.parents("tr").remove();
							}else{
								alert("删除失败")
							}
						},"删除失败")
				}				
		})
	},
	ajax: function(url,data,callback,error) {
		$.ajax({
			url: url,
			type: "GET",
			dataType: 'json',
			data: data,
			success: function(data){
				callback && callback(data);
			},error:function(data) {
				console.log(error);
			}
		});
	},
	jeDate: function() {
		//日历
		var start = {
		    format: 'YYYY-MM-DD hh:mm:ss',
		    minDate: '2014-06-16 23:59:59', //设定最小日期为当前日期
		    festival:false,
		    //isinitVal:true,
		    maxDate: $.nowDate(0), //最大日期
		    choosefun: function(elem,datas){
		        end.minDate = datas; //开始日选好后，重置结束日的最小日期
		    }
		};
		var end = {
		    format: 'YYYY-MM-DD hh:mm:ss',
		    minDate: $.nowDate(0), //设定最小日期为当前日期
		    festival:false,
		    //isinitVal:true,
		    maxDate: '2099-06-16 23:59:59', //最大日期
		    choosefun: function(elem,datas){
		        start.maxDate = datas; //将结束日的初始值设定为开始日的最大日期
		    }
		};
		$("#inpstart").jeDate(start);
		$("#inpend").jeDate(end);
	},
	/*
		*num 为列表总条数
	 */
	Pagination:function(num,id,callback) {
		//var num_entries = $("#hiddenresult div.result").length;
		// 创建分页
		$("#"+id).pagination(num, {
			num_edge_entries: 1, //边缘页数
			num_display_entries: 4, //主体页数
			callback: function (page_index, item){
				callback && callback(page_index, item)
			},
			items_per_page:1 //每页显示1项
		});
	},
	newsUrl:function() {

		var url = window.document.location.href; 
		var htmlparams = url.substring(url.indexOf("?")+1, url.length);
		var host = url.substring(0,url.indexOf("?"));
		var params = htmlparams.split('&'); 
		var m ="",	
				start_time = "",
				end_time = "",
				keyword = "",
				page = "";

		for (var i = 0; i < params.length; i++) {
			var tmp = params[i].split('=');
			if (tmp[0] == "m")
				m = tmp[1];
			if (tmp[0] == "start_time")
				start_time = tmp[1];
			if (tmp[0] == "end_time")
				end_time = tmp[1];
			if (tmp[0] == "keyword")
				keyword = tmp[1];
			if (tmp[0] == "page")
				page = tmp[1];
		}
		return [host,m,start_time,end_time,keyword,page];	
	}
}
against.init();