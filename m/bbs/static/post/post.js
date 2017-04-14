/**
 * @file 首页和论坛列表页的页面js
 */
!function(){
    "use strict";
    var Tips = require('common:widget/ui/tips/tips.js');
    var dace = require("common:widget/ui/page-dace/page-dace.js");
    var Util = require('common:widget/ui/util/util.js');
    var Authcode = require('common:widget/ui/authcode/authcode.js');

    var pageId = __daceDataNameOfPage;

    /**
     * 接口地址
     */
    var apiUrl = {
        // 回帖
        post: '/bbs/threads'
    };

    var PostBbs = {
        init: function() {
            var that = this;

            this.$form = $('#J_postForm');

            if ( !this.$form.length ) {
                return;
            }

            this.$title = this.$form.find('.J_inputTitle');
            this.$button = this.$form.find('.J_buttonSubmit');
            this.$textarea = this.$form.find('.edit-content');
            this.fid = this.$form.find('input[name="fid"]').val();
            this.errorText = '';

            this.bind();
        },
        bind: function() {
            var that = this;

            // 发送
            this.$button.on('click', function() {
                that.verify();
            });
        },
        /**
         * 验证
         */
        verify: function() {
            var that = this;

            // 未登录
            if ( !HPM.isLogin ) {
                HPM.popLogin();
                return;
            }

            var title = $.trim( this.$title.val() ),
                content = '';

            if ( title === '' ) {
                Tips( '请输入标题' );
                return;
            }

            content = $.trim($('.edit-content').html());

            if ( content === '' ) {
                Tips( '请输入正文内容' );
                return;
            }
            //长度
            if ( content.replace(/<img [^>]*src=['"]([^'"]+)[^>]>/ig,'1').length < 6 ) {
                 Tips( 'JRs专注发帖10年^_^，请将字数控制在6~5000之间' );
                return;
            }

            var sendData = {
                fid: this.fid,
                title: title,
                content: content,
                files: []
            };

            // 有上传图片
            var $imgList = this.$form.find('.J_loadImage');

            if($imgList.length){
                $imgList.each(function(){
                    sendData.files.push($(this).attr('data-url'));
                });
            }

            // 禁止提交
            if(this.$button.attr("disabled") == "disabled"){
                Tips( this.errorText );
                return;
            } else {
                this.$button.attr("disabled", "disabled");
            }


            if(typeof isAuthCode != undefined && isAuthCode) {
                Authcode({
                    successCallback: function(val) {
                        sendData.code = val;
                        that.send(sendData);
                    },
                    canelCallback: function() {
                        that.$button.attr("disabled", "false");
                    }
                });
            }else{
                that.send(sendData);
            }
        },
        /**
         * 发帖
         */
        send: function(sendData) {
            var that = this;

            $.ajax({
                url: apiUrl.post,
                type: "POST",
                data: sendData,
                dataType: 'json',
                success: function(data) {
                    // 防止调用BBS接口出错
                    if(data.status == -107) {
                        Tips( data.data );
                        that.errorText = data.data;

                        setTimeout(function() {
                            that.$button.attr("disabled", "false");
                        }, 10 * 1000);
                        return;
                    }

                    that.$button.attr("disabled", "false");

                    if ( data.status == 1 ) {
                        dace.send(pageId + "_bbs_post");
                        window.location = data.data.url;
                        Tips( '发布成功' );
                        return;
                    }

                    Tips( data.data );
                }
            });
        }
    }

    $(function(){
        PostBbs.init();
    })
}();