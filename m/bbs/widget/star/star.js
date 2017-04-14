"use strict";
/**
 * 收藏贴子
 * @type {{}}
 */

var Tips = require('common:widget/ui/tips/tips.js');

var Star = {
    init: function() {
        var that = this;

        // 收藏按钮
        this.$buttonStar = $('#J_top_star');

        if(!this.$buttonStar.length) {
            return
        }

        this.bind();
    },
    bind: function() {
        var that = this;

        this.$buttonStar.on('click', function() {
            var uid = $(this).data('uid'),
                tid = $(this).data('tid');

            // 未登录
            if ( !HPM.isLogin ) {
                HPM.popLogin();
                return;
            }

            $.ajax({
                url: '/my/usercollectedthreads?tid='+tid+'&uid='+uid+'&do=add',
                type: 'GET',
                dataType: 'json',
                success: function(data){
                    Tips(data.msg);
                }
            })
        })
    }
}

module.exports = Star;