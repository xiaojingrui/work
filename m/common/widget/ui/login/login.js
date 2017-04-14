/**
 * @file 登录框提示
 * @author huangmian@hupu.com
 * @date 2015-05-26
 **/
"use strict";
//登录实例. 单页唯一.
var Instance = null;


function Login() {
    this.init();
};

Login.prototype = {
    init: function(){
        if(document.getElementById('J_login')){
            this.show();
            return;
        }

        this.render();
        this.show();
    },
    render: function(){
        this.$elem = $('<div />').attr('id','J_login').addClass("hp-login-container");
        this.$mask = $("<div />").addClass('hp-login-mask');
        $("body").append( this.$mask );
        $("body").append( this.$elem );
        
    },
    show: function(){
        var width = $(window).width();
        var height = $(window).height();
        var docHeight = Math.max($(document).height(), $(window).height());
        var scrollTop = $(window).scrollTop();
        var _html = '<p>该操作需要登录，是否登录？</p><div class="btn-item"><span class="cancel">取消</span><span class="submit"><img src="'+__uri('./login-icon.png')+'" alt="" />登录</span></div>';

        this.$mask.css({
            "width": width,
            "height": docHeight
        });
        this.$elem.empty().html(_html);

        $("html").addClass("hide-body-scroll");
        $("body").addClass("blur-body");

        this.$mask.show();
        this.$elem.show();
        this.bindEvent();

    },
    bindEvent: function() {
        var that = this;

        this.$mask.bind('click', function(e) {
            that.hide();
        });

        $('.cancel').bind('click', function(e) {
            that.hide();
        });

        $('.submit').bind('click', function(e) {
            location.href = HPM.loginUrl ;
        });

    },
    hide: function(){
        $("html").removeClass("hide-body-scroll");
        $("body").removeClass("blur-body");
        
        this.$mask.hide();
        this.$elem.hide();
    }
}   

module.exports = function(options){
    if(Instance){
        return Instance.init();
    } else{
        return Instance = new Login();
    }   
}


