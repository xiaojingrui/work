/**
 *  @name 图片相关
 *  @description 图片相关操作
 **/
var _ = require("underscore");
var dace = require("common:widget/ui-dace/ui-dace.js");
var errorImgs = {
    day: "//w10.hoopchina.com.cn/hybrid/resource/img/n_err_day.png",
    night: "//w10.hoopchina.com.cn/hybrid/resource/img/n_err_night.png",
    person: "//w10.hoopchina.com.cn/hybrid/resource/avatar/man.png"
  }
  //图片自动缩放
function resizeWidthAndHeight(maxW, w, h) {
  var ratio = 1,
    realWidth = 0,
    realHeight = 0;
  if (w >= maxW) {
    ratio = maxW / w;
    realWidth = maxW;
    realHeight = ratio * h;
  } else {
    realWidth = w;
    realHeight = h;
  }

  return {
    w: realWidth,
    h: realHeight
  }
};

//通过图片src得到图片大小.
function getImgSize(url) {
  var reSize = /(\d+)_(\d+)\.gif$/i;
  var matchSize = _.isString(url) && url.length ? url.match(reSize) : [];
  var out = {
    w: 0,
    h: 0
  };
  if (_.isArray(matchSize) && matchSize.length === 3) {
    out.w = parseInt(matchSize[1], 10);
    out.h = parseInt(matchSize[2], 10);
  }
  //给加载的GIF图大小加上最大阈值
  if (out.h > 10000 || out.w > 10000) {
    out.w = 0;
    out.h = 0;
  }
  return out;
}

var Images = {
  //更新gif图
  updateGifSize: function(container) {
    var gifs = $(container).find(".lazy-gif img");
    var imgs = $(container).find("img").not(".emoji");
    var containerId = $(container).attr("id");

    this.listenImagesReplaceErr(imgs);

    //计算图片所在容器的最大宽度
    var maxWidth = 0;
    switch (containerId) {
      //正文图片
      case "J-page-container":
        maxWidth = $(window).width() - 20;
        break;
        //评论图片
      default:
        maxWidth = container.find(".current-content").eq(0).width() - 24;
        break;
    }
    if (maxWidth <= 0) {
      maxWidth = $(window).width() - 60;
    }
    $(gifs).each(function(idx, gif) {
      var out = getImgSize( gif.getAttribute("data-gif") );
      //图片可能未load, 从URL中获得图片大小.
      if (out.w > 0 && out.h > 0) {
        out = resizeWidthAndHeight(maxWidth, out.w, out.h);
        $(gif).parents(".lazy-gif").css({
          "width": out.w,
          "height": out.h
        });
      } else {
        $(gif).on("load", function() {
          if(gif.getAttribute("data-src")) return;
          out.w = this.width;
          out.h = this.height;
          out = resizeWidthAndHeight(maxWidth, out.w, out.h);
          $(gif).parents(".lazy-gif").css({
            "width": out.w,
            "height": out.h
          });
        });
        //已经加载的图片
        if(gif.complete){
          $(gif).parents(".lazy-gif").css({
            "width": gif.width,
            "height": gif.height
          });
        }
      }
    });
  },
  //图片加载失败，自动替换成默认图
  listenImagesReplaceErr: function(imgs) {
    $(imgs).each(function(idx, img) {
      var oldClassName = img.className;
      var isAvatar = ~img.className.indexOf("J-user-avatar-img");
      var defaultErrimg = (GM && GM.night) ? errorImgs.night :
        errorImgs.day;
      if (isAvatar) {
        defaultErrimg = errorImgs.person;
      }
      img.onerror = function() {
        var errimg = document.createElement("img");
        errimg.src = defaultErrimg;
        errimg.className = isAvatar ? oldClassName : (oldClassName +
          " onerror-img");
        //使用新标签替换旧的图片
        img.parentNode.replaceChild(errimg, img);
      }
    });
  },
  getPicSize: function(url){
      var ret = 0;
      if(!url || !_.isString(url)) return ret
      var reSize = /s_(\d+)_o/;
      if(reSize.test(url)){
          //url中的图片大小以字节为单位，先转换成K
          ret = Math.round(+url.match(reSize)[1] / 1024);

          //大于1M的显示 如1.2M
          if(ret >= 1000){
              ret = (ret / 1024).toFixed(1) + "MB";
          //小于1M的显示 如600K
          } else{
              ret += "KB";
          }
      }
      return ret
  },
  //创建图集
  createAlbum: function(target, oriImages) {
    var index = 0,
      images = [],
      _tmpIdx = 0,
      self = this,
      targetDataSrc = target.getAttribute("data-src");

    _.each(oriImages, function(img) {
      // 兼容GIF图片的图集显示.
      var preLoadUrl = img.getAttribute("data-gif") || img.getAttribute("data_url") || img.getAttribute(
        "data-src") || img.getAttribute("src");
      /*
        *图片有@600w_1l_60q和@600w_1l_60q.webp的时候替换为800w_1l
        * 有gif@的时候去掉@后的字符
       */
      var n = preLoadUrl.indexOf("@");
      if(preLoadUrl.indexOf("gif@") != -1){
        preLoadUrl = preLoadUrl.substring(0,n);
      }
      if(preLoadUrl.indexOf("@600w_1l_60q") != -1 || preLoadUrl.indexOf("@600w_1l_60q.webp") != -1){
        var imgChange = preLoadUrl.substring(0,n+1);
        preLoadUrl = imgChange+"800w_1l";
      }
      //图片没有http
      if(!(/^(http|https)/i.test(preLoadUrl))){
          preLoadUrl = location.protocol + preLoadUrl;
      }

      var realSrc = img.getAttribute("data-origin");
      var size = self.getPicSize(realSrc);
      if (target.src === img.src || (targetDataSrc && targetDataSrc ===
          preLoadUrl)) {
        index = _tmpIdx;
      }
      //查看图片，展示查看原图. 需要原图地址 & 大小
      if(realSrc && size){
          images.push({
            url: $.trim(preLoadUrl),
            originSrc: $.trim(realSrc),
            originSize: size,
            index: _tmpIdx
          });
      } else{
          images.push({
            url: $.trim(preLoadUrl),
            index: _tmpIdx
          });
      }
      _tmpIdx++;
    });

    HupuBridge.send("hupu.album.view", {
      title: "",
      index: index,
     images: images
    });
  },
  renderGifs: function($container, nopic, night, from){
    var $imgs = $container.find("img");
    if(!$imgs.size()) return;

    var isNopic = _.isUndefined(nopic) ? (_.isUndefined(GM.nopic) ? false : GM.nopic) : nopic;
    var isNight = _.isUndefined(night) ? (_.isUndefined(GM.night) ? false : GM.night) : night;
    var className = isNight ? 'icon_night' : 'icon_day';

    //因为新闻和论坛的gif的格式不同，所以需要不同的处理方式.
    switch(from){
      //新闻GIF处理
      case "news":
        var loadStatus = isNopic ? 'first' : 'second';
        $imgs.each(function(){
          var $target = $(this);
          //如果图片alt中包含GIF关键词, 则处理该图片.
          if(~$target.attr("alt").indexOf("GIF")){
              $target.wrap("<div class='gif-pic'></div>");
              var html = [
                "<span class='gif_btn' data-load='", loadStatus ,"' dace-node='gif_firstclick'>",
                  $target.attr("alt"),
                  "<i class=", className ,"></i>",
                "</span>",
                "<div class='ball-clip-rotate' style='display:none;'><div></div></div>"
              ].join("");
              $target.after(html);

              if(this.complete){
                 $target.next().show();
              } else{
                $target.on("load", function(){
                    $target.next().show();
                    $target.off("load");
                });
              }
          }
        });

        //穿透图片上的 GIF 播放按钮.
        $container.delegate(".gif_btn", "click", function(e){
            $(this).hide().prev().attr("secondclick", 1).trigger("click");
        });
        break;
       //论坛GIF处理方式
       case "bbs":
         $imgs.each(function(){
           var $target = $(this);
           //如果图片包含data-gif属性.
           if(this.getAttribute("data-gif")){
               $target.attr("secondclick", 1);
               $target.wrap("<div class='gif-pic'></div>");
               var html = "<div class='ball-clip-rotate' style='display:none;'><div></div></div>";
               $target.after(html);
           }
         });
        break;
      }
  },
  //展示GIF图片的 loading 效果.
  showGifLoading: function($Gif){
    $Gif.siblings(".ball-clip-rotate").show();
    $Gif.on("load", function(){
        $Gif.siblings(".ball-clip-rotate").hide();
    });
  },
  //点击包含data-gif图片的处理.
  handlerClickGif: function( target, nopic ){
    var isNopic = _.isUndefined(nopic) ? (_.isUndefined(GM.nopic) ? false : GM.nopic) : nopic;
    var $target = $(target);
    if(isNopic){
      if(target.getAttribute("secondclick")){
          realSrc = target.getAttribute("data-gif");
          target.src = realSrc;
          $target.siblings(".gif_btn").hide();
          this.showGifLoading($target);
          target.removeAttribute("data-gif");
          target.removeAttribute("secondclick");
          target.setAttribute("alt", "gif");
      }else{
          $target.attr("secondclick", 1).siblings(".gif_btn").show();
      }
    } else{
      var realSrc = target.getAttribute("data-gif");
      target.src = realSrc;
      $target.siblings(".gif_btn").hide();
      this.showGifLoading($target);
      target.removeAttribute("data-gif");
      target.setAttribute("alt", "gif");
    }
  }
};

module.exports = Images;
