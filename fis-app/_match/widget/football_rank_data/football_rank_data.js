var show_box = require("match:widget/show_box/show_box.js");
var tapLink = require("common:widget/tap-link/tap-link.js");
var Store = require("common:widget/ui-store/ui-store.js");

var football_rank_data = {
	init: function() {
		this.render();
		this.bind();
	},

	render: function() {
		this.modRankContainer = $("#J-mod-rank-wrap");
		this.tabContainer = $("#J-tab");
		this.transferPlayerContainer = $(".transfer-player");

		this.iWidth = this.tabContainer.width();
		this.iHeight = $(window).height();

		this.tabArray = [];
		if (GM.pageLastTab) {
			//if (GM.leagueName == "epl" || GM.leagueName == "bund" || GM.leagueName ==
			//	"liga" || GM.leagueName == "seri" || GM.leagueName == "fran") {
			//	this.tabArray = ["transfer-player", "standings-rank", "player-rank", "team-rank"];
			//}else {
			//
			//}
			this.tabArray = ["standings-rank", "player-rank", "team-rank", "transfer-player"];
		}else{
			this.tabArray = ["standings-rank", "player-rank", "team-rank"];
		}

		$("body").css("height", this.iHeight);
		$(".standings-rank .main").css("height", this.iHeight - 40);
		$(".mod-no-data").css("line-height", (this.iHeight - 40)+"px");
	},

	bind: function() {
		var self = this;

		tapLink.init(self.modRankContainer);
		self.allLinkClick();

		var storePlayerTag = new Store("hide_player_tag");
		var storeTeamTag = new Store("hide_team_tag");

		//提供给测试妹子测试
		//storePlayerTag.remove();
		//storeTeamTag.remove();

		var hidePlayerTag = storePlayerTag.get() ? storePlayerTag.get() : 0;
		var hideTeamTag = storeTeamTag.get() ? storeTeamTag.get() : 0;

		if(hidePlayerTag == 0){
			self.tabContainer.find(".player-tag").show();
		}
		if(hideTeamTag == 0){
			self.tabContainer.find(".team-tag").show();
		}

		var swiperHeight = $(".swiper-wrapper").css("height");

		var mySwiper = new Swiper('.swiper-container', {
			noSwiping: true,
			effect : "fade",
			onSlideChangeStart: function(swiper) {
				self.tabContainer.find("li").eq(mySwiper.activeIndex).addClass(
					"active").siblings("li").removeClass("active");
			}
		});

		// 转会期间，五大联赛(英超epl,德甲bund,西甲liga,意甲seri,法甲fran)默认进来得转会球员tab
		//if (GM.pageLastTab) {
		//	if (GM.leagueName == "epl" || GM.leagueName == "bund" || GM.leagueName ==
		//		"liga" || GM.leagueName == "seri" || GM.leagueName == "fran") {
		//		self.setHeight($("#J-transfer-player"));
		//		self.mainScroll($("#J-transfer-player").find(".main"));
		//		self.navClick($("#J-transfer-player").find(".nav"));
		//		self.tabContainer.find("li").eq(3).addClass("active");
		//	}else{
		//		self.tabContainer.find("li").eq(0).addClass("active");
		//		self.mainScroll($("#J-standings-rank").find(".main"));
		//	}
		//}else{
		//
		//}

		self.tabContainer.find("li").eq(0).addClass("active");
		self.mainScroll($("#J-standings-rank").find(".main"));

		// tab切换
		for (var i = 0; i < self.tabArray.length; i++) {
			tabClick(self.tabArray[i], i);
		}

		function tabClick(selector, index) {
			self.tabContainer.find(".tab-" + selector).on("click", function() {
				mySwiper.slideTo(index, 0, false);
				$(".swiper-slide").hide();
				$("#J-" + selector).show();
				$(this).addClass("active").siblings("li").removeClass("active");
				self.setHeight($("#J-" + selector));
				self.mainScroll($("#J-" + selector).find(".main"));
				self.navClick($("#J-" + selector).find(".nav"));

				// New标签
				if($(this).find(".new-tag").hasClass("player-tag")){
					storePlayerTag.set(1);
				}else if($(this).find(".new-tag").hasClass("team-tag")){
					storeTeamTag.set(1);
				}
				$(this).find(".new-tag").hide();
			});
		}

		// 转会费点击 整行取消点击效果
		self.transferPlayerContainer.find(".icon").parent().on("click", function(
			event) {
			$(".formation .bd").html($(this).find(".icon").data("memo"));
			show_box.init('.formation', '.cover');
			event.stopPropagation();
		});

		self.transferPlayerContainer.find(".icon").parent().on("touchstart",
			function(event) {
				$(this).parent().removeClass("tap");
				event.stopPropagation();
			});
		self.transferPlayerContainer.find(".icon").parent().on("touchend", function(
			event) {
			$(this).parent().addClass("tap");
			event.stopPropagation();
		});
	},

	allLinkClick: function() {
		var self = this;

		self.modRankContainer.delegate(".all-link", "click", function(e) {
			var current = $(e.currentTarget);
			var rank_type = current.attr("data-type");
			var client = GM.client;
			var league_name = GM.leagueName;

			window.location.href = current.attr("link") + "?client=" + client +
				"&league_name=" + league_name + "&rank_type=" + rank_type;
		});
	},

	setHeight: function(obj) {
		var self = this;
		obj.find(".main, .nav").css("height", self.iHeight - 40);
	},

	navClick: function(obj) {
		var self = this;
		var index = 0;

		obj.find("li").on("click", function() {
			index = $(this).index();
			$(this).addClass("active").siblings().removeClass("active");
			$(this).parent().parent().next().scrollTop(self.actualMainHeight(obj,
				index));
		});
	},

	actualMainHeight: function(prevObj, index) {
		var actualMainHeight = 0;
		var length = prevObj.next().find("li").length;

		for (var i = 0; i < length; i++) {
			if (i < index) {
				actualMainHeight += prevObj.next().find("li").eq(i).height();
			}
		}

		return actualMainHeight;
	},

	mainScroll: function(obj) {
		var self = this;
		var scrollTop = null;
		var length = obj.find("li").length;
		var picLen = obj.find(".lazy").length;
		var timer = null;

		if(GM.leagueName == "chlg"){
			lazyload(34);
		}else{
			lazyload(14);
		}

		obj.on("scroll", function() {
			clearTimeout(timer);
			scrollTop = $(this).scrollTop();

			timer = setTimeout(function() {

				lazyload(picLen);

				if (!obj.parent().hasClass("standings-rank")) {
					for (var i = 0; i < length; i++) {
						if (scrollTop >= self.actualMainHeight(obj.prev(), i) && scrollTop <=
							self.actualMainHeight(obj.prev(), i + 1)) {
							obj.prev().find("li").eq(i).addClass("active").siblings().removeClass(
								"active");
						}
					}

					if (obj.prev().find(".active").offset().top >= self.iHeight - 44) {
						obj.prev().scrollTop(obj.prev().scrollTop() + self.iHeight / 2);
					}

					if (obj.prev().find(".active").offset().top <= 40) {
						obj.prev().scrollTop(obj.prev().scrollTop() - self.iHeight / 2);
					}
				}
			}, 200);
		});

		function lazyload(len) {
			for (var i = 0; i < len; i++) {
				if (obj.find(".lazy").eq(i).offset().top > 43 && obj.find(".lazy").eq(
						i).offset().top < self.iHeight) {
					if(!obj.find(".lazy").eq(i).attr("src")){
						obj.find(".lazy").eq(i).attr("src", obj.find(".lazy").eq(i).attr(
							"data-original"));
					}
				}
			}
		}
	},

	navFixed: function(obj) {
		var self = this;
		var oldValue = obj.find("table.fixed .type").html();
		var currentValue = null;
		var oFixedTitle = obj.find("table.fixed").clone();
		var oFixedType = oFixedTitle.find(".type");
		var iScrollTop = null;
		if (obj.find(".title").size()) {
			var oFirstTitleTop = obj.find(".title").eq(0).offset().top;
		}
		$(".standings-rank").scrollTop(0);
		self.tabContainer.siblings("table").remove();
		self.tabContainer.after(oFixedTitle);
		$(".standings-rank").on("scroll", function() {
			iScrollTop = $(".standings-rank").scrollTop() + 40;
			obj.find(".title").each(function() {
				if ($(this).offset().top < iScrollTop) {
					currentValue = $(this).find(".type").html();
					oFixedType.html(currentValue);
				} else if (iScrollTop < oFirstTitleTop) {
					oFixedType.html(oldValue);
				} else {
					oFixedType.html(currentValue);
				}
			});
		});
	}
};

module.exports = football_rank_data;
