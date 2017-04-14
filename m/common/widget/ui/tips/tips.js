/**
 * @file 全部黑色提示层
 * @author wangjun@hupu.com
 * @date 2015-06-01
 **/
"use strict";

var timer = null;
var Tips = function( msg ){
    if(!msg || !msg.length) return;

    var $tips = $("#J_tips");

    if ( !$tips.length ) {
        var tpl = '<div class="m-tips" id="J_tips"></div>'

        $("body").append(tpl);

        $tips = $("#J_tips");
    }

    clearTimeout(timer);
    $tips
        .removeClass('m-tips-hide')
        .html( msg )
        .show();

    // 获取位标
    function getPosition() {
        var win = $(window),
            getViewWidth = win.width(),
            getViewHeight = win.height(),
            getSrollTop = win.scrollTop(),
            getSrollLeft = win.scrollLeft(),
            width = $tips.width() || 100,
            top = getSrollTop + getViewHeight / 3,
            left = getSrollLeft + (getViewWidth - width) / 2;


        return {
            top : top,
            left : left
        }
    }

    var getPos = getPosition();

    $tips
        .css({
            top : getPos.top,
            left : getPos.left
        });

    timer = setTimeout(function(){
        clearTimeout(timer);
        $tips.addClass('m-tips-hide');
    }, 1130);
}

module.exports = Tips;


