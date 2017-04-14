"use strict";

var toShare = require("common:widget/ui/share/share.js");
var Tips = require('common:widget/ui/tips/tips.js');

var FnFixed = {
    init: function(){

        // 收藏按钮
        this.$buttonStar = $('#J_top_star');

        this.bind();
    },
    bind: function() {
        var that = this;

        this.$buttonStar.on('click', function() {
            if(!HPM.isLogin){
                HPM.popLogin();
                return;
            }
            var uid = $(this).data('uid'),
                tid = $(this).data('tid');

            $.ajax({
                url: '/my/usercollectedthreads?tid='+tid+'&uid='+uid+'&do=add',
                type: 'GET',
                dataType: 'json',
                success: function(data){
                    Tips(data.msg);
                }
            })
        })

        //页面分享按钮
        $("#J_buttonShare").on("click", function(){
            toShare();
        });

        $('#J_buttonReply').on("click", function() {
            $(document).trigger("page:reply");
        });

    }
}

module.exports = FnFixed;