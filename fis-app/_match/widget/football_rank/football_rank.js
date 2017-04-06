var football_rank = {
	init: function(){
		this.render();
		this.bind();
	},

	render: function(){
		this.modRankContainer = $("#J-mod-rank-wrap");
		this.tabContainer     = $("#J-tab");

		this.standingsRankContainer    = $("#J-standings-rank");
		this.goalsRankContainer = $("#J-goals-rank");
		this.assistsRankContainer   = $("#J-assists-rank");
	},

	bind: function(){
		var self = this;

		var u = navigator.userAgent, app = navigator.appVersion;
        var isAndroid = u.indexOf('Android') > -1 || u.indexOf('Linux') > -1; //android终端或者uc浏览器
        var isiOS = !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/); //ios终端


        var mySwiper = new Swiper ('.swiper-container',{
			autoHeight: true,
			lazyLoading: true,
			preloadImages: false,
			onSlideChangeStart: function(swiper){
		    	self.tabContainer.find("li").eq(mySwiper.activeIndex).addClass("active").siblings("li").removeClass("active");
		    	if(mySwiper.activeIndex == 0){
		    		self.navFixed(self.standingsRankContainer);
		    	}else if(mySwiper.activeIndex == 1){
					self.navFixed(self.goalsRankContainer);
					isLoad();
		    	}else{
		    		self.navFixed(self.assistsRankContainer);
		    		isLoad();
		    	}
		    }
		});
		androidCss();

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

		//积分榜
		self.navFixed(self.standingsRankContainer);
		self.tabContainer.find(".tab-standings").on("click", function(){
			$(this).addClass("active").siblings("li").removeClass("active");
			self.navFixed(self.standingsRankContainer);
			mySwiper.slideTo(0, 500, false);
		});

		//射手榜
		self.tabContainer.find(".tab-goals").on("click", function(){
			$(this).addClass("active").siblings("li").removeClass("active");
			self.navFixed(self.goalsRankContainer);
			mySwiper.slideTo(1, 500, false);
			isLoad();
		});

		//助攻榜
		self.tabContainer.find(".tab-assists").on("click",function(){
			$(this).addClass("active").siblings("li").removeClass("active");
			self.navFixed(self.assistsRankContainer);
			mySwiper.slideTo(2, 500, false);
			isLoad();
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
			iScrollTop = $(window).scrollTop()+40;
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
	}
}

module.exports = football_rank;