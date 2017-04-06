/**
 * @file 点击弹出提示层
 * @author wangun@hupu.com
 * @date 2015-11-27
 **/
"use strict";

var defaults = {
    // 弹出列表模板
    tpl: '',
    // 点击元素区域
    clickWrap: 'reply-list',
    // 过滤元素
    preventName: 'J_preventName',
    // 阻止元素
    preventElem: {
        className: 'J_preventElem',
        callback: function(){

        }
    },
    // 增加class
    tplClass: '',
    // 初始化回调
    callback: function() {

    },
    // 点击列表回调
    clickCallback: function() {

    }
}

var ClickTips = {
    init: function(content, options) {
        var that = this;

        this.$content = $(content);

        if(!this.$content.length) {
            return;
        }

        this.$body = $('body');

        this.opts = $.extend(true, {}, defaults, options || {});
        this.isShow = false;
        this._target = null;
        this._targetClass = null;

        if(this.opts.tpl != '') {
            this.render();
            this.bind();
        }
    },
    render: function() {
        var that = this;

        var tpl = [
            '<div class="ui-click-tips '+ this.opts.tplClass +'" id="J_uiClickTips">',
                "<ul class='ui-click-tips-list'>",
                    this.opts.tpl,
                "</ul>",
            '</div>'
        ].join('');

        this.$body.append(tpl);

        this.$tips = $('#J_uiClickTips');
    },
    bind: function() {
        var that = this;

        this.$content.on('click', function(event) {
            that.update(event);
            that.opts.clickCallback && that.opts.clickCallback(event);
        });

        this.opts.callback && this.opts.callback(this.$tips);
    },
    update: function(event) {
        var target = event.target,
            $current;

        while (!$(target).hasClass(this.opts.clickWrap)
               && !$(target).hasClass(this.opts.preventName)
               && !$(target).hasClass(this.opts.preventElem.className)
              ){

            if('BODY' === target.tagName){
                break;
            }else{
                target = target.parentElement;
            }
        }

        $current = $(target);

        if ('BODY' === target.tagName) {
            this.hideAll();
            return;
        }

        // 阻止元素
        if($current.hasClass(this.opts.preventElem.className)){
            this.hideAll();
            this.opts.preventElem.callback && this.opts.preventElem.callback(event);
            return;
        }

        // 过滤元素
        if($current.hasClass(this.opts.preventName)){
            this.hideAll();
            return;
        }

        this.$tips.css({
            top: event.pageY - 50
        });

        if(this._target == target) {
            this.toggle();
        } else {
            this._target = target;
            this.show();
        }

        if($current.hasClass('target-active')) {
            $current.removeClass('target-active');
        }else {
            if(this._targetClass !== null) {
                this._targetClass.removeClass('target-active');
            }

            this._targetClass = $current;
            $current.addClass('target-active');
        }

    },
    toggle: function(){
        if(this.isShow){
            this.hide();
        } else{
            this.show();
        }
    },
    show: function() {
        if(!this.isShow){
            this.$tips.show();
        }
        this.isShow = true;
    },
    hide: function() {
        if(this.isShow){
            this.$tips.hide();
        }
        this.isShow = false;
    },
    hideAll: function(){
        this.$content.find('.' + this.opts.clickWrap).removeClass('target-active');
        this.hide();
    }
}

module.exports = ClickTips;