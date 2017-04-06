import * as app from './app'
import _ from 'underscore'
import $ from './zepto'

//判断是否支持localStorage
export const isSupportLocalStorage = ('localStorage' in window)
//获取div的style
export const elementStyle = document.createElement('div').style
//history是否支持pushState
export const isSuportPushState = !!(history && history.pushState)

/**
 * 监听CSS3动画执行结束
 * @param callback
 * @returns {$.fn}
 */
$.fn.cssEnd = function ( callback ){
    var EventAnimateEnd = 'webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend';
    this.one(EventAnimateEnd , callback);
    return this
}

//获取当前毫秒数
export function getTime(){
    return Date.now ? Date.now() : Date.valueOf()
}

//截取数组
export function arraySlice(arr, start = 0, end){
 return arr instanceof Array ? arr.slice(start, end) : arr
}

//收拢alert接口
export function toast(msg){
    //IOS上不弹出
    if(app.isAndroid){
    //    alert(msg);
    }
}

//获取字体大小
export function getFontSize( ft = 18 ){
    const list = [14, 16, 18, 20, 22];
    let fontSize = 18;
    list.forEach(item => {
        if(item === parseInt(ft, 10)){
            fontSize = item
        }
    })
    return fontSize
}

export function exitExam(){
    app.send("hupu.ui.pageclose")
}

/**
 * 提示数字 +1
 * @param elem
 * @param text
 */
export function count(elem, text, pos = "right") {
    var $elem = $(elem),
        offset = {
            top: Math.floor($elem.offset().top - 15)
        };
    if(pos && pos == "right"){
        offset.right = 30;
    } else{
        offset.left = Math.floor($elem.offset().left + 30);
    }

    var $tip = $("#J_tipCount");

    if (!$tip.length) {
        var tpl = '<div id="J_tipCount" class="m-tip-count">'+ text +'</div>';
        $("body").append(tpl);
        $tip = $("#J_tipCount");
    }else{
        $tip.html(text);
    }

    $tip
        .show()
        .css(offset)
        .addClass('transform-tip-count')
        .cssEnd(function() {
            $(this)
                .removeClass('transform-tip-count')
                .hide();
        });
}

// 判断浏览器内核类型
export function vendor() {
       var vendors = ['t', 'webkitT', 'MozT', 'msT', 'OT'],
           transform,
           i = 0,
           l = vendors.length;

       for (; i < l; i++) {
           transform = vendors[i] + 'ransform';
           if (transform in elementStyle) {
               return vendors[i].substr(0, vendors[i].length - 1);
           }
       }

       return false;
}

// 判断浏览器来适配css属性值
export function prefixStyle(style) {
       if (vendor() === false) return false;
       if (vendor() === '') return style;

       return vendor() + style.charAt(0).toUpperCase() + style.substr(1);
}

// 判断是否支持css transform-3d（需要测试下面属性支持）
export function hasPerspective() {
       var ret = prefixStyle('perspective') in elementStyle;
       if (ret && 'webkitPerspective' in elementStyle) {
           injectStyles('@media (transform-3d),(-webkit-transform-3d){#modernizr{left:9px;position:absolute;height:3px;}}', function(node, rule) {
               ret = node.offsetLeft === 9 && node.offsetHeight === 3;
           });
       }
       return !!ret;
}

// 页面插入样式
export function injectStyles(rule) {
	  var div = $('<div />', {
	    html : '&shy;<style>' + rule + '</style>'
	  }).appendTo('body')
}

// translateZ
export function translateZ() {
       if (hasPerspective()) {
           return ' translateZ(0)';
       } else {
           return '';
       }
}

//图片mock请求
export function ImgMockGET(url){
       var img = new Image();
       img.onload = img.onerror = function(){
           img.onload = img.onerror = null;
           img = null;
       }
       img.src = url
}

//替换Dom节点
export function replaceNode(node, newNode){
   if(node.parentNode){
       node.parentNode.replaceChild(newNode, node);
   }
}
