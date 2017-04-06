/**
 * 工具库
 * @type {Object}
 */
var app = require("common:widget/ui-app/ui-app.js");
var Util = {
    elementStyle: document.createElement('div').style,
    // 判断浏览器内核类型
    vendor: function() {
        var vendors = ['t', 'webkitT', 'MozT', 'msT', 'OT'],
            transform,
            i = 0,
            l = vendors.length;

        for (; i < l; i++) {
            transform = vendors[i] + 'ransform';
            if (transform in Util.elementStyle) {
                return vendors[i].substr(0, vendors[i].length - 1);
            }
        }

        return false;
    },
    // 判断浏览器来适配css属性值
    prefixStyle: function(style) {
        if (Util.vendor() === false) return false;
        if (Util.vendor() === '') return style;

        return Util.vendor() + style.charAt(0).toUpperCase() + style.substr(1);
    },
    // 判断是否支持css transform-3d（需要测试下面属性支持）
    hasPerspective: function() {
        var ret = Util.prefixStyle('perspective') in Util.elementStyle;
        if (ret && 'webkitPerspective' in Util.elementStyle) {
            Util.injectStyles('@media (transform-3d),(-webkit-transform-3d){#modernizr{left:9px;position:absolute;height:3px;}}', function(node, rule) {
                ret = node.offsetLeft === 9 && node.offsetHeight === 3;
            });
        }
        return !!ret;
    },
    translateZ: function() {
        if (Util.hasPerspective) {
            return ' translateZ(0)';
        } else {
            return '';
        }
    },
    ImgMockGET : function(url){
        var img = new Image();
        img.onload = img.onerror = function(){
            img.onload = img.onerror = null;
            img = null;
        }
        img.src = url;
    },
    //截断字符长度，GET请求长度有最大限制
    cutText : function(content){
        var result = content;
        result = result.replace(/&nbsp;/g," ");
        if(app.isIOS){
            var maxlen = 300;
            //过滤*字符，IOS中 unescape无法解析
            result = result.replace(/\*/g, '');
            result = result.length > maxlen ? (result.substr(0, maxlen) + "...") : result;
        }
        return result;
    },
    //替换Dom节点
    replaceNode : function(node, newNode){
        if(node.parentNode){
            node.parentNode.replaceChild(newNode, node);
        }
    }
}

module.exports = Util;
