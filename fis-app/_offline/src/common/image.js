import _ from 'underscore'
import $ from 'common/zepto'
import { getInfo, createAlbum } from './app'
import emoji from './emoji'

// 无图模式默认图
export const noPic = {
    day : "https://b10.hoopchina.com.cn/games/images/news_nopic_day@2x.png",
    night: "https://w10.hoopchina.com.cn/games/images/bbs-night-nopic.png",
    gif_day: "https://w10.hoopchina.com.cn/hybrid/resource/img/news_gif_nopic_2x_day.png",
    gif_night: "https://w10.hoopchina.com.cn/hybrid/resource/img/news_gif_nopic_2x_night.png",
    person: "https://w10.hoopchina.com.cn/hybrid/resource/avatar/man.png"
};

//图片mock请求
export function getmock(url){
    let img = new Image();
    img.onload = img.onerror = function(){
        img.onload = img.onerror = null;
        img = null;
    }
    img.src = url;
}

// 错图
export const errorImgs = {
    day: "https://w10.hoopchina.com.cn/hybrid/resource/img/n_err_day.png",
    night: "https://w10.hoopchina.com.cn/hybrid/resource/img/n_err_night.png"
};
/**
 * 是否支持webp
 * @param  {Function} cb [description]
 */
export function supportWebp( callback ){
    let base64Src = "UklGRiIAAABXRUJQVlA4IBYAAAAwAQCdASoBAAEADsD+JaQAA3AAAAAA";
    let img = new Image();
    img.onload = function () {
        let result = (img.width > 0) && (img.height > 0);
        callback(result);
    };
    img.onerror = function () {
        callback(false);
    };
    img.src = "data:image/webp;base64," + base64Src;
}


/**
 * 从URL中获得图片大小
 * @param  {string} url = "" 图片的url
 * @return {string} 图片大小
 */
export function getPicFileSize(url = ""){
    let size = 0;
    if(!url || !_.isString(url)) return size

    let reWeight = /s_(\d+)_o/;
    if(reWeight.test(url)){
        //url中的图片大小以字节为单位，先转换成K
        size = Math.round(+url.match(reWeight)[1] / 1024);

        //大于1M的显示 如1.2M
        if(size >= 1000){
            size = (size / 1024).toFixed(1) + "MB";
        //小于1M的显示 如600K
        } else{
            size += "KB";
        }
    }
    return size
}

/**
 * 从gif的url中获得图片宽高
 * @param  {string} url = "" 图片的url
 * @return {object} 图片大小
 */
export function getPicSize(url = "") {
  let reSize = /(\d+)_(\d+)\.gif$/i;
  let matchSize = _.isString(url) && url.length ? url.match(reSize) : [];
  let size = {
    w: 0,
    h: 0
  }

  if (_.isArray(matchSize) && matchSize.length === 3) {
    size.w = parseInt(matchSize[1], 10);
    size.h = parseInt(matchSize[2], 10);
  }
  //给加载的GIF图大小加上最大阈值
  if (size.h > 10000 || size.w > 10000) {
    size.w = 0;
    size.h = 0;
  }
  return size
}


/**
 * 替换白天和页面模式中的图片
 */
export function replaceImageWithMode(picSrc, nightMode = 0){
    if(!picSrc) return ""
    let newPicSrc = picSrc;

    if(nightMode){
        if(~picSrc.indexOf("news_nopic_day@2x.png")){
            newPicSrc = noPic.night
        }
        if(~picSrc.indexOf("n_err_day.png")){
            newPicSrc = errorImgs.night
        }
        if(~picSrc.indexOf("news_gif_nopic_2x_day.png")){
            newPicSrc = noPic.gif_night
        }
    } else{
        if(~picSrc.indexOf("news_nopic_night@2x.png") || ~picSrc.indexOf("bbs-night-nopic.png")){
            newPicSrc = noPic.day
        }
        if(~picSrc.indexOf("n_err_night.png")){
            newPicSrc = errorImgs.day
        }
        if(~picSrc.indexOf("news_gif_nopic_2x_night.png")){
            newPicSrc = noPic.gif_day
        }
    }
    return newPicSrc
}

/**
 * 图片加载失败，替换成默认图
 */
export function placeholderImages( imgs = [] ){
    if(!_.isArray(imgs)) return
    let night = getInfo().night

    imgs.forEach(img => {
        let oldClassName = img.className;
        let isAvatar = ~img.className.indexOf("J-user-avatar-img");
        let defaultErrimg = night ? errorImgs.night : errorImgs.day;
        if (isAvatar) {
            defaultErrimg = errorImgs.person;
        }
        img.onerror = function() {
          let errimg = document.createElement("img");
          errimg.src = defaultErrimg;
          errimg.className = isAvatar ? oldClassName : (oldClassName +" onerror-img");
          //使用新标签替换旧的图片
          img.parentNode.replaceChild(errimg, img);
        }
    })
}

/**
 * 图片根据宽度自适应
 * @param  {number} maxW 最大宽度
 * @param  {number} w  当前宽度
 * @param  {number} h  当前高度
 * @return {object}
 */
export function resizeWidthAndHeight(maxW, w, h) {
  let ratio = 1,
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

/**
 * 更新容器内的gif图大小
 * @param  {element} container
 * @return void
 */
export function updateGifSize( container ){
    if(!_.isElement(container)) return

    let clientWidth = document.documentElement.clientWidth

    let gifs = $(container).find(".lazy-gif img");
    let imgs = $(container).find("img").not(".emoji");
    let containerId = container.getAttribute("id");

    placeholderImages(imgs);

    //计算图片所在容器的最大宽度
    var maxWidth = 0;
    switch (containerId) {
      //正文图片
      case "J-page-container":
        maxWidth = clientWidth - 20;
        break;
        //评论图片
      default:
        maxWidth = container.querySelector(".current-content").offsetWidth - 24;
        break;
    }
    if (maxWidth <= 0) {
      maxWidth = clientWidth - 60;
    }

    $(gifs).each((idx, gif) => {
      let out = getPicSize( gif.getAttribute("data-gif") );
      //图片可能未load, 从URL中获得图片大小.
      if (out.w > 0 && out.h > 0) {
        out = resizeWidthAndHeight(maxWidth, out.w, out.h);
        $(gif).parents(".lazy-gif").css({
          "width": out.w,
          "height": out.h
        });
      } else {
        gif.addEventListener("load", () => {
            if(gif.getAttribute("data-src")) return;
            out.w = this.width;
            out.h = this.height;
            out = resizeWidthAndHeight(maxWidth, out.w, out.h);
            $(gif).parents(".lazy-gif").css({
              "width": out.w,
              "height": out.h
            });
        })
        //已经加载的图片
        if(gif.complete){
            $(gif).parents(".lazy-gif").css({
              "width": gif.width,
              "height": gif.height
            });
        }
      }
    });
}

/**
 * 点击容器创建图集
 */
 export function handleCreateAlbum(target, oriImages) {
     let index = 0,
       images = [],
       _tmpIdx = 0,
       targetDataSrc = target.getAttribute("data-src");

    oriImages.forEach(img => {
       // 兼容GIF图片的图集显示.
       let preLoadUrl = img.getAttribute("data_url") || img.getAttribute("data-url") || img.getAttribute("src");
       if(preLoadUrl){
           /*
            * 图片有@600w_1l_60q和@600w_1l_60q.webp的时候替换为800w_1l
            * 有?x-oss-process的时候去掉?后的字符
            */
           if(!img.getAttribute("data_url") && !img.getAttribute("data-url")){
               let n = preLoadUrl.indexOf("?x-oss-process");
               if(n != -1){
                 preLoadUrl = preLoadUrl.substr(0, n);
               }
           }
        //    if(preLoadUrl.indexOf("@600w_1l_60q") != -1 || preLoadUrl.indexOf("@600w_1l_60q.webp") != -1){
        //      let imgChange = preLoadUrl.substring(0,n+1);
        //      preLoadUrl = imgChange+"800w_1l";
        //    }
           //图片没有http
           if(!(/^(http|https)/i.test(preLoadUrl))){
               preLoadUrl = "http:" + preLoadUrl;
           }

           let realSrc = img.getAttribute("data-origin");
           let size = getPicFileSize(realSrc);
           if (target.src === img.src || (targetDataSrc && targetDataSrc ===
               preLoadUrl)) {
             index = _tmpIdx;
           }
           //查看图片，展示查看原图. 需要原图地址 & 大小
           if(realSrc && size){
               images.push({
                 url: preLoadUrl.trim(),
                 originSrc: realSrc.trim(),
                 originSize: size,
                 index: _tmpIdx
               });
           } else{
               images.push({
                 url: preLoadUrl.trim(),
                 index: _tmpIdx
               });
           }
           _tmpIdx++;
       }
     });

     createAlbum("", index, images)
 }

/**
 * 渲染新闻中的gif
 * @param  {element} $container [description]
 * @param  {number} nopic      [description]
 * @param  {number} night      [description]
 * @param  {[type]} from       [description]
 * @return {[type]}            [description]
 */
export function renderGifs($container, from = "news") {
    let $imgs = $container.find("img").not(".emoji").not(".J-user-avatar-img");
    if(!$imgs.size()) return;

    let na = getInfo()
    let isNopic = !!na.nopic
    let isNight = !!na.night
    let className = isNight ? 'icon_night' : 'icon_day';

    //因为新闻和论坛的gif的格式不同，所以需要不同的处理方式.
    switch(from){
      //新闻GIF处理
      case "news":
        let loadStatus = isNopic ? 'first' : 'second';
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
  }

/**
 * 展示gif加载的loading
 */
export function showGifLoading($Gif){
    $Gif.siblings(".ball-clip-rotate").show();
    $Gif.on("load", function(){
        $Gif.siblings(".ball-clip-rotate").hide();
    });
}

/**
 * gif点击处理函数
 * @param  {element} target
 * @param  {number} nopic
 */
export function handlerClickGif( target ){
    let na = getInfo()
    let isNopic = !!na.nopic
    let $target = $(target);
    if(isNopic){
      if(target.getAttribute("secondclick")){
          let realSrc = target.getAttribute("data-gif");
          target.src = realSrc;
          $target.siblings(".gif_btn").hide();
          showGifLoading($target);
          target.removeAttribute("data-gif");
          target.removeAttribute("secondclick");
          target.setAttribute("alt", "gif");
      }else{
          $target.attr("secondclick", 1).siblings(".gif_btn").show();
      }
    } else{
      let realSrc = target.getAttribute("data-gif");
      target.src = realSrc;
      $target.siblings(".gif_btn").hide();
      showGifLoading($target);
      target.removeAttribute("data-gif");
      target.setAttribute("alt", "gif");
    }
 }


 /*
  * PC的默认表情
  */
export function isSmile(url){
     return !!url.match(/b[1-9]\.hoopchina\.com\.cn\/post\/smile/i)
}

 /*
  * 夜间模式 or 日间模式
  * 过滤内容中的表情图片
  * 默认图
  */
export function filterSmile(content){
    let nightMode = getInfo().night
    let nopicMode = getInfo().nopic

    if($.type(content) === "string"){
        content = emoji.trans(content);
        if(nopicMode){
            let defaultPic = nightMode ? noPic.night: noPic.day;
            let match = /<img[^<>]*?src=\"[^<>]*?>/gi;
            let result = content.replace(match, function(img){
                let srcs = img.match(/src=[\"\']([^\"]*?)[\"\']/gi);
                let src = srcs && srcs.length ? srcs[0] : "";
                let res = img;
                if(src && !isSmile(src) ){
                    src = src.substr(5, src.length-6);
                    res = img.replace(src, defaultPic);
                    res = res.replace(/<img/gi, "<img data-src='"+ src +"'");
                }
                return res
            });
            return result
        } else{
            return content
        }
    } else{
        return "";
    }
}

export function imgResizeByMaxWidth( $img, max, opt){
  let { realHeight, realWidth, originWidth, originHeight } = opt
  let width = originWidth,
      height = originHeight;

  //判断图片大小是否超出最大宽度
  if(originWidth > max) {
      width = max
      height = max * originHeight / originWidth;
  }
  if(width > 0 && height > 0){
      $img.css({"width": width, "height": height});

      //针对gif
      if($img.size() && $img[0].getAttribute("data-gif")) {
          $img.parents(".lazy-gif").css({
            "width": width,
            "height": height
          });
      }
  }
}

//论坛图片宽高自适应
export function imgResize(gif){
  let $gif = _.isElement(gif) ? $(gif) : gif;
  let realHeight = $gif.height();
  let realWidth  = $gif.width() || 0;
  let originWidth  = parseInt($gif.attr("data-w"), 10) || 0;
  let originHeight = parseInt($gif.attr("data-h"), 10) || 0;

  if(originHeight > 0 && originWidth > 0) {
      let opt = {
        realHeight,
        realWidth,
        originWidth,
        originHeight
      }
      //主贴
      if($gif.closest(".J-article-content").size()){
          let contentWidth = document.body.clientWidth - 20;
          imgResizeByMaxWidth($gif, contentWidth, opt)
      }
      //引用评论
      if($gif.closest(".short-quote-content").size()) {
          //引用内容中的图片部分
          let contentWidth = $gif.closest(".short-quote-content").width() - 16;
          //判断图片大小是否超出引用容器宽度
          imgResizeByMaxWidth($gif, contentWidth, opt)
      }
      //自己评论
      if($gif.closest(".J_contentParent").size()) {
          let contentWidth = $gif.closest(".J_contentParent").width();
          //判断图片大小是否超出评论容器宽度
          imgResizeByMaxWidth($gif, contentWidth, opt)
      }
  }
}
