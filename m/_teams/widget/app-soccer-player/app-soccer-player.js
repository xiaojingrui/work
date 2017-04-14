var version = require("common:widget/ui-versions/ui-versions.js");
var dace = require("common:widget/ui-dace/ui-dace.js");
var _ = require("underscore");
var webp = 0;

(function(){
    var base64Src = "UklGRiIAAABXRUJQVlA4IBYAAAAwAQCdASoBAAEADsD+JaQAA3AAAAAA";
    var img = new Image();
    img.onload = function () {
        var result = (img.width > 0) && (img.height > 0);
        webp = result ? 1 : 0
    };
    img.onerror = function () {
        webp = 0
    };
    img.src = "data:image/webp;base64," + base64Src;
})();

var soccerPlayer = {

    init:function(){
        this.bind();
    },

    bind:function(){
        var newsContainer = $("#J-news-wrap");
        var tNewsContainer = $("#J-t-news");
        var tplNewsRender = _.template($("#J-news-tpl").html());
        var next_nid = null;
        var bGetNews = true;
        var title = null;

        minHeight(GM.isApp);

        if(GM.player_name || GM.player_enname){
            if(GM.player_name){
                title = GM.player_name;
            }else{
                title = GM.player_enname;
            }
        }else{
            title = "饮水机守护神";
        }

        if(version.gte(GM.version,"7.0.6")){
            initBridge(function(){
               HupuBridge.send("hupu.ui.header", {
                    title: title,
                    subtitle : GM.player_enname
               }, function(){});

                HupuBridge.send("hupu.share.setNative",{
                    imageUrl: "",
                    title: GM.player_name,
                    text: "详细资料、各项数据排名、新闻等",
                    linkUrl: GM.cur_url
                }, function(){});
            });
        }

        var $tabs = $('#J-tab'),
            $tabLi = $tabs.find('li');

        var mySwiper = new Swiper ('.swiper-container', {
            autoHeight: true,
            lazyLoading: true,
            preloadImages: false,
            resistanceRatio: 0,
            onSlideChangeStart: function(swiper){
                $tabLi.eq(mySwiper.activeIndex).addClass("active").siblings().removeClass("active");
                if(mySwiper.activeIndex == 3){
                    getNews("", "tab");
                }

                if(mySwiper.activeIndex == 0){
                    HupuBridge.send("hupu.ui.slidegesture", {
                        open : true
                    }, function(){});
                }else{
                    HupuBridge.send("hupu.ui.slidegesture", {
                        open : false
                    }, function(){});
                }
            }
        });

        $tabLi.on('click', function() {
            var index = $(this).index();
            if( index == 0 ){
                dace.send("profile");
            }else if( index == 1 ){
                dace.send("data");
            }else if( index == 3 ){
                getNews("", "tab");
            }

            if(index == 0){
                HupuBridge.send("hupu.ui.slidegesture", {
                    open : true
                }, function(){});
            }else{
                HupuBridge.send("hupu.ui.slidegesture", {
                    open : false
                }, function(){});
            }

            mySwiper.slideTo(index, 400, false);
            $(this).addClass('active').siblings().removeClass('active');
        });

        $(".data-list li>div").each(function() {
            if ($(this).hasClass("rank")) {
                $(".data-list li").css({
                    "max-height:": "auto",
                    "min-height": "58px"
                });
            }
        });

        $(".data-tab").find("span").on("click", function(){
            $(this).addClass("active").siblings("span").removeClass("active");
            $(this).parents(".data-list").find(".data-tab-content").eq($(this).index()).show().siblings("ul").hide();
        });

        // 滚动加载新闻
        var win = $(window);
        var doc= $("body");

        win.on("scroll", function(){
            if($(this).scrollTop() >= doc.height() - win.height() && next_nid && $("#J-tab").find("li:last-child").hasClass("active")){
                getNews(next_nid, "scroll");
            }
        });

        function initBridge(callback) {
            if(window.HupuBridge){
                callback();
            }else{
                document.addEventListener("hupuBridgeReady", function(){
                    callback();
                });
            }
        }

        function getNews(nid, type){
            if(bGetNews){
                $.ajax({
        			url: "/playernews",
        			type: "GET",
        			dataType: "json",
        			data: {
                        "player_name": GM.player_name,
        				"player_id": GM.player_id,
        				"client": GM.client,
        				"plat_id": GM.projectId,
                        "version": GM.version,
                        "type": GM.type,
                        "nid": nid,
                        "webp": webp
        			},
        			success: function(data) {
                        if(data.data){
                            if(type == "tab"){
                                newsContainer.html("");
                            }
                            newsContainer.append(tplNewsRender({datas: data.data}));
                            $(".swiper-wrapper").css("height", $(".swiper-news").find("li").length * 80);
                        }else{
                            if(!$(".swiper-news .no-data").html()){
                                tNewsContainer.append("<div class='no-data'>暂无该球员相关新闻</div>");
                            }
                        }
                        next_nid = data.next;
                        bGetNews = true;
        			}
        		});
            }

            bGetNews = false;
        }

        function minHeight(isApp) {
            var h = isApp ? 119 : 163;
            $(".swiper-wrapper, .swiper-news, .swiper-career, .swiper-data").css({
                "min-height": $(".iHeight").height() - h + "px"
            });
        }
    }
};
module.exports = soccerPlayer;
