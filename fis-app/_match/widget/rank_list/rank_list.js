var version = require("common:widget/ui-versions/ui-versions.js");
var _ = require("underscore");

var rank_list = {
	init: function(){
		this.render();
		this.bind();
	},

	render: function(){
		this.modRankContainer = $("#J-mod-rank-wrap");
		this.tabContainer     = $("#J-tab");

		this.teamRankContainer    = $("#J-team-rank");
		this.regularRankContainer = $("#J-regular-rank");
		this.dailyRankContainer   = $("#J-daily-rank");

		this.tplRegularRender = _.template($("#J-regular-rank-tpl").html());
		this.tplDailyRender   = _.template($("#J-daily-rank-tpl").html());

		this.regularRankContent = null;
		this.dailyRankContent   = null;

		this.iWidth  = this.tabContainer.width();
		this.iHeight = $(window).height();

		this.vsBoxWrap = $("#J-vs-box-wrap");

		this.isOver = true;

		if(GM.match == "nba"){
			this.match = "nba";
			this.url = "getPlayerDataInGeneral";
		}else{
			this.match = "cba";
			this.url = "getPlayerRank";
		}

		// 判断版本  7.0.7CBA球员页schemes跳转  之前版本的H5跳转
		this.isH5url = null;
		if(version.gte(GM.version, "7.0.7")){
    		this.isH5url = false;
    	}else{
    		this.isH5url = true;
    	}
	},

	bind: function(){
		var self = this;

		var u = navigator.userAgent, app = navigator.appVersion;
        var isAndroid = u.indexOf('Android') > -1 || u.indexOf('Linux') > -1; //android终端或者uc浏览器
        var isiOS = !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/); //ios终端

        //self.vsBoxWrap.find(".vs-box").css("zoom", self.iWidth/320);

        var mySwiper = new Swiper ('.swiper-container',{
			autoHeight: true,
			lazyLoading: true,
			preloadImages: false,
			onSlideChangeStart: function(swiper){
		    	self.tabContainer.find("li").eq(mySwiper.activeIndex).addClass("active").siblings("li").removeClass("active");
		    	if(mySwiper.activeIndex == 0){
		    		self.navFixed(self.teamRankContainer);
		    	}else if(mySwiper.activeIndex == 1){
					self.navFixed(self.regularRankContainer);
					isLoad();
		    	}else{
		    		self.navFixed(self.dailyRankContainer);
		    		isLoad();
		    	}
		    }
		});
		androidCss();

		setTimeout(function(){
			// 球员数据和今日数据一进来变请求接口
			if(self.regularRankContent){
				self.regularRankContainer.html(self.regularRankContent);
			}else{
				self.tabRegular($(".tab-regular").data("type"), function(){
					androidCss();
				});
			}

			if(self.dailyRankContent){
				self.dailyRankContainer.html(self.dailyRankContent);
			}else{
				self.tabDaily($(".tab-daily").data("type"), function(){
					androidCss();
				});
			}
		},0);
		

		//模拟a链接跳转
		self.modRankContainer.delegate(".link", "touchstart", function(e){
			var current = $(e.currentTarget);
			current.addClass("link-touched");
		});

		self.modRankContainer.delegate(".link", "touchmove", function(e){
			var current = $(e.currentTarget);
			current.removeClass("link-touched");
		});

		self.modRankContainer.delegate(".link", "touchend", function(e){
			var current = $(e.currentTarget);
			current.removeClass("link-touched");
		});

		self.modRankContainer.delegate(".link", "click", function(e){
			var current = $(e.currentTarget);
			window.location.href = current.attr("link");
		});

		self.vsBoxWrap.delegate(".link", "click", function(e){
			var current = $(e.currentTarget);
			window.location.href = current.attr("link");
		});


		self.modRankContainer.delegate(".all-link", "click", function(e){
			var current = $(e.currentTarget);
			var type = current.data("type");
			var category = GM.season;
			var client = GM.client;
			var page = 1;

			window.location.href = current.attr("link")+"?client="+client+"&category="+category+"&type="+type+"&page="+page;
		});

		//球队排名
		self.navFixed(self.teamRankContainer);
		self.tabContainer.find(".tab-team").on("click", function(){
			$(this).addClass("active").siblings("li").removeClass("active");
			self.navFixed(self.teamRankContainer);
			mySwiper.slideTo(0, 500, false);
		});

		//球员数据
		self.tabContainer.find(".tab-regular").on("click", function(){
			$(this).addClass("active").siblings("li").removeClass("active");
			self.navFixed(self.regularRankContainer);
			mySwiper.slideTo(1, 500, false);
			isLoad();
		});

		//今日数据
		self.tabContainer.find(".tab-daily").on("click",function(){
			$(this).addClass("active").siblings("li").removeClass("active");
			self.navFixed(self.dailyRankContainer);
			mySwiper.slideTo(2, 500, false);
			isLoad();
		});

		$(window).on("load scroll resize", function(){
			//self.vsBoxWrap.find(".vs-box").css("zoom", self.tabContainer.width()/320);
		    self.showWrapH();
		});

		//规则提示
		self.regularRankContainer.delegate(".rules", "click", function(){
			self.showBox($(".rules-showBox"));
		});

		// IOS 安卓  垂直居中样式问题
		function androidCss(){
			if(isAndroid){
	        	$(".mod-title thead td").css({
	        		"line-height": "23px",
	        		"padding-top": "3px",
	        		"padding-bottom": "0px"
	        	});
	        }
		}

		//
		function isLoad(){
			if($(".swiper-wrapper").css("height") == "60px"){
				$(".swiper-wrapper").css("height","auto");
			}
		}
	},

	tabRegular: function(type, callback){
		var self = this;
        $.ajax({
            url: "/"+self.match+"/"+self.url,
            type: "GET",
            dataType: "json",
            data:{
                "client": GM.client,
                "type": type,
                "night": GM.night
            },
            success: function(data){
                self.regularRankContent = self.tplRegularRender({datas: data, isH5url: self.isH5url});
								self.regularRankContainer.html( self.regularRankContent );
                callback && callback();
                self.showWrapH();
            }
        });
	},

	tabDaily: function(type, callback){
		var self = this;
        $.ajax({
            url: "/"+self.match+"/"+self.url,
            type: "GET",
            dataType: "json",
            data:{
                "client": GM.client,
                "type": type,
                "night": GM.night
            },
            success: function(data){

                self.dailyRankContent = self.tplDailyRender({datas: data, isH5url: self.isH5url});
								self.dailyRankContainer.html( self.dailyRankContent );
                callback && callback();
            }
        });
	},

	navFixed: function(obj){
		var self = this;
		var oldValue = obj.find("table.fixed .type").html();
		var currentValue = null;
		var oFixedTitle = obj.find("table.fixed").clone();
		var oFixedType = oFixedTitle.find(".type");
		var iScrollTop = null;
		if(obj.find(".title").size()){
			var oFirstTitleTop = obj.find(".title").eq(0).offset().top;
		}
		$(window).scrollTop(0);
		self.tabContainer.siblings("table").remove();
		self.tabContainer.after(oFixedTitle);
		$(window).on("scroll", function() {
			iScrollTop = $(window).scrollTop()+50;
			obj.find(".title").each(function(){
				if($(this).offset().top < iScrollTop ){
					currentValue = $(this).find(".type").html();
					oFixedType.html(currentValue);
				}else if(iScrollTop < oFirstTitleTop){
					oFixedType.html(oldValue);
				}else{
					oFixedType.html(currentValue);
				}
			})
		});
	},

	showBox: function(obj){
		var self = this;
		obj.show();
		obj.removeClass('m-hide');
		$(".mod-show-mask").show();
	    obj.find(".close").on("click", function(){
	        self.hideBox(obj);
	    });
	    $(".mod-show-mask").on("click", function(){
	        self.hideBox(obj);
	    });
	    self.boxCenter($(".mod-showBox"));
	},

	hideBox: function(obj) {
		obj.addClass('m-hide');
		obj.one('webkitTransitionEnd', function(e) {
            obj.hide();
        });
	    $(".mod-show-mask").hide();
	},

	showWrapH: function(){
		$(".mod-show-mask").css("height", $(document).height());
	},

	boxCenter: function(obj){
		var self = this;
		var objWidth = obj.width();
		var objHeight = obj.height();
		//alert(objWidth+"|"+objHeight);

		if(obj.size()==1){
	        obj.css({
	            "left":(self.iWidth-objWidth)/2,
	            "top":(self.iHeight-objHeight)/2
	        });
	    }else{
	        obj.each(function(){
	            $(this).css({
	                "left":(self.iWidth-objWidth)/2,
	            	"top":(self.iHeight-objHeight)/2
	            });
	        });
	    }
	}
}

module.exports = rank_list;
