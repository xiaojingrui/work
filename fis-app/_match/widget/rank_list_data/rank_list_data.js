var version = require("common:widget/ui-versions/ui-versions.js");
var tapLink = require("common:widget/tap-link/tap-link.js");
var _ = require("underscore");
var rank_list = {
	init: function() {
		this.render();
		this.bind();
	},

	render: function() {
		this.modRankContainer = $("#J-mod-rank-wrap");
		this.tabContainer = $("#J-tab");

		this.teamRankContainer = $("#J-team-rank");
		this.playerDataContainer = $("#J-player-data");

		this.content = {};
		this.content.player = null;
		this.content.daily = null;
		this.content.trade = null;
		this.content.draft = null;

		this.iWidth = this.tabContainer.width();
		this.iHeight = $(window).height();

		this.isOver = true;

		this.isPreGame = false; //季前赛没有数据 只展示伤病

		// NBA和CBA的tab集合
		if (GM.match == "nba") {
			this.match = "nba";
			this.url = "getPlayerDataInGeneral";
			if (GM.pageLastTab == "draft") {
				this.tabArray = ["trade-info", "team-rank", "player-data", "draft-result"];
			} else if (this.isPreGame) {
				this.tabArray = ["hurt-info", "team-rank", "player-data", "daily-data"];
			} else {
				this.tabArray = ["team-rank", "player-data", "daily-data", "hurt-info"];
			}
		} else {
			this.match = "cba";
			this.url = "getPlayerRank";
			this.tabArray = ["team-rank", "player-data", "daily-data"];
		}

		// 判断版本  7.0.7CBA球员页schemes跳转  之前版本的H5跳转
		this.isH5url = null;
		if (version.gte(GM.version, "7.0.7")) {
			this.isH5url = false;
		} else {
			this.isH5url = true;
		}
	},

	bind: function() {
		var self = this;

		tapLink.init(self.modRankContainer);

		var mySwiper = new Swiper('.swiper-container', {
			lazyLoading: true,
			preloadImages: false,
			noSwiping: true,
			effect: "fade",
			onSlideChangeStart: function(swiper) {
				self.tabContainer.find("li").eq(mySwiper.activeIndex).addClass(
					"active").siblings("li").removeClass("active");
			}
		});

		// 定时器解决页面加载不显示的BUG
		setTimeout(function() {
			for (var i = 0; i < self.tabArray.length; i++) {
				if (self.content[self.tabArray[i]]) {
					$("#J-" + self.tabArray[i]).html(self.content[self.tabArray[i]]);
				} else {
					if(self.tabArray[i] != "team-rank") {
						self.ajaxTab(self.tabArray[i], $(".tab-" + self.tabArray[i]).data(
						"type"), $("#J-" + self.tabArray[i]), self.content[self.tabArray[i]]);
					} else {
						if ((GM.match == "nba" && !self.isPreGame) || GM.match == "cba") {
							self.tabContainer.find("li").eq(0).addClass("active");
						}
					}
				}
			}
		}, 10);

		// 查看全部
		self.modRankContainer.delegate(".all-link", "click", function(e) {
			var current = $(e.currentTarget);
			var type = current.data("type");
			var category = GM.season;
			var client = GM.client;
			var isTeam = current.data("isteam");
			var page = 1;

			// 交易信息里面的查看全部由服务端直接给到的allURL,之前的拼的
			if (type) {
				window.location.href = current.attr("link") + "?client=" + client +
					"&category=" + category + "&type=" + type + "&page=" + page;
			} else {
				window.location.href = current.attr("link");
			}

			if(isTeam){
				window.location.href = current.attr("link") + "?client=" + client +
					"&category=" + category + "&rank_type=" + type + "&page=" + page;
			}
		});

		// tab点击切换
		for (var i = 0; i < self.tabArray.length; i++) {
			tabClick(self.tabArray[i], i);
		}

		//规则提示
		$(window).on("load scroll resize", function() {
			self.showWrapH();
		});
		self.playerDataContainer.delegate(".rules", "click", function() {
			self.showBox($(".rules-showBox"));
		});

		function tabClick(selector, index) {
			self.tabContainer.find(".tab-" + selector).on("click", function() {
				mySwiper.slideTo(index, 0, false);
				$(".swiper-slide").hide();
				$("#J-" + selector).show();
				$(this).addClass("active").siblings("li").removeClass("active");
				self.mainScroll($("#J-" + selector).find(".main"));
				self.navClick($("#J-" + selector).find(".nav"));
			});
		}

		self.setHeight(self.teamRankContainer);

	},

	// 设置nav和main固定高度，实现内滚动
	setHeight: function(obj) {
		var self = this;
		obj.find(".main, .nav").css("height", self.iHeight - 40);
	},

	// nav点击切换main内容对应定位
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

	// main中第n项中每项高度之和，实现nav点击跳转对应某项
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

	// main滚动对应nav滚动
	mainScroll: function(obj) {
		var self = this;
		var scrollTop = null;
		var length = obj.find("li").length;
		var picLen = obj.find(".lazy").length;
		var timer = null;

		lazyload(14);

		obj.on("laod scroll", function() {
			clearTimeout(timer);
			scrollTop = $(this).scrollTop();

			timer = setTimeout(function() {
				for (var i = 0; i < length; i++) {
					if (scrollTop >= self.actualMainHeight(obj.prev(), i) && scrollTop <=
						self.actualMainHeight(obj.prev(), i + 1)) {
						obj.prev().find("li").eq(i).addClass("active").siblings().removeClass(
							"active");
					}
				}

				lazyload(picLen);

				if (obj.prev().find(".active").offset().top >= self.iHeight - 44) {
					obj.prev().scrollTop(obj.prev().scrollTop() + self.iHeight / 2);
				}

				if (obj.prev().find(".active").offset().top <= 40) {
					obj.prev().scrollTop(obj.prev().scrollTop() - self.iHeight / 2);
				}
			}, 300);
		});

		function lazyload(len) {
			for (var i = 0; i < len; i++) {
				if (obj.find(".lazy").eq(i).offset().top > 43 && obj.find(".lazy").eq(
						i).offset().top < self.iHeight) {
					obj.find(".lazy").eq(i).attr("src", obj.find(".lazy").eq(i).attr(
						"data-original"));
				}
			}
		}
	},

	// 由于除第一个TAB之外都是异步接口(异步接口领导说体验不好)，改成页面一进来请求所有异步接口
	ajaxTab: function(selector, type, container, content, callback) {
		var self = this;
		var render = null;
		var html = null;

		$.ajax({
			url: "/" + self.match + "/" + self.url,
			type: "GET",
			dataType: "json",
			data: {
				"client": GM.client,
				"type": type,
				"night": GM.night
			},
			success: function(data) {
				html = $("#J-" + selector + "-tpl").html() || "";
				render = _.template(html);
				content = render({
					datas: data,
					isH5url: self.isH5url
				});
				container.html(content);
				self.setHeight(container);
				self.showWrapH();
				// 选秀期间，默认进来得选秀结果tab 选秀结束  默认跳签约交易
				if (GM.pageLastTab == "draft") {
					self.mainScroll($("#J-trade-info").find(".main"));
					self.navClick($("#J-trade-info").find(".nav"));
					self.tabContainer.find("li").eq(2).addClass("active");
				}else if(self.isPreGame){
					self.mainScroll($("#J-hurt-info").find(".main"));
					self.navClick($("#J-hurt-info").find(".nav"));
					self.tabContainer.find("li").eq(3).addClass("active");
				}else{
					self.mainScroll($("#J-team-rank").find(".main"));
					self.navClick($("#J-team-rank").find(".nav"));
					self.tabContainer.find("li").eq(0).addClass("active");
				}
				callback && callback();
			}
		});
	},

	// 导航栏的固定（目前的布局暂时不用）
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
		$(".team-rank").scrollTop(0);
		self.tabContainer.siblings("table").remove();
		self.tabContainer.after(oFixedTitle);
		$(".team-rank").on("scroll", function() {
			iScrollTop = $(".team-rank").scrollTop() + 50;
			obj.find(".title").each(function() {
				if ($(this).offset().top < iScrollTop) {
					currentValue = $(this).find(".type").html();
					oFixedType.html(currentValue);
				} else if (iScrollTop < oFirstTitleTop) {
					oFixedType.html(oldValue);
				} else {
					oFixedType.html(currentValue);
				}
			})
		});
	},

	showBox: function(obj) {
		var self = this;

		obj.show();
		obj.removeClass('m-hide');
		$(".mod-show-mask").show();
		obj.find(".close").on("click", function() {
			self.hideBox(obj);
		});
		$(".mod-show-mask").on("click", function() {
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

	showWrapH: function() {
		$(".mod-show-mask").css("height", $(document).height());
	},

	boxCenter: function(obj) {
		var self = this;
		var objWidth = obj.width();
		var objHeight = obj.height();

		if (obj.size() == 1) {
			obj.css({
				"left": (self.iWidth - objWidth) / 2,
				"top": (self.iHeight - objHeight) / 2
			});
		} else {
			obj.each(function() {
				$(this).css({
					"left": (self.iWidth - objWidth) / 2,
					"top": (self.iHeight - objHeight) / 2
				});
			});
		}
	}
}

module.exports = rank_list;
