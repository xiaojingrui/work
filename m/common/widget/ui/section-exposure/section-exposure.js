/**
 * @file 封装栏目曝光
 * @author wangjun@hupu.com
 **/

"use strict";

var Exposure = {
    init: function() {
        var that = this;

        this.$section = $('[section-exposure]');

        if(!this.$section.length) {
            return;
        }

        this.posTop = [];
        this.hasSend = [];

        this.getElemTop();
        this.scrollEvent($(window));
        this.bind();


    },
    /**
     * 获取元素坐标
     */
    getElemTop: function() {
        var that = this;

        var top = 0,
            height = 0,
            str = '';

        this.$section.each(function(index) {
            top = $(this).offset().top;
            height = top + $(this).height();
            str = $(this).attr('section-exposure');

            if(str !== '') {
                that.posTop.push({
                    str: str,
                    top: top,
                    height: height
                });
            }
        });

    },
    bind: function() {
        var that = this,
            $elem,
            timer = null;

        $(window).on('scroll.sectionexposure', function(event) {
            $elem = $(this);
            timer = setTimeout(function() {
                that.scrollEvent($elem);
            },200)
        })
    },
    unbind: function() {
        $(window).off('scroll.sectionexposure');
    },
    /**
     * 滚动动事件
     * @param $elem
     */
    scrollEvent: function($elem) {
        var len = this.posTop.length,
            scrollTop = parseInt($elem.scrollTop()),
            removeCount = 0,
            activeCount = 0,
            screenTop = scrollTop + $(window).height();

        if (!len) {
            this.unbind();
            return;
        }

        for(var i = 0; i < len; i++) {
            activeCount = i - removeCount;

            if(screenTop >= this.posTop[activeCount].top) {
                this.send(this.posTop[activeCount].str);
                removeCount++;
                this.posTop.splice(activeCount, activeCount + 1);
            }
        }
    },
    /**
     * 做个简单的队列，避免丢失统计数据.
     *
     * @param {string} daceStr dace的数据
     * @return {void}
     */
    send: function ( daceStr ) {
        if(window.__dace){
            var sendHandler = window.__dace.sendEvent;
            if(daceStr && daceStr.length) {
                sendHandler(daceStr)
            }

        }
    }
}

module.exports = Exposure;