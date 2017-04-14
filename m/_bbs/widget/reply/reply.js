    var _ = require('underscore');
    var Tips = require('common:widget/ui/tips/tips.js');
    var dace = require("common:widget/ui/page-dace/page-dace.js");
    var pageId = __daceDataNameOfPage;
    var Images = require("common:widget/click-image-show/click-image-show.js");
    //var uploadImage = require("common:widget/ui/upload-image/upload-image.js");
    /**
     * 接口地址
     */
    var apiUrl = {
        // 更多回复
        moreReply: '/api/bbs/replies',
        // 点亮
        light: '/bbs/thread/light',
        // 回帖
        reply: '/bbs/reply',
        // 考试
        exam: '/bbs/exam'
    };
    /**
     * 回复框
     * @type {{init: Function, bind: Function}}
     */
    var PopupReply = {
        //禁止滚动条
        scrollStop : function(){
            $('html, body').addClass('m-scroll-stop');

            this.$popup.on("touchmove.replypopup",function(e){
                e.stopPropagation();
                e.preventDefault();
            });

        },
        //启动滚动条
        scrollStart : function(){
            $('html, body').removeClass('m-scroll-stop');
            this.$popup.off('.replypopup');
        },
        init: function() {
            var that = this;
            this.$button = $('.J_buttonReply');

            this.pageContainer = $(".detail-wrap");
            //回复列表
            this.$reply = $('#J_replyContent');
            // 查看更多评论按扭
            // this.$buttonViewMore = $('#J_buttonViewMore');
            setTimeout(function(){
                Images.updateGifSize(".detail-wrap");
                $(".reply-quote-bd .lazy-gif").css({
                    "max-width":$(window).width()-71+"px"
                })
            },500)
            
            // 弹层
            this.$popup = $('#J-reply-box');
            // 引用文字
            this.$popupQuote = $('.J_popupQuoteContent');
            // 关闭按扭
            this.$buttonClose = this.$popup.find('.J_buttonClosePopup');
            // 确认按扭
            this.$buttonSubmit = $('.J_buttonSubmit');
            // 回复框
            this.$textarea = $('.J_replyTexttarea');

            //
            this.replyPageNumber = 2;
            // 引用内容
            this.quoteArray = {};
            this.isState = true;

            this.bind();
            this.listBind();
        },
        bind: function() {
            var that = this;
            // 查看更多
            // this.$buttonViewMore.on('click', function() {
            //     that.viewMoreReply();
            // });
            this.bindArticalEvent();
            //取消引用
            $(".reply-box").on("click",".cancel_quoto",function() {
                $(".J_popupQuoteContent").hide();
                that.$popupQuote.find(".reply-quote-header").removeAttr('data-pid');
            })

            // 确认事件
            this.$buttonSubmit.on('click', function() {
                that.formSubmit( $(this) );
            });
            //从考试过来的页面定位
            var hash = window.location.hash;
            if( !!HPM.back_from_exam && !hash ) {
                setTimeout(function() {
                    $('html,body').scrollTop($("#J-reply-box").offset().top);
                },300)
                
            }

        },
        /**
         * 列表事件
         */
        listBind: function() {
            var that = this;

            // 展开按扭
            this.$buttonOpen = this.$reply.find('.J_buttonOpenAll');
            // 点亮按扭
            this.$buttonBright = this.$reply.find('.J_buttonBright');
            this.$buttonContent = this.$reply.find('.J_currentContent');

            // 引用按扭
            this.$buttonQuote = this.$reply.find('.J_buttonQuote');

            // 展开事件
            this.$buttonOpen
                .off('click')
                .on('click', function() {
                    var $parent = $(this).parents('.J_contentParent'),
                        $allContent = $parent.find('.J_allContent');

                    $(this).hide();
                    $allContent.show();
                    $parent.find('.J_shortContent').hide();

                });

            // 点亮事件
            this.$buttonBright
                .off('click')
                .on('click', function() {
                    that.sendBright( $(this) );
                });


            // if(HPM.isLogin){
            //     // 引用事件
            //     this.$buttonContent
            //         .tap( function(event) {
            //             if(!that.listenElement(event)) {
            //                 that.setQuote( $(this).parents('.reply-list').find('.J_buttonQuote'), $(this).attr('dace-info') );
            //             }
            //         });
            // }
            this.$buttonQuote
                .off('click')
                .on('click', function() {
                    // 未登录
                    if ( !HPM.isLogin ) {
                        HPM.popLogin();
                        return;
                    }
                    //未考试过
                    if(HPM.exam_paper_url){
                        var addPid = that.getQueryString("from",HPM.exam_paper_url)+"#"+$(this).attr('data-pid');
                        window.location.href = that.changeURLArg(HPM.exam_paper_url,'from',addPid);
                        return false;
                    }
                    that.setQuote( $(this), $(this).attr('dace-info'),$(this).attr('data-pid') );
                });
        },
        /**
         * 查看更多评论
         */
        viewMoreReply: function() {
            var that = this;

            var url = apiUrl.moreReply + '/' + HPM.tid + '-' + this.replyPageNumber;

            $.ajax({
                url: url,
                type: "GET",
                dataType: 'json',
                success: function(data) {
                    // 无评论
                    if ( parseInt( data.data.page ) >= parseInt(data.data.pageCount) ) {
                        that.$buttonViewMore.hide();
                        that.$reply.find('.finish-loading').show();
                    }

                    if ( data.status === 200 ) {
                        var tpl = _.template( $("#J_more_reply_template").html(), {datas: data.data.replies} );

                        that.$reply.find('.general-reply .reply-inner').append( tpl );

                        // 回复分页大于5页，显示下载APP
                        if ( that.replyPageNumber === 5 && parseInt(data.data.pageCount) > 5 ) {
                            $('#J_replyDownKanApp').removeClass('fn-hide');
                        }

                        that.replyPageNumber++;

                        that.listBind();
                        return;
                    }

                    Tips( data.msg );
                }
            });
        },
        /**
         * 点亮
         */
        sendBright: function( elem ) {
            var that = this;

            // 未登录
            if ( !HPM.isLogin ) {
                HPM.popLogin();
                return;
            }

            if ( elem.hasClass('button-hasBight') ) {
                Tips( '点亮太频繁' );
                return;
            }

            var url = apiUrl.light + '/tid/'+ HPM.tid +'/pid/'+ elem.attr('data-pid') + HPM.token + HPM.csrf;

            $.ajax({
                url: url,
                type: "POST",
                dataType: 'json',
                success: function(data) {
                    if ( +data.status === 200 ) {
                        elem.addClass('button-hasBight');
                        dace.send(pageId + "_lighten");

                        // 点亮数增加
                        var $brightNumber = elem.find('.J_brightNumber'),
                            number = parseInt( $brightNumber.text() );

                        if ( number <= 0 ) {
                            elem.find('.bright-number-box').removeClass('fn-hide');
                        }

                        $brightNumber.html( "(" + data.data + ")");

                        that.tipBrightNumber({
                            top: Math.floor(elem.offset().top - 15),
                            left: Math.floor(elem.offset().left)
                        });

                        Tips("点亮成功");
                        //return;
                    }else{
                        Tips( data.data );
                    }
                }
            })
        },
        /**
         * 提示点亮+1
         */
        tipBrightNumber: function(ops) {
            var that = this;

            if ( !$('#J_popupBrightTip').length ) {
                var tpl = [
                    '<style>',
                    '.transform-bright {-webkit-animation: preloader-loading 0.4s; -moz-animation: preloader-loading 0.4s;animation: preloader-loading 0.4s}',
                    '@-webkit-keyframes preloader-loading {',
                        '0% { -webkit-transform: translateY(0); opacity: 1;}',
                        '100% { -webkit-transform: translateY(-15px); opacity: 0;}',
                    '}',
                    '@keyframes preloader-loading {',
                        '0% { transform: translateY(0); opacity: 1;}',
                        '100% { transform: translateY(-15px); opacity: 0;}',
                    '}',
                    '</style>',
                    '<div id="J_popupBrightTip" class="popup-bright-tip" style="display:none;position: absolute;top:0;left:0;z-index:10;color:#c01e2f;">+1</div>'
                ].join('');

                $('body').append(tpl);

                that.$brightTip = $('#J_popupBrightTip');
            }

            that.$brightTip
                .show()
                .css({
                    top: ops.top,
                    left: ops.left
                })
                .addClass('transform-bright')
                .cssEnd(function() {
                    $(this)
                        .removeClass('transform-bright')
                        .hide();
                });
        },
        /**
         * 引用
         */
        setQuote: function( elem, daceInfo ,dataPid) {
            this.daceInfo = daceInfo;

            var that = this,
                $parent = elem.parents('.reply-list'),
                $username = $parent.find('.user-name'),
                floor = elem.attr('data-floor');

            if ( !elem.attr('data-floor') ) {
                floor = 1;
            }

            this.quoteArray = {
                title: '<div class="reply-quote-header" data-pid='+dataPid+'><p>引用 '+ floor +'楼 <a target="_blank" href="'+ $username.attr('href') +'">@ '+ $username.text() +'</a> 发表的:<span>'+elem.find('.qoute-smail-content').text()+'</span></p><span class="cancel_quoto">取消引用</span></div>',
                title2:'<div class="reply-quote-header" data-pid='+dataPid+'><p>引用 '+ floor +'楼 <a target="_blank" href="'+ $username.attr('href') +'">@ '+ $username.text() +'</a> 发表的:<span></div>',
                content: $parent.find('.short-content').html()
            }
            var tpl = this.quoteArray.title;


            this.$popupQuote
                .html( tpl );
            this.$popupQuote.show();
            //定位到回复框位置
            $('html,body').scrollTop($("#J-reply-box").offset().top);
            $(".tip-textarea textarea").focus();
            //this.showPopup( elem.attr('data-pid') );
        },
        /**
         * 提交回复
         */
        formSubmit: function(elem) {
            var that = this;
            // 未登录
            if ( !HPM.isLogin ) {
                HPM.popLogin();
                return;
            }

            var sendData = {
                fid: HPM.fid,
                tid: HPM.tid,
                commentContent: $.trim( this.$textarea.val() ),
                files: []
            }
            //未考试过
            if(HPM.exam_paper_url){
                Tips( '抱歉，请先参与答题' );
                return false;
            }
            //不能为空
            if ( sendData.commentContent === '' ) {
                Tips( '回复内容不能为空' );
                return;
            }

            //长度
            if ( sendData.commentContent.length < 6 ) {
                Tips( 'JRs专注回复10年^_^，请将字数控制在6~400之间' );
                return;
            }

            var isQuote = this.$popupQuote.find(".reply-quote-header").attr('data-pid');
            // 引用
            if ( isQuote ) {
                sendData.pid = isQuote;
            }

            // 有上传图片
            var $imgList = this.$popup.find('.J_loadImage');

            if($imgList.length){
                $imgList.each(function(){
                    sendData.files.push($(this).attr('data-url'));
                });
            }

            // 禁止提交
            if(elem.attr("disabled") == "disabled"){
                return;
            } else {
                elem.attr("disabled", "disabled");
            }

            if(!sendData.files.length) {
                that.$buttonSubmit.text("回复中...");
            }else{
                that.$buttonSubmit.text("上传中...");
            }
            $.ajax({
                url: apiUrl.reply,
                type: "POST",
                data: sendData,
                support_webp:HPM.support_webp,
                dataType: 'json',
                complete:function(data){
                    if(data.status == 413) {
                        that.$buttonSubmit.text("回复");
                        Tips( '上传图片总共不能超过5MB，请重新上传' );
                        elem.attr("disabled", "false");
                        return;
                    }
                },
                success: function(data) {
                    
                    that.$buttonSubmit.text("回复");
                    elem.attr("disabled", "false");
                    // 去考试
                    if(data.status == 201){
                        window.location.href = data.data;
                        return;
                    }

                    if ( data.status == 200 ) {
                        Tips( '回复成功，请到全部回复页查看最新内容' );
                        dace.send(that.daceInfo);
                        dace.send(pageId + "_comment");

                        var replies = [
                            {
                                "author": HPM.getUserName,
                                "authorid": HPM.getUserId,
                                "pid": data.data.pid,
                                "content": data.data.content,
                                "smallcontent": data.data.smallcontent,
                                "togglecontent": data.data.togglecontent,
                                "header": data.data.header,
                                "quote": [],
                                "light": 0,
                                "_postdate": "刚刚"
                            }
                        ];

                        /* 引用 */
                        if ( isQuote ) {
                            replies[0].quote.push({
                                "header": [
                                    that.quoteArray.title2
                                ],
                                "content": that.quoteArray.content,
                                "togglecontent": ""
                            });
                        }

                        that.$textarea.val('');
                        if(that.$popup.find('.has-upload-list').length) {
                            that.$popup.find('.has-upload-list').each(function() {
                                $(this).remove();
                            });
                        }
                        var tpl = _.template( $("#J_more_reply_template").html(), {datas: replies} );
                        //回复内容为空时
                        if(!HPM.replies.length) {
                            location.reload();

                        }
                        that.$reply.find('.general-reply .reply-inner').append( tpl );
                        that.$reply.find('.general-reply').removeClass( 'general-not-reply' );


                        that.listBind();
                        $("#J_uploadImageWrap").hide();
                        $(".J_popupQuoteContent").hide();
                        that.$popupQuote.find(".reply-quote-header").removeAttr('data-pid');

                        that.bindArticalEvent();
                        Images.updateGifSize(".detail-wrap");
                        $(".reply-quote-bd .lazy-gif").css({
                            "max-width":$(window).width()-71+"px"
                        })
                        return;
                    }

                    //Tips( data.data );
                }
            });
        },
        /* 
        * url 目标url 
        * arg 需要替换的参数名称 
        * arg_val 替换后的参数的值 
        * return url 参数替换后的url 
        */ 
        changeURLArg: function(url,arg,arg_val) {
            var pattern=arg+'=([^&]*)'; 
            var replaceText=arg+'='+arg_val; 
            if(url.match(pattern)){ 
                var tmp='/('+ arg+'=)([^&]*)/gi'; 
                tmp=url.replace(eval(tmp),replaceText); 
                return tmp; 
            }else{ 
                if(url.match('[\?]')){ 
                    return url+'&'+replaceText; 
                }else{ 
                    return url+'?'+replaceText; 
                } 
            } 
            return url+'\n'+arg+'\n'+arg_val; 
        },
        getQueryString: function(name,url) {
                var reg = new RegExp('(^|&)' + name + '=([^&]*)(&|$)', 'i');
                
                var paramLen = url.indexOf("?")+1;
                var urlNew = url.substr(paramLen);

                var paramLen2 = urlNew.indexOf("?");
                var urlNew2 = urlNew.substr(paramLen2);
                var r = urlNew2.substr(1).match(reg);
                if (r != null) {
                    return unescape(r[2]);
                }
                return null;
            },
        /**
         * 监听元素点击的事件. 在标签上添加 data-jump 属性，点击行为被跳转链接.
         **/
        listenElement: function (e) {
            var jumpName = 'data-jump';
            var target = e.target;

            while ('A' !== target.tagName && 'BODY' !== target.tagName) {
                target = target.parentElement;
                if (!target) {
                    break;
                }
            }

            if ('BODY' !== target.tagName) {
                return true;
            }else{
                return false;
            }
        },
        bindArticalEvent: function(){
            var self = this;
            Images.renderGifs(this.pageContainer, 0, 0, "bbs");
            //图片点击事件
            this.pageContainer.find("img").not(".emoji").on("click", function(e){
                var currentTarget = e.currentTarget;
                if(currentTarget.getAttribute("data-src")){
                    var realSrc = currentTarget.getAttribute("data-src");
                    currentTarget.src = realSrc;
                    currentTarget.removeAttribute("data-src");
                    return false;
                } else{
                    if(currentTarget.getAttribute("data-gif")){
                        Images.handlerClickGif(currentTarget, 0,$(".detail-wrap"));
                    }
                }
            });
        }

    };

    /**
     * 监听CSS3动画执行结束
     * @param callback
     * @returns {$.fn}
     */
    // $.fn.cssEnd = function ( callback ){
    //     var EventAnimateEnd = 'webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend';
    //     this.one(EventAnimateEnd , callback);
    //     return this;
    // };

    module.exports = PopupReply;
