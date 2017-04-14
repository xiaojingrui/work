/**
 * @file 验证码
 * @author wangjun@hupu.com
 * @date 2015-11-24
 **/
"use strict";

var Tips = require('common:widget/ui/tips/tips.js');
var Dialog = require('common:widget/ui/dialog/dialog.js');

var Instance;
var defaults = {
    canelCallback: function() {

    },
    // 成功回调
    successCallback: function() {

    }
}

/**
 * 接口地址
 */
var apiUrl = {
    // 验证校验码
    authcode: '/bbs/verificationcode'
};

function Authcode(options) {
    this.init(options);
}

Authcode.prototype = {
    init: function(options) {
        var that = this;

        this.opts = $.extend(true, {}, defaults, options || {});

        this.render();
    },
    render: function() {
        var that = this;

        var tpl = [
            '<div class="authcode-content" id="J_authcodeContent">',
                '<input type="text" value="" placeholder="请输入校验码" class="input-authcode J_authcodeInput" maxlength="6">',
                '<a href="javascript:" class="button-authcode J_buttonAuthcodePic"><img src="/bbs/verificationcode" alt=""/></a>',
            '</div>'
        ].join('')

        new Dialog({
            tpl: tpl,
            submitCallback: function() {
                that.verify();
            },
            canelCallback: function() {
                that.opts.canelCallback && that.opts.canelCallback();
            }
        });

        if(Instance) {
            that.getCode();
            return;
        }

        this.$con = $('#J_authcodeContent');
        this.$input = this.$con.find('.J_authcodeInput');
        this.$button = this.$con.find('.J_buttonAuthcodePic');

        this.bind();
    },
    bind: function() {
        var that = this;

        this.$button.on('click', function(){
            that.getCode();
        });
    },
    verify: function() {
        var that = this;
        var val = this.$input.val();

        $.ajax({
            url: apiUrl.authcode,
            type: "POST",
            data: {
                check: 1,
                code: val
            },
            dataType: 'json',
            success: function(data) {
                if(data.status === 200) {
                    that.opts.successCallback && that.opts.successCallback(val);
                    return;
                }

                that.getCode();
                Tips( data.msg );
            }
        });
    },
    /**
     * 获取验证码
     */
    getCode: function() {
        this.$button.find('img').attr('src', '/bbs/verificationcode?'+ (+new Date()));
    }
}

module.exports = function(options){
    if(Instance){
        return Instance.init(options);
    } else{
        return Instance = new Authcode(options);
    }
};


