var Images = require("common:widget/click-image-show/click-image-show.js");
var dace = require("common:widget/ui-dace/ui-dace.js");
var tapLink = require("common:widget/tap-link/tap-link.js");

var RecapData = {
  init: function(){
    this.render();
    this.bind();
  },
  render: function(){
    this.$content = $("#J-main");
    this.recapWrap = $(".recap-wrap");
  },
  bind: function(){
    var that = this;

    tapLink.init(that.recapWrap);

    Images.renderGifs(that.$content, GM.nopic, GM.night, "news");

    that.recapWrap.find(".comments hr").remove();
    that.recapWrap.find(".comments *").each(function(){
      if($(this).attr("face")){
        $(this).attr("face", "");
      }
      if($(this).attr("size")){
        $(this).attr("size", "");
      }
      if($(this).attr("color")){
        $(this).attr("color", "");
      }
      if($(this).attr("style") && !$(this).hasClass("bbsface")){
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

  }
}

module.exports = RecapData
