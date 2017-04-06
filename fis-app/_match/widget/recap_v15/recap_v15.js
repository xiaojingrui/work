var Images = require("common:widget/click-image-show/click-image-show.js");
var dace = require("common:widget/ui-dace/ui-dace.js");
var rememberPos = require("match:widget/remember-pos/remember-pos.js");

var RecapData = {
    init: function() {
        this.render();
        this.bind();
    },
    render: function() {
        this.$content = $("#J-main");
        this.recapWrap = $(".recap-wrap");

        //记住阅读位置
        rememberPos.init(GM.lid + GM.gid);
    },
    bind: function() {
        var that = this;

        Images.renderGifs(that.$content, GM.nopic, GM.night, "news");

        that.recapWrap.find(".comments hr").remove();
        that.recapWrap.find(".comments *").each(function() {
            if ($(this).attr("face")) {
                $(this).attr("face", "");
            }
            if ($(this).attr("size")) {
                $(this).attr("size", "");
            }
            if ($(this).attr("color")) {
                $(this).attr("color", "");
            }
            if ($(this).attr("style") && !$(this).hasClass("bbsface")) {
                $(this).attr("style", "");
            }
        });

        // 图片点击
        that.$content.delegate("img", "click", function(e) {
            var currentTarget = e.currentTarget;
            var realSrc = null;

            if (currentTarget.getAttribute("data-src")) {
                realSrc = currentTarget.getAttribute("data-src");
                currentTarget.src = realSrc;
                currentTarget.removeAttribute("data-src");
            } else {
                if (!currentTarget.getAttribute("data-gif")) {
                    var imgs = that.$content.find("img");
                    Images.createAlbum(currentTarget, imgs);
                }
            }

            // gif二次点击统计
            if ($(this).attr("alt").indexOf("gif") != -1) {
                dace.send("gif_secondclick");
            }

            if (currentTarget.getAttribute("data-gif")) {
                Images.handlerClickGif(currentTarget, GM.nopic);
            }
        });

        if(!GM.nopic){
            // 图片加载完渲染
            var hotImg = $(".hot-pic img");
            var _img = hotImg.get(0);
            if(_img.complete){
                $(".hot-pic").show();
            }else{
                hotImg.on("load", function(){
                    $(".hot-pic").show();
                });
            }
        }

        $("body").css("height", $("html").height());
    }
};

module.exports = RecapData;
