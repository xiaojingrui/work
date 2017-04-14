/**
 * 设置
 */
$(function() {
    "use strict";
    var Tips = require('common:widget/ui/tips/tips.js');
    var dace = require("common:widget/ui/page-dace/page-dace.js");

    var pageId = __daceDataNameOfPage;

    /**
     * 接口地址
     */
    var apiUrl = {
        setting: "/my/usersetting"
    };

    var Setting = {
        init: function(){
            var that = this;

            this.$wrap = $('#J_settingWrap');

            if(!this.$wrap.length){
                return;
            }

            this.$button = this.$wrap.find('.J_buttonSetting');
            this.$content = this.$wrap.find('.J_contentSelect');
            this.$lable = this.$wrap.find('.lable');

            this.setCount = 1;

            this.bind();

        },
        bind: function(){
            var that = this;

            this.$button.on('click', function(){
                that.switchStatus($(this));
            });

            //this.$lable.on('click', function(){
            //    if(that.setCount === parseInt($(this).find('input').val())){
            //        return;
            //    }
            //
            //    that.setCount = parseInt($(this).find('input').val());
            //    // 不是所有人
            //    if(that.setCount == 1){
            //        dace.send(pageId + "_all");
            //    }else{
            //        dace.send(pageId + "_friend");
            //    }
            //    that.setOperating();
            //});

        },
        switchStatus: function($elem) {
            var that = this;

            if($elem.hasClass('active')){
                return;
            }

            this.$button.removeClass('active');
            $elem.addClass('active');

            this.setCount = parseInt($elem.attr('data-type'));

            //if(this.setCount){
            //    this.$content.show();
            //}else{
            //    this.$content.hide();
            //}

            this.setOperating();

        },
        setOperating: function(){
            var that = this;

            $.ajax({
                url: apiUrl.setting,
                type: "POST",
                data: {
                    type: 'set',
                    set: this.setCount
                },
                dataType: 'json',
                success: function(data) {
                    Tips(data.msg);
                }
            });
        }
    }

    $(function(){
        Setting.init();
    })
});
