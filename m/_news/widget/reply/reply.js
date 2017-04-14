
    var _ = require('underscore');
    var Tips = require('common:widget/ui/tips/tips.js');
    var dace = require("common:widget/ui/page-dace/page-dace.js");

    var pageId = __daceDataNameOfPage;

    /**
     * 接口地址
     */
    var apiUrl = {
        // 更多回复
        moreReply: '/news/replies',
        // 点亮
        light: '/news/light',
        // 回帖
        reply: '/news/comment'
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

            this.$button = $('#J_buttonReply');
            this.$tips = $('.tips');
            this.pagecount = $('.newest-reply').data('pagecount');
            this.ajaxMore = false;

            //回复列表
            this.$reply = $('#J_replyContent');
            // 查看更多评论按扭
            this.$buttonViewMore = $('#J_buttonViewMore');
            this.commentNum = this.$buttonViewMore.find('.comment-num').html();

            // 弹层
            this.$popup = $('#J_popupReply');
            // 引用文字
            this.$popupQuote = this.$popup.find('.J_popupQuoteContent');
            // 关闭按扭
            this.$buttonClose = this.$popup.find('.J_buttonClosePopup');
            // 确认按扭
            this.$buttonSubmit = this.$popup.find('.J_buttonSubmit');
            // 回复框
            this.$textarea = this.$popup.find('.J_replyTexttarea');

            // 帖子id
            this.tid = HPM.tid;
            //
            this.replyPageNumber = 1;
            // 引用内容
            this.quoteArray = {};
            this.isState = true;

            this.bind();
            this.listBind();
        },
        bind: function() {
            var that = this;

            // 查看更多
            this.$buttonViewMore.on('click', function() {
                that.viewMoreReply();
            });

            // 全局回复事件
            $(document).on("page:reply", function(){
                that.showPopup.call(that);
            });

            // 关闭事件
            this.$buttonClose.on('click', function() {
                that.closePopup();
            });

            // 确认事件
            this.$buttonSubmit.on('click', function() {

                that.formSubmit( $(this) );
            });

        },
        /**
         * 列表事件
         */
        listBind: function() {
            var that = this;

            // 展开事件
            this.$reply.delegate(".J_buttonOpenAll", "click", function(e){
                var $parent = $(e.currentTarget).parents('.J_contentParent'),
                    $allContent = $parent.find('.J_allContent');

                $(this).hide();
                $allContent.show();
                $parent.find('.J_shortContent').hide();
            });

            //   点亮事件
            this.$reply.delegate(".J_buttonBright", "click", function(e){
                that.sendBright( $(e.currentTarget) );
            });

            //   引用事件
            this.$reply.delegate(".J_buttonQuote", "click", function(e){
                that.setQuote( $(e.currentTarget) );
            });
        },
        /**
         * 查看更多评论
         */
        viewMoreReply: function() {
            var that = this;

            this.replyPageNumber++;

            var url = HPM.curUrl + this.tid + '-' + this.replyPageNumber+'.html';

            if(!that.ajaxMore){
               $.ajax({
                   url: url,
                   type: "POST",
                   dataType: 'json',
                   beforeSend: function(){
                       that.$buttonViewMore.html("加载评论中...");
                       that.ajaxMore = true;
                   },
                   success: function(data) {
                        // 无评论
                        if ( data.restNum <= 0 ) {
                            that.$buttonViewMore.parent().hide();
                        }
                        if ( data.status == 200 ) {

                               var tpl = _.template( $("#more-reply-template").html(), {datas: data.commentsInfo} );
                               that.$reply.find('.newest-reply .reply-inner').append( tpl );
                               that.$buttonViewMore.html('查看更多评论');
                                // 回复分页大于5页，显示下载APP
                                if ( that.replyPageNumber === 100 && parseInt(data.pageCount) > 100 ) {
                                    that.$buttonViewMore.hide();
                                    $('#J_replyDownKanApp').removeClass('fn-hide');
                                }
                               that.pagecount = data.pageCount;
                               that.ajaxMore = false;
                        }

                    }
               });
            }
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

            var url = apiUrl.light + '/cid/'+ elem.data('pid') +'/aid/'+ elem.data('uid') +'/subject/' + HPM.tid;

            $.ajax({
                url: url,
                type: "POST",
                dataType: 'json',
                success: function(data) {
                    if ( data.status == 200 ) {
                        elem.find('.text').html('点亮');
                        dace.send(pageId + "_lighten");

                        // 点亮数增加
                        var $brightNumber = elem.find('.J_brightNumber'),
                            number = parseInt( $brightNumber.text() );

                        $brightNumber.html( number + 1 );

                        that.tipBrightNumber({
                            top: Math.floor(elem.offset().top - 15),
                            left: Math.floor(elem.offset().left)
                        });
                    }
                    Tips( data.msg );
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
        setQuote: function( elem ) {
            var that = this,
                $parent = elem.parents('.reply-list'),
                $username = $parent.find('.user-name a');
                floor = elem.attr('data-floor');
            if ( !elem.attr('data-floor') ) {
                floor = 1;
            }

            this.quoteArray = {
                title: '引用 <a href="'+ $username.attr('href') +'">@ '+ $username.text() +'</a> 发表的',
                content: $parent.find('.short-content').html()
            }


            var tpl = this.quoteArray.title + '“'+ elem.find('.qoute-smail-content').text() +'”';

            this.$popupQuote
                .html( tpl );

            this.showPopup( elem.attr('data-pid'),floor );
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
                content: $.trim( this.$textarea.val() ),
                subject: HPM.tid
            }

            //不能为空
            if ( sendData.content === '' ) {
                Tips( '回复内容不能为空' );
                return;
            }

            //长度
            if ( sendData.content.length < 6 ) {
                Tips( 'JRs专注回复10年^_^，请将字数控制在6~400之间' );
                return;
            }

            var quoteId = this.$popupQuote.data('pid'),
                quoteFloor = this.$popupQuote.data('floor');

            // 引用
            if ( quoteId ) {
                sendData.quote_id = quoteId;
                sendData.quote_floor = quoteFloor;
            }

            // 禁止提交
            if(elem.attr("disabled") == "disabled"){
                return;
            } else {
                elem.attr("disabled", "disabled");
            }

            $.ajax({
                url: apiUrl.reply,
                type: "POST",
                data: sendData,
                dataType: 'json',
                success: function(data) {

                    elem.attr("disabled", "false");

                    if ( data.status == 200 ) {
                        Tips( '回复成功' );
                        dace.send(pageId + "_comment");

                        var replies = [
                            {
                                "user": HPM.getUserName,
                                "uid": HPM.getUserId,
                                "id": data.pid,
                                "floor":data.floor,
                                "content": sendData.content,
                                "smallcontent": data.smallcontent,
                                "togglecontent": "",
                                "quote": {},
                                "light": 0,
                                "time": "刚刚"
                            }
                        ];


                        /* 引用 */
                        if ( quoteId ) {
                            replies[0].quote = {
                                "header": that.quoteArray.title,
                                "content": that.quoteArray.content,
                                "togglecontent": ""
                            };
                        }

                        that.$textarea.val('');
                        var tpl = _.template( $("#more-reply-template").html(), {datas: replies} );
                        var html = "";

                        // 如果回复的时候没有一条评论
                        if (!that.$reply.length){
                            html = [
                                '<div class="m-reply" id="J_replyContent">',
                                    '<div class="newest-reply">',
                                        '<div class="title"><h2>最新评论</h2></div>',
                                        '<div class="reply-inner">'+tpl+'</div>',
                                        '<div class="button-inner"><span class="finish-loading">暂无更多评论</span></div>',
                                    '</div>',
                                '</div>'
            	            ].join("");
                            $('.detail-wrap').after( html );
                        }else {
                            html = tpl;
                            that.$reply.find('.newest-reply .reply-inner').prepend( html );
                        }
                        //that.listBind();
                        that.closePopup();
                        $(window).scrollTop($('.newest-reply').offset().top);
                        return false;
                    }
                    Tips( data.msg );
                }
            });
        },
        /**
         * 显示弹层
         */
        showPopup: function(pid,floor) {
            if ( !HPM.isLogin ) {
                HPM.popLogin();
                return;
            }

            // 是否有引用
            if ( pid ) {
                this.$popupQuote
                    .attr('data-pid', pid)
                    .attr('data-floor', floor)
                    .show();
            } else {
                this.$popupQuote
                    .hide();
            }

            this.$popup
                .show()
                .addClass('slideInUp')
                .cssEnd(function() {
                    $(this).removeClass('slideInUp')
                });

            this.scrollStop();
        },
        /**
         * 关闭弹层
         */
        closePopup: function() {

            this.$popupQuote.removeAttr('data-pid');

            this.$popup
                .addClass('slideInDown')
                .cssEnd(function() {
                    $(this)
                        .hide()
                        .removeClass('slideInDown');
                });

            this.scrollStart();
        },

        showTips: function(str){
            var that = this;
            this.$tips.html(str).show();
            setTimeout(function(){
                that.$tips.hide();
            },1000)
        }
    };

    /**
     * 监听CSS3动画执行结束
     * @param callback
     * @returns {$.fn}
     */
    $.fn.cssEnd = function ( callback ){
        var EventAnimateEnd = 'webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend';
        this.one(EventAnimateEnd , callback);
        return this;
    };

    module.exports = PopupReply;
