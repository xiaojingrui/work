/**
 * @file 页面工具栏
 * @authoer xiongwengang@hupu.com
 **/

"use strict";

var weixinTool = {
	init: function(wrap){
        var that = this;

        this.$wrap = $(wrap);

        if(!this.$wrap.length && !this.$wrap.find('img').length){
            return;
        }

        this.$img = this.$wrap.find('img');
        this.aIMG = [];

        // 获取内容全部图片
        this.$img.each(function(){
            var picSrc = '';
            if($(this).parent("a.bbs-link").size()){
                picSrc = $(this).parent("a.bbs-link").attr("href");
            } else{
                picSrc = $(this).attr('src');
            }
            // 排除gif,微信不能播放
            if(that.isGIF(picSrc)){
                return;
            }

            that.aIMG.push(picSrc);
        });


        if(!this.aIMG.length){
            return;
        }

        this.bind();

	},
    bind: function(){
        var that = this;
        var nowImgurl = '';

        this.$wrap.on("click", "img", function() {
            nowImgurl = $(this).attr("src");

            if(that.isGIF(nowImgurl)){
                return;
            }

            event.preventDefault();

            that.getPicInfo(nowImgurl);
        });
    },
    getPicInfo: function(nowImgurl){
        var that = this;
        if(WeixinJSBridge){
            try {
                WeixinJSBridge.invoke("imagePreview", {
                    "urls": that.aIMG,
                    "current": nowImgurl
                });
            } catch (e) {}
        }

    },
    isGIF: function(str) {
        return /.gif$/.test(str)
    }
};

module.exports = {
	init: function(wrap){
        var ua = navigator.userAgent.toLowerCase();
        // 微信打开
        if(ua.match(/MicroMessenger/i) == "micromessenger"){
            weixinTool.init(wrap);
        }
	}
}