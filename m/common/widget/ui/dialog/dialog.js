/**
 * @file 对话框
 * @author wangjun@hupu.com
 * @date 2015-11-25
 **/
"use strict";
var Instance;

var defaults = {
    tpl: '',
    // 提交回调
    submitCallback: function() {

    },
    canelCallback: function() {

    }
}

function Popup(options) {
    this.init(options);
}

Popup.prototype = {
    init: function(options) {
        var that = this;

        this.opts = $.extend(true, {}, defaults, options || {});

        this.$popup = $('#J_hpTipPopup');

        if(this.$popup.length) {
            this.show();
            return;
        }

        this.render();
    },
    render: function() {
        var that = this;

        var tpl = [
            '<div class="hp-tip-mask" id="J_hpTipMask"></div>',
            '<div class="hp-tip-popup" id="J_hpTipPopup">',
                '<div class="hp-tip-popup-wrap">',
                    '<div class="hp-popup-content">',
                        this.opts.tpl,
                    '</div>',
                    '<div class="button-inner">',
                        '<a href="javascript:" class="button-cancel J_buttonCanel">取消</a>',
                        '<a href="javascript:" class="button-submit J_buttonSubmit">确认</a>',
                    '</div>',
                '</div>',
            '</div>'
        ].join('');

        $('body').append(tpl);

        this.$popup = $('.hp-tip-popup');

        this.bind();
    },
    bind: function() {
        var that = this;

        this.$popup.find('.J_buttonCanel').on('click', function(){
            that.hide();
            that.opts.canelCallback && that.opts.canelCallback();
        });

        this.$popup.find('.J_buttonSubmit').on('click', function(){
            that.opts.submitCallback && that.opts.submitCallback();
        });
    },
    show: function() {
        var that = this;
        $('#J_hpTipMask').show();
        $('#J_hpTipPopup').show();
    },
    hide: function() {
        $('#J_hpTipMask').hide();
        $('#J_hpTipPopup').hide();
    }
}

module.exports = function(options){
    if(Instance){
        return Instance.init(options);
    } else{
        return Instance = new Popup(options);
    }
};


