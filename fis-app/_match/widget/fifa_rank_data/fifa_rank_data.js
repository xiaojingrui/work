var tapLink = require("common:widget/tap-link/tap-link.js");

var fifa_rank_data = {
    init: function() {
        this.render();
        this.bind();
    },

    render: function() {
        this.modRankContainer = $("#J-mod-rank-wrap");
        this.tabContainer = $("#J-tab");

        this.iWidth = this.tabContainer.width();
        this.iHeight = $(window).height();

        this.tabArray = ["world", "asia"];

        $("body").css("height", this.iHeight);
        $(".mod-rank").css("height", this.iHeight - 40);
        $(".no-data").css("line-height", (this.iHeight - 40)+"px");
    },

    bind: function() {
        var self = this;

        tapLink.init(self.modRankContainer);

        var mySwiper = new Swiper('.swiper-container', {
            autoHeight: true,
            noSwiping: true,
            effect: "fade",
            onSlideChangeStart: function(swiper) {
                self.tabContainer.find("li").eq(mySwiper.activeIndex)
                    .addClass(
                        "active").siblings("li").removeClass(
                        "active");
            }
        });

        // tab切换
		for (var i = 0; i < self.tabArray.length; i++) {
			tabClick(self.tabArray[i], i);
		}

		function tabClick(selector, index) {
			self.tabContainer.find(".tab-" + selector).on("click", function() {
                mySwiper.slideTo(index, 500, false);
                $(".swiper-slide").hide();
				$("#J-" + selector).show();
				$(this).addClass("active").siblings("li").removeClass("active");
                self.mainScroll(self.modRankContainer.find("."+selector));
			});
		}

        self.mainScroll(self.modRankContainer.find(".world"));
    },

    mainScroll: function(obj) {
        var self = this;
        var scrollTop = null;
        var picLen = obj.find(".lazy").length;
        var timer = null;

        lazyload();
        obj.on("scroll", function() {
            clearTimeout(timer);
            scrollTop = $(this).scrollTop();

            timer = setTimeout(function() {
                lazyload();
            }, 200);
        });

        function lazyload() {
            for (var i = 0; i < picLen; i++) {
                if (obj.find(".lazy").eq(i).offset().top > 43 && obj.find(
                        ".lazy").eq(
                        i).offset().top < self.iHeight) {
                    obj.find(".lazy").eq(i).attr("src", obj.find(
                        ".lazy").eq(i).attr(
                        "data-original"));
                }
            }
        }
    }
};

module.exports = fifa_rank_data;
