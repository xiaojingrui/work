var _ = require("underscore");
var version = require("common:widget/ui-versions/ui-versions.js");
var refresh = require("common:widget/ui-refresh/ui-refresh.js");
//var tapLink = require("common:widget/tap-link/tap-link.js");
var webp = 0;

function initBridge(callback) {
    if (window.HupuBridge) {
        callback();
    } else {
        document.addEventListener("hupuBridgeReady", function() {
            callback();
        });
    }
}

(function() {
    var base64Src = "UklGRiIAAABXRUJQVlA4IBYAAAAwAQCdASoBAAEADsD+JaQAA3AAAAAA";
    var img = new Image();
    img.onload = function() {
        var result = (img.width > 0) && (img.height > 0);
        webp = result ? 1 : 0
    };
    img.onerror = function() {
        webp = 0
    };
    img.src = "data:image/webp;base64," + base64Src;
})();

var mySwiper;
var cbaPlayer = {
    init: function() {
        this.render();
        this.bind();
        //tapLink.init(".cba-player-wrap");
        //if(version.gte(GM.version,"7.0.6")){
        initBridge(function() {
            HupuBridge.send("hupu.ui.header", {
                title: GM.player_name,
                subtitle: GM.player_enname
            }, function() {});
        });
        //}
    },

    render: function() {
        this.newsContainer = $("#J-news-wrap");
        this.next_nid = null;
        this.tplNewsRender = _.template($("#J-news-tpl").html());
        this.isOver = true;
    },
    bind: function() {
        var self = this;
        $(".main li>div").each(function() {
            if ($(this).hasClass("rank")) {
                $(".main li").css({
                    "max-height:": "auto",
                    "min-height": "68px"
                });
            }
        });

        //适应高度不足右滑的时候底部不对齐
        var win = $(window).height() - 110 + "px";
        $(".slideWrap").css("min-height", win)

        $("#J-tab").find("li").on("click", function() {
            var index = $(this).index();
            $(this).addClass("active").siblings("li").removeClass("active");
            //$(".swiper-slide").eq(index).show().siblings(".swiper-slide").hide();
            if (index == 1) {
                self.getNews("", "tab");
                self.initScroll();
            }

            if (index == 0) {
                HupuBridge.send("hupu.ui.slidegesture", {
                    open: true
                }, function() {});
            } else {
                HupuBridge.send("hupu.ui.slidegesture", {
                    open: false
                }, function() {});
            }

            mySwiper.slideTo(index, 400, false);
        });

        //tab滑动切换
        mySwiper = new Swiper('.swiper-container', {
            autoHeight: true,
            lazyLoading: true,
            preloadImages: false,
            resistanceRatio: 0,
            onSlideChangeStart: function(swiper) {
                $("#J-tab").find('li').eq(mySwiper.activeIndex).addClass("active").siblings().removeClass("active");

                if (mySwiper.activeIndex == 0) {
                    HupuBridge.send("hupu.ui.slidegesture", {
                        open: true
                    }, function() {});
                } else {
                    HupuBridge.send("hupu.ui.slidegesture", {
                        open: false
                    }, function() {});
                }

                if (mySwiper.activeIndex == 1) {
                    self.getNews("", "tab");
                    self.initScroll();
                }
            }
        });
        // 滚动加载新闻
        var win = $(window);
        var doc = $("body");

        // win.on("scroll", function(){
        //     if($(this).scrollTop() >= doc.height() - win.height() && self.next_nid && $("#J-tab").find("li:last-child").hasClass("active")){
        //         self.getNews(self.next_nid, "scroll");
        //     }
        // });
    },
    initScroll: function() {
        var self = this;
        refresher = refresh({
            contentEl: '#J-t-news',
            isRefresh: false,
            isLoadingMore: true,
            loadingMoreCallback: function(callback) {
                if (self.isOver) {
                    self.getNews(self.next_nid, "scroll");
                } else {
                    $(".preloader-loading-more").hide();
                }
            }
        });
    },
    getNews: function(nid, type) {
        var self = this;
        $.ajax({
            url: "/news/playerNewsList",
            type: "GET",
            dataType: "json",
            data: {
                "player_id": GM.player_id,
                "client": GM.client,
                "version": GM.version,
                "player_name": GM.player_name,
                "nid": nid,
                "webp": webp
            },
            success: function(data) {
                if (data.result.data.length) {
                    if (type == "tab") {
                        self.newsContainer.html("");
                    }
                    self.newsContainer.append(self.tplNewsRender({
                        datas: data.result.data
                    }));
                    $(".swiper-wrapper").css("height", $(".t-news").find("li").length * 80);
                } else {
                    if (self.newsContainer.html("")) {
                        $(".no-news").css("display", "table");
                        $(".swiper-container-autoheight").css("height", "100%");
                    }
                    //noNewsStyle(GM.isApp);
                }
                if (!data.result.nextDataExists) {
                    self.isOver = false;
                    $(".preloader-loading-more").hide();
                }
                //alert(data.result.nextDataExists)
                if (data.result.nextDataExists) {
                    self.next_nid = data.result.data[data.result.data.length - 1].nid;
                } else {
                    self.next_nid = null;
                }
            }
        })
    }
}

module.exports = cbaPlayer;
