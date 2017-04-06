var _ = require("underscore");
var refresh = require("common:widget/ui-refresh/ui-refresh.js");
var tapLink = require("common:widget/tap-link/tap-link.js");

function initBridge(callback) {
    if(window.HupuBridge){
        callback();
    }else{
        document.addEventListener("hupuBridgeReady", function(){
            callback();
        });
    }
}

var all_rank = {
	init: function() {
		this.render();
		this.bind();
	},

	render: function() {
		this.allRankWrapContainer = $("#J-all-rank-wrap");
		this.allRankContainer = $("#J-all-rank");
		this.tplAllRender = _.template($("#J-all-rank-tpl").html());
		if ($("#J-all-trade-tpl").html()) {
			this.tplAllTradeRender = _.template($("#J-all-trade-tpl").html());
		}
		this.allRankContent = null;

		this.isOver = true;
		this.bOn = true;
		this.page = 2;
	},

	bind: function() {
		var self = this;
		tapLink.init(self.allRankWrapContainer);
		self.clickIcon();
		if (GM.rank_type != "TOP20") {
			self.initScroll();
		}

        if($("#J-all-rank tr").eq(19).position().top < $(window).height()){
            self.linkAllMore(2);
        }

		initBridge(function(){
			HupuBridge.send("hupu.ui.share", {
				open: false
			}, function(){});
		});
	},

	linkAllMore: function(page, callback) {
		var self = this;

		if(self.bOn){
			$.ajax({
				url: window.location.href.replace(/&page=\d+/, ""),
				//url: "/nba/getDailyPlayerAjax_" + page, //本地测试
				type: "get",
				dataType: "json",
				data: {
					"page": page,
					"night": GM.night
				},
				success: function(data) {
					if (data.type == "trade") {
						self.allRankContainer.append(self.tplAllTradeRender({
							datas: data.data,
							is_more: data.is_more
						}));
					} else {
						self.allRankContainer.append(self.tplAllRender({
							datas: data.data
						}));
					}
					if (data.data.length == 0) {
						self.isOver = false;
						$(".preloader-loading-more").hide();
					}
					self.page++;
					self.bOn = true;
                    self.clickIcon();
					callback && callback();
				}
			});
		}
		self.bOn = false;
	},

	initScroll: function() {
		var self = this;
		refresher = refresh({
			contentEl: '#J-scroll-wrapper',
			isRefresh: false,
			isLoadingMore: true,
			loadingMoreCallback: function(callback) {
				if (self.isOver) {
					self.linkAllMore(self.page, callback);
				} else {
					callback("finish");
				}
			}
		});
	},

	clickIcon: function(){
		var self = this;
		// 转会费说明弹层
        var show_box = require("match:widget/show_box/show_box.js");
        self.allRankWrapContainer.find(".td-icon").on("click", function(event){
            $(".formation .bd").html($(this).find(".icon").data("memo"));
            show_box.init('.formation','.cover');
            event.stopPropagation();
        });

        self.allRankWrapContainer.find(".td-icon").on("touchstart", function(event){
            $(this).parent().removeClass("tap");
            event.stopPropagation();
        });

        self.allRankWrapContainer.find(".td-icon").on("touchend", function(event){
            $(this).parent().addClass("tap");
            event.stopPropagation();
        });
	}
}

module.exports = all_rank;
