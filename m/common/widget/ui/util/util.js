/**
 * @file 公用的工具函数
 */
"use strict";

var Util = {
	elementStyle: document.createElement('div').style,
    // 判断浏览器内核类型
    vendor: function() {
        var vendors = ['t', 'webkitT', 'MozT', 'msT', 'OT'],
            transform,
            i = 0,
            l = vendors.length;

        for ( ; i < l; i++ ) {
            transform = vendors[i] + 'ransform';
            if ( transform in Util.elementStyle ) {
                return vendors[i].substr(0, vendors[i].length-1);
            }
        }

        return false;
    },
    // 判断浏览器来适配css属性值
    prefixStyle: function(style) {
        if ( Util.vendor() === false ) return false;
        if ( Util.vendor() === '' ) return style;

        return Util.vendor() + style.charAt(0).toUpperCase() + style.substr(1);
    },
    // 判断是否支持css transform-3d（需要测试下面属性支持）
    hasPerspective: function(){
        var ret = Util.prefixStyle('perspective') in Util.elementStyle;
        if ( ret && 'webkitPerspective' in Util.elementStyle ) {
            Util.injectStyles('@media (transform-3d),(-webkit-transform-3d){#modernizr{left:9px;position:absolute;height:3px;}}', function( node, rule ) {
                ret = node.offsetLeft === 9 && node.offsetHeight === 3;
            });
        }
        return !!ret;
    },
    // 设置元素的translateZ
    translateZ: function(){
        if(Util.hasPerspective){
            return ' translateZ(0)';
        }else{
            return '';
        }
    },
    isSuportPushState: !!(history && history.pushState),
    /**
     * @method getParamFromPathname
     * @param url {string}
     **/
    getParamFromPathname: function( format, match ){
        var pathname = location.pathname;
        var start = format.split(match);
        var result = "";
        switch (start.length){
            case 1:
                result = pathname.substr(start[0].length);
                break;
            case 2:
                result = pathname.substr(start[0].length);
                result = result.substr(0, result.length - start[1].length);
                break;
        }

        return result;
    },
    /**
	 * @method getParamFromHash
	 * @param query {string} hash中的query.
	 * @param *urlfix {string} 结束标识，如果不存在，默认设置为 “&”
	 *
	 * @returns {string} 返回链接中的query值. 
	 */
    getParamFromHash: function( query, urlfix ){
    	var url = location.hash;
	    var param = "";
	    var paramStart = url.indexOf(query + "=");
	    if (paramStart < 0) {
	      return param;
	    } else {
	      paramStart += query.length + 1;
	      urlfix = urlfix || "&";
	      var paramEnd = url.substr(paramStart).indexOf(urlfix);
	      if (paramEnd > 0) {
	        param = url.substring(paramStart, paramStart + paramEnd);
	      } else {
	        param = url.substr(paramStart);
	      }
	    }
	    return param;
    },
    getType:function(elem){
        return Object.prototype.toString.call(elem).match(/^\[object\s(.*)\]$/)[1];
    },
    getStart:function(elem){
        if (elem.selectionStart || elem.selectionStart == '0'){
            return elem.selectionStart;
        }
        else if (window.getSelection){
            var rng = window.getSelection().getRangeAt(0).cloneRange();
            rng.setStart(elem,0);

            return rng.toString().length;
        }
    },
    insertText:function(elem,text,ucStart){
        elem.focus();
        if (document.all){
            var a = document.selection.createRange();
            document.selection.empty();
            a.text = text;
            a.collapse();
            a.select();
        }else{
            var start = Util.getStart(elem);

            //console.re.log('start====='+start);

            if(Util.getType(elem) == 'HTMLDivElement'){
                // UC浏览器 获取焦点focus浏览器不纪录光标位置
                //if(navigator.userAgent.toLowerCase().indexOf('ucbrowser') != -1){
                    //elem.innerHTML = elem.innerHTML.substr(0, ucStart) + text + elem.innerHTML.substr(ucStart);
                //}else{
                    var sel = window.getSelection();
                    var range = sel.getRangeAt(0);

                    //elem.setSelectionRange(3,3);

                    //console.log(range.cloneRange().setStart(5,2));
                    var frag = range.createContextualFragment(text);
                    // 获得DocumentFragment的末尾位置
                    var lastNode = frag.lastChild;
                    range.insertNode(frag);
                    range.setStartAfter(lastNode);
                    // 设置末尾位置
                    range.setEndAfter(lastNode);

                    // 清除range
                    sel.removeAllRanges();
                    // 设置range
                    sel.addRange(range);
                //}

            }else{
                elem.value = elem.value.substr(0,start) + text + elem.value.substr(start);
            }
        }
    },
    getText:function(elem){
        if (document.all){
            var r = document.selection.createRange();
            document.selection.empty();
            return r.text;
        }
        else{
            if (elem.selectionStart || elem.selectionStart == '0'){
                var text=Util.getType(elem)=='HTMLDivElement'?elem.innerHTML:elem.value;
                return text.substring(elem.selectionStart,elem.selectionEnd);
            }
            else if (window.getSelection){
                return window.getSelection().toString()
            };
        }
    }
};

module.exports = Util;